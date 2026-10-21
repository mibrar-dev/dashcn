// Shareable preset-string payloads for the Get Code dialog (pure logic).
//
// The Theme Studio prints the live `dcn1_` string of the document it holds:
// canonical preset JSON → DEFLATE → base64url, via the kit codec (mirrored
// `ui/dashcn/theme/interop/` layer, public `interop.dart` surface only).
// The same string is what `dashcn apply --preset` / `update --preset` take
// in a project; decoding is local and never touches the network.

import '../ui/dashcn/theme/interop/interop.dart';
import 'theme_document.dart';

/// The live `dcn1_` string for [document] (updates on every token change).
String presetStringFromDocument(ThemeDocument document) => encodePresetString(
  document.toJson().map((String key, Object? value) => MapEntry(key, value)),
);

/// First-time install command for [presetString] (refuses when a theme
/// already exists unless `--force`).
String presetApplyCommand(String presetString) =>
    'dashcn apply --preset $presetString';

/// In-place update command for [presetString] (replaces only the
/// preset-owned theme file and font entries; supports `--dry-run`).
String presetUpdateCommand(String presetString) =>
    'dashcn update --preset $presetString';

/// The Preset tab payload: the live string plus both `--preset` commands.
String presetShareGuide(ThemeDocument document) {
  final String preset = presetStringFromDocument(document);
  return <String>[
    '# Share this theme as one string (updates on every builder change)',
    preset,
    '# First-time install in a project with no dashcn theme yet:',
    presetApplyCommand(preset),
    '# Update an existing project (preset-owned files only):',
    presetUpdateCommand(preset),
  ].join('\n');
}
