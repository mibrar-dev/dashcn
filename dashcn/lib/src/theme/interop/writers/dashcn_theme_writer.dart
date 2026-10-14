// Kit preset reader/writer (pure Dart): [WebTheme] to and from the schema-v2
// preset JSON shape (`lib/src/themes/<id>.json`). Used by the round-trip gate
// over all presets. Strict on read (throws [WebThemeException] with a field
// path); writers call `completed()` so output always validates.

import 'dart:convert';

import '../internal/color_format.dart';
import '../internal/token_inventory.dart';
import '../theme_model.dart';
import '../web_color_parser.dart';

/// Rejected preset document.
class WebThemeException implements Exception {
  /// Creates the exception with a human readable [message].
  const WebThemeException(this.message);

  /// Human readable reason.
  final String message;

  @override
  String toString() => 'WebThemeException: $message';
}

/// Reads a schema-v2 preset document into a [WebTheme].
///
/// Throws [WebThemeException] when required fields are missing or malformed.
/// Colours accept upper or lower case hex; values are normalised on write.
WebTheme webThemeFromPresetJson(Map<String, Object?> json) {
  final Object? version = json['schemaVersion'];
  if (version is! num || version.toInt() != 2) {
    throw const WebThemeException('preset.schemaVersion must be 2');
  }
  Map<String, int> colorsOf(String mode) {
    final Object? block = json[mode];
    if (block is! Map) {
      throw WebThemeException('preset.$mode is required');
    }
    final Map<String, int> out = <String, int>{};
    for (final String token in kKitColorTokens) {
      final Object? value = block[token];
      if (value is! String) {
        throw WebThemeException('preset.$mode.$token is required');
      }
      final int? argb = tryParseWebColor(value);
      if (argb == null ||
          !RegExp(r'^#[0-9A-Fa-f]{6}([0-9A-Fa-f]{2})?$').hasMatch(value)) {
        throw WebThemeException(
          'preset.$mode.$token must be #RRGGBB[AA], got $value',
        );
      }
      out[token] = argb;
    }
    return out;
  }

  double numberOf(Object? value, String path) {
    if (value is! num) {
      throw WebThemeException('$path must be a number');
    }
    return value.toDouble();
  }

  final Map<String, double> tracking = <String, double>{};
  final Object? trackingJson = json['tracking'];
  if (trackingJson is! Map) {
    throw const WebThemeException('preset.tracking is required');
  }
  for (final String step in const <String>['normal', 'tight', 'wide']) {
    final Object? value = trackingJson[step];
    if (value == null) {
      if (step == 'normal') {
        throw const WebThemeException('preset.tracking.normal is required');
      }
      continue;
    }
    tracking[step] = numberOf(value, 'preset.tracking.$step');
  }
  final Map<String, String> fonts = <String, String>{};
  final Object? fontsJson = json['fonts'];
  if (fontsJson != null) {
    if (fontsJson is! Map) {
      throw const WebThemeException('preset.fonts must be an object');
    }
    for (final String slot in const <String>['sans', 'serif', 'mono']) {
      final Object? value = fontsJson[slot];
      if (value == null) {
        continue;
      }
      if (value is! String || value.isEmpty) {
        throw WebThemeException('preset.fonts.$slot must be a string');
      }
      fonts[slot] = value;
    }
  }
  WebShadowAtoms atomsOf(String mode) {
    final Object? shadow = json['shadow'];
    if (shadow is! Map || shadow[mode] is! Map) {
      throw WebThemeException('preset.shadow.$mode is required');
    }
    final Map<Object?, Object?> block = (shadow[mode] as Map)
        .cast<Object?, Object?>();
    Object? field(String name) => block[name];
    final Object? color = field('color');
    if (color is! String || tryParseWebColor(color) == null) {
      throw WebThemeException('preset.shadow.$mode.color must be a colour');
    }
    return WebShadowAtoms(
      color: tryParseWebColor(color)!,
      opacity: numberOf(field('opacity'), 'preset.shadow.$mode.opacity'),
      blur: numberOf(field('blur') ?? 0, 'preset.shadow.$mode.blur'),
      spread: numberOf(field('spread') ?? 0, 'preset.shadow.$mode.spread'),
      offsetX: numberOf(field('offsetX') ?? 0, 'preset.shadow.$mode.offsetX'),
      offsetY: numberOf(field('offsetY') ?? 1, 'preset.shadow.$mode.offsetY'),
    );
  }

  return WebTheme(
    light: colorsOf('light'),
    dark: colorsOf('dark'),
    radius: numberOf(json['radius'], 'preset.radius'),
    fonts: fonts,
    spacing: numberOf(json['spacing'] ?? 0.25, 'preset.spacing'),
    tracking: tracking,
    lightShadow: atomsOf('light'),
    darkShadow: atomsOf('dark'),
  );
}

/// Writes [theme] as a schema-v2 preset document map (calls `completed()`
/// first; `shadowsDerived` provenance is intentionally omitted).
Map<String, Object?> presetJsonFromWebTheme(
  WebTheme theme, {
  required String id,
  required String name,
}) {
  final WebTheme complete = theme.completed();
  Map<String, Object?> colorsOf(bool isDark) {
    final Map<String, int> colors = isDark ? complete.dark : complete.light;
    return <String, Object?>{
      for (final String token in kKitColorTokens)
        token: webHexOf(colors[token]!),
    };
  }

  Map<String, Object?> atomsOf(WebShadowAtoms atoms) => <String, Object?>{
    'color': webHexOf(atoms.color),
    'opacity': _jsonNumber(atoms.opacity),
    'blur': _jsonNumber(atoms.blur),
    'spread': _jsonNumber(atoms.spread),
    'offsetX': _jsonNumber(atoms.offsetX),
    'offsetY': _jsonNumber(atoms.offsetY),
  };
  return <String, Object?>{
    r'$schema': './themes.schema.json',
    'id': id,
    'name': name,
    'schemaVersion': 2,
    'light': colorsOf(false),
    'dark': colorsOf(true),
    if (complete.fonts.isNotEmpty)
      'fonts': Map<String, Object?>.of(complete.fonts),
    'radius': _jsonNumber(complete.radius!),
    'spacing': _jsonNumber(complete.spacing!),
    'tracking': <String, Object?>{
      for (final MapEntry<String, double> step in complete.tracking.entries)
        step.key: _jsonNumber(step.value),
    },
    'shadow': <String, Object?>{
      'light': atomsOf(complete.lightShadow!),
      'dark': atomsOf(complete.darkShadow!),
    },
  };
}

/// Writes [theme] as canonical preset JSON text (2-space indent).
String presetJsonStringFromWebTheme(
  WebTheme theme, {
  required String id,
  required String name,
}) {
  return const JsonEncoder.withIndent(
    '  ',
  ).convert(presetJsonFromWebTheme(theme, id: id, name: name));
}

/// Integral doubles as `int`, so re-encoded documents match the checked-in
/// preset files (`0`, `3`, never `0.0`, `3.0`).
Object _jsonNumber(double value) =>
    value.isFinite && value == value.roundToDouble() && value.abs() < 1e15
    ? value.toInt()
    : value;
