// GENERATED CODE - DO NOT MODIFY BY HAND.
//
// Sources:
//   * dashcn/lib/src/manifests/scorecards.json
//
// Regenerate: dart run tool/gen_docs_data.dart
//
// Measured quality facts per component (P9-5a harness output).
// `null` always means "not measured" and is never a pass.
// Frame times are test-environment relative, never device numbers.

/// One guideline check: `passed` null means not measured.
class DocsScorecardCheck {
  /// Creates the check.
  const DocsScorecardCheck({required this.passed, this.message, this.exempt});

  /// Whether the guideline passed, or null when not measured.
  final bool? passed;

  /// Failing guideline message, or null.
  final String? message;

  /// Documented exemption reason; exempt checks render as "Exempt"
  /// and never count as failures.
  final String? exempt;
}

/// Semantics presence: `present` null means not measured.
class DocsScorecardSemantics {
  /// Creates the entry.
  const DocsScorecardSemantics({
    required this.present,
    this.message,
    this.exempt,
  });

  /// Whether semantics were found, or null when not measured.
  final bool? present;

  /// Detail message, or null.
  final String? message;

  /// Documented exemption reason (see [DocsScorecardCheck.exempt]).
  final String? exempt;
}

/// Accessibility facts for one component.
class DocsScorecardA11y {
  /// Creates the facts.
  const DocsScorecardA11y({
    required this.textContrast,
    required this.labeledTapTarget,
    required this.androidTapTarget,
    required this.iOSTapTarget,
    required this.semantics,
  });

  /// Text contrast guideline.
  final DocsScorecardCheck textContrast;

  /// Labeled tap-target guideline.
  final DocsScorecardCheck labeledTapTarget;

  /// Android tap-target guideline (mobile, informational).
  final DocsScorecardCheck androidTapTarget;

  /// iOS tap-target guideline (mobile, informational).
  final DocsScorecardCheck iOSTapTarget;

  /// Semantics presence.
  final DocsScorecardSemantics semantics;
}

/// Right-to-left facts for one component.
class DocsScorecardRtl {
  /// Creates the facts.
  const DocsScorecardRtl({
    required this.passed,
    required this.renders,
    required this.mirrored,
    this.message,
    this.ltrX,
    this.rtlX,
  });

  /// Whether the RTL run passed, or null when not measured.
  final bool? passed;

  /// Whether the preview rendered under RTL, or null.
  final bool? renders;

  /// True when mirrored; null means symmetric/not applicable.
  final bool? mirrored;

  /// Detail message, or null.
  final String? message;

  /// First-text x in LTR, or null.
  final double? ltrX;

  /// First-text x in RTL, or null.
  final double? rtlX;
}

/// Frame-time facts for one component.
class DocsScorecardFrames {
  /// Creates the facts.
  const DocsScorecardFrames({
    required this.p50Ms,
    required this.p90Ms,
    required this.frames,
    required this.label,
  });

  /// p50 build time in ms, or null when not measured.
  final double? p50Ms;

  /// p90 build time in ms, or null when not measured.
  final double? p90Ms;

  /// Number of pumped frames.
  final int frames;

  /// Always `test environment (relative)`.
  final String label;
}

/// Test-count facts for one component.
class DocsScorecardTests {
  /// Creates the facts.
  const DocsScorecardTests({required this.count, required this.passed});

  /// Registry test cases tagged to the component.
  final int count;

  /// Harness pass at generation time.
  final bool passed;
}

/// All scorecard facts for one component.
class DocsScorecard {
  /// Creates the facts.
  const DocsScorecard({
    required this.componentId,
    required this.a11y,
    required this.rtl,
    required this.frames,
    required this.tests,
  });

  /// Registry component id.
  final String componentId;

  /// Accessibility facts.
  final DocsScorecardA11y a11y;

  /// Right-to-left facts.
  final DocsScorecardRtl rtl;

  /// Frame-time facts.
  final DocsScorecardFrames frames;

  /// Test-count facts.
  final DocsScorecardTests tests;

