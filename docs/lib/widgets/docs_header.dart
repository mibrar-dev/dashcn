// The docs site header (spec §2.0): sticky 64 px (`lg+`) / 56 px bar, no
// border, four nav items, fixed-width search trigger (192/160/256), GitHub,
// theme toggle, locale switcher and the primary CTA. Below `lg` the nav
// collapses into the full-width mobile popper (not a side drawer); the search
// trigger hides below `md`.
//
// The bar is the kit `navigation_bar` component (bar container): its surface
// paints `surfaceColor(background, ambient.surfaceOpacity)` under a
// `GlassSurface(ambient.surfaceBlur)`, so lowering the theme's surface
// opacity makes scrolled content show through (blurred). Text uses the
// foreground/muted tokens, which hold 4.5:1 on the background token.

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../routing/docs_nav.dart';
import '../routing/docs_router.dart';
import '../state/docs_state.dart';
import '../state/docs_strings.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/divider/divider.dart';
import '../ui/dashcn/components/keyboard_shortcut/keyboard_shortcut.dart';
import '../ui/dashcn/components/navigation_bar/navigation_bar.dart';
import '../ui/dashcn/components/popup/popup.dart';
import '../ui/dashcn/components/tooltip/tooltip.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/primitives/clickable.dart';
import '../ui/dashcn/primitives/localizations/localizations.dart';
import '../ui/dashcn/primitives/overlay.dart';
import '../ui/dashcn/theme/color_tokens.dart';
import '../ui/dashcn/theme/theme.dart';
import '../web_bridge.dart';
import 'docs_footer.dart' show kDocsRepoUrl;
import 'get_code_dialog.dart';
import 'docs_tokens.dart';

/// Translated header-nav label for [location] in [locale].
String docsHeaderNavLabel(String location, Locale locale) {
  final String key = switch (location) {
    '/' => 'navHome',
    '/docs' => 'navDocs',
    '/docs/components' => 'navComponents',
    '/charts' => 'navCharts',
    '/blocks' => 'navBlocks',
    '/docs/flows' => 'navFlows',
    '/docs/starters' => 'navStarters',
    '/themes' => 'navThemes',
    _ => 'navDocs',
  };
  return docsChrome(locale, key);
}

/// Translated docs-section label for [location] in [locale].
String docsSectionLabel(String location, Locale locale) {
  final String key = switch (location) {
    '/docs' => 'secIntroduction',
    '/docs/components' => 'navComponents',
    '/docs/installation' => 'secInstallation',
    '/docs/package-or-own' => 'secPackageOrOwn',
    '/docs/material' => 'secMaterial',
    '/docs/theming' => 'secTheming',
    '/docs/dark-mode' => 'secDarkMode',
    '/docs/internationalization' => 'secI18n',
    '/docs/cli' => 'secCli',
    '/docs/scorecards' => 'secScorecards',
    _ => 'secIntroduction',
  };
  return docsChrome(locale, key);
}

/// The site header.
class DocsHeader extends StatelessWidget {
  /// Creates the header.
  const DocsHeader({
    super.key,
    required this.delegate,
    required this.state,
    required this.currentLocation,
    required this.mobileNavOpen,
    required this.onToggleMobileNav,
  });

  /// Router delegate (navigation + palette).
  final DocsRouterDelegate delegate;

  /// Theme state (toggle + locale).
  final DocsState state;

  /// Current canonical location (active nav state).
  final String currentLocation;

  /// Whether the mobile nav popper is open.
  final bool mobileNavOpen;

