// Home showcase: people and plan cards (P6-H1).
//
// Two home-only compositions: the contributor wall (`AvatarGroup` with a
// `HoverCard` handle) and the release timeline (`Timeline`).

import 'package:flutter/widgets.dart';
import '../routing/docs_router.dart';
import '../state/docs_content_home.dart';

import '../ui/dashcn/components/avatar/avatar.dart';
import '../ui/dashcn/components/hover_card/hover_card.dart';
import '../ui/dashcn/components/timeline/timeline.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/theme/theme.dart';
import 'collage_cards.dart';
import 'studio_blocks/studio_card.dart';
import '../ui/dashcn/foundation/component_preview.dart';

/// `Contributors`: the avatar stack with a hoverable handle.
class HomeContributorsCard extends StatelessWidget {
  /// Creates the card.
  const HomeContributorsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    final ThemeData theme = Theme.of(context);
    return CollageCard(
      title: docsHome(locale, 'homeContribTitle'),
      subtitle: docsHome(locale, 'homeContribSub'),
      children: <Widget>[
        const AvatarGroup(
          children: <Widget>[
            Avatar(initials: 'MO'),
            Avatar(initials: 'LM'),
            Avatar(initials: 'AK'),
            Avatar(initials: '+4'),
          ],
        ),
        const Gap(12),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 4,
          children: <Widget>[
            Text(
              docsSample(context, 'Curated by'),
              style: theme.typography.small.copyWith(
                color: theme.colors.mutedForeground,
              ),
            ),
            HoverCard(
              hoverBuilder: (BuildContext context) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('@ledger'),
                  StudioHelper(
                    docsSample(context, 'Beautifully designed components.'),
                  ),
                ],
              ),
              child: Text(
                '@ledger',
                style: theme.typography.small.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// `Release timeline`: three dated milestones from the registry timeline.
class HomeTimelineCard extends StatelessWidget {
  /// Creates the card.
  const HomeTimelineCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    return CollageCard(
      title: docsHome(locale, 'homeTimelineTitle'),
      subtitle: docsHome(locale, 'homeTimelineSub'),
      children: <Widget>[
        Timeline(
          data: <TimelineData>[
            TimelineData(
              time: Text('09:00'),
              title: Text(docsSample(context, 'Master delivered')),
              content: Text(
                docsSample(context, 'Final WAV approved by the label.'),
              ),
            ),
            TimelineData(
              time: Text('11:30'),
              title: Text(docsSample(context, 'Artwork signed off')),
              content: Text(
                docsSample(context, 'Cover passed the store checks.'),
              ),
            ),
            TimelineData(
              time: Text('14:00'),
              title: Text(docsSample(context, 'Distributed')),
              content: Text(
                docsSample(context, 'Live on 40+ stores worldwide.'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