  /// Number of failing checks (a11y + semantics + rtl).
  /// Exempt checks never count as failures.
  int get failureCount {
    int count = 0;
    if (a11y.textContrast.passed == false && a11y.textContrast.exempt == null) {
      count++;
    }
    if (a11y.labeledTapTarget.passed == false &&
        a11y.labeledTapTarget.exempt == null) {
      count++;
    }
    if (a11y.androidTapTarget.passed == false &&
        a11y.androidTapTarget.exempt == null) {
      count++;
    }
    if (a11y.iOSTapTarget.passed == false && a11y.iOSTapTarget.exempt == null) {
      count++;
    }
    if (a11y.semantics.present == false && a11y.semantics.exempt == null) {
      count++;
    }
    if (rtl.passed == false) {
      count++;
    }
    return count;
  }

  /// Whether any measured check failed.
  bool get hasFailures => failureCount > 0;

  /// Number of checks with a documented exemption.
  int get exemptCount {
    int count = 0;
    if (a11y.textContrast.exempt != null) {
      count++;
    }
    if (a11y.labeledTapTarget.exempt != null) {
      count++;
    }
    if (a11y.androidTapTarget.exempt != null) {
      count++;
    }
    if (a11y.iOSTapTarget.exempt != null) {
      count++;
    }
    if (a11y.semantics.exempt != null) {
      count++;
    }
    return count;
  }
}

