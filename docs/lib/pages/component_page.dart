// The component page template (spec §2.4, P7-D1 upstream docs layout): one
// route for all 118 components.
//
// Title row + typeset description, the main demo card (the first named
// example, inside the P9-1 device frame), an install block, Usage (snippets),
// Examples (every remaining example as `### <Name>` + its own Preview |
// Code card), API Reference, Theme, and Accessibility (keyboard rows, hidden
// when empty). Prev/next pager at the bottom. Every fact comes from the
// generated data.
//
// Trust scorecards open from a top button in a dialog (desktop) or sheet
// (phone) instead of an inline list. The Playground opens as a right-side
// panel (Figma-like): the sidebar stays put while the content area shows
// the panel on the right. While open, the playground canvas is the single
// live preview — the left column drops its duplicate main preview card but
// keeps the description and the examples list — and the same playground
// values drive every example on the page (code tabs preserve the original
// per-example sources).
//
// The example cards live in `widgets/example_preview_card.dart` (P7-D1: one
// card per named example instead of P6-F4's single preview + Select).

import 'package:flutter/widgets.dart';

import '../generated/docs_api.dart';
import '../generated/docs_controls.dart';
import '../generated/docs_data.dart';
import '../generated/docs_tables.dart';
import '../playground/builders.dart';
import '../playground/ui/playground_panel.dart';
import '../playground/ui/scope.dart';
import '../routing/docs_nav.dart';
import '../routing/docs_router.dart';
import '../state/docs_content_components.dart';
import '../state/docs_state.dart';
import '../state/docs_strings.dart';
import '../ui/dashcn/components/badge/badge.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/dialog/dialog.dart' as dashcn_dialog;
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/theme/theme.dart';
import '../widgets/component_examples_section.dart';
import '../widgets/component_install_block.dart';
import '../widgets/component_preview_card.dart';
import '../widgets/component_sections.dart';
import '../widgets/docs_article.dart';
import '../widgets/docs_shell.dart';
import '../widgets/docs_tokens.dart';
import '../widgets/scorecard/scorecard_card.dart';

/// `/docs/components/<id>` — the component template.
class ComponentPage extends StatefulWidget {
  /// Creates the page for [componentId].
  const ComponentPage({super.key, required this.componentId});

  /// The registry component id.
  final String componentId;

  @override
  State<ComponentPage> createState() => _ComponentPageState();
}

class _ComponentPageState extends State<ComponentPage> {
  bool _playgroundOpen = false;

