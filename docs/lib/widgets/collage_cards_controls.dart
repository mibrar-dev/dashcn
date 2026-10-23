// The landing collage's data/control cards (registry counts, presets).
// Split from `collage_cards.dart` to keep both files under the ~400-line rule;
// shares the public `CollageCard` shell from that file.

import 'package:flutter/widgets.dart';

import '../generated/docs_data.dart';
import '../ui/dashcn/components/progress/progress.dart';
import '../ui/dashcn/foundation/component_preview.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/theme/color_tokens.dart';
import '../ui/dashcn/theme/theme.dart';
import 'collage_cards.dart';
import 'docs_tokens.dart';

class CollageRegistryCard extends StatelessWidget {
  const CollageRegistryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return CollageCard(
      title: docsSample(context, 'Registry'),
      subtitle: docsSample(context, 'Counts generated from the manifest'),
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            Text(
              '${kStats.components}',
              style: docsText(
                context,
                size: 28,
                weight: FontWeight.w600,
                color: theme.colors.cardForeground,
              ),
            ),
            const Gap(8),
            Text(
              'components',
              style: docsText(
                context,
                size: 13,
                color: theme.colors.mutedForeground,
              ),
            ),
          ],
        ),
        const Gap(12),
        Progress(value: 1, height: 6),
        const Gap(12),
        Text(
          '${kStats.presets} presets · ${kStats.materialImports} Material imports',
          style: docsText(
            context,
            size: 12.5,
            color: theme.colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}

class CollagePresetsCard extends StatelessWidget {
  const CollagePresetsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ThemeColors colors = theme.colors;
    return CollageCard(
      title: docsSample(context, 'Theme presets'),
      subtitle: docsSample(context, 'Light and dark from one token set'),
      children: <Widget>[
        Row(
          children: <Widget>[
            for (final Color color in colors.chartColors)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: const SizedBox(width: 20, height: 20),
                ),
              ),
          ],
        ),
        const Gap(12),
        Text(
          docsSample(context, kPresets.first.name),
          style: docsText(
            context,
            size: 13,
            weight: FontWeight.w500,
            color: theme.colors.cardForeground,
          ),
        ),
        const Gap(8),
        Progress(value: 0.66, height: 6),
      ],
    );
  }
}