  /// Toggles the mobile nav popper.
  final VoidCallback onToggleMobileNav;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool wide = width >= 1024;
    final bool showSearch = width >= 768;
    final bool showSeparators = width >= 1024;
    final double searchWidth = width >= 1280
        ? DocsMetrics.searchWidthXl
        : (width >= 1024
              ? DocsMetrics.searchWidthLg
              : DocsMetrics.searchWidthMd);
    final bool showCta = width >= 768;
    // The kit bar owns the surface: no manual `surfaceColor`/`GlassSurface`
    // here. `backgroundColor: null` resolves the background token and the
    // ambient surfaceOpacity/surfaceBlur, identical to the manual paint the
    // header did before, so future glass-theme changes propagate via kit.
    return SizedBox(
      height: wide ? DocsMetrics.headerHeightLg : DocsMetrics.headerHeightSm,
      child: NavigationBar(
        container: NavigationContainerType.bar,
        alignment: MainAxisAlignment.start,
        spacing: 0,
        padding: const EdgeInsets.symmetric(horizontal: DocsMetrics.barPadding),
        children: <NavigationBarItem>[
          _DocsBarContents(
            delegate: delegate,
            state: state,
            currentLocation: currentLocation,
            mobileNavOpen: mobileNavOpen,
            onToggleMobileNav: onToggleMobileNav,
            wide: wide,
            showSearch: showSearch,
            searchWidth: searchWidth,
            showSeparators: showSeparators,
            showCta: showCta,
          ),
        ],
      ),
    );
  }
}

/// Inert adapter: keeps the existing bar Row (focus anchor, nav-link buttons,
/// spacer, search trigger, GitHub/theme/locale/CTA) unchanged inside the kit
/// surface. Non-selectable so the bar's roving index ignores it.
class _DocsBarContents extends StatelessWidget implements NavigationBarItem {
  /// Creates the bar contents.
  const _DocsBarContents({
    required this.delegate,
    required this.state,
    required this.currentLocation,
    required this.mobileNavOpen,
    required this.onToggleMobileNav,
    required this.wide,
    required this.showSearch,
    required this.searchWidth,
    required this.showSeparators,
    required this.showCta,
  });

  /// Router delegate (navigation + palette).
  final DocsRouterDelegate delegate;

  /// Theme + locale state.
  final DocsState state;

  /// Current canonical location (active nav state).
  final String currentLocation;

  /// Whether the mobile nav popper is open.
  final bool mobileNavOpen;

  /// Toggles the mobile nav popper.
  final VoidCallback onToggleMobileNav;

  /// Whether the nav links render inline (`lg+`).
  final bool wide;

  /// Whether the search trigger renders (`md+`).
  final bool showSearch;

  /// Fixed search trigger width (192/160/256).
  final double searchWidth;

  /// Whether the bar separators render (`lg+`).
  final bool showSeparators;

  /// Whether the primary CTA renders (`md+`).
  final bool showCta;

  @override
  bool get selectable => false;

