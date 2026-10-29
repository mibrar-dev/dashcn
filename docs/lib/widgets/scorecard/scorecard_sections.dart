// Scorecard sections (P9-5b): the four card sections with kit components.
//
// Each section renders its rows with [ScoreStatusBadge]; failing guideline
// messages appear in a [Collapsible] detail. Spacing comes from the ambient
// `Theme.spacing` via the [rowGap] argument.

import 'package:flutter/widgets.dart';

import '../../generated/docs_scorecards.dart';
import '../../routing/docs_router.dart';
import '../../state/docs_strings.dart';
import '../../ui/dashcn/components/collapsible/collapsible.dart';
import '../../ui/dashcn/components/tooltip/tooltip.dart';
import '../../ui/dashcn/components/badge/badge.dart';
import '../../ui/dashcn/foundation/gap.dart';
import '../../ui/dashcn/theme/theme.dart';
import '../docs_tokens.dart';
import 'scorecard_badge.dart';

/// Section heading (13 px semibold, muted).
class ScorecardSectionTitle extends StatelessWidget {
  /// Creates the heading.
  const ScorecardSectionTitle(this.title, {super.key});

  /// Heading text.
  final String title;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Text(
      title,
      style: docsText(
        context,
        size: 13,
        weight: FontWeight.w600,
        color: theme.colors.mutedForeground,
      ),
    );
  }
}

/// One label + badge row with an optional expandable failure detail.
class ScorecardCheckRow extends StatelessWidget {
  /// Creates the row.
  const ScorecardCheckRow({
    super.key,
    required this.label,
    required this.passed,
    this.message,
    this.exempt,
  });

  /// Row label.
  final String label;

  /// Whether the check passed, or null when not measured.
  final bool? passed;

  /// Failing guideline message (shown expandable when failing).
  final String? message;

  /// Documented exemption reason; renders as "Exempt" with the reason.
  final String? exempt;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ??
        Localizations.localeOf(context);
    final bool showDetail =
        passed == false && exempt == null && (message?.isNotEmpty ?? false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: Text(label, style: docsText(context, size: 14))),
            ScoreStatusBadge(passed: passed, exempt: exempt),
          ],
        ),
        if (exempt != null)
          Padding(
            padding: EdgeInsets.only(top: theme.spacing.xs),
            child: Text(
              docsFill(docsChrome(locale, 'scExemptReason'), reason: exempt),
              style: docsText(
                context,
                size: 12,
                color: theme.colors.mutedForeground,
              ),
            ),
          ),
        if (showDetail)
          Collapsible(
            children: <Widget>[
              CollapsibleTrigger(
                child: Text(
                  docsChrome(locale, 'scShowDetails'),
                  style: docsText(
                    context,
                    size: 12,
                    color: theme.colors.mutedForeground,
                  ),
                ),
              ),
              CollapsibleContent(
                child: Padding(
                  padding: EdgeInsets.only(top: theme.spacing.sm),
                  child: Text(
                    message!,
                    style: docsText(
                      context,
                      size: 12,
                      color: theme.colors.mutedForeground,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

/// Accessibility section: five checks + the mobile-guideline note.
class ScorecardA11ySection extends StatelessWidget {
  /// Creates the section.
  const ScorecardA11ySection({
    super.key,
    required this.scorecard,
    required this.rowGap,
  });

  /// Scorecard, or null when the component has no entry.
  final DocsScorecard? scorecard;

  /// Theme-derived row spacing.
  final double rowGap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ??
        Localizations.localeOf(context);
    final DocsScorecardA11y? a11y = scorecard?.a11y;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ScorecardSectionTitle(docsChrome(locale, 'scA11yTitle')),
        Gap(rowGap),
        ScorecardCheckRow(
          label: docsChrome(locale, 'scTextContrast'),
          passed: a11y?.textContrast.passed,
          message: a11y?.textContrast.message,
          exempt: a11y?.textContrast.exempt,
        ),
        Gap(rowGap),
        ScorecardCheckRow(
          label: docsChrome(locale, 'scLabeledTap'),
          passed: a11y?.labeledTapTarget.passed,
          message: a11y?.labeledTapTarget.message,
          exempt: a11y?.labeledTapTarget.exempt,
        ),
        Gap(rowGap),
        ScorecardCheckRow(
          label: docsChrome(locale, 'scAndroidTap'),
          passed: a11y?.androidTapTarget.passed,
          message: a11y?.androidTapTarget.message,
          exempt: a11y?.androidTapTarget.exempt,
        ),
        Gap(rowGap),
        ScorecardCheckRow(
          label: docsChrome(locale, 'scIosTap'),
          passed: a11y?.iOSTapTarget.passed,
          message: a11y?.iOSTapTarget.message,
          exempt: a11y?.iOSTapTarget.exempt,
        ),
        Gap(rowGap),
        ScorecardCheckRow(
          label: docsChrome(locale, 'scSemantics'),
          passed: _semanticsPassed(a11y),
          message: a11y?.semantics.message,
          exempt: a11y?.semantics.exempt,
        ),
        Gap(rowGap),
        Text(
          docsChrome(locale, 'scTapNote'),
          style: docsText(
            context,
            size: 12,
            color: theme.colors.mutedForeground,
          ),
        ),
      ],
    );
  }

  static bool? _semanticsPassed(DocsScorecardA11y? a11y) {
    final bool? present = a11y?.semantics.present;
    if (present == null) {
      return null;
    }
    return present;
  }
}

/// Right-to-left section: renders + mirroring.
class ScorecardRtlSection extends StatelessWidget {
  /// Creates the section.
  const ScorecardRtlSection({
    super.key,
    required this.scorecard,
    required this.rowGap,
  });

  /// Scorecard, or null when the component has no entry.
  final DocsScorecard? scorecard;

  /// Theme-derived row spacing.
  final double rowGap;

  @override
  Widget build(BuildContext context) {
    final DocsScorecardRtl? rtl = scorecard?.rtl;
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ??
        Localizations.localeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ScorecardSectionTitle(docsChrome(locale, 'scRtlTitle')),
        Gap(rowGap),
        ScorecardCheckRow(
          label: docsChrome(locale, 'scRendersRtl'),
          passed: rtl?.passed,
          message: _rtlMessage(rtl),
        ),
        Gap(rowGap),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                docsChrome(locale, 'scMirroring'),
                style: docsText(context, size: 14),
              ),
            ),
            ScoreMirroringBadge(rtl: rtl),
          ],
        ),
      ],
    );
  }

  static String? _rtlMessage(DocsScorecardRtl? rtl) {
    if (rtl == null || rtl.passed != false) {
      return null;
    }
    return rtl.message;
  }
}

