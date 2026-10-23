import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'color_tokens.dart';
import 'density.dart';
import 'density_tokens.dart';
import 'motion.dart';
import 'syntax_colors.dart';
import 'tokens.dart';
import 'typography.dart';

/// How a popup-style overlay adapts to narrow widths.
///
/// The responsive-popups rule: `auto` (the default) anchors to the trigger
/// at >= [kPopupAdaptiveBreakpoint] and becomes an edge-anchored bottom
/// sheet below it. `anchored` always anchors (tooltips), `sheet` always
/// uses the sheet. Overridable per component through the `adaptive`
/// parameter on every `show*` helper and [ThemeData.popupAdaptive].
enum PopupAdaptive { anchored, sheet, auto }

/// Width below which `auto` popups become bottom sheets (tablet portrait
/// and phones). Matches the `color_input` popover/dialog switch.
const double kPopupAdaptiveBreakpoint = 768.0;

/// Horizontal gutter of the bottom sheet (each side).
const double kPopupSheetGutter = 12.0;

/// Maximum sheet height as a fraction of the screen height.
const double kPopupSheetMaxHeightFraction = 0.7;

/// Whether [width] resolves [adaptive] to the bottom sheet.
bool popupUsesSheet(double width, PopupAdaptive adaptive) {
  return switch (adaptive) {
    PopupAdaptive.anchored => false,
    PopupAdaptive.sheet => true,
    PopupAdaptive.auto => width < kPopupAdaptiveBreakpoint,
  };
}

/// How [TouchHitArea] treats desktop-density controls on touch platforms.
///
/// See `primitives/touch_hit_area.dart`. `padded` (the default) expands the
/// hit-test region and the semantics tap target to the platform minimum
/// (iOS 44, Android 48) with no layout change (SIZING.md: same sizes on
/// desktop and mobile); `shrinkWrap` skips the expansion entirely.
enum TouchTargets { padded, shrinkWrap }

/// Ambient dashcn theme data: colors, tokens, fonts, typography and flags.
class ThemeData {
  const ThemeData({
    this.colors = ThemeColors.lightFallback,
    this.tokens = const DesignTokens(),
    this.fonts = ThemeFonts.empty,
    this.typography = const Typography.geist(),
    this.iconTheme = const IconThemeProperties(),
    this.scaling = 1,
    this.density = Density.defaultDensity,
    this.densityTokens = DensityTokens.compact,
    this.spacing = const SpacingScale(4.0),
    this.tracking = const TrackingScale(),
    this.touchTargets = TouchTargets.padded,
    this._platform,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.enableFeedback,
    this.syntax,
    this.motion = const MotionTokens(),
    this.popupAdaptive = PopupAdaptive.auto,
  });

  /// Color tokens for the current brightness.
  final ThemeColors colors;

  /// Non-color tokens (radius factor, spacing base, tracking, shadows).
  final DesignTokens tokens;

  /// Mode-independent font families.
  final ThemeFonts fonts;

  /// Text styles.
  final Typography typography;

  /// Icon sizes.
  final IconThemeProperties iconTheme;

  /// Global size scaling factor.
  final double scaling;

  /// Container/content padding and gap bases.
  final Density density;

  /// Sizing/density tokens (compact default). See `density_tokens.dart`.
  final DensityTokens densityTokens;

  /// Spacing scale for padding/margins.
  final SpacingScale spacing;

  /// Letter-spacing scale.
  final TrackingScale tracking;

  /// Whether touch platforms grow controls with transparent hit padding.
  final TouchTargets touchTargets;

  final TargetPlatform? _platform;

  /// Surface overlay opacity for popups/cards (read by surface components).
  final double? surfaceOpacity;

  /// Surface blur radius for popups/cards.
  final double? surfaceBlur;

  /// Haptic/sound feedback toggle for interactive controls.
  final bool? enableFeedback;

  /// Syntax-highlight palette override. Null (the default) resolves
  /// [syntaxColors] from the ambient brightness, so every preset works with
  /// no per-preset JSON edits; set it to pin a custom palette.
  final SyntaxColors? syntax;

