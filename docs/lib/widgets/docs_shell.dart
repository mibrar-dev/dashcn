// The app shell (spec §2.0) and the docs layout grid (spec §2.2).
//
// Shell: header + content + conditional one-line footer. The footer renders
// only on `/` (landing) and not-found, matching the reference's
// `body:has([data-slot=docs])` / `/create` hiding rules.
//
// Docs layout: `lg:` grid `[288, 1fr]` with an 8 px container gutter; the
// article (with its own TOC column on `xl`) fills the rest.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../motion/ease.dart';
import '../motion/motion_scope.dart';
import '../routing/docs_router.dart';
import '../ui/dashcn/theme/theme.dart';
import '../state/docs_state.dart';
import 'docs_footer.dart';
import 'docs_header.dart';
import 'docs_sidebar.dart';
import 'docs_tokens.dart';

/// Wraps the navigator with the site header/footer and the mobile popper.
class DocsAppShell extends StatefulWidget {
  /// Creates the shell.
  const DocsAppShell({
    super.key,
    required this.delegate,
    required this.state,
    required this.child,
  });

  /// Router delegate (navigation + palette + current route).
  final DocsRouterDelegate delegate;

  /// Theme state (header toggle).
  final DocsState state;

  /// The navigator subtree.
  final Widget child;

  @override
  State<DocsAppShell> createState() => _DocsAppShellState();
}

class _DocsAppShellState extends State<DocsAppShell> {
  bool _mobileNavOpen = false;
  bool _drawerMounted = false;

  void _toggleMobileNav() {
    if (_mobileNavOpen) {
      _closeMobileNav();
      return;
    }
    // Mount closed, then open next frame so the slide/fade animate in
    // instead of jumping. Reduced motion still snaps (duration zero).
    setState(() {
      _drawerMounted = true;
      _mobileNavOpen = false;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _drawerMounted && !_mobileNavOpen) {
        setState(() => _mobileNavOpen = true);
      }
    });
  }

  void _closeMobileNav() {
    if (!_mobileNavOpen && !_drawerMounted) {
      return;
    }
    final Duration duration = context.motionDuration(kDurationPopper * 2);
    setState(() => _mobileNavOpen = false);
    // Keep mounted during the slide-out/fade-out, then unmount so the
    // off-screen drawer never lingers for finders or focus.
    Future.delayed(duration + const Duration(milliseconds: 50), () {
      if (mounted && !_mobileNavOpen && _drawerMounted) {
        setState(() => _drawerMounted = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.delegate,
      builder: (BuildContext context, Widget? _) {
        final DocsRouteConfiguration config =
            widget.delegate.currentConfiguration;
        final double width = MediaQuery.sizeOf(context).width;
        final double headerHeight = width >= 1024
            ? DocsMetrics.headerHeightLg
            : DocsMetrics.headerHeightSm;
        // The landing footer lives INSIDE the landing page (after the
        // collage), so at the reference's first-viewport heights the footer
        // sits below the fold exactly like the reference. The shell keeps it
        // only for not-found.
        final bool showFooter = config.route == DocsRoute.notFound;
        final Widget shell = Column(
          children: <Widget>[
            FocusTraversalOrder(
              order: DocsFocusOrder.header,
              child: DocsHeader(
                delegate: widget.delegate,
                state: widget.state,
                currentLocation: config.location,
                mobileNavOpen: _mobileNavOpen,
                onToggleMobileNav: _toggleMobileNav,
              ),
            ),
            Expanded(
              child: FocusTraversalOrder(
                order: DocsFocusOrder.navigator,
                child: widget.child,
              ),
            ),
            if (showFooter)
              FocusTraversalOrder(
                order: DocsFocusOrder.footer,
                child: DocsFooter(
                  onDocs: () => widget.delegate.go(context, '/docs'),
                  onCli: () => widget.delegate.go(context, '/docs/cli'),
                ),
              ),
          ],
        );
        // The mobile nav is a drawer: a panel slides in from the left over a
        // dimmed scrim. The drawer mounts on open (closed, then animates in)
        // and stays mounted during the slide-out/fade-out before unmounting,
        // so open and close both animate with no jump and no lingering
        // off-screen widgets. Reduced motion snaps it (duration zero).
        final Widget content = Stack(
          children: <Widget>[
            shell,
            if (_drawerMounted) ...<Widget>[
              Positioned(
                top: headerHeight,
                left: 0,
                right: 0,
                bottom: 0,
                child: IgnorePointer(
                  ignoring: !_mobileNavOpen,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: _closeMobileNav,
                    child: AnimatedOpacity(
                      opacity: _mobileNavOpen ? 1 : 0,
                      duration: context.motionDuration(kDurationPopper * 2),
                      curve: kEaseStandard,
                      child: const ColoredBox(color: Color(0x66000000)),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: headerHeight,
                bottom: 0,
                left: 0,
                width: MediaQuery.sizeOf(context).width * 0.86 > 360
                    ? 360
                    : MediaQuery.sizeOf(context).width * 0.86,
                child: ExcludeFocus(
                  excluding: !_mobileNavOpen,
                  child: ExcludeSemantics(
                    excluding: !_mobileNavOpen,
                    child: AnimatedSlide(
                      offset: _mobileNavOpen
                          ? Offset.zero
                          : const Offset(-1, 0),
                      duration: context.motionDuration(kDurationPopper * 2),
                      curve: kEaseStandard,
                      child: DocsMobileNav(
                        key: const ValueKey<String>('mobile-nav'),
                        delegate: widget.delegate,
                        currentLocation: config.location,
                        onNavigate: _closeMobileNav,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
        // Paint the viewport with the active preset background: the app has
        // no scaffold, so unpainted gaps would otherwise show the dark
        // `index.html` first-paint background in light mode.
        final Widget painted = ColoredBox(
          color: Theme.of(context).colors.background,
          child: content,
        );
        // Escape closes the popper. The binding lives at the shell level (an
        // ancestor of the focused node) because the popper itself is a sibling
        // branch and would never see the key event.
        //
        // Tab order: `OrderedTraversalPolicy` + the `FocusTraversalOrder`
        // slots above make the shell traverse header → navigator → footer
        // instead of the default reading order, which reaches the header (it
        // lives outside the page navigator) only after the article.
        return CallbackShortcuts(
          bindings: <ShortcutActivator, VoidCallback>{
            const SingleActivator(LogicalKeyboardKey.escape): () {
              if (_mobileNavOpen) {
                _closeMobileNav();
              }
            },
          },
          child: FocusTraversalGroup(
            policy: OrderedTraversalPolicy(),
            child: painted,
          ),
        );
      },
    );
  }
}

/// The docs grid: sidebar (≥`lg`) + article column.
class DocsLayout extends StatelessWidget {
  /// Creates the layout.
  const DocsLayout({super.key, required this.child});

  /// The article column (usually a `DocsArticle`).
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final String location =
        DocsRouterScope.maybeOf(context)?.currentConfiguration.location ??
        '/docs';
    final Widget content = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DocsMetrics.containerGutter,
      ),
      child: width >= 1024
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FocusTraversalOrder(
                  order: DocsFocusOrder.sidebar,
                  child: DocsSidebar(activeLocation: location),
                ),
                Expanded(
                  child: FocusTraversalOrder(
                    order: DocsFocusOrder.content,
                    child: child,
                  ),
                ),
              ],
            )
          : child,
    );
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: content,
    );
  }
}