  @override
  Widget build(BuildContext context) {
    final Locale locale = state.locale;
    final double width = MediaQuery.sizeOf(context).width;
    return Row(
      children: <Widget>[
        // Invisible initial-focus anchor: the reference paints no focus
        // ring on load, but the first Tab must still start in the header
        // (focus_test). A plain `Focus(autofocus: true)` loses the race
        // against the Navigator route scope's own autofocus (it requests
        // focus during build), so the anchor asks in a post-frame callback
        // - the same trick `Button(autofocus)` uses. No `FocusOutline`
        // wraps it, so taking focus paints nothing.
        FocusTraversalOrder(
          order: DocsFocusOrder.headerAnchor,
          child: const _HeaderFocusAnchor(),
        ),
        if (!wide)
          SizedBox(
            height: 32,
            child: Button(
              variant: ButtonVariant.ghost,
              size: ButtonSize.sm,
              // No `autofocus`: the reference paints no focus ring on load.
              // `OrderedTraversalPolicy` + the shell `FocusTraversalOrder`
              // slots still make the first Tab land in the header.
              onPressed: onToggleMobileNav,
              leading: Icon(
                mobileNavOpen ? LucideIcons.x : LucideIcons.menu,
                size: 16,
              ),
              child: Text(
                mobileNavOpen
                    ? docsChrome(locale, 'close')
                    : docsChrome(locale, 'menu'),
              ),
            ),
          ),
        if (wide)
          for (final DocsNavLink link in _headerNavFor(width))
            Padding(
              // P7-TH1: nav link trailing gap follows the theme (gap-1).
              padding: EdgeInsets.only(right: Theme.of(context).spacing.xs),
              child: _NavLink(
                link: DocsNavLink(
                  label: docsHeaderNavLabel(link.location, locale),
                  location: link.location,
                ),
                active: _navActive(link.location, currentLocation),
                onPressed: () => delegate.go(context, link.location),
              ),
            ),
        const Spacer(),
        if (showSearch)
          _SearchTrigger(
            width: searchWidth,
            label: width >= 1280
                ? docsChrome(locale, 'searchLong')
                : docsChrome(locale, 'searchShort'),
            onPressed: delegate.openPalette,
          ),
        if (showSeparators) ...<Widget>[
          Gap(Theme.of(context).spacing.sm),
          const _BarSeparator(),
        ],
        Gap(Theme.of(context).spacing.sm),
        Tooltip(
          tooltip: (BuildContext context) =>
              Text(docsChrome(locale, 'githubRepo')),
          child: SizedBox(
            height: 32,
            child: Button(
              variant: ButtonVariant.ghost,
              size: ButtonSize.sm,
              onPressed: () => webOpenUrl(kDocsRepoUrl),
              leading: const Icon(LucideIcons.github, size: 16),
              // The label needs 1600: the bar is overflow-free at 1280/1440
              // with the icon only (measured in the responsive audit), and the
              // locale switcher takes the remaining room.
              child: width >= 1600
                  ? Text(docsChrome(locale, 'github'))
                  : const SizedBox.shrink(),
            ),
          ),
        ),
        Gap(Theme.of(context).spacing.xs),
        Tooltip(
          tooltip: (BuildContext context) =>
              Text(docsChrome(locale, 'toggleTheme')),
          child: SizedBox(
            width: 32,
            height: 32,
            child: Button(
              variant: ButtonVariant.ghost,
              size: ButtonSize.xs,
              theme: const ButtonVariantStyle(padding: EdgeInsets.zero),
              onPressed: state.toggleBrightness,
              child: Icon(
                state.brightness == Brightness.dark
                    ? LucideIcons.sun
                    : LucideIcons.moon,
                size: 16,
              ),
            ),
          ),
        ),
        Gap(Theme.of(context).spacing.xs),
        DocsLocaleSwitcher(state: state),
        if (showCta) ...<Widget>[
          Gap(Theme.of(context).spacing.sm),
          if (currentLocation == '/themes')
            // Spec §2.7: on `/create`/`/themes` the header swaps the primary
            // CTA for `Get Code`, which opens the export dialog.
            SizedBox(
              height: 32,
              child: Button(
                key: const ValueKey<String>('docs-header-get-code'),
                variant: ButtonVariant.primary,
                size: ButtonSize.sm,
                onPressed: () => showGetCodeDialog(context, state.themeModel),
                child: Text(docsChrome(locale, 'getCode')),
              ),
            )
          else
            SizedBox(
              height: 32,
              child: Button(
                variant: ButtonVariant.primary,
                size: ButtonSize.sm,
                onPressed: () => delegate.go(context, '/docs/installation'),
                child: Text(docsChrome(locale, 'getStarted')),
              ),
            ),
        ],
      ],
    );
  }
}

/// The header locale switcher: a globe button showing the current language.
///
/// Lists every locale the kit ships (from
/// `ComponentLocalizations.supportedLocales` — never a hard-coded subset)
/// with its native name. Choosing one switches the whole website immediately
/// (same page), persists to localStorage + `?locale=` and flips text
/// direction for RTL languages via the app locale.
class DocsLocaleSwitcher extends StatelessWidget {
  /// Creates the switcher.
  const DocsLocaleSwitcher({super.key, required this.state});

  /// Locale state (current choice + setter).
  final DocsState state;

  /// Short trigger label for [locale] (`EN`, `DE`, `PT-BR`, `繁`, `简`).
  ///
  /// Kept for tests (trigger-label unit coverage); the trigger itself stays
  /// icon-only — the bar has no room for the code next to eight nav items.
  static String triggerLabel(Locale locale) {
    final String tag = docsLocaleTag(locale);
    if (tag == 'zh_Hant') {
      return '繁';
    }
    if (tag == 'zh_Hans') {
      return '简';
    }
    if (tag == 'pt_BR') {
      return 'PT-BR';
    }
    return locale.languageCode.toUpperCase();
  }

