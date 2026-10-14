// The `app` component: [DashcnApp], the app shell that wires WidgetsApp with
// the upstream theme, component-theme overrides, overlay manager and
// localizations, plus the default text/icon style scope below the theme.
//
// Ported from `layout/app/**` (old tree). The old shell wrapped Material's
// `ThemeData`/`Theme`; the new tree's root is `ThemeData`/`Theme`
// (plus `ComponentThemes` for user overrides), and this component exists only
// to install them — it does not duplicate them.
//
// Old bugs fixed, not ported:
//  * `themeMode: ThemeMode.system` never resolved the dark theme: the old
//    `_resolveTheme` ran at the root, above `WidgetsApp`'s MediaQuery, so
//    `platformBrightness` was always null. The theme now resolves inside the
//    app builder where MediaQuery exists (regression-tested);
//  * the old app installed a manual `Localizations` on top of WidgetsApp's
//    own, with a hand-rolled locale resolver that disagreed with the
//    framework's; WidgetsApp's resolver is used now;
//  * two Material imports (`import 'package:flutter/material.dart' as
//    material`), the `Material` transparency fallback and
//    `registerComponentThemeGlobalConfigs()` global registry.
//
// `shortcuts`/`actions` are merged over [WidgetsApp.defaultShortcuts] and
// [WidgetsApp.defaultActions] (caller entries win): the framework REPLACES its
// defaults when a map is supplied, so forwarding them verbatim killed Tab
// traversal, Enter/Space activation and Escape dismissal in every app that
// set one (regression-tested in `test/registry/components/app_test.dart`).

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';

import '../../foundation/constants.dart';
import '../../primitives/localizations/localizations.dart';
import '../../primitives/overlay.dart';
import '../../primitives/overlay_manager_layer.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import '../eye_dropper/eye_dropper.dart';

/// A upstream-themed application shell.
///
/// ```dart
/// DashcnApp(
///   title: 'My App',
///   theme: appTheme,
///   darkTheme: appDarkTheme,
///   home: const HomePage(),
/// );
/// ```
class DashcnApp extends StatelessWidget {
  /// Creates a dashcn app.
  const DashcnApp({
    super.key,
    this.navigatorKey,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.pageRouteBuilder,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title,
    this.color,
    this.theme = const ThemeData(),
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    this.componentThemes = const <ComponentThemeData>[],
    this.scaling,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = ComponentLocalizations.supportedLocales,
    this.showPerformanceOverlay = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.restorationScopeId,
    this.popoverHandler = OverlayHandler.popover,
    this.tooltipHandler = OverlayHandler.popover,
    this.menuHandler = OverlayHandler.popover,
    this.enableThemeAnimation = false,
  });

  /// See [WidgetsApp.navigatorKey].
  final GlobalKey<NavigatorState>? navigatorKey;

  /// See [WidgetsApp.home].
  final Widget? home;

  /// See [WidgetsApp.routes].
  final Map<String, WidgetBuilder> routes;

  /// See [WidgetsApp.initialRoute].
  final String? initialRoute;

  /// See [WidgetsApp.onGenerateRoute].
  final RouteFactory? onGenerateRoute;

  /// See [WidgetsApp.onGenerateInitialRoutes].
  final InitialRouteListFactory? onGenerateInitialRoutes;

  /// See [WidgetsApp.onUnknownRoute].
  final RouteFactory? onUnknownRoute;

  /// See [WidgetsApp.pageRouteBuilder].
  final PageRouteFactory? pageRouteBuilder;

  /// See [WidgetsApp.navigatorObservers].
  final List<NavigatorObserver> navigatorObservers;

  /// See [WidgetsApp.builder].
  final TransitionBuilder? builder;

  /// See [WidgetsApp.title].
  final String? title;

  /// Overrides the operating-system switcher colour. Defaults to the theme's
  /// `primary` token.
  final Color? color;

  /// The light (or only) theme.
  final ThemeData theme;

  /// The dark theme; falls back to [theme] when null.
  final ThemeData? darkTheme;

  /// Which theme [theme]/[darkTheme] to use.
  final ThemeMode themeMode;

  /// App-wide component-theme overrides (the generated `component_themes.dart`
  /// list); provided through [ComponentThemes].
  final List<ComponentThemeData> componentThemes;

  /// Optional adaptive scaling applied on top of the resolved theme.
  final AdaptiveScaling? scaling;

  /// See [WidgetsApp.locale].
  final Locale? locale;