/// All 97 measured components, keyed by id (sorted).
const Map<String, DocsScorecard> kScorecards = <String, DocsScorecard>{
  'accordion': DocsScorecard(
    componentId: 'accordion',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 0.0,
      rtlX: 562.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.027,
      p90Ms: 0.035,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 8, passed: true),
  ),
  'action_sheet': DocsScorecard(
    componentId: 'action_sheet',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 281.0,
      rtlX: 281.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.028,
      p90Ms: 0.037,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 12, passed: true),
  ),
  'alert': DocsScorecard(
    componentId: 'alert',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 44.0,
      rtlX: 644.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.027,
      p90Ms: 0.033,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 35, passed: true),
  ),
  'alert_dialog': DocsScorecard(
    componentId: 'alert_dialog',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 302.0,
      rtlX: 302.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.026,
      p90Ms: 0.049,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 20, passed: true),
  ),
  'audio_player': DocsScorecard(
    componentId: 'audio_player',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 17.0,
      rtlX: 17.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.026,
      p90Ms: 0.055,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 28, passed: true),
  ),
  'autocomplete': DocsScorecard(
    componentId: 'autocomplete',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 13.0,
      rtlX: 339.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.023,
      p90Ms: 0.031,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 32, passed: true),
  ),
  'avatar': DocsScorecard(
    componentId: 'avatar',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: null,
      ltrX: null,
      rtlX: null,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.024,
      p90Ms: 0.062,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 12, passed: true),
  ),
  'badge': DocsScorecard(
    componentId: 'badge',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 358.0,
      rtlX: 358.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.021,
      p90Ms: 0.027,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 25, passed: true),
  ),
  'border_loading': DocsScorecard(
    componentId: 'border_loading',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 286.0,
      rtlX: 286.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.292,
      p90Ms: 0.717,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 12, passed: true),
  ),
  'breadcrumb': DocsScorecard(
    componentId: 'breadcrumb',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 208.0,
      rtlX: 536.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.017,
      p90Ms: 0.019,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 9, passed: true),
  ),
  'button': DocsScorecard(
    componentId: 'button',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 358.0,
      rtlX: 358.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.018,
      p90Ms: 0.031,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 36, passed: true),
  ),
  'calendar': DocsScorecard(
    componentId: 'calendar',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 288.0,
      rtlX: 480.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.023,
      p90Ms: 0.036,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 77, passed: true),
  ),
  'card': DocsScorecard(
    componentId: 'card',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 264.0,
      rtlX: 360.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.018,
      p90Ms: 0.035,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 41, passed: true),
  ),
  'card_image': DocsScorecard(
    componentId: 'card_image',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 198.0,
      rtlX: 518.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.015,
      p90Ms: 0.016,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 23, passed: true),
  ),
  'carousel': DocsScorecard(
    componentId: 'carousel',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 18.0,
      rtlX: 754.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.016,
      p90Ms: 0.019,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 38, passed: true),
  ),
  'chat': DocsScorecard(
    componentId: 'chat',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 392.0,
      rtlX: 172.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.016,
      p90Ms: 0.023,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 18, passed: true),
  ),
  'checkbox': DocsScorecard(
    componentId: 'checkbox',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 24.0,
      rtlX: 608.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.015,
      p90Ms: 0.02,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 39, passed: true),
  ),
  'chip': DocsScorecard(
    componentId: 'chip',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 94.0,
      rtlX: 550.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.018,
      p90Ms: 0.023,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 63, passed: true),
  ),
  'chip_input': DocsScorecard(
    componentId: 'chip_input',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 21.0,
      rtlX: 692.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.015,
      p90Ms: 0.02,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 42, passed: true),
  ),
  'code_snippet': DocsScorecard(
    componentId: 'code_snippet',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 205.0,
      rtlX: 245.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.013,
      p90Ms: 0.017,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 26, passed: true),
  ),
  'collapsible': DocsScorecard(
    componentId: 'collapsible',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 16.0,
      rtlX: 80.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.013,
      p90Ms: 0.014,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 8, passed: true),
  ),
  'color_picker': DocsScorecard(
    componentId: 'color_picker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 56.0,
      rtlX: 696.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.013,
      p90Ms: 0.014,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 22, passed: true),
  ),
  'command': DocsScorecard(
    componentId: 'command',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 280.0,
      rtlX: 252.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.013,
      p90Ms: 0.025,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 11, passed: true),
  ),
  'context_menu': DocsScorecard(
    componentId: 'context_menu',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 311.5,
      rtlX: 293.5,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.013,
      p90Ms: 0.031,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 24, passed: true),
  ),
  'country_flag': DocsScorecard(
    componentId: 'country_flag',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 0.0,
      rtlX: 776.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.021,
      p90Ms: 0.096,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 13, passed: true),
  ),
  'date_picker': DocsScorecard(
    componentId: 'date_picker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 0.0,
      rtlX: 644.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.015,
      p90Ms: 0.027,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 19, passed: true),
  ),
  'dialog': DocsScorecard(
    componentId: 'dialog',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 316.0,
      rtlX: 316.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.015,
      p90Ms: 0.052,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 15, passed: true),
  ),
  'divider': DocsScorecard(
    componentId: 'divider',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: null,
      ltrX: null,
      rtlX: null,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.013,
      p90Ms: 0.016,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 18, passed: true),
  ),
  'dot_indicator': DocsScorecard(
    componentId: 'dot_indicator',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 358.0,
      rtlX: 358.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.015,
      p90Ms: 0.058,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 23, passed: true),
  ),
  'drawer': DocsScorecard(
    componentId: 'drawer',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 86.0,
      rtlX: 588.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.013,
      p90Ms: 0.02,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 19, passed: true),
  ),
  'dropdown_menu': DocsScorecard(
    componentId: 'dropdown_menu',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 303.0,
      rtlX: 399.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.019,
      p90Ms: 0.066,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 10, passed: true),
  ),
  'dropzone': DocsScorecard(
    componentId: 'dropzone',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 246.0,
      rtlX: 246.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.012,
      p90Ms: 0.019,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 30, passed: true),
  ),
  'empty_state': DocsScorecard(
    componentId: 'empty_state',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 208.0,
      rtlX: 208.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.012,
      p90Ms: 0.02,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 31, passed: true),
  ),
  'fab': DocsScorecard(
    componentId: 'fab',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: null,
      ltrX: null,
      rtlX: null,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.013,
      p90Ms: 0.044,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 16, passed: true),
  ),
  'feature_carousel': DocsScorecard(
    componentId: 'feature_carousel',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 364.0,
      rtlX: 364.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.012,
      p90Ms: 0.017,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 19, passed: true),
  ),
  'file_diff_viewer': DocsScorecard(
    componentId: 'file_diff_viewer',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 33.0,
      rtlX: 501.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.018,
      p90Ms: 0.062,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 9, passed: true),
  ),
  'file_picker': DocsScorecard(
    componentId: 'file_picker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 274.0,
      rtlX: 274.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.02,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 23, passed: true),
  ),
  'filter_bar': DocsScorecard(
    componentId: 'filter_bar',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 45.0,
      rtlX: 671.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.012,
      p90Ms: 0.026,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 29, passed: true),
  ),
  'form': DocsScorecard(
    componentId: 'form',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 0.0,
      rtlX: 0.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.011,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 18, passed: true),
  ),
  'formatted_input': DocsScorecard(
    componentId: 'formatted_input',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 33.0,
      rtlX: 753.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.012,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 39, passed: true),
  ),
  'gooey_toast': DocsScorecard(
    componentId: 'gooey_toast',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 321.0,
      rtlX: 409.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.011,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 21, passed: true),
  ),
  'hover_card': DocsScorecard(
    componentId: 'hover_card',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 0.0,
      rtlX: 0.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.012,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 10, passed: true),
  ),
  'image': DocsScorecard(
    componentId: 'image',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: null,
      ltrX: null,
      rtlX: null,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.013,
      p90Ms: 0.022,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 29, passed: true),
  ),
  'image_lightbox': DocsScorecard(
    componentId: 'image_lightbox',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 20.0,
      rtlX: 710.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.055,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 16, passed: true),
  ),
  'input': DocsScorecard(
    componentId: 'input',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 0.0,
      rtlX: 0.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.012,
      p90Ms: 0.022,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 81, passed: true),
  ),
  'input_otp': DocsScorecard(
    componentId: 'input_otp',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 18.0,
      rtlX: 562.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.012,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 55, passed: true),
  ),
  'item_picker': DocsScorecard(
    componentId: 'item_picker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 37.5,
      rtlX: 748.5,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.01,
      p90Ms: 0.017,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 13, passed: true),
  ),
  'keyboard_shortcut': DocsScorecard(
    componentId: 'keyboard_shortcut',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 380.0,
      rtlX: 408.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.01,
      p90Ms: 0.037,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 37, passed: true),
  ),
  'list_tile': DocsScorecard(
    componentId: 'list_tile',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 60.0,
      rtlX: 670.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.012,
      p90Ms: 0.014,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 11, passed: true),
  ),
  'markdown': DocsScorecard(
    componentId: 'markdown',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 334.0,
      rtlX: 334.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.01,
      p90Ms: 0.011,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 31, passed: true),
  ),
  'menu': DocsScorecard(
    componentId: 'menu',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 13.0,
      rtlX: 745.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.012,
      p90Ms: 0.039,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 39, passed: true),
  ),
  'menubar': DocsScorecard(
    componentId: 'menubar',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 12.0,
      rtlX: 732.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.012,
      p90Ms: 0.022,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 15, passed: true),
  ),
  'multi_select': DocsScorecard(
    componentId: 'multi_select',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 20.0,
      rtlX: 720.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.012,
      p90Ms: 0.013,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 9, passed: true),
  ),
  'navigation_bar': DocsScorecard(
    componentId: 'navigation_bar',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 82.0,
      rtlX: 670.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.012,
      p90Ms: 0.022,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 24, passed: true),
  ),
  'navigation_menu': DocsScorecard(
    componentId: 'navigation_menu',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 16.0,
      rtlX: 574.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.013,
      p90Ms: 0.028,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 25, passed: true),
  ),
  'number_ticker': DocsScorecard(
    componentId: 'number_ticker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 0.0,
      rtlX: 744.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.012,
      p90Ms: 0.022,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 10, passed: true),
  ),
  'object_input': DocsScorecard(
    componentId: 'object_input',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 9.0,
      rtlX: 763.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.012,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 19, passed: true),
  ),
  'overflow_marquee': DocsScorecard(
    componentId: 'overflow_marquee',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 9.5,
      rtlX: -1287.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.206,
      p90Ms: 0.499,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 17, passed: true),
  ),
  'pagination': DocsScorecard(
    componentId: 'pagination',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 32.0,
      rtlX: 656.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.026,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 14, passed: true),
  ),
  'phone_input': DocsScorecard(
    componentId: 'phone_input',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 13.0,
      rtlX: 763.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.011,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 21, passed: true),
  ),
  'pinned_sheet': DocsScorecard(
    componentId: 'pinned_sheet',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 12.0,
      rtlX: 648.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.01,
      p90Ms: 0.011,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 21, passed: true),
  ),
  'popup': DocsScorecard(
    componentId: 'popup',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 13.0,
      rtlX: 661.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.012,
      p90Ms: 0.032,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 18, passed: true),
  ),
  'progress': DocsScorecard(
    componentId: 'progress',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: null,
      ltrX: null,
      rtlX: null,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.01,
      p90Ms: 0.012,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 11, passed: true),
  ),
  'qr_code': DocsScorecard(
    componentId: 'qr_code',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: null,
      ltrX: null,
      rtlX: null,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.014,
      p90Ms: 0.055,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 17, passed: true),
  ),
  'radio_group': DocsScorecard(
    componentId: 'radio_group',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 26.0,
      rtlX: 718.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.01,
      p90Ms: 0.011,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 33, passed: true),
  ),
  'refresh_trigger': DocsScorecard(
    componentId: 'refresh_trigger',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 0.0,
      rtlX: 0.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.01,
      p90Ms: 0.011,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 28, passed: true),
  ),
  'resizable': DocsScorecard(
    componentId: 'resizable',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 11.0,
      rtlX: 691.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.011,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 11, passed: true),
  ),
  'scaffold': DocsScorecard(
    componentId: 'scaffold',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 84.0,
      rtlX: 84.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.011,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 12, passed: true),
  ),
  'scrollbar': DocsScorecard(
    componentId: 'scrollbar',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 8.0,
      rtlX: 8.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.012,
      p90Ms: 0.027,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 10, passed: true),
  ),
  'search_bar': DocsScorecard(
    componentId: 'search_bar',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 40.0,
      rtlX: 592.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.021,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 30, passed: true),
  ),
  'segmented_control': DocsScorecard(
    componentId: 'segmented_control',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 306.0,
      rtlX: 455.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.012,
      p90Ms: 0.025,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 21, passed: true),
  ),
  'select': DocsScorecard(
    componentId: 'select',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 12.0,
      rtlX: 36.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.012,
      p90Ms: 0.044,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 22, passed: true),
  ),
  'sidebar': DocsScorecard(
    componentId: 'sidebar',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 44.0,
      rtlX: 600.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.015,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 10, passed: true),
  ),
  'signature_pad': DocsScorecard(
    componentId: 'signature_pad',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 0.0,
      rtlX: 744.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.036,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 16, passed: true),
  ),
  'skeleton': DocsScorecard(
    componentId: 'skeleton',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 12.0,
      rtlX: 620.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.207,
      p90Ms: 0.477,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 44, passed: true),
  ),
  'slider': DocsScorecard(
    componentId: 'slider',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: null,
      ltrX: null,
      rtlX: null,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.015,
      p90Ms: 0.033,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 20, passed: true),
  ),
  'sortable': DocsScorecard(
    componentId: 'sortable',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 39.0,
      rtlX: 13.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.012,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 7, passed: true),
  ),
  'spinner': DocsScorecard(
    componentId: 'spinner',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: null,
      ltrX: null,
      rtlX: null,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.357,
      p90Ms: 0.735,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 9, passed: true),
  ),
  'star_rating': DocsScorecard(
    componentId: 'star_rating',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: null,
      ltrX: null,
      rtlX: null,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.031,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 12, passed: true),
  ),
  'stepper': DocsScorecard(
    componentId: 'stepper',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 48.0,
      rtlX: 646.6666666666667,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.01,
      p90Ms: 0.011,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 18, passed: true),
  ),
  'steps': DocsScorecard(
    componentId: 'steps',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 7.0,
      rtlX: 779.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.01,
      p90Ms: 0.011,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 7, passed: true),
  ),
  'swipe_actions': DocsScorecard(
    componentId: 'swipe_actions',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 684.0,
      rtlX: 68.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.021,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 27, passed: true),
  ),
  'switch': DocsScorecard(
    componentId: 'switch',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 42.0,
      rtlX: 576.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.011,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 27, passed: true),
  ),
  'table': DocsScorecard(
    componentId: 'table',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 248.0,
      rtlX: 482.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.014,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 27, passed: true),
  ),
  'tabs': DocsScorecard(
    componentId: 'tabs',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 9.549999999999997,
      rtlX: 687.55,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.012,
      p90Ms: 0.013,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 14, passed: true),
  ),
  'text_animate': DocsScorecard(
    componentId: 'text_animate',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 0.0,
      rtlX: 366.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.01,
      p90Ms: 0.011,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 29, passed: true),
  ),
  'text_area': DocsScorecard(
    componentId: 'text_area',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: null,
      ltrX: null,
      rtlX: null,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.012,
      p90Ms: 0.048,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 34, passed: true),
  ),
  'time_picker': DocsScorecard(
    componentId: 'time_picker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 36.0,
      rtlX: 694.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.015,
      p90Ms: 0.034,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 22, passed: true),
  ),
  'timeline': DocsScorecard(
    componentId: 'timeline',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 50.0,
      rtlX: 680.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.01,
      p90Ms: 0.014,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 24, passed: true),
  ),
  'toast': DocsScorecard(
    componentId: 'toast',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 330.0,
      rtlX: 330.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.012,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 14, passed: true),
  ),
  'toggle': DocsScorecard(
    componentId: 'toggle',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 379.0,
      rtlX: 379.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.012,
      p90Ms: 0.02,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 11, passed: true),
  ),
  'toolbar': DocsScorecard(
    componentId: 'toolbar',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: null,
      ltrX: null,
      rtlX: null,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.01,
      p90Ms: 0.012,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 14, passed: true),
  ),
  'tooltip': DocsScorecard(
    componentId: 'tooltip',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: null,
      ltrX: null,
      rtlX: null,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.012,
      p90Ms: 0.014,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 16, passed: true),
  ),
  'tracker': DocsScorecard(
    componentId: 'tracker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: null,
      ltrX: null,
      rtlX: null,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.01,
      p90Ms: 0.012,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 15, passed: true),
  ),
  'tree': DocsScorecard(
    componentId: 'tree',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 56.0,
      rtlX: 8.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.01,
      p90Ms: 0.01,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 40, passed: true),
  ),
  'video_player': DocsScorecard(
    componentId: 'video_player',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 320.0,
      rtlX: 320.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.024,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 31, passed: true),
  ),
  'wheel_picker': DocsScorecard(
    componentId: 'wheel_picker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: true,
        message: null,
        exempt: null,
      ),
      semantics: DocsScorecardSemantics(
        present: true,
        message: null,
        exempt: null,
      ),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 384.0007167857057,
      rtlX: 384.0007167857057,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.011,
      p90Ms: 0.011,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 18, passed: true),
  ),
};

/// Generator timestamp (UTC ISO) for the card footer.
const String kScorecardsGeneratedAt = '2026-10-23T03:13:52.714946Z';

/// Full commit hash at generation time.
const String kScorecardsCommit = '103fa738c96980ec834959c63197dc412f30576e';

/// Short commit hash (7 chars) for the card footer.
const String kScorecardsCommitShort = '103fa73';

/// Flutter/Dart version at generation time.
const String kScorecardsFlutter = '3.47.7 / Dart 3.13.5';
