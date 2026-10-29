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
  const ScorecardCard({
    super.key,
    required this.componentId,
    this.bordered = true,
  });

  /// The registry component id.
  final String componentId;

  /// Whether the card paints its own bordered surface. Dialogs set this to
  /// false so the dialog shell is the single border (one surface, one
  /// border); standalone uses keep the bordered card.
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    if (!bordered) {
      // Inside a dialog/sheet the outer surface already paints the border:
      // return the body bare so the overlay shows one border, not a card
      // inside a card.
      return ScorecardBody(componentId: componentId);
    }
    return Card(child: ScorecardBody(componentId: componentId));
  }
}

/// The scorecard body without the outer [Card] chrome.
///
/// Used bare inside dialogs (the dialog shell is the single border) and
/// wrapped in a [Card] by [ScorecardCard] for standalone uses.
class ScorecardBody extends StatelessWidget {
  /// Creates the body for [componentId].
  const ScorecardBody({super.key, required this.componentId});

  /// The registry component id.
  final String componentId;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double sectionGap = theme.spacing.lg;
    final double rowGap = theme.spacing.sm;
    final DocsScorecard? scorecard = kScorecards[componentId];
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ??
        Localizations.localeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CardHeader(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CardTitle(child: Text(docsChrome(locale, 'scTitle'))),
              CardDescription(child: Text(docsChrome(locale, 'scDesc'))),
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
                  _footerText(locale),
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
                  child: Text(docsChrome(locale, 'secScorecards')),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _footerText(Locale locale) {
    final String date = kScorecardsGeneratedAt.length >= 10
        ? kScorecardsGeneratedAt.substring(0, 10)
        : kScorecardsGeneratedAt;
    return docsFill(
      docsChrome(locale, 'scFooter'),
      date: date,
      commit: kScorecardsCommitShort,
    );
  }

  void _goToMeasure(BuildContext context) {
    DocsRouterScope.maybeOf(context)?.go(context, '/docs/scorecards');
  }
}
