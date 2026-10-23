import '../ui/dashcn/foundation/component_preview.dart';
// Home showcase: feedback cards (P6-H1).
//
// `Status` extends the Theme Studio block (`studio_blocks/studio_form.dart`);
// the alert callouts, the loading skeleton and the star rating are composed
// from the same registry components for the home wall.

import 'package:flutter/widgets.dart';

import '../ui/dashcn/components/alert/alert.dart';
import '../ui/dashcn/components/badge/badge.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/chip/chip.dart';
import '../ui/dashcn/components/progress/progress.dart';
import '../ui/dashcn/components/star_rating/star_rating.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/theme/theme.dart';
import 'collage_cards.dart';
import 'studio_blocks/studio_card.dart';

/// `Status`: every badge variant, so a preset that changes the secondary /
/// outline / destructive colours shows up.
class HomeStatusCard extends StatelessWidget {
  /// Creates the card.
  const HomeStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CollageCard(
      title: docsSample(context, 'Status'),
      children: <Widget>[
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            Badge(
              variant: BadgeVariant.primary,
              child: Text(docsSample(context, 'Live')),
            ),
            Badge(
              variant: BadgeVariant.secondary,
              child: Text(docsSample(context, 'Draft')),
            ),
            Badge(
              variant: BadgeVariant.outline,
              child: Text(docsSample(context, 'Review')),
            ),
            Badge(
              variant: BadgeVariant.destructive,
              child: Text(docsSample(context, 'Overdue')),
            ),
          ],
        ),
      ],
    );
  }
}

/// `Notices`: the registry alert callouts in both variants.
class HomeAlertsCard extends StatelessWidget {
  /// Creates the card.
  const HomeAlertsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CollageCard(
      title: docsSample(context, 'Notices'),
      subtitle: docsSample(context, 'Callouts for status and warnings.'),
      children: <Widget>[
        Alert(
          leading: Icon(LucideIcons.info, size: 16),
          title: Text(docsSample(context, 'Heads up')),
          content: Text(
            docsSample(context, 'Royalties settle on the 15th of every month.'),
          ),
        ),
        Gap(12),
        Alert(
          variant: AlertVariant.destructive,
          leading: Icon(LucideIcons.triangleAlert, size: 16),
          title: Text(docsSample(context, 'Payout failed')),
          content: Text(
            docsSample(
              context,
              docsSample(
                context,
                'The bank rejected the transfer. Update the IBAN.',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// `Storage`: quota bars with a manage action.
///
/// Note: `Skeleton` and `Spinner` run repeating animations by design, which
/// would keep the landing page's frame schedule alive forever (widget tests
/// `pumpAndSettle`, and the static `<768` collage, require a settled wall).
/// Loading feedback is therefore composed from static `Progress` bars; the
/// animated components are covered on their own component pages.
class HomeLoadingCard extends StatelessWidget {
  /// Creates the card.
  const HomeLoadingCard({super.key});

  static List<(String, String, double)> bars = <(String, String, double)>[
    (docsSample(null, 'Documents'), docsSample(null, '7.2 of 10 GB'), 0.72),
    (docsSample(null, 'Media'), docsSample(null, '16.0 of 40 GB'), 0.4),
    (docsSample(null, 'Backups'), docsSample(null, '4.5 of 5 GB'), 0.9),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return CollageCard(
      title: docsSample(context, 'Storage'),
      subtitle: docsSample(context, 'Synced 4 minutes ago.'),
      children: <Widget>[
        for (final (String label, String detail, double value) in bars)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Text(label)),
                    Text(
                      detail,
                      style: theme.typography.small.copyWith(
                        color: theme.colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
                const Gap(6),
                Progress(value: value, height: 6, semanticsLabel: label),
              ],
            ),
          ),
        Button(
          variant: ButtonVariant.outline,
          size: ButtonSize.sm,
          onPressed: collageNoop,
          child: Text(docsSample(context, 'Manage storage')),
        ),
      ],
    );
  }
}

/// `Rate this release`: the registry star rating with topic chips.
class HomeRatingCard extends StatefulWidget {
  /// Creates the card.
  const HomeRatingCard({super.key});

  @override
  State<HomeRatingCard> createState() => _HomeRatingCardState();
}

class _HomeRatingCardState extends State<HomeRatingCard> {
  double _rating = 3.5;

  @override
  Widget build(BuildContext context) {
    return CollageCard(
      title: docsSample(context, 'Rate this release'),
      subtitle: docsSample(context, 'How did Midnight Drive land?'),
      children: <Widget>[
        StarRating(
          value: _rating,
          onChanged: (double value) => setState(() => _rating = value),
        ),
        const Gap(12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            Chip(child: Text(docsSample(context, 'Mix'))),
            Chip(child: Text(docsSample(context, 'Master'))),
            Chip(child: Text(docsSample(context, 'Artwork'))),
          ],
        ),
        const Gap(12),
        StudioHelper(
          _rating >= 4
              ? 'Loved it — thanks for the high score.'
              : docsSample(context, 'Tap a star to leave your score.'),
        ),
      ],
    );
  }
}