  /// Motion tokens: durations, curves and the enabled flag.
  ///
  /// Read as `Theme.of(context).motion`. Preset JSON files carry no motion
  /// values; the defaults apply until the Theme Studio motion toggle writes
  /// one.
  final MotionTokens motion;

  /// Responsive-popups token: how popup-style overlays adapt to narrow
  /// widths. `auto` (default) anchors at >= 768 and sheets below.
  final PopupAdaptive popupAdaptive;

  /// Effective syntax-highlight palette for the current brightness.
  SyntaxColors get syntaxColors =>
      syntax ?? SyntaxColors.forBrightness(colors.brightness);

  /// Effective platform (override or ambient default).
  TargetPlatform get platform => _platform ?? defaultTargetPlatform;

  /// Explicit platform override, if any.
  TargetPlatform? get specifiedPlatform => _platform;

  /// Current brightness, from the color tokens.
  Brightness get brightness => colors.brightness;

  /// Base radius factor: the preset `radius` rem number (e.g. 0.625).
  ///
  /// Derived steps follow upstream `globals.css`: `lg` is the rem value in
  /// px (`radius * 16`); `sm`/`md` step down 4/2 px and `xl` steps up
  /// 4 px, clamped at zero so small radii (and 0) never go negative.
  /// `xl` additionally collapses to 0 when `lg` is 0, so square-corner
  /// presets (`radius: 0`) stay square on `rounded-xl` surfaces too.
  /// `xs`/`xxl` are kit extensions that keep the old linear steps.
  double get radius => tokens.radius;
  double get radiusXs => radius * 4;
  double get radiusSm => max(0.0, radiusLg - 4);
  double get radiusMd => max(0.0, radiusLg - 2);
  double get radiusLg => radius * 16;
  double get radiusXl => radiusLg <= 0 ? 0 : radiusLg + 4;
  double get radiusXxl => radius * 24;

  BorderRadius get borderRadiusXs => BorderRadius.circular(radiusXs);
  BorderRadius get borderRadiusSm => BorderRadius.circular(radiusSm);
  BorderRadius get borderRadiusMd => BorderRadius.circular(radiusMd);
  BorderRadius get borderRadiusLg => BorderRadius.circular(radiusLg);
  BorderRadius get borderRadiusXl => BorderRadius.circular(radiusXl);
  BorderRadius get borderRadiusXxl => BorderRadius.circular(radiusXxl);

