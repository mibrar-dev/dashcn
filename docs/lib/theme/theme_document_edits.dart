// Immutable token edits for [ThemeDocument] (D7).
//
// Split out of `theme_document.dart` purely for the ~400-line rule: an
// extension resolves across libraries, so callers import both files. Every
// method returns a new document, which is what lets the Theme Studio drive
// one `AnimatedTheme` tween per edit while the document itself stays
// the single source of truth for the live site, localStorage and the export.

import 'package:flutter/widgets.dart';

import '../ui/dashcn/theme/motion.dart';
import 'theme_document.dart';

export 'theme_document.dart' show ThemeDocumentException;

// ---------------------------------------------------------------------------
// Token edits
// ---------------------------------------------------------------------------

/// Immutable token edits. Every method returns a new document, so the Theme
/// Studio can drive one tween per change and the site stays a single source.
extension ThemeDocumentEdits on ThemeDocument {
  /// Renames the document (used by `Shuffle`, so a random combination is not
  /// claimed by a registry id).
  ThemeDocument renamed(String id, String name) => ThemeDocument(
    schema: schema,
    id: id,
    name: name,
    light: light,
    dark: dark,
    radius: radius,
    spacing: spacing,
    tracking: tracking,
    lightShadow: lightShadow,
    darkShadow: darkShadow,
    fonts: fonts,
    surfaceOpacity: surfaceOpacity,
    surfaceBlur: surfaceBlur,
    motionEnabled: motionEnabled,
    motionIntensity: motionIntensity,
    motionCustomDurationMultiplier: motionCustomDurationMultiplier,
    motionCustomPressScale: motionCustomPressScale,
    motionCustomEnterOffset: motionCustomEnterOffset,
    motionCustomCurve: motionCustomCurve,
    shadowsDerived: shadowsDerived,
  );

  /// Sets one colour [token] in both mode blocks.
  ThemeDocument withColor(String token, String hex) =>
      withLightColor(token, hex).withDarkColor(token, hex);

  /// Sets one colour [token] in the light mode block.
  ThemeDocument withLightColor(String token, String hex) {
    _checkToken(token);
    return ThemeDocument(
      schema: schema,
      id: id,
      name: name,
      light: <String, String>{...light, token: _checkColor(hex)},
      dark: dark,
      radius: radius,
      spacing: spacing,
      tracking: tracking,
      lightShadow: lightShadow,
      darkShadow: darkShadow,
      fonts: fonts,
      surfaceOpacity: surfaceOpacity,
      surfaceBlur: surfaceBlur,
      motionEnabled: motionEnabled,
      motionIntensity: motionIntensity,
      motionCustomDurationMultiplier: motionCustomDurationMultiplier,
      motionCustomPressScale: motionCustomPressScale,
      motionCustomEnterOffset: motionCustomEnterOffset,
      motionCustomCurve: motionCustomCurve,
      shadowsDerived: shadowsDerived,
    );
  }

  /// Sets one colour [token] in the dark mode block.
  ThemeDocument withDarkColor(String token, String hex) {
    _checkToken(token);
    return ThemeDocument(
      schema: schema,
      id: id,
      name: name,
      light: light,
      dark: <String, String>{...dark, token: _checkColor(hex)},
      radius: radius,
      spacing: spacing,
      tracking: tracking,
      lightShadow: lightShadow,
      darkShadow: darkShadow,
      fonts: fonts,
      surfaceOpacity: surfaceOpacity,
      surfaceBlur: surfaceBlur,
      motionEnabled: motionEnabled,
      motionIntensity: motionIntensity,
      motionCustomDurationMultiplier: motionCustomDurationMultiplier,
      motionCustomPressScale: motionCustomPressScale,
      motionCustomEnterOffset: motionCustomEnterOffset,
      motionCustomCurve: motionCustomCurve,
      shadowsDerived: shadowsDerived,
    );
  }

  /// Sets [token] in one [brightness] block.
  ThemeDocument withModeColor(
    String token,
    String hex,
    Brightness brightness,
  ) => brightness == Brightness.dark
      ? withDarkColor(token, hex)
      : withLightColor(token, hex);

  /// Sets a light token and a dark token in one edit (ramp families).
  ThemeDocument withPair(
    String lightToken,
    String lightHex,
    String darkToken,
    String darkHex,
  ) => withLightColor(lightToken, lightHex).withDarkColor(darkToken, darkHex);

  /// Sets the radius from [px] logical pixels.
  ThemeDocument withRadiusPx(double px) => _copy(radius: px / 16);

  /// Sets the base spacing unit in [rem].
  ThemeDocument withSpacingRem(double rem) => _copy(spacing: rem);

  /// Sets the family list of [slot]; a null or empty [spec] removes it.
  ThemeDocument withFont(String slot, String? spec) {
    final Map<String, String> next = <String, String>{...fonts};
    if (spec == null || spec.isEmpty) {
      next.remove(slot);
    } else {
      next[slot] = spec;
    }
    return _copy(
      fonts: <String, String>{
        for (final String s in kDocsFontSlots)
          if (next.containsKey(s)) s: next[s]!,
      },
    );
  }

  /// Sets one tracking [step] in em.
  ThemeDocument withTracking(String step, double em) =>
      _copy(tracking: <String, double>{...tracking, step: em});

  /// Sets the base shadow atoms of one mode.
  ThemeDocument withShadow(Brightness brightness, DocsShadowAtoms atoms) =>
      brightness == Brightness.dark
      ? _copy(darkShadow: atoms)
      : _copy(lightShadow: atoms);