  Future<void> _open(BuildContext context) async {
    final Locale current = state.locale;
    await showPopup<void>(
      context: context,
      alignment: Alignment.topRight,
      anchorAlignment: Alignment.bottomRight,
      offset: const Offset(0, 4),
      maxWidth: 280,
      maxHeight: 360,
      builder: (BuildContext popupContext) => ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 320),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (final Locale locale
                  in ComponentLocalizations.supportedLocales)
                _LocaleRow(
                  locale: locale,
                  selected: docsLocaleTag(locale) == docsLocaleTag(current),
                  onPressed: () {
                    closeOverlay(popupContext);
                    state.setLocale(locale);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Locale locale = state.locale;
    return Tooltip(
      tooltip: (BuildContext context) => Text(
        '${docsChrome(locale, 'language')}: ${docsLocaleNativeName(locale)}',
      ),
      child: SizedBox(
        height: 32,
        child: Button(
          key: const ValueKey<String>('docs-locale-switcher'),
          variant: ButtonVariant.ghost,
          size: ButtonSize.sm,
          onPressed: () => _open(context),
          leading: const Icon(LucideIcons.globe, size: 16),
          child: Text(triggerLabel(locale)),
        ),
      ),
    );
  }
}

/// One locale row in the switcher popup (native name + check on current).
class _LocaleRow extends StatelessWidget {
  /// Creates the row.
  const _LocaleRow({
    required this.locale,
    required this.selected,
    required this.onPressed,
  });

  /// The locale this row selects.
  final Locale locale;

  /// Whether this is the current website locale.
  final bool selected;

  /// Selects the locale (and closes the popup).
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ThemeColors colors = theme.colors;
    return SizedBox(
      height: 32,
      child: Clickable(
        onPressed: onPressed,
        decoration: WidgetStateProperty.resolveWith<Decoration?>((
          Set<WidgetState> states,
        ) {
          if (selected) {
            return BoxDecoration(
              color: colors.accent.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(4),
            );
          }
          if (states.contains(WidgetState.hovered)) {
            return BoxDecoration(
              color: colors.accent,
              borderRadius: BorderRadius.circular(4),
            );
          }
          return null;
        }),
        padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 8),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  docsLocaleNativeName(locale),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: docsText(
                    context,
                    size: 14,
                    weight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
              if (selected)
                Icon(LucideIcons.check, size: 16, color: colors.foreground),
            ],
          ),
        ),
      ),
    );
  }
}

/// The header nav items for [width].
///
/// The reference shows every nav item from `lg` (1024) up; with five items our
/// bar overflows there by 11 px (the labels are measured with the fallback
/// font in tests and with Geist in the browser), so `Blocks` joins the nav at
/// `xl` — the same escalation that adds the GitHub label and the 256 px
/// search — `Flows` joins at 1440 px and `Starters` joins past 1440 px (seven
/// items no longer fit at exactly 1440 in the test font). `Charts` joined the
/// bar as a first-class item after `Components`, so `Blocks` moved up to join
/// with `Flows` at 1440 px and `Themes` joins at 1280 px: 1024 shows four
/// items, 1280 shows five, and every width stays overflow-free. All stay
/// reachable below their escalation through the mobile popper (which renders
/// the whole [kHeaderNav]) and the docs sidebar.
List<DocsNavLink> _headerNavFor(double width) {
  if (width >= 1600) {
    return kHeaderNav;
  }
  if (width >= 1440) {
    return <DocsNavLink>[
      for (final DocsNavLink link in kHeaderNav)
        if (link.location != '/docs/starters') link,
    ];
  }
  if (width >= 1280) {
    return <DocsNavLink>[
      for (final DocsNavLink link in kHeaderNav)
        if (link.location != '/blocks' &&
            link.location != '/docs/flows' &&
            link.location != '/docs/starters')
          link,
    ];
  }
  return <DocsNavLink>[
    for (final DocsNavLink link in kHeaderNav)
      if (link.location != '/blocks' &&
          link.location != '/docs/flows' &&
          link.location != '/docs/starters' &&
          link.location != '/themes')
        link,
  ];
}

