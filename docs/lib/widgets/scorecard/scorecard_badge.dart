// Scorecard badges (P9-5b): pass/fail/not-measured and mirroring states.
//
// `null` always means "not measured" and is never shown as a pass.

import 'package:flutter/widgets.dart';

import '../../ui/dashcn/components/badge/badge.dart';
import '../../generated/docs_scorecards.dart';

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
    if (exempt != null) {
      return const Badge(variant: BadgeVariant.outline, child: Text('Exempt'));
    }
    if (passed == null) {
      return const Badge(
        variant: BadgeVariant.outline,
        child: Text('Not measured'),
      );
    }
    if (passed!) {
      return const Badge(variant: BadgeVariant.secondary, child: Text('Pass'));
    }
    return const Badge(variant: BadgeVariant.destructive, child: Text('Fail'));
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
    if (rtl == null || rtl!.passed == null) {
      return const Badge(
        variant: BadgeVariant.outline,
        child: Text('Not measured'),
      );
    }
    if (rtl!.mirrored == true) {
      return const Badge(
        variant: BadgeVariant.secondary,
        child: Text('Mirrored'),
      );
    }
    final String? message = rtl!.message;
    if (message != null && message.contains('symmetric')) {
      return const Badge(
        variant: BadgeVariant.secondary,
        child: Text('Symmetric'),
      );
    }
    if (rtl!.ltrX == null || rtl!.rtlX == null) {
      return const Badge(
        variant: BadgeVariant.secondary,
        child: Text('Not applicable'),
      );
    }
    return const Badge(
      variant: BadgeVariant.secondary,
      child: Text('Symmetric'),
    );
  }
}