  ThemeData copyWith({
    ValueGetter<ThemeColors>? colors,
    ValueGetter<DesignTokens>? tokens,
    ValueGetter<ThemeFonts>? fonts,
    ValueGetter<Typography>? typography,
    ValueGetter<IconThemeProperties>? iconTheme,
    ValueGetter<double>? scaling,
    ValueGetter<Density>? density,
    ValueGetter<DensityTokens>? densityTokens,
    ValueGetter<SpacingScale>? spacing,
    ValueGetter<TrackingScale>? tracking,
    ValueGetter<TouchTargets>? touchTargets,
    ValueGetter<TargetPlatform>? platform,
    ValueGetter<double>? surfaceOpacity,
    ValueGetter<double>? surfaceBlur,
    ValueGetter<bool>? enableFeedback,
    ValueGetter<SyntaxColors?>? syntax,
    ValueGetter<MotionTokens>? motion,
    ValueGetter<PopupAdaptive>? popupAdaptive,
  }) {
    final nextDensity = density == null ? this.density : density();
    final nextSpacing = spacing == null
        ? (density == null ? this.spacing : nextDensity.toSpacingScale())
        : spacing();
    return ThemeData(
      colors: colors == null ? this.colors : colors(),
      tokens: tokens == null ? this.tokens : tokens(),
      fonts: fonts == null ? this.fonts : fonts(),
      typography: typography == null ? this.typography : typography(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      scaling: scaling == null ? this.scaling : scaling(),
      density: nextDensity,
      densityTokens: densityTokens == null
          ? this.densityTokens
          : densityTokens(),
      spacing: nextSpacing,
      tracking: tracking == null ? this.tracking : tracking(),
      touchTargets: touchTargets == null ? this.touchTargets : touchTargets(),
      platform: platform == null ? _platform : platform(),
      surfaceOpacity: surfaceOpacity == null
          ? this.surfaceOpacity
          : surfaceOpacity(),
      surfaceBlur: surfaceBlur == null ? this.surfaceBlur : surfaceBlur(),
      enableFeedback: enableFeedback == null
          ? this.enableFeedback
          : enableFeedback(),
      syntax: syntax == null ? this.syntax : syntax(),
      motion: motion == null ? this.motion : motion(),
      popupAdaptive: popupAdaptive == null
          ? this.popupAdaptive
          : popupAdaptive(),
    );
  }

  static ThemeData lerp(ThemeData a, ThemeData b, double t) {
    if (t <= 0.0) {
      return a;
    }
    if (t >= 1.0) {
      return b;
    }
    if (a == b) {
      return a;
    }
    // A light/dark toggle changes colours only: every structural leg below is
    // identical, so it is reused by identity instead of re-lerping 36 text
    // styles and 8 shadow lists on every animation frame (P7-WD).
    return ThemeData(
      colors: a.colors == b.colors
          ? a.colors
          : ThemeColors.lerp(a.colors, b.colors, t),
      tokens: a.tokens == b.tokens
          ? a.tokens
          : DesignTokens.lerp(a.tokens, b.tokens, t),
      fonts: a.fonts == b.fonts
          ? a.fonts
          : ThemeFonts.lerp(a.fonts, b.fonts, t),
      typography: a.typography == b.typography
          ? a.typography
          : Typography.lerp(a.typography, b.typography, t),
      iconTheme: a.iconTheme == b.iconTheme
          ? a.iconTheme
          : IconThemeProperties.lerp(a.iconTheme, b.iconTheme, t),
      scaling: a.scaling == b.scaling
          ? a.scaling
          : lerpDouble(a.scaling, b.scaling, t)!,
      density: a.density == b.density
          ? a.density
          : Density.lerp(a.density, b.density, t),
      densityTokens: a.densityTokens == b.densityTokens
          ? a.densityTokens
          : DensityTokens.lerp(a.densityTokens, b.densityTokens, t),
      spacing: a.spacing == b.spacing
          ? a.spacing
          : SpacingScale.lerp(a.spacing, b.spacing, t),
      tracking: a.tracking == b.tracking
          ? a.tracking
          : TrackingScale.lerp(a.tracking, b.tracking, t),
      touchTargets: a.touchTargets == b.touchTargets
          ? a.touchTargets
          : (t < 0.5 ? a.touchTargets : b.touchTargets),
      platform: t < 0.5 ? a._platform : b._platform,
      surfaceOpacity: a.surfaceOpacity == b.surfaceOpacity
          ? a.surfaceOpacity
          : lerpDouble(a.surfaceOpacity, b.surfaceOpacity, t),
      surfaceBlur: a.surfaceBlur == b.surfaceBlur
          ? a.surfaceBlur
          : lerpDouble(a.surfaceBlur, b.surfaceBlur, t),
      enableFeedback: t < 0.5 ? a.enableFeedback : b.enableFeedback,
      syntax: t < 0.5 ? a.syntax : b.syntax,
      motion: a.motion == b.motion
          ? a.motion
          : MotionTokens.lerp(a.motion, b.motion, t),
      popupAdaptive: t < 0.5 ? a.popupAdaptive : b.popupAdaptive,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ThemeData &&
        other.colors == colors &&
        other.tokens == tokens &&
        other.fonts == fonts &&
        other.typography == typography &&
        other.iconTheme == iconTheme &&
        other.scaling == scaling &&
        other.density == density &&
        other.densityTokens == densityTokens &&
        other.spacing == spacing &&
        other.tracking == tracking &&
        other.touchTargets == touchTargets &&
        other._platform == _platform &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur &&
        other.enableFeedback == enableFeedback &&
        other.syntax == syntax &&
        other.motion == motion &&
        other.popupAdaptive == popupAdaptive;
  }

  @override
  int get hashCode => Object.hash(
    colors,
    tokens,
    fonts,
    typography,
    iconTheme,
    scaling,
    density,
    densityTokens,
    spacing,
    tracking,
    touchTargets,
    _platform,
    surfaceOpacity,
    surfaceBlur,
    enableFeedback,
    syntax,
    motion,
    popupAdaptive,
  );
}

/// Provides [ThemeData] to descendants.
class Theme extends InheritedTheme {
  const Theme({super.key, required this.data, required super.child});

  /// Theme data for this subtree.
  final ThemeData data;

  /// Nearest ambient data, defaulting to `const ThemeData()`.
  /// Dark themes pass through readability normalisation.
  static ThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<Theme>();
    final data = theme?.data ?? const ThemeData();
    return ensureReadableDarkTheme(data);
  }

  /// Patches near-black-on-dark foregrounds against luminance floors.
  /// Fires only for dark themes on dark backgrounds; kept from the old
  /// `Theme._ensureReadableDarkTheme` verbatim (thresholds included).
  static ThemeData ensureReadableDarkTheme(ThemeData data) {
    final scheme = data.colors;
    if (scheme.brightness != Brightness.dark) return data;
    if (scheme.background.computeLuminance() >= 0.5) return data;
    const defaults = ThemeColors.darkFallback;
    Color readable(Color color, Color fallback, double minLuminance) {
      return color.computeLuminance() < minLuminance ? fallback : color;
    }

    final normalized = scheme.copyWith(
      foreground: readable(scheme.foreground, defaults.foreground, 0.5),
      mutedForeground: readable(
        scheme.mutedForeground,
        defaults.mutedForeground,
        0.35,
      ),
      cardForeground: readable(
        scheme.cardForeground,
        defaults.cardForeground,
        0.45,
      ),
      popoverForeground: readable(
        scheme.popoverForeground,
        defaults.popoverForeground,
        0.45,
      ),
      sidebarForeground: readable(
        scheme.sidebarForeground,
        defaults.sidebarForeground,
        0.45,
      ),
    );
    if (normalized == scheme) return data;
    return data.copyWith(colors: () => normalized);
  }

  @override
  bool updateShouldNotify(covariant Theme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    final ancestor = context.findAncestorWidgetOfExactType<Theme>();
    return identical(this, ancestor) ? child : Theme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ThemeData>('data', data));
  }
}

