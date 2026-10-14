// Copy/export payloads of the Theme Studio (spec §2.7 requirement 3).
//
//  * `Get Code` → Dart — the exact `app_theme.dart` that
//    `dashcn theme apply <id>` writes into an installed project. It is
//    rendered from the live document by `themeDartSource`, the port of the kit
//    generator that `theme_dart_source_test.dart` pins byte-for-byte against
//    the generated per-preset sources.
//  * `Get Code` → JSON — the canonical schema-v2 preset document, which is
//    also what `Open Preset` accepts, so the round-trip is lossless.
//  * `Get Code` → CLI — how to apply the document in a project, including
//    the `pubspec.yaml` font steps when the Studio's font rows picked a
//    bundled family (P7-TS1).

import '../generated/docs_preset_sources.dart';
import 'docs_fonts.dart';
import 'theme_dart_source.dart' show camelCaseId;
import 'theme_document.dart';

/// The command that regenerates `app_theme.dart` for a registry preset.
String themeApplyCommand(String presetId) => 'dashcn theme apply $presetId';

/// The CLI tab of the `Get Code` dialog.
String themeCliGuide(ThemeDocument document) {
  final String? matched = _matchedPresetId(document);
  final StringBuffer out = StringBuffer()
    ..writeln('# 1. Install the theme layer')
    ..writeln('flutter pub add dashcn')
    ..writeln()
    ..writeln('# 2. Write the generated file into your project');
  if (matched != null) {
    out.writeln('dashcn theme apply $matched');
  } else {
    out.writeln('# Not a registry preset: save the JSON tab as');
    out.writeln('# lib/src/themes/${document.id}.json in your project, then');
    out.writeln('dashcn theme apply ${document.id}');
  }
  out
    ..writeln()
    ..writeln('# 3. Use it')
    ..writeln('runApp(DashcnApp(theme: build${_classPrefix(document.id)}Theme(')
    ..writeln(
      '  WidgetsBinding.instance.platformDispatcher.platformBrightness,',
    )
    ..writeln('), home: const HomePage()));');
  if (themePubspecSnippet(document) case final String snippet) {
    out
      ..writeln()
      ..writeln(snippet);
  }
  return out.toString();
}

/// The `pubspec.yaml` font steps for the Studio's picked families (P7-TS1).
///
/// `theme apply` writes the families into `app_theme.dart` but cannot fetch
/// font files, so the CLI tab prints these exact steps instead. Only the
/// Studio's own `heading`/`body` slots are considered: registry presets
/// never set them, so an untouched preset prints no font section, while any
/// picked family — bundled OFL or custom — prints its entry. Returns null
/// when neither slot names a real family.
String? themePubspecSnippet(ThemeDocument document) {
  final Set<String> bundled = <String>{};
  final Set<String> external = <String>{};
  for (final String slot in const <String>['heading', 'body']) {
    final String? first = _firstRealFamily(document.fontOf(slot));
    if (first == null) {
      continue;
    }
    final List<String>? assets = docsFontAsset(first);
    if (assets != null && assets.isNotEmpty) {
      bundled.add(first);
    } else {
      external.add(first);
    }
  }
  if (bundled.isEmpty && external.isEmpty) {
    return null;
  }
  final StringBuffer out = StringBuffer()
    ..writeln('# 4. Bundle the picked fonts (OFL)')
    ..writeln('# `theme apply` writes the families into `app_theme.dart`,')
    ..writeln('# but the .ttf files are yours: drop each under assets/fonts/')
    ..writeln('# and declare it in pubspec.yaml:');
  for (final String family in <String>{...bundled, ...external}) {
    final List<String>? assets = docsFontAsset(family);
    out.writeln('#   - family: $family');
    out.writeln('#     fonts:');
    if (assets != null && assets.isNotEmpty) {
      for (final String asset in assets) {
        out.writeln('#       - asset: $asset');
      }
    } else {
      out.writeln('#       - asset: assets/fonts/<your-file>.ttf');
    }
  }
  return out.toString().trimRight();
}

/// The first non-generic family of [spec] (`DM Sans` in
/// `"DM Sans", sans-serif`), or null when there is none.
String? _firstRealFamily(String? spec) {
  if (spec == null || spec.isEmpty) {
    return null;
  }
  const Set<String> generic = <String>{
    'sans-serif',
    'serif',
    'monospace',
    'ui-sans-serif',
    'ui-monospace',
    'ui-serif',
    'system-ui',
    'cursive',
    'fantasy',
  };
  for (final String part in spec.split(',')) {
    final String family = part.trim().replaceAll('"', '');
    if (family.isNotEmpty && !generic.contains(family.toLowerCase())) {
      return family;
    }
  }
  return null;
}

/// The registry preset id whose document is exactly [document], or null.
String? _matchedPresetId(ThemeDocument document) {
  final String json = document.json;
  for (final DocsPresetSource source in kPresetSources.values) {
    if (source.json == json) {
      return source.id;
    }
  }
  return null;
}

String _classPrefix(String id) {
  final String camel = camelCaseId(id);
  return camel.isEmpty ? camel : camel[0].toUpperCase() + camel.substring(1);
}
