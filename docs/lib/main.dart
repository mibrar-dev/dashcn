// Entry point of the docs web app (P6 rebuild).
//
// Composition: a root `Router` owns URL/history (delegate + parser in
// `routing/docs_router.dart`); the delegate builds the registry `DashcnApp`
// shell around a docs navigator. The shell installs the theme (one swap per
// commit under a ~250ms snapshot cross-fade on preset/mode switches,
// instant under reduced motion), the global keyboard shortcuts and the
// web-bridge events.
//
// Brightness defaults to the system (the reference's `next-themes` default);
// the header toggle stores an explicit mode. The platform listener below
// forwards system changes while no explicit mode is stored.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'motion/ease.dart';
import 'motion/motion_scope.dart';
import 'pages/blocks_pages.dart' deferred as blocks_pages;
import 'pages/flows_pages.dart' deferred as flows_pages;
import 'pages/starters_pages.dart' deferred as starters_pages;
import 'pages/charts_family_page.dart';
import 'pages/charts_hub_page.dart';
import 'pages/cli_reference.dart';
import 'pages/component_page.dart' deferred as component_page;
import 'pages/components_index_page.dart';
import 'pages/dark_mode_page.dart';
import 'pages/internationalization_page.dart';
import 'pages/getting_started.dart';
import 'pages/introduction_page.dart';
import 'pages/landing_page.dart';
import 'pages/material_interop_page.dart';
import 'pages/package_or_own_page.dart';
import 'pages/placeholder_page.dart';
import 'pages/scorecards_page.dart';
import 'pages/themes.dart';
import 'pages/theming_page.dart';
import 'routing/deferred_page.dart';
import 'routing/docs_router.dart';
import 'state/docs_sample_strings.dart';
import 'state/docs_state.dart';
import 'state/docs_storage.dart';
import 'theme/docs_fonts.dart';
import 'theme/theme_document.dart';
import 'ui/dashcn/components/app/app.dart';
import 'ui/dashcn/components/drawer/drawer.dart';
import 'ui/dashcn/components/gooey_toast/gooey_toast.dart';
import 'ui/dashcn/components/toast/toast.dart';
import 'ui/dashcn/theme/color_tokens.dart';
import 'ui/dashcn/theme/theme.dart';
import 'web_bridge.dart';
import 'widgets/docs_shell.dart';
import 'widgets/palette.dart';
import 'widgets/theme_switch_transition.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  installDocsSampleResolver();
  final DocsState state = DocsState(
    storage: const DocsStorage(),
    systemBrightness:
        WidgetsBinding.instance.platformDispatcher.platformBrightness,
  )..restore();
  runApp(DocsApp(state: state));
}

/// The docs application root.
class DocsApp extends StatefulWidget {
  /// Creates the app.
  const DocsApp({super.key, required this.state});

  /// Theme/navigation state shared by the shell and the pages.
  final DocsState state;

  @override
  State<DocsApp> createState() => _DocsAppState();
}

class _DocsAppState extends State<DocsApp> with WidgetsBindingObserver {
  late final DocsRouterDelegate _delegate = DocsRouterDelegate(
    state: widget.state,
    pageBuilder: buildDocsPage,
    paletteBuilder: buildDocsPalette,
    shellBuilder: _buildShell,
  );

  // Owned here: `Router` does not create a provider, only `WidgetsApp` does.
  // Without this the initial URL is never parsed and URL reports are dropped.
  late final PlatformRouteInformationProvider _routeInformationProvider;

  // P7-WA: drawer/sheet background scale. The observer watches the root
  // navigator for `DrawerRoute`s; the wrapper (in `_buildShell`)
  // scales the shell while one is open.
  final DrawerScaleObserver _drawerScaleObserver = DrawerScaleObserver();

  /// The last tap point, in global coordinates (P7-TS1: the circular
  /// reveal expands from here). Written on pointer-down, read on switch.
  Offset? _switchOrigin;

