// Trust scorecard card (P9-5b): measured quality facts for one component.
//
// Four sections (Accessibility, Right-to-left, Frame time, Tests) with
// pass/fail/not-measured badges, failing guideline messages in an expandable
// detail, the "measured on <date> at <commit>" footer and a "How we measure"
// link. Light/dark comes from the ambient theme; spacing comes from
// `Theme.spacing` so presets re-space the card. Kit components only.
//
// Integration point (P9-Z places it on the component page):
// ```dart
// ScorecardCard(componentId: componentId)
// ```

import 'package:flutter/widgets.dart';

import '../../generated/docs_scorecards.dart';
import '../../routing/docs_router.dart';
import '../../state/docs_strings.dart';
import '../../ui/dashcn/components/button/button.dart';
import '../../ui/dashcn/components/card/card.dart';
import '../../ui/dashcn/components/divider/divider.dart';
import '../../ui/dashcn/foundation/gap.dart';
import '../../ui/dashcn/theme/theme.dart';
import '../docs_tokens.dart';
import 'scorecard_sections.dart';

/// The trust scorecard card for [componentId].
class ScorecardCard extends StatelessWidget {
  /// Creates the card for [componentId].
  const ScorecardCard({super.key, required this.componentId});

  /// The registry component id.
  final String componentId;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double sectionGap = theme.spacing.lg;
    final double rowGap = theme.spacing.sm;
    final DocsScorecard? scorecard = kScorecards[componentId];
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CardHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CardTitle(
                  child: Text(
                    docsChrome(
                      DocsRouterScope.maybeOf(context)?.state.locale ??
                          const Locale('en'),
                      'scTitle',
                    ),
                  ),
                ),
                CardDescription(
                  child: Text(
                    docsChrome(
                      DocsRouterScope.maybeOf(context)?.state.locale ??
                          const Locale('en'),
                      'scDesc',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(sectionGap),
          CardContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ScorecardA11ySection(scorecard: scorecard, rowGap: rowGap),
                Gap(sectionGap),
                const Divider(),
                Gap(sectionGap),
                ScorecardRtlSection(scorecard: scorecard, rowGap: rowGap),
                Gap(sectionGap),
                const Divider(),
                Gap(sectionGap),
                ScorecardFramesSection(scorecard: scorecard, rowGap: rowGap),
                Gap(sectionGap),
                const Divider(),
                Gap(sectionGap),
                ScorecardTestsSection(scorecard: scorecard, rowGap: rowGap),
              ],
            ),
          ),
          Gap(sectionGap),
          CardFooter(
            alignment: MainAxisAlignment.start,
            // Expanded: CardFooter lays out in a Row (unbounded main axis),
            // so the footer column would size to its intrinsic width and
            // overflow narrow pages (P9-Z 390 px audit).
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    _footerText(),
                    style: docsText(
                      context,
                      size: 12,
                      color: theme.colors.mutedForeground,
                    ),
                  ),
                  Button(
                    variant: ButtonVariant.link,
                    size: ButtonSize.sm,
                    onPressed: () => _goToMeasure(context),
                    child: Text(
                      docsChrome(
                        DocsRouterScope.maybeOf(context)?.state.locale ??
                            const Locale('en'),
                        'secScorecards',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _footerText() {
    final String date = kScorecardsGeneratedAt.length >= 10
        ? kScorecardsGeneratedAt.substring(0, 10)
        : kScorecardsGeneratedAt;
    return 'measured on $date at $kScorecardsCommitShort';
  }

  void _goToMeasure(BuildContext context) {
    DocsRouterScope.maybeOf(context)?.go(context, '/docs/scorecards');
  }
}
