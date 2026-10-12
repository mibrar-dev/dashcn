---
title: "Class: DashcnApp"
description: "A upstream-themed application shell."
---

```dart
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
  /// Creates a upstream app.
  const DashcnApp({super.key, this.navigatorKey, this.home, this.routes = const <String, WidgetBuilder>{}, this.initialRoute, this.onGenerateRoute, this.onGenerateInitialRoutes, this.onUnknownRoute, this.pageRouteBuilder, this.navigatorObservers = const <NavigatorObserver>[], this.builder, this.title, this.color, this.theme = const ThemeData(), this.darkTheme, this.themeMode = ThemeMode.system, this.componentThemes = const <ComponentThemeData>[], this.scaling, this.locale, this.localizationsDelegates, this.localeListResolutionCallback, this.localeResolutionCallback, this.supportedLocales = ComponentLocalizations.supportedLocales, this.showPerformanceOverlay = false, this.showSemanticsDebugger = false, this.debugShowCheckedModeBanner = true, this.shortcuts, this.actions, this.restorationScopeId, this.popoverHandler = OverlayHandler.popover, this.tooltipHandler = OverlayHandler.popover, this.menuHandler = OverlayHandler.popover, this.enableThemeAnimation = false});
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
  Widget build(BuildContext context);
}
```