bool _navActive(String linkLocation, String current) {
  if (linkLocation == '/') {
    return current == '/';
  }
  if (linkLocation == '/docs/components') {
    return current.startsWith('/docs/components');
  }
  if (linkLocation == '/charts') {
    return current.startsWith('/charts');
  }
  if (linkLocation == '/blocks') {
    return current.startsWith('/blocks');
  }
  if (linkLocation == '/docs/flows') {
    return current.startsWith('/docs/flows');
  }
  if (linkLocation == '/docs/starters') {
    return current.startsWith('/docs/starters');
  }
  if (linkLocation == '/docs') {
    return current.startsWith('/docs') &&
        !current.startsWith('/docs/components') &&
        !current.startsWith('/docs/flows') &&
        !current.startsWith('/docs/starters');
  }
  return current == linkLocation;
}

class _HeaderFocusAnchor extends StatefulWidget {
  const _HeaderFocusAnchor();

  @override
  State<_HeaderFocusAnchor> createState() => _HeaderFocusAnchorState();
}

class _HeaderFocusAnchorState extends State<_HeaderFocusAnchor> {
  final FocusNode _node = FocusNode(debugLabel: 'header-focus-anchor');

  @override
  void initState() {
    super.initState();
    // Post-frame: the route's focus scope grabs focus during the first
    // build; asking afterwards makes the header the traversal origin.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _node.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      FocusableActionDetector(focusNode: _node, child: const SizedBox.shrink());
}

class _NavLink extends StatelessWidget {
  const _NavLink({
    required this.link,
    required this.active,
    required this.onPressed,
  });

  final DocsNavLink link;
  final bool active;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeColors colors = Theme.of(context).colors;
    return SizedBox(
      height: 32,
      child: Button(
        variant: ButtonVariant.ghost,
        size: ButtonSize.sm,
        theme: ButtonVariantStyle(
          // Spec §2.0 measures the reference nav link at `px-2.5` (10 px
          // horizontal); the kit button's default padding is wider, which with
          // five nav items overflows the 64 px bar at exactly 1024 px.
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          foreground: StateValue<ThemedColor>(
            rest: ThemedColor.value(
              active ? colors.foreground : colors.mutedForeground,
            ),
            hovered: ThemedColor.value(colors.foreground),
          ),
        ),
        onPressed: onPressed,
        child: Text(link.label),
      ),
    );
  }
}

/// The search trigger; exact `h-8`/pl-3/muted surface layout (spec §2.0).
class _SearchTrigger extends StatelessWidget {
  const _SearchTrigger({
    required this.width,
    required this.label,
    required this.onPressed,
  });

  final double width;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeColors colors = Theme.of(context).colors;
    final ThemeData theme = Theme.of(context);
    return SizedBox(
      key: const ValueKey<String>('docs-search-trigger'),
      width: width,
      height: 32,
      child: Clickable(
        onPressed: onPressed,
        decoration: WidgetStateProperty.resolveWith<Decoration?>((
          Set<WidgetState> states,
        ) {
          return BoxDecoration(
            color: colors.muted.withValues(
              alpha: states.contains(WidgetState.hovered) ? 0.5 : 1,
            ),
            borderRadius: Theme.of(context).borderRadiusLg,
          );
        }),
        padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 12),
        ),
        textStyle: WidgetStatePropertyAll<TextStyle?>(
          docsText(context, size: 14, color: colors.mutedForeground),
        ),
        child: Row(
          // Explicitly centred: the h-5 kbd hint sits mid-field in the 32 px
          // trigger (P7-WC2).
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(LucideIcons.search, size: 14, color: colors.mutedForeground),
            Gap(theme.spacing.sm),
            Expanded(
              child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            // The reference shows the palette shortcut as a kbd at the right
            // of the field; tapping anywhere (hint included) opens the
            // palette through the trigger's `onPressed`, and ⌘K / Ctrl+K is
            // bound globally in `main.dart`.
            Gap(theme.spacing.sm),
            const _SearchHint(),
          ],
        ),
      ),
    );
  }
}

/// Whether [platform] uses the ⌘ glyph for the palette hint.
bool _hintUsesCommand(TargetPlatform platform) {
  return platform == TargetPlatform.macOS || platform == TargetPlatform.iOS;
}