  /// Sets the glass surface opacity (0..1); null restores opaque.
  ThemeDocument withSurfaceOpacity(double? opacity) {
    if (opacity != null && (opacity < 0 || opacity > 1)) {
      throw const ThemeDocumentException('surfaceOpacity must be in 0..1');
    }
    return _copy(surfaceOpacity: opacity, clearSurfaceOpacity: opacity == null);
  }

  /// Sets the glass surface blur sigma in logical px; null removes the blur.
  ThemeDocument withSurfaceBlur(double? blur) {
    if (blur != null && blur < 0) {
      throw const ThemeDocumentException('surfaceBlur must be >= 0');
    }
    return _copy(surfaceBlur: blur, clearSurfaceBlur: blur == null);
  }

  /// Sets the motion master switch; null restores the default (enabled,
  /// no motion block in the document unless another motion leg is set).
  ThemeDocument withMotionEnabled(bool? enabled) =>
      _copy(motionEnabled: enabled, clearMotionEnabled: enabled == null);

  /// Sets the motion intensity; null restores the default (standard, no
  /// intensity leg in the document unless another motion leg is set).
  ThemeDocument withMotionIntensity(MotionIntensity? intensity) => _copy(
    motionIntensity: intensity,
    clearMotionIntensity: intensity == null,
  );

  /// Sets the custom duration multiplier (0.25..3.0); null clears the leg.
  ThemeDocument withMotionCustomDurationMultiplier(double? value) {
    if (value != null && (value < 0.25 || value > 3.0)) {
      throw const ThemeDocumentException(
        'motion durationMultiplier must be in 0.25..3.0',
      );
    }
    return _copy(
      motionCustomDurationMultiplier: value,
      clearMotionCustomDurationMultiplier: value == null,
    );
  }

  /// Sets the custom press scale (0.8..1.0); null clears the leg.
  ThemeDocument withMotionCustomPressScale(double? value) {
    if (value != null && (value < 0.8 || value > 1.0)) {
      throw const ThemeDocumentException(
        'motion pressScale must be in 0.8..1.0',
      );
    }
    return _copy(
      motionCustomPressScale: value,
      clearMotionCustomPressScale: value == null,
    );
  }

  /// Sets the custom enter offset in logical px (0..24); null clears the leg.
  ThemeDocument withMotionCustomEnterOffset(double? value) {
    if (value != null && (value < 0 || value > 24)) {
      throw const ThemeDocumentException('motion enterOffset must be in 0..24');
    }
    return _copy(
      motionCustomEnterOffset: value,
      clearMotionCustomEnterOffset: value == null,
    );
  }

  /// Sets the custom enter curve; null clears the leg.
  ThemeDocument withMotionCustomCurve(MotionCurveName? curve) =>
      _copy(motionCustomCurve: curve, clearMotionCustomCurve: curve == null);

  ThemeDocument _copy({
    double? radius,
    double? spacing,
    Map<String, double>? tracking,
    Map<String, String>? fonts,
    DocsShadowAtoms? lightShadow,
    DocsShadowAtoms? darkShadow,
    double? surfaceOpacity,
    double? surfaceBlur,
    bool clearSurfaceOpacity = false,
    bool clearSurfaceBlur = false,
    bool? motionEnabled,
    bool clearMotionEnabled = false,
    MotionIntensity? motionIntensity,
    bool clearMotionIntensity = false,
    double? motionCustomDurationMultiplier,
    bool clearMotionCustomDurationMultiplier = false,
    double? motionCustomPressScale,
    bool clearMotionCustomPressScale = false,
    double? motionCustomEnterOffset,
    bool clearMotionCustomEnterOffset = false,
    MotionCurveName? motionCustomCurve,
    bool clearMotionCustomCurve = false,
  }) => ThemeDocument(
    schema: schema,
    id: id,
    name: name,
    light: light,
    dark: dark,
    radius: radius ?? this.radius,
    spacing: spacing ?? this.spacing,
    tracking: tracking ?? this.tracking,
    lightShadow: lightShadow ?? this.lightShadow,
    darkShadow: darkShadow ?? this.darkShadow,
    fonts: fonts ?? this.fonts,
    surfaceOpacity: clearSurfaceOpacity
        ? null
        : (surfaceOpacity ?? this.surfaceOpacity),
    surfaceBlur: clearSurfaceBlur ? null : (surfaceBlur ?? this.surfaceBlur),
    motionEnabled: clearMotionEnabled
        ? null
        : (motionEnabled ?? this.motionEnabled),
    motionIntensity: clearMotionIntensity
        ? null
        : (motionIntensity ?? this.motionIntensity),
    motionCustomDurationMultiplier: clearMotionCustomDurationMultiplier
        ? null
        : (motionCustomDurationMultiplier ??
              this.motionCustomDurationMultiplier),
    motionCustomPressScale: clearMotionCustomPressScale
        ? null
        : (motionCustomPressScale ?? this.motionCustomPressScale),
    motionCustomEnterOffset: clearMotionCustomEnterOffset
        ? null
        : (motionCustomEnterOffset ?? this.motionCustomEnterOffset),
    motionCustomCurve: clearMotionCustomCurve
        ? null
        : (motionCustomCurve ?? this.motionCustomCurve),
    shadowsDerived: shadowsDerived,
  );

  static void _checkToken(String token) {
    if (!kDocsColorTokenKeys.contains(token)) {
      throw ThemeDocumentException('Unknown colour token: $token');
    }
  }

  static String _checkColor(String hex) {
    if (!kDocsHexColorPattern.hasMatch(hex)) {
      throw ThemeDocumentException('Not a #RRGGBB[AA] colour: $hex');
    }
    return hex.toUpperCase();
  }
}
