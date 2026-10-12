// The bundled font catalogue for the Theme Studio font rows (P7-TS1).
//
// The `Heading font` / `Body font` pickers offer OFL families that ship as
// docs assets. Switching loads only the picked family through `FontLoader`
// (see [loadDocsFonts]), so a switch never re-downloads the whole catalogue.
//
// Every entry here must also be listed in `docs/pubspec.yaml` under
// `flutter: fonts:` so the file exists in both a `flutter run` and a
// compiled bundle.

import 'package:flutter/services.dart';

/// One bundled family: the CSS-ish spec stored in the document and the
/// asset the loader fetches.
class DocsFontFamily {
  /// Creates an entry.
  const DocsFontFamily({
    required this.label,
    required this.family,
    required this.assets,
  });

  /// The row label / tooltip name.
  final String label;

  /// The family list stored in the document (what `ShadcnFonts` carries).
  final String family;

  /// The asset paths to load, in order.
  final List<String> assets;
}

/// The families offered by the `Heading font` row.
const List<DocsFontFamily> kDocsHeadingFonts = <DocsFontFamily>[
  DocsFontFamily(label: 'Default', family: '', assets: <String>[]),
  DocsFontFamily(
    label: 'Playfair Display',
    family: 'Playfair Display',
    assets: <String>['assets/fonts/PlayfairDisplay-Regular.ttf'],
  ),
  DocsFontFamily(
    label: 'Lora',
    family: 'Lora',
    assets: <String>['assets/fonts/Lora-Regular.ttf'],
  ),
  DocsFontFamily(
    label: 'Space Grotesk',
    family: 'Space Grotesk',
    assets: <String>['assets/fonts/SpaceGrotesk-Regular.ttf'],
  ),
  DocsFontFamily(
    label: 'DM Sans',
    family: 'DM Sans',
    assets: <String>['assets/fonts/DMSans-Regular.ttf'],
  ),
  DocsFontFamily(
    label: 'Manrope',
    family: 'Manrope',
    assets: <String>['assets/fonts/Manrope-Regular.ttf'],
  ),
  DocsFontFamily(
    label: 'Inter',
    family: 'Inter',
    assets: <String>['assets/fonts/Inter-Regular.ttf'],
  ),
];

/// The families offered by the `Body font` row.
const List<DocsFontFamily> kDocsBodyFonts = <DocsFontFamily>[
  DocsFontFamily(label: 'Default', family: '', assets: <String>[]),
  DocsFontFamily(
    label: 'Inter',
    family: 'Inter',
    assets: <String>['assets/fonts/Inter-Regular.ttf'],
  ),
  DocsFontFamily(label: 'Geist Sans', family: 'GeistSans', assets: <String>[]),
  DocsFontFamily(
    label: 'Manrope',
    family: 'Manrope',
    assets: <String>['assets/fonts/Manrope-Regular.ttf'],
  ),
  DocsFontFamily(
    label: 'DM Sans',
    family: 'DM Sans',
    assets: <String>['assets/fonts/DMSans-Regular.ttf'],
  ),
  DocsFontFamily(
    label: 'Outfit',
    family: 'Outfit',
    assets: <String>['assets/fonts/Outfit-Regular.ttf'],
  ),
  DocsFontFamily(
    label: 'Plus Jakarta Sans',
    family: 'Plus Jakarta Sans',
    assets: <String>['assets/fonts/PlusJakartaSans-Regular.ttf'],
  ),
  DocsFontFamily(
    label: 'Space Grotesk',
    family: 'Space Grotesk',
    assets: <String>['assets/fonts/SpaceGrotesk-Regular.ttf'],
  ),
  DocsFontFamily(
    label: 'IBM Plex Sans',
    family: 'IBM Plex Sans',
    assets: <String>['assets/fonts/IBMPlexSans-Regular.ttf'],
  ),
];

/// The families offered by the `Mono` row (`AnyFamily`).
const List<DocsFontFamily> kDocsMonoFonts = <DocsFontFamily>[
  DocsFontFamily(label: 'Default', family: '', assets: <String>[]),
  DocsFontFamily(label: 'Geist Mono', family: 'GeistMono', assets: <String>[]),
  DocsFontFamily(
    label: 'JetBrains Mono',
    family: 'JetBrains Mono',
    assets: <String>['assets/fonts/JetBrainsMono-Regular.ttf'],
  ),
];

/// The families already loaded this session, keyed by family name.
///
/// A family is either a bundled `pubspec` entry (empty [DocsFontFamily
/// .assets] — Geist is already declared) or loaded on demand; both are
/// cached so a re-pick costs nothing.
final Set<String> _loadedFonts = <String>{};

/// Whether [family] has already been made available to the text engine.
bool docsFontLoaded(String family) => _loadedFonts.contains(family);

/// Loads [family] (and any family in [extras]) through [FontLoader].
///
/// Families declared in `pubspec.yaml` need no loader call, so only the
/// families with assets are loaded. Unknown or missing families fail
/// silently: the family then falls back to the bundled default, which is
/// what a real font picker must do on a flaky network.
Future<void> loadDocsFonts(
  String family, {
  Set<String> extras = const <String>{},
}) async {
  final Set<String> pending = <String>{
    for (final String name in <String>{family, ...extras})
      if (name.isNotEmpty &&
          !_loadedFonts.contains(name) &&
          (docsFontAsset(name)?.isNotEmpty ?? false))
        name,
  };
  for (final String name in pending) {
    _loadedFonts.add(name);
    final List<String> paths = docsFontAsset(name)!;
    final FontLoader loader = FontLoader(name);
    for (final String path in paths) {
      loader.addFont(rootBundle.load(path));
    }
    try {
      await loader.load();
    } on Object {
      // Offline or missing asset: keep the default family rather than break
      // the site. The selection still persists and applies on the next load.
      _loadedFonts.remove(name);
    }
  }
}

/// The asset paths for [family], or null when it is a declared family.
///
/// Returns an empty list for the `pubspec` families (Geist, the bundled
/// default), so they never go through [FontLoader].
List<String>? docsFontAsset(String family) {
  for (final DocsFontFamily entry in <DocsFontFamily>[
    ...kDocsHeadingFonts,
    ...kDocsBodyFonts,
    ...kDocsMonoFonts,
  ]) {
    if (entry.family == family) {
      return entry.assets;
    }
  }
  return null;
}