  /// Extra localization delegates, merged with the upstream delegates.
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// See [WidgetsApp.localeListResolutionCallback].
  final LocaleListResolutionCallback? localeListResolutionCallback;

  /// See [WidgetsApp.localeResolutionCallback].
  final LocaleResolutionCallback? localeResolutionCallback;

  /// See [WidgetsApp.supportedLocales].
  ///
  /// Defaults to [ComponentLocalizations.supportedLocales] — the locales the
  /// upstream delegate can load. (The delegate does not declare `en`: English
  /// is the class fallback, not a translated table — see the README.)
  final Iterable<Locale> supportedLocales;

  /// See [WidgetsApp.showPerformanceOverlay].
  final bool showPerformanceOverlay;

  /// See [WidgetsApp.showSemanticsDebugger].
  final bool showSemanticsDebugger;

  /// See [WidgetsApp.debugShowCheckedModeBanner].
  final bool debugShowCheckedModeBanner;

  /// App-wide keyboard shortcuts, merged over [WidgetsApp.defaultShortcuts].
  ///
  /// `WidgetsApp` *replaces* its defaults when a map is supplied: an app that
  /// passes a single shortcut would otherwise lose Tab traversal
  /// (`NextFocusIntent`), activation (`Enter`/`Space` → `ActivateIntent`) and
  /// dismissal (`Escape` → `DismissIntent`) app-wide. `DashcnApp` therefore
  /// merges, and caller entries win.
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// App-wide intent-to-action bindings, merged over
  /// [WidgetsApp.defaultActions] with the same "caller entries win" rule as
  /// [shortcuts].
  final Map<Type, Action<Intent>>? actions;

  /// See [WidgetsApp.restorationScopeId].
  final String? restorationScopeId;

  /// Handler for popover overlays installed by [OverlayManagerLayer].
  final OverlayHandler popoverHandler;

  /// Handler for tooltip overlays installed by [OverlayManagerLayer].
  final OverlayHandler tooltipHandler;

  /// Handler for menu overlays installed by [OverlayManagerLayer].
  final OverlayHandler menuHandler;

  /// Animates theme changes with [AnimatedTheme] when true.
  final bool enableThemeAnimation;

  /// [WidgetsApp] replaces its defaults when `shortcuts`/`actions` are
  /// non-null, so merge over them instead of forwarding the raw maps.
  ///
  /// Returning null for the unsupplied side keeps `WidgetsApp` on its own
  /// platform-dependent default (identical to the untouched behaviour).
  Map<ShortcutActivator, Intent>? get _mergedShortcuts {
    if (shortcuts == null) {
      return null;
    }
    return <ShortcutActivator, Intent>{
      ...WidgetsApp.defaultShortcuts,
      ...?shortcuts,
    };
  }

  /// See [_mergedShortcuts].
  Map<Type, Action<Intent>>? get _mergedActions {
    if (actions == null) {
      return null;
    }
    return <Type, Action<Intent>>{...WidgetsApp.defaultActions, ...?actions};
  }

  Iterable<LocalizationsDelegate<dynamic>> get _delegates {
    final List<LocalizationsDelegate<dynamic>> delegates =
        <LocalizationsDelegate<dynamic>>[
          ...?localizationsDelegates,
          ...ComponentLocalizations.localizationsDelegates,
          GlobalWidgetsLocalizations.delegate,
        ];
    final Set<Type> seen = <Type>{};
    // Materialised: a lazy `where` over the dedup set would yield an empty
    // iterable on its second iteration, and WidgetsApp iterates the list on
    // every rebuild.
    return delegates
        .where(
          (LocalizationsDelegate<dynamic> delegate) =>
              seen.add(delegate.runtimeType),
        )
        .toList(growable: false);
  }

  /// Default locale resolution: language code first, then script/country,
  /// falling back to the first `supportedLocales` entry (`en`). See
  /// [ComponentLocalizations.resolveLocale].
  static Locale? _resolveLocale(
    Locale? locale,
    Iterable<Locale> supportedLocales,
  ) {
    return locale == null
        ? null
        : ComponentLocalizations.resolveLocale(locale, supportedLocales);
  }