  @override
  void initState() {
    super.initState();
    installDocsSampleResolver();
    setDocsSampleLocale(widget.state.locale);
    // Web deep links (`/docs/...`, `/charts/...`) resolve from the browser
    // URL (`Uri.base`) on http(s), not the `"/"` default route, so release
    // builds served with an SPA fallback land on the linked page. Tests
    // (`file://`) keep the `"/"` landing.
    final Uri initialUri =
        (Uri.base.scheme == 'http' || Uri.base.scheme == 'https')
        ? Uri.base
        : Uri.parse(
            WidgetsBinding.instance.platformDispatcher.defaultRouteName,
          );
    _routeInformationProvider = PlatformRouteInformationProvider(
      initialRouteInformation: RouteInformation(uri: initialUri),
    );
    WidgetsBinding.instance.addObserver(this);
    widget.state.addListener(_onThemeChanged);
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      dispatchWebAppReady();
      _onThemeChanged();
    });
    // A restored document names families the picker loads on demand. Load
    // them once at startup so a reload paints in the right families.
    _loadRestoredFonts();
  }

  /// Lazily loads the families the persisted document names.
  void _loadRestoredFonts() {
    final ThemeDocument document = widget.state.themeModel.document;
    loadDocsFonts(document.headingFont ?? '');
    loadDocsFonts(document.bodyFont ?? '');
    loadDocsFonts(document.monoFont ?? '');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    widget.state.removeListener(_onThemeChanged);
    _delegate.dispose();
    _routeInformationProvider.dispose();
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    widget.state.setSystemBrightness(
      WidgetsBinding.instance.platformDispatcher.platformBrightness,
    );
  }

  void _onThemeChanged() {
    dispatchWebThemeChanged(_themeEventColors(widget.state.theme));
  }

  @override
  Widget build(BuildContext context) {
    return Router<DocsRouteConfiguration>(
      routeInformationProvider: _routeInformationProvider,
      routerDelegate: _delegate,
      routeInformationParser: DocsRouteInformationParser(state: widget.state),
      backButtonDispatcher: RootBackButtonDispatcher(),
    );
  }

  Widget _buildShell(BuildContext context, Widget navigator) {
    final DocsState state = widget.state;
    return ListenableBuilder(
      listenable: state,
      builder: (BuildContext context, Widget? _) {
        // Resolved per build: the model caches per document, so every read
        // is the identical instance and unchanged commits stay no-ops.
        // Inside the listener so locale/brightness commits rebuild
        // `DashcnApp` with the fresh theme + locale (same page).
        final ThemeData theme = state.theme;
        return DashcnApp(
          title: 'dashcn',
          debugShowCheckedModeBanner: false,
          color: theme.colors.primary,
          theme: theme,
          locale: state.locale,
          themeMode: state.brightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light,
          // DashcnApp merges `shortcuts`/`actions` over the WidgetsApp defaults
          // (Tab traversal, Enter/Space activation, Escape dismissal survive), so
          // only the docs-specific bindings are listed here.
          shortcuts: docsShortcuts,
          actions: <Type, Action<Intent>>{
            OpenDocsPaletteIntent: CallbackAction<OpenDocsPaletteIntent>(
              onInvoke: (OpenDocsPaletteIntent intent) {
                _delegate.openPalette();
                return null;
              },
            ),
          },
          builder: (BuildContext context, Widget? child) => MotionScope(
            child: Builder(
              builder: (BuildContext context) {
                final DocsThemeTransition kind = state.themeModel.transition;
                return Listener(
                  // The tap point the circular reveal expands from (P7-TS1).
                  // One offset write per pointer-down; never a rebuild.
                  onPointerDown: (PointerDownEvent event) =>
                      _switchOrigin = event.position,
                  child: ThemeSwitchTransition(
                    // One swap per commit, then the picked animation of the old
                    // frame over the new one (P7-WD single swap, P7-TS1 kinds).
                    // Reduced motion swaps instantly whatever is picked.
                    data: theme,
                    duration: context.reduceMotion
                        ? Duration.zero
                        : docsTransitionDuration(kind),
                    curve: kEaseOutExpo,
                    kind: kind,
                    origin: _switchOrigin,
                    child: child ?? const SizedBox.shrink(),
                  ),
                );
              },
            ),
          ),
          // The home route is deliberately unnamed: the docs navigator must be the
          // only thing reporting URLs to the engine (the Router owns history).
          // P7-WA app-level overlay hosting: the gooey layer portals into the
          // root overlay and the toast layer stacks over the window, so toasts
          // anchor to the browser window instead of the preview card that
          // triggered them; the background-scale wrapper dims/scales the shell
          // while a drawer/sheet route is open.
          navigatorObservers: <NavigatorObserver>[_drawerScaleObserver],
          home: GooeyToastLayer(
            child: ToastLayer(
              child: DrawerBackgroundScale(
                observer: _drawerScaleObserver,
                child: DocsAppShell(
                  delegate: _delegate,
                  state: state,
                  child: navigator,
                ),
              ),
            ),
          ),
          pageRouteBuilder:
              <T>(RouteSettings settings, WidgetBuilder builder) =>
                  PageRouteBuilder<T>(
                    settings: const RouteSettings(),
                    pageBuilder:
                        (
                          BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                        ) => builder(context),
                  ),
        );
      },
    );
  }
}

/// Opens the command palette from anywhere (⌘K / Ctrl+K).
class OpenDocsPaletteIntent extends Intent {
  /// Creates the intent.
  const OpenDocsPaletteIntent();
}