/// Frame-time section with the relative-environment tooltip.
class ScorecardFramesSection extends StatelessWidget {
  /// Creates the section.
  const ScorecardFramesSection({
    super.key,
    required this.scorecard,
    required this.rowGap,
  });

  /// Scorecard, or null when the component has no entry.
  final DocsScorecard? scorecard;

  /// Theme-derived row spacing.
  final double rowGap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ??
        Localizations.localeOf(context);
    final DocsScorecardFrames? frames = scorecard?.frames;
    final bool measured = frames?.p50Ms != null || frames?.p90Ms != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Tooltip(
          tooltip: (_) => Text(docsChrome(locale, 'scFrameNote')),
          child: Text(
            docsChrome(locale, 'scFrameTitle'),
            style: docsText(context, size: 13, weight: FontWeight.w600),
          ),
        ),
        Gap(rowGap),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                measured
                    ? _frameText(frames!, locale)
                    : docsChrome(locale, 'scNoFrame'),
                style: docsText(context, size: 14),
              ),
            ),
            if (!measured)
              Badge(
                variant: BadgeVariant.outline,
                child: Text(docsChrome(locale, 'scNotMeasured')),
              )
            else
              Badge(
                variant: BadgeVariant.secondary,
                child: Text(docsChrome(locale, 'scMeasured')),
              ),
          ],
        ),
        Gap(rowGap),
        Text(
          docsChrome(locale, 'scFrameNote'),
          style: docsText(
            context,
            size: 12,
            color: theme.colors.mutedForeground,
          ),
        ),
      ],
    );
  }

  static String _frameText(DocsScorecardFrames frames, Locale locale) {
    final String p50 = frames.p50Ms == null ? '—' : '${frames.p50Ms} ms';
    final String p90 = frames.p90Ms == null ? '—' : '${frames.p90Ms} ms';
    return docsFill(docsChrome(locale, 'scFrameText'), p50: p50, p90: p90);
  }
}

/// Tests section: count + harness pass.
class ScorecardTestsSection extends StatelessWidget {
  /// Creates the section.
  const ScorecardTestsSection({
    super.key,
    required this.scorecard,
    required this.rowGap,
  });

  /// Scorecard, or null when the component has no entry.
  final DocsScorecard? scorecard;

  /// Theme-derived row spacing.
  final double rowGap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ??
        Localizations.localeOf(context);
    final int count = scorecard?.tests.count ?? 0;
    final bool? passed = scorecard == null
        ? null
        : (scorecard!.tests.passed ? true : null);
    final String countLabel = count == 1
        ? docsChrome(locale, 'scTestsOne')
        : docsFill(docsChrome(locale, 'scTestsMany'), count: count);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ScorecardSectionTitle(docsChrome(locale, 'scTestsTitle')),
        Gap(rowGap),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(countLabel, style: docsText(context, size: 14)),
            ),
            ScoreStatusBadge(passed: passed),
          ],
        ),
        Gap(rowGap),
        Text(
          docsChrome(locale, 'scTestsNote'),
          style: docsText(
            context,
            size: 12,
            color: theme.colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}