  ThemeData _resolveTheme(BuildContext context) {
    final Brightness platformBrightness =
        MediaQuery.maybeOf(context)?.platformBrightness ??
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final bool useDark =
        themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            platformBrightness == Brightness.dark);
    var data = useDark ? (darkTheme ?? theme) : theme;
    if (scaling != null) {
      data = scaling!.scale(data);
    }
    return data;
  }

  Widget _buildApp(BuildContext context, Widget? child) {
    final ThemeData data = _resolveTheme(context);
    Widget result = child ?? const SizedBox.shrink();
    if (builder != null) {
      result = builder!(context, result);
    }
    // Default text/icon style scope, read from the ambient theme at this
    // position (above the theme installed below).
    final Widget content = result;
    result = Builder(
      builder: (BuildContext context) {
        final ThemeData ambient = Theme.of(context);
        return DefaultTextStyle(
          style: ambient.typography.sans.copyWith(
            color: ambient.colors.foreground,
          ),
          child: IconTheme(
            data: IconThemeData(color: ambient.colors.foreground),
            child: content,
          ),
        );
      },
    );
    // Whole-app eye-dropper sampling: the root layer's RepaintBoundary is the
    // capture source and its loupe + crosshair cover the entire window — above
    // popovers too. Nested `EyeDropperLayer`s delegate sessions here.
    result = EyeDropperLayer(child: result);
    result = enableThemeAnimation
        ? AnimatedTheme(data: data, duration: kDefaultDuration, child: result)
        : Theme(data: data, child: result);
    result = ComponentThemes(themes: componentThemes, child: result);
    // P7-FOCUS: keep everything unbuilt for one frame (see below).
    return _FirstFrameFocusGate(
      child: OverlayManagerLayer(
        popoverHandler: popoverHandler,
        tooltipHandler: tooltipHandler,
        menuHandler: menuHandler,
        child: result,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      navigatorKey: navigatorKey,
      color: color ?? theme.colors.primary,
      title: title,
      onGenerateRoute: onGenerateRoute,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onUnknownRoute: onUnknownRoute,
      initialRoute: initialRoute,
      pageRouteBuilder: pageRouteBuilder ?? _defaultPageRouteBuilder,
      navigatorObservers: navigatorObservers,
      home: home,
      routes: routes,
      builder: _buildApp,
      locale: locale,
      localizationsDelegates: _delegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback ?? _resolveLocale,
      supportedLocales: supportedLocales,
      showPerformanceOverlay: showPerformanceOverlay,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: _mergedShortcuts,
      actions: _mergedActions,
      restorationScopeId: restorationScopeId,
    );
  }
}

PageRoute<T> _defaultPageRouteBuilder<T>(
  RouteSettings settings,
  WidgetBuilder builder,
) {
  return PageRouteBuilder<T>(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
  );
}

/// Keeps [child] out of the tree until after the first frame.
///
/// On web the engine delivers the initial view-focus event before the first
/// layout pass, and the reading-order traversal throws on un-laid-out boxes
/// (`Bad state: RenderBox was not laid out`). Building nothing for one frame
/// makes the traversal find nothing instead.
///
/// An earlier revision hid [child] behind `Focus(descendantsAreTraversable:
/// false)` for one frame; in release web that left the nodes built in the
/// first frame permanently out of tab traversal (the first Tab skipped the
/// whole header — P7I-fix-focus2), while removing the gate brought the
/// view-focus exception back. Not building until the first post-frame keeps
/// both: no focusable exists before the first layout, and every focus node is
/// created after the gate opens so none can be stuck untraversable.
/// `autofocus` still works (those requests run once the subtree exists), and
/// one blank frame is covered by the host page splash.
///
/// Web only: the early view-focus event is a web-engine behaviour, so on other
/// platforms [DashcnApp] builds its content in the first frame as usual (app
/// widget tests need no extra pump). Tests of the gate itself set
/// [debugFirstFrameFocusGateOnAllPlatforms].
class _FirstFrameFocusGate extends StatefulWidget {
  /// Creates a first-frame focus gate around [child].
  const _FirstFrameFocusGate({required this.child});

  /// The subtree built once the first frame completes.
  final Widget child;

  @override
  State<_FirstFrameFocusGate> createState() => _FirstFrameFocusGateState();
}

/// Applies [DashcnApp]'s first-frame focus gate on every platform, not only on
/// the web. For tests of the gate; leave `false` in apps.
@visibleForTesting
bool debugFirstFrameFocusGateOnAllPlatforms = false;

/// State of [_FirstFrameFocusGate]: builds [child] after the first post-frame.
class _FirstFrameFocusGateState extends State<_FirstFrameFocusGate> {
  bool _ready = !kIsWeb && !debugFirstFrameFocusGateOnAllPlatforms;

  @override
  void initState() {
    super.initState();
    if (_ready) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_ready) {
        setState(() => _ready = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _ready ? widget.child : const SizedBox.shrink();
  }
}
