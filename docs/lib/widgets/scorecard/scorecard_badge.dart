// Scorecard badges (P9-5b): pass/fail/not-measured and mirroring states.
//
// `null` always means "not measured" and is never shown as a pass.

import 'package:flutter/widgets.dart';

import '../../ui/dashcn/components/badge/badge.dart';
import '../../generated/docs_scorecards.dart';
import '../../routing/docs_router.dart';
import '../../state/docs_strings.dart';

/// Label for tap-target rows (mobile guideline, informational on desktop).
const String kTapTargetGuidelineLabel =
    'Mobile tap-target guideline (44/48 px)';

/// Tooltip text for the frame-time section (never device performance).
const String kFrameTooltip =
    'Measured with 120 pumped frames in the widget test environment. '
    'Relative numbers for comparing components, not device performance.';

/// Pass/fail/exempt/not-measured badge.
class ScoreStatusBadge extends StatelessWidget {
  /// Creates the badge for [passed] (null means not measured).
  const ScoreStatusBadge({super.key, required this.passed, this.exempt});

  /// Whether the check passed, or null when not measured.
  final bool? passed;

  /// Documented exemption reason; renders as "Exempt" when non-null.
  final String? exempt;

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ??
        Localizations.localeOf(context);
    if (exempt != null) {
      return Badge(
        variant: BadgeVariant.outline,
        child: Text(docsChrome(locale, 'scExempt')),
      );
    }
    if (passed == null) {
      return Badge(
        variant: BadgeVariant.outline,
        child: Text(docsChrome(locale, 'scNotMeasured')),
      );
    }
    if (passed!) {
      return Badge(
        variant: BadgeVariant.secondary,
        child: Text(docsChrome(locale, 'scPass')),
      );
    }
    return Badge(
      variant: BadgeVariant.destructive,
      child: Text(docsChrome(locale, 'scFail')),
    );
  }
}

/// Mirroring badge: mirrored / symmetric / not applicable / not measured.
class ScoreMirroringBadge extends StatelessWidget {
  /// Creates the badge.
  const ScoreMirroringBadge({super.key, required this.rtl});

  /// RTL facts, or null when the component has no scorecard.
  final DocsScorecardRtl? rtl;

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ??
        Localizations.localeOf(context);
    if (rtl == null || rtl!.passed == null) {
      return Badge(
        variant: BadgeVariant.outline,
        child: Text(docsChrome(locale, 'scNotMeasured')),
      );
    }
    if (rtl!.mirrored == true) {
      return Badge(
        variant: BadgeVariant.secondary,
        child: Text(docsChrome(locale, 'scMirrored')),
      );
    }
    final String? message = rtl!.message;
    if (message != null && message.contains('symmetric')) {
      return Badge(
        variant: BadgeVariant.secondary,
        child: Text(docsChrome(locale, 'scSymmetric')),
      );
    }
    if (rtl!.ltrX == null || rtl!.rtlX == null) {
      return Badge(
        variant: BadgeVariant.secondary,
        child: Text(docsChrome(locale, 'scNotApplicable')),
      );
    }
    return Badge(
      variant: BadgeVariant.secondary,
      child: Text(docsChrome(locale, 'scSymmetric')),
    );
  }
}
