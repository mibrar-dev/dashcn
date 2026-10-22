// `/charts` — the charts gallery: hero, family tab bar and the first family
// section (tab-selected, one family at a time).
//
// Full-width like Blocks/Themes: no docs sidebar.

import 'package:flutter/widgets.dart';

import 'charts_gallery.dart';

/// `/charts` — every chart family on one page.
class ChartsHubPage extends StatelessWidget {
  /// Creates the hub page.
  const ChartsHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChartsGallery();
  }
}