/// Animates [ThemeData] changes implicitly.
class AnimatedTheme extends ImplicitlyAnimatedWidget {
  const AnimatedTheme({
    super.key,
    required this.data,
    required super.duration,
    super.curve,
    required this.child,
  });

  /// Target theme data.
  final ThemeData data;

  /// Widget below this widget in the tree.
  final Widget child;

  @override
  AnimatedWidgetBaseState<AnimatedTheme> createState() => _AnimatedThemeState();
}

class _AnimatedThemeState extends AnimatedWidgetBaseState<AnimatedTheme> {
  ThemeDataTween? _data;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _data =
        visitor(
              _data,
              widget.data,
              (dynamic value) => ThemeDataTween(begin: value as ThemeData),
            )
            as ThemeDataTween?;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(data: _data!.evaluate(animation), child: widget.child);
  }
}

/// Tween for [ThemeData].
class ThemeDataTween extends Tween<ThemeData> {
  ThemeDataTween({super.begin, super.end});

  @override
  ThemeData lerp(double t) {
    if (end == null) return begin!;
    return ThemeData.lerp(begin!, end!, t);
  }
}

/// Base of every `<Name>Theme` component theme class. Carries optional
/// density/spacing/shadow overrides scoped to that component.
abstract class ComponentThemeData {
  const ComponentThemeData({
    this.themeDensity,
    this.themeDensityTokens,
    this.themeSpacing,
    this.themeShadows,
  });

  /// Optional density override for this component theme.
  final Density? themeDensity;

  /// Optional sizing/density tokens override (compact default). Wins over
  /// [themeDensity] when both are set on the same leg.
  final DensityTokens? themeDensityTokens;

  /// Optional spacing override for this component theme.
  final SpacingScale? themeSpacing;

