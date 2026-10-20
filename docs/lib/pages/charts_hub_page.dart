// `/charts` — the charts gallery: hero, family nav and every family section
// (heading + responsive card grid) on one page.
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