  void _openScorecards() {
    final double width = MediaQuery.sizeOf(context).width;
    final Locale dialogLocale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    final Widget card = ScorecardCard(componentId: widget.componentId);
    if (width < 640) {
      // Phone: bottom sheet.
      dashcn_dialog.showDialog<void>(
        context: context,
        alignment: Alignment.bottomCenter,
        builder: (BuildContext context) {
          final ThemeData theme = Theme.of(context);
          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.9,
              maxWidth: 640,
            ),
            decoration: BoxDecoration(
              color: theme.colors.background,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              border: Border.all(color: theme.colors.border),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Spacer(),
                      Button(
                        variant: ButtonVariant.ghost,
                        size: ButtonSize.sm,
                        onPressed: () => Navigator.pop(context),
                        child: Text(docsChrome(dialogLocale, 'close')),
                      ),
                    ],
                  ),
                  card,
                ],
              ),
            ),
          );
        },
      );
      return;
    }
    // Desktop: centred dialog.
    dashcn_dialog.showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        final ThemeData theme = Theme.of(context);
        return Container(
          constraints: const BoxConstraints(maxWidth: 640, maxHeight: 640),
          decoration: BoxDecoration(
            color: theme.colors.background,
            borderRadius: theme.borderRadiusLg,
            border: Border.all(color: theme.colors.border),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Spacer(),
                    Button(
                      variant: ButtonVariant.ghost,
                      size: ButtonSize.sm,
                      onPressed: () => Navigator.pop(context),
                      child: Text(docsChrome(dialogLocale, 'close')),
                    ),
                  ],
                ),
                card,
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final DocsComponent component = kComponents.firstWhere(
      (DocsComponent c) => c.id == widget.componentId,
    );
    final ({String? previousId, String? nextId}) neighbors = componentNeighbors(
      widget.componentId,
    );
    final bool hasPlayground =
        kControlSpecs.containsKey(widget.componentId) &&
        kPlaygroundBuilders.containsKey(widget.componentId);
    final DocsState state = DocsRouterScope.of(context).state;
    // Shareable deep links (`?p.variant=…`): a non-empty query auto-opens
    // the panel so reload/back-forward restore the configured playground.
    // Router navigation without `p.*` clears the query (applyRouteUri), so
    // no leftover leaks across components.
    final bool playgroundActive =
        (_playgroundOpen || state.playgroundQuery.isNotEmpty) && hasPlayground;
    final ThemeData theme = Theme.of(context);
    void openPlayground() {
      // Fresh controls per component: a leftover `p.*` query from another
      // component would otherwise leak (e.g. Button `p.variant` into Badge).
      state.setPlaygroundQuery(const <String, String>{});
      setState(() => _playgroundOpen = true);
    }

    void closePlayground() {
      state.setPlaygroundQuery(const <String, String>{});
      setState(() => _playgroundOpen = false);
    }

    final Widget article = DocsArticle(
      hideToc: playgroundActive,
      title: component.name,
      description: docsComponentDescription(
        component.id,
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en'),
      ),
      previous: neighbors.previousId != null
          ? DocsNavLink(
              label: kComponentLinks
                  .firstWhere(
                    (DocsComponentLink l) => l.id == neighbors.previousId,
                  )
                  .name,
              location: '/docs/components/${neighbors.previousId}',
            )
          : null,
      next: neighbors.nextId != null
          ? DocsNavLink(
              label: kComponentLinks
                  .firstWhere((DocsComponentLink l) => l.id == neighbors.nextId)
                  .name,
              location: '/docs/components/${neighbors.nextId}',
            )
          : null,
      titleActions: <Widget>[
        Badge(
          variant: BadgeVariant.secondary,
          child: Text(
            docsFileCount(
              component.fileCount,
              DocsRouterScope.maybeOf(context)?.state.locale ??
                  const Locale('en'),
            ),
          ),
        ),
        Badge(variant: BadgeVariant.outline, child: Text(component.stability)),
        if (_isWip(component.id)) ...<Widget>[
          Badge(
            variant: BadgeVariant.outline,
            child: Text(
              docsChrome(
                DocsRouterScope.maybeOf(context)?.state.locale ??
                    const Locale('en'),
                'cmpWip',
              ),
            ),
          ),
          _WipNote(),
        ],
      ],
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: theme.spacing.lg),
          child: Wrap(
            spacing: theme.spacing.sm,
            runSpacing: theme.spacing.sm,
            children: <Widget>[
              Button(
                key: const ValueKey<String>('trust-scorecards-open'),
                variant: ButtonVariant.outline,
                size: ButtonSize.sm,
                onPressed: _openScorecards,
                child: Text(
                  docsChrome(
                    DocsRouterScope.maybeOf(context)?.state.locale ??
                        const Locale('en'),
                    'cmpTrust',
                  ),
                ),
              ),
              if (hasPlayground)
                Button(
                  key: const ValueKey<String>('playground-open'),
                  variant: ButtonVariant.secondary,
                  size: ButtonSize.sm,
                  onPressed: openPlayground,
                  child: Text(
                    docsChrome(
                      DocsRouterScope.maybeOf(context)?.state.locale ??
                          const Locale('en'),
                      'cmpPlayground',
                    ),
                  ),
                ),
            ],
          ),
        ),
        // Single live preview: while the playground is open its canvas is
        // the preview, so the left column drops the duplicate main card but
        // keeps the description and every example below.
        if (!playgroundActive)
          ComponentPreviewCard(componentId: widget.componentId),
        ComponentInstallBlock(componentId: widget.componentId),
        ComponentUsageSection(componentId: widget.componentId),
        ComponentExamplesSection(componentId: widget.componentId),
        ComponentApiSection(componentId: widget.componentId),
        if (_hasMembers(widget.componentId))
          ComponentMembersSection(componentId: widget.componentId),
        if (_hasThemeTable(widget.componentId))
          ComponentThemeSection(componentId: widget.componentId),
        if (_hasKeyboardRows(widget.componentId))
          ComponentAccessibilitySection(componentId: widget.componentId),
      ],
    );
    if (!playgroundActive) {
      return DocsLayout(child: article);
    }
    // Figma-like: sidebar stays put (DocsLayout), content area shows the
    // article on the left and the 380 px playground panel docked on the
    // right. The panel holds the single live canvas plus the grouped
    // controls, Reset/Copy and the live code. Phone widths show the same
    // panel as a bottom sheet so the Row never overflows 375 px.
    final double contentWidth = MediaQuery.sizeOf(context).width;
    // The shell header floats over the navigator: the docked panel starts
    // below it (narrow overlay fills the article area, same inset).
    final double panelTop = (contentWidth >= 1024 ? 64.0 : 56.0) + 12;
    Widget panelContent() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(
              theme.spacing.lg,
              panelTop,
              theme.spacing.md,
              theme.spacing.sm,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    docsChrome(
                      DocsRouterScope.maybeOf(context)?.state.locale ??
                          const Locale('en'),
                      'cmpPlayground',
                    ),
                    style: docsText(context, size: 14, weight: FontWeight.w600),
                  ),
                ),
                Gap(theme.spacing.xs),
                Button(
                  key: const ValueKey<String>('playground-close'),
                  variant: ButtonVariant.ghost,
                  size: ButtonSize.sm,
                  onPressed: closePlayground,
                  child: Text(
                    docsChrome(
                      DocsRouterScope.maybeOf(context)?.state.locale ??
                          const Locale('en'),
                      'close',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                theme.spacing.lg,
                0,
                theme.spacing.lg,
                theme.spacing.lg,
              ),
              child: ListenableBuilder(
                listenable: state,
                builder: (BuildContext context, Widget? _) => PlaygroundPanel(
                  componentId: widget.componentId,
                  initialQuery: state.playgroundQuery,
                  onQueryChanged: state.setPlaygroundQuery,
                  reportUrl: false,
                  inlineControls: true,
                ),
              ),
            ),
          ),
        ],
      );
    }

    final Widget scopedArticle = PlaygroundScope(
      activeComponentId: widget.componentId,
      child: article,
    );
    if (contentWidth < 1024) {
      final double sheetHeight = MediaQuery.sizeOf(context).height * 0.85;
      return DocsLayout(
        child: PlaygroundScope(
          activeComponentId: widget.componentId,
          child: Stack(
            children: <Widget>[
              scopedArticle,
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: sheetHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colors.background,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: panelContent(),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return DocsLayout(
      child: PlaygroundScope(
        activeComponentId: widget.componentId,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(child: scopedArticle),
            Container(
              width: 380,
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: theme.colors.border)),
                color: theme.colors.background,
              ),
              child: panelContent(),
            ),
          ],
        ),
      ),
    );
  }

  static bool _hasMembers(String id) {
    return kApiTables[id]!.members.isNotEmpty;
  }

  /// Audio/video players are still being polished.
  static bool _isWip(String id) {
    return id == 'audio_player' || id == 'video_player';
  }

  static bool _hasThemeTable(String id) {
    final DocsThemeTable table = kThemeTables[id]!;
    return table.hasTheme && table.fields.isNotEmpty;
  }

  static bool _hasKeyboardRows(String id) {
    return (kKeyboardRows[id] ?? const <DocsKeyboardRow>[]).isNotEmpty;
  }
}

/// WIP note beside the badge: density-capped and truncating so the title
/// row fits at 375 and 1280.
///
/// The badge Wrap measures its children with the Row's remaining width once
/// `docs_article` gives it a Flexible bound; without a cap this note's
/// intrinsic width (~396) forces the Row past 640 by ~300. Capping at 12x
/// the content-padding base (192 at the default density, scaled) and
/// ellipsizing keeps it to one line in both branches.
class _WipNote extends StatelessWidget {
  /// Creates the note.
  const _WipNote();

  @override
  Widget build(BuildContext context) {
    final double densityBase =
        Theme.of(context).density.baseContentPadding *
        Theme.of(context).scaling;
    final locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: densityBase * 12),
      child: Text(
        docsChrome(locale, 'cmpWipNote'),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: docsText(
          context,
          size: 12,
          color: Theme.of(context).colors.mutedForeground,
        ),
      ),
    );
  }
}