/// The palette shortcut hint (⌘K on macOS/iOS, Ctrl K elsewhere) at the
/// right of the search field.
///
/// The registry `keyboard_shortcut` component in its default `subtle` Kbd
/// styling (P7-WC2): two separate caps with the muted fill, the `border`
/// outline and the fixed 4 px radius — the same key caps the component drew
/// before, replacing the one-bubble "⌘K" that read too small and crammed
/// against the field's right edge. Tapping anywhere on the trigger (the hint
/// included) opens the palette through `onPressed`.
class _SearchHint extends StatelessWidget {
  const _SearchHint();

  @override
  Widget build(BuildContext context) {
    return KeyboardShortcut(
      keys: <LogicalKeyboardKey>[
        // The cap glyph table maps `meta` to ⌘ and `control` to Ctrl.
        if (_hintUsesCommand(defaultTargetPlatform))
          LogicalKeyboardKey.meta
        else
          LogicalKeyboardKey.control,
        LogicalKeyboardKey.keyK,
      ],
    );
  }
}

class _BarSeparator extends StatelessWidget {
  const _BarSeparator();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      child: Divider(
        axis: Axis.vertical,
        thickness: 1,
        color: ThemedColor.value(Theme.of(context).colors.border),
      ),
    );
  }
}

/// The mobile navigation drawer: a left panel sliding in over a dimmed
/// scrim (the shell owns the scrim + slide animation). Solid background
/// with a right rule, `Menu` group then `Sections`, gap 12.
class DocsMobileNav extends StatelessWidget {
  /// Creates the mobile nav.
  const DocsMobileNav({
    super.key,
    required this.delegate,
    required this.currentLocation,
    required this.onNavigate,
    required this.locale,
  });

  /// Router delegate.
  final DocsRouterDelegate delegate;

  /// Current canonical location.
  final String currentLocation;

  /// Called after a link is chosen (closes the drawer).
  final VoidCallback onNavigate;

  /// Website locale for the group + link labels.
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double width = MediaQuery.sizeOf(context).width;
    final double headerHeight = width >= 1024
        ? DocsMetrics.headerHeightLg
        : DocsMetrics.headerHeightSm;
    List<DocsNavLink> translated(List<DocsNavLink> links) => <DocsNavLink>[
      for (final DocsNavLink link in links)
        DocsNavLink(
          label:
              link.location.startsWith('/docs') &&
                  link.location != '/' &&
                  kDocsSections.any(
                    (DocsNavLink s) => s.location == link.location,
                  )
              ? docsSectionLabel(link.location, locale)
              : docsHeaderNavLabel(link.location, locale),
          location: link.location,
        ),
    ];
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height - headerHeight,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colors.background,
          border: Border(right: BorderSide(color: theme.colors.border)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _MobileGroup(
                label: docsChrome(locale, 'menu'),
                links: translated(kHeaderNav),
                currentLocation: currentLocation,
                delegate: delegate,
                onNavigate: onNavigate,
              ),
              const Gap(48),
              _MobileGroup(
                label: docsChrome(locale, 'sideSections'),
                links: translated(kDocsSections),
                currentLocation: currentLocation,
                delegate: delegate,
                onNavigate: onNavigate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileGroup extends StatelessWidget {
  const _MobileGroup({
    required this.label,
    required this.links,
    required this.currentLocation,
    required this.delegate,
    required this.onNavigate,
  });

  final String label;
  final List<DocsNavLink> links;
  final String currentLocation;
  final DocsRouterDelegate delegate;
  final VoidCallback onNavigate;

  @override
  Widget build(BuildContext context) {
    final ThemeColors colors = Theme.of(context).colors;
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: docsText(
            context,
            size: 14,
            weight: FontWeight.w500,
            color: colors.mutedForeground,
          ),
        ),
        Gap(theme.spacing.md),
        for (final DocsNavLink link in links)
          Padding(
            padding: EdgeInsets.only(bottom: theme.spacing.md),
            child: Clickable(
              onPressed: () {
                onNavigate();
                delegate.go(context, link.location);
              },
              behavior: HitTestBehavior.opaque,
              child: Text(
                link.label,
                style: docsText(context, size: 18, weight: FontWeight.w500),
              ),
            ),
          ),
      ],
    );
  }
}