  /// Optional shadow override for this component theme.
  final ShadowScale? themeShadows;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComponentThemeData &&
          runtimeType == other.runtimeType &&
          other.themeDensity == themeDensity &&
          other.themeDensityTokens == themeDensityTokens &&
          other.themeSpacing == themeSpacing &&
          other.themeShadows == themeShadows;

  @override
  int get hashCode => Object.hash(
    runtimeType,
    themeDensity,
    themeDensityTokens,
    themeSpacing,
    themeShadows,
  );
}

/// Tree-scoped component theme. Lookup is tree-only: it never falls back to
/// the app leg (that leg is [ComponentThemes], read separately by
/// [resolveComponentStyle]).
class ComponentTheme<T extends ComponentThemeData> extends InheritedTheme {
  const ComponentTheme({super.key, required this.data, required super.child});

  /// Theme data for type [T] in this subtree.
  final T data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final ancestor = context.findAncestorWidgetOfExactType<ComponentTheme<T>>();
    if (identical(this, ancestor)) return child;
    return ComponentTheme<T>(data: data, child: child);
  }

  /// Nearest tree ancestor data. Throws when absent.
  static T of<T extends ComponentThemeData>(BuildContext context) {
    final data = maybeOf<T>(context);
    assert(data != null, 'No ComponentTheme<$T> found in context');
    return data!;
  }

  /// Nearest tree ancestor data, or null. Never reads [ComponentThemes].
  static T? maybeOf<T extends ComponentThemeData>(BuildContext context) {
    final widget = context
        .dependOnInheritedWidgetOfExactType<ComponentTheme<T>>();
    return widget?.data;
  }

  @override
  bool updateShouldNotify(covariant ComponentTheme<T> oldWidget) {
    return oldWidget.data != data;
  }
}

/// App-override leg: user-owned `<name>_theme.dart` values, one entry per
/// installed component, provided once at the app root (the generated
/// `component_themes.dart` exports `const appComponentThemes`, a
/// `List<ComponentThemeData>` passed here by the app widget).
/// A different widget type from [ComponentTheme], so the app leg and the
/// tree-scoped leg stay distinct; read together only by [resolveComponentStyle].
class ComponentThemes extends InheritedWidget {
  const ComponentThemes({
    super.key,
    required this.themes,
    required super.child,
  });

  /// App-override entries, one per component type.
  final List<ComponentThemeData> themes;

  /// Entry of type [T] from the nearest [ComponentThemes], or null.
  static T? maybeOf<T extends ComponentThemeData>(BuildContext context) {
    final widget = context
        .dependOnInheritedWidgetOfExactType<ComponentThemes>();
    if (widget == null) return null;
    for (final theme in widget.themes) {
      if (theme is T) return theme;
    }
    return null;
  }

  @override
  bool updateShouldNotify(covariant ComponentThemes oldWidget) {
    if (identical(oldWidget.themes, themes)) return false;
    if (oldWidget.themes.length != themes.length) return true;
    for (var i = 0; i < themes.length; i++) {
      if (oldWidget.themes[i] != themes[i]) return true;
    }
    return false;
  }
}

/// Which theme mode to use.
enum ThemeMode { system, light, dark }

/// Generic four-leg resolver. [select] picks the component's slice out of a
/// theme container; legs merge via [Mergeable.merge] so a higher-priority
/// leg setting only one state never wipes a lower leg's other states.
/// Leg order: defaults < app ([ComponentThemes]) < scoped ([ComponentTheme]
/// in tree) < widget.
S resolveComponentStyle<T extends ComponentThemeData, S extends Mergeable<S>>(
  BuildContext context, {
  S? widget,
  required S? Function(T) select,
  required S defaults,
}) {
  var acc = defaults;
  final app = ComponentThemes.maybeOf<T>(context);
  if (app != null) {
    final slice = select(app);
    if (slice != null) acc = slice.merge(acc);
  }
  final scoped = ComponentTheme.maybeOf<T>(context);
  if (scoped != null) {
    final slice = select(scoped);
    if (slice != null) acc = slice.merge(acc);
  }
  if (widget != null) acc = widget.merge(acc);
  return acc;
}