/// Global shortcut map handed to [DashcnApp].
const Map<ShortcutActivator, Intent> docsShortcuts =
    <ShortcutActivator, Intent>{
      SingleActivator(LogicalKeyboardKey.keyK, meta: true):
          OpenDocsPaletteIntent(),
      SingleActivator(LogicalKeyboardKey.keyK, control: true):
          OpenDocsPaletteIntent(),
    };

/// Maps a parsed route to its page widget.
///
/// D3 provides the landing, introduction and components index; D4 provides
/// the component template, themes customizer, installation and CLI reference;
/// P8-4 provides the package-or-own and Material interop pages;
/// D4b provides theming and dark mode; P6-B3 provides the Blocks index and
/// block pages (one deferred library, so the block sources never ship with the
/// landing route). The Charts hub and family pages are small and ship with the
/// main chunk. Only unknown URLs fall through to the not-found page.
Widget buildDocsPage(BuildContext context, DocsRouteConfiguration config) {
  return switch (config.route) {
    DocsRoute.landing => LandingPage(),
    DocsRoute.introduction => IntroductionPage(),
    DocsRoute.components => ComponentsIndexPage(),
    DocsRoute.charts => ChartsHubPage(),
    DocsRoute.chartFamily => ChartFamilyPage(familyId: config.chartFamilyId!),
    DocsRoute.component => DeferredPage(
      load: component_page.loadLibrary,
      builder: (BuildContext context) =>
          component_page.ComponentPage(componentId: config.componentId!),
    ),
    DocsRoute.themes => ThemesPage(
      openPanel: config.sourceUri?.queryParameters['panel'],
    ),
    DocsRoute.installation => GettingStartedPage(),
    DocsRoute.packageOrOwn => PackageOrOwnPage(),
    DocsRoute.material => MaterialInteropPage(),
    DocsRoute.theming => ThemingPage(),
    DocsRoute.darkMode => DarkModePage(),
    DocsRoute.internationalization => InternationalizationPage(),
    DocsRoute.cli => CliReferencePage(),
    DocsRoute.scorecards => ScorecardsPage(),
    DocsRoute.blocks => DeferredPage(
      load: blocks_pages.loadLibrary,
      builder: (BuildContext context) => blocks_pages.BlocksIndexPage(),
    ),
    DocsRoute.blockCategory => DeferredPage(
      load: blocks_pages.loadLibrary,
      builder: (BuildContext context) =>
          blocks_pages.BlocksIndexPage(categorySlug: config.blockCategorySlug),
    ),
    DocsRoute.block => DeferredPage(
      load: blocks_pages.loadLibrary,
      builder: (BuildContext context) =>
          blocks_pages.BlockPage(blockId: config.blockId!),
    ),
    DocsRoute.flows => DeferredPage(
      load: flows_pages.loadLibrary,
      builder: (BuildContext context) => flows_pages.FlowsIndexPage(),
    ),
    DocsRoute.flow => DeferredPage(
      load: flows_pages.loadLibrary,
      builder: (BuildContext context) =>
          flows_pages.FlowPage(flowId: config.flowId!),
    ),
    DocsRoute.starters => DeferredPage(
      load: starters_pages.loadLibrary,
      builder: (BuildContext context) => starters_pages.StartersIndexPage(),
    ),
    DocsRoute.starter => DeferredPage(
      load: starters_pages.loadLibrary,
      builder: (BuildContext context) =>
          starters_pages.StarterPage(starterId: config.starterId!),
    ),
    _ => DocsPlaceholderPage(config: config),
  };
}

/// Maps the palette overlay slot to its panel.
Widget buildDocsPalette(BuildContext context, VoidCallback close) {
  return DocsPalette(onClose: close);
}

// ---------------------------------------------------------------------------
// Web-bridge helpers.
// ---------------------------------------------------------------------------

Map<String, String> _themeEventColors(ThemeData data) {
  final ThemeColors c = data.colors;
  return <String, String>{
    'background': _hex(c.background),
    'foreground': _hex(c.foreground),
    'card': _hex(c.card),
    'popover': _hex(c.popover),
    'primary': _hex(c.primary),
    'primaryForeground': _hex(c.primaryForeground),
    'secondary': _hex(c.secondary),
    'muted': _hex(c.muted),
    'mutedForeground': _hex(c.mutedForeground),
    'accent': _hex(c.accent),
    'destructive': _hex(c.destructive),
    'border': _hex(c.border),
    'input': _hex(c.input),
    'ring': _hex(c.ring),
    'radiusLg': data.radiusLg.toStringAsFixed(1),
  };
}

String _hex(Color color) {
  final String argb = color.toARGB32().toRadixString(16).padLeft(8, '0');
  return '#${argb.substring(2).toUpperCase()}';
}
