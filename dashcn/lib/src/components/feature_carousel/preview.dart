// Named examples for the `feature_carousel` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// The controller lives in the example's own state, so two examples never
// attach one controller twice.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'feature_carousel.dart';

/// The full carousel with its default chrome, scrollable when the cards are
/// taller than the stage.
class _FeatureCarouselDefaultFeatureCarousel extends StatefulWidget {
  const _FeatureCarouselDefaultFeatureCarousel();

  @override
  State<_FeatureCarouselDefaultFeatureCarousel> createState() =>
      _FeatureCarouselDefaultFeatureCarouselState();
}

class _FeatureCarouselDefaultFeatureCarouselState
    extends State<_FeatureCarouselDefaultFeatureCarousel> {
  late final FeatureCarouselController _controller = FeatureCarouselController(
    autoPlay: false,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 420,
        child: FeatureCarousel(
          controller: _controller,
          items: <FeatureCarouselItem>[
            FeatureCarouselItem(
              title: docsSample(context, 'Fast'),
              description: docsSample(context, 'Ship a build in seconds.'),
              icon: LucideIcons.zap,
            ),
            FeatureCarouselItem(
              title: docsSample(context, 'Safe'),
              description: docsSample(context, 'Every deploy is immutable.'),
              icon: LucideIcons.shield,
            ),
            FeatureCarouselItem(
              title: docsSample(context, 'Insightful'),
              description: docsSample(context, 'Metrics for every release.'),
              icon: LucideIcons.chartLine,
            ),
          ],
        ),
      ),
    );
  }
}

/// A carousel whose theme leg re-colours the accent and card fill.
Widget _featureCarouselThemed(BuildContext context) {
  return SingleChildScrollView(
    child: SizedBox(
      width: 420,
      child: ComponentTheme<FeatureCarouselTheme>(
        data: const FeatureCarouselTheme(
          accentColor: ThemedColor.ref(ColorRef.chart2),
          cardFill: ThemedColor.ref(ColorRef.popover),
          radius: 20,
        ),
        child: FeatureCarousel(
          items: <FeatureCarouselItem>[
            FeatureCarouselItem(
              title: docsSample(context, 'Themed'),
              icon: LucideIcons.sparkles,
            ),
            FeatureCarouselItem(
              title: docsSample(context, 'Accent'),
              icon: LucideIcons.star,
            ),
          ],
        ),
      ),
    ),
  );
}

/// The cards without the CTA and the navigation arrows.
Widget _featureCarouselCardsOnly(BuildContext context) {
  return SingleChildScrollView(
    child: SizedBox(width: 420, child: _FeatureCarouselCardsOnlyCarousel()),
  );
}

class _FeatureCarouselCardsOnlyCarousel extends StatefulWidget {
  const _FeatureCarouselCardsOnlyCarousel();

  @override
  State<_FeatureCarouselCardsOnlyCarousel> createState() =>
      _FeatureCarouselCardsOnlyCarouselState();
}

class _FeatureCarouselCardsOnlyCarouselState
    extends State<_FeatureCarouselCardsOnlyCarousel> {
  late final FeatureCarouselController _controller = FeatureCarouselController(
    autoPlay: false,
    showCta: false,
    showNavArrows: false,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FeatureCarousel(
      controller: _controller,
      items: <FeatureCarouselItem>[
        FeatureCarouselItem(
          title: docsSample(context, 'Cards only'),
          icon: LucideIcons.image,
        ),
        FeatureCarouselItem(
          title: docsSample(context, 'No chrome'),
          icon: LucideIcons.circle,
        ),
      ],
    );
  }
}

/// A single slide, so the CTA sits under one card.
Widget _featureCarouselLabelled(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 420,
          child: FeatureCarousel(
            items: <FeatureCarouselItem>[
              FeatureCarouselItem(
                title: docsSample(context, 'Analytics'),
                description: docsSample(context, 'Every release measured.'),
                icon: LucideIcons.chartLine,
              ),
            ],
          ),
        ),
        Gap(spacing.md),
        Text(
          docsSample(
            context,
            docsSample(
              context,
              docsSample(context, 'A single slide, so the CTA sits under one card.'),
            ),
          ),
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colors.mutedForeground,
          ),
        ),
      ],
    ),
  );
}

Widget _featureCarouselDefault(BuildContext context) =>
    const _FeatureCarouselDefaultFeatureCarousel();

/// Named docs examples for `feature_carousel`; the first entry is the default.
List<ComponentPreview> get featureCarouselPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _featureCarouselDefault),
  ComponentPreview(docsSample(null, 'Themed'), _featureCarouselThemed),
  ComponentPreview(docsSample(null, 'Cards only'), _featureCarouselCardsOnly),
  ComponentPreview(docsSample(null, 'Labelled'), _featureCarouselLabelled),
];
