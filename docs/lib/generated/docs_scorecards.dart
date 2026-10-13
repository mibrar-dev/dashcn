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
  const DocsScorecardCheck({required this.passed, this.message});

  /// Whether the guideline passed, or null when not measured.
  final bool? passed;

  /// Failing guideline message, or null.
  final String? message;
}

/// Semantics presence: `present` null means not measured.
class DocsScorecardSemantics {
  /// Creates the entry.
  const DocsScorecardSemantics({required this.present, this.message});

  /// Whether semantics were found, or null when not measured.
  final bool? present;

  /// Detail message, or null.
  final String? message;
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
  int get failureCount {
    int count = 0;
    if (a11y.textContrast.passed == false) {
      count++;
    }
    if (a11y.labeledTapTarget.passed == false) {
      count++;
    }
    if (a11y.androidTapTarget.passed == false) {
      count++;
    }
    if (a11y.iOSTapTarget.passed == false) {
      count++;
    }
    if (a11y.semantics.present == false) {
      count++;
    }
    if (rtl.passed == false) {
      count++;
    }
    return count;
  }

  /// Whether any measured check failed.
  bool get hasFailures => failureCount > 0;
}

/// All 84 measured components, keyed by id (sorted).
const Map<String, DocsScorecard> kScorecards = <String, DocsScorecard>{
  'accordion': DocsScorecard(
    componentId: 'accordion',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.054,
      p90Ms: 0.122,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 8, passed: true),
  ),
  'alert': DocsScorecard(
    componentId: 'alert',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.059,
      p90Ms: 0.114,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 32, passed: true),
  ),
  'alert_dialog': DocsScorecard(
    componentId: 'alert_dialog',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 227.5,
      rtlX: 191.5,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.048,
      p90Ms: 0.087,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 17, passed: true),
  ),
  'autocomplete': DocsScorecard(
    componentId: 'autocomplete',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.049,
      p90Ms: 0.098,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 32, passed: true),
  ),
  'avatar': DocsScorecard(
    componentId: 'avatar',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.05,
      p90Ms: 0.081,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 12, passed: true),
  ),
  'badge': DocsScorecard(
    componentId: 'badge',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.068,
      p90Ms: 0.132,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 25, passed: true),
  ),
  'border_loading': DocsScorecard(
    componentId: 'border_loading',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 1.057,
      p90Ms: 1.717,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 12, passed: true),
  ),
  'breadcrumb': DocsScorecard(
    componentId: 'breadcrumb',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.039,
      p90Ms: 0.082,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 9, passed: true),
  ),
  'button': DocsScorecard(
    componentId: 'button',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.036,
      p90Ms: 0.057,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 12, passed: true),
  ),
  'calendar': DocsScorecard(
    componentId: 'calendar',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#5(Rect.fromLTRB(12.0, 44.0, 44.0, 76.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Feb 26, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#6(Rect.fromLTRB(48.0, 44.0, 80.0, 76.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Feb 27, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#7(Rect.fromLTRB(84.0, 44.0, 116.0, 76.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Feb 28, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#8(Rect.fromLTRB(120.0, 44.0, 152.0, 76.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Feb 29, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#9(Rect.fromLTRB(156.0, 44.0, 188.0, 76.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 1, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#10(Rect.fromLTRB(192.0, 44.0, 224.0, 76.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 2, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#11(Rect.fromLTRB(228.0, 44.0, 260.0, 76.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 3, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#12(Rect.fromLTRB(12.0, 80.0, 44.0, 112.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 4, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#13(Rect.fromLTRB(48.0, 80.0, 80.0, 112.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 5, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#14(Rect.fromLTRB(84.0, 80.0, 116.0, 112.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 6, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#15(Rect.fromLTRB(120.0, 80.0, 152.0, 112.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 7, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#16(Rect.fromLTRB(156.0, 80.0, 188.0, 112.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 8, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#17(Rect.fromLTRB(192.0, 80.0, 224.0, 112.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 9, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#18(Rect.fromLTRB(228.0, 80.0, 260.0, 112.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 10, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#19(Rect.fromLTRB(12.0, 116.0, 44.0, 148.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 11, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#20(Rect.fromLTRB(48.0, 116.0, 80.0, 148.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 12, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#21(Rect.fromLTRB(84.0, 116.0, 116.0, 148.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 13, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#22(Rect.fromLTRB(120.0, 116.0, 152.0, 148.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 14, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#23(Rect.fromLTRB(156.0, 116.0, 188.0, 148.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 15, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#24(Rect.fromLTRB(192.0, 116.0, 224.0, 148.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 16, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#25(Rect.fromLTRB(228.0, 116.0, 260.0, 148.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 17, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#26(Rect.fromLTRB(12.0, 152.0, 44.0, 184.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 18, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#27(Rect.fromLTRB(48.0, 152.0, 80.0, 184.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 19, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#28(Rect.fromLTRB(84.0, 152.0, 116.0, 184.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 20, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#29(Rect.fromLTRB(120.0, 152.0, 152.0, 184.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 21, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#30(Rect.fromLTRB(156.0, 152.0, 188.0, 184.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 22, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#31(Rect.fromLTRB(192.0, 152.0, 224.0, 184.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 23, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#32(Rect.fromLTRB(228.0, 152.0, 260.0, 184.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 24, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#33(Rect.fromLTRB(12.0, 188.0, 44.0, 220.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 25, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#34(Rect.fromLTRB(48.0, 188.0, 80.0, 220.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 26, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#35(Rect.fromLTRB(84.0, 188.0, 116.0, 220.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 27, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#36(Rect.fromLTRB(120.0, 188.0, 152.0, 220.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 28, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#37(Rect.fromLTRB(156.0, 188.0, 188.0, 220.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 29, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#38(Rect.fromLTRB(192.0, 188.0, 224.0, 220.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 30, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#39(Rect.fromLTRB(228.0, 188.0, 260.0, 220.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 31, 2024", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(32.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#5(Rect.fromLTRB(12.0, 44.0, 44.0, 76.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Feb 26, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#6(Rect.fromLTRB(48.0, 44.0, 80.0, 76.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Feb 27, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#7(Rect.fromLTRB(84.0, 44.0, 116.0, 76.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Feb 28, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#8(Rect.fromLTRB(120.0, 44.0, 152.0, 76.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Feb 29, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#9(Rect.fromLTRB(156.0, 44.0, 188.0, 76.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 1, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#10(Rect.fromLTRB(192.0, 44.0, 224.0, 76.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 2, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#11(Rect.fromLTRB(228.0, 44.0, 260.0, 76.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 3, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#12(Rect.fromLTRB(12.0, 80.0, 44.0, 112.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 4, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#13(Rect.fromLTRB(48.0, 80.0, 80.0, 112.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 5, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#14(Rect.fromLTRB(84.0, 80.0, 116.0, 112.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 6, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#15(Rect.fromLTRB(120.0, 80.0, 152.0, 112.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 7, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#16(Rect.fromLTRB(156.0, 80.0, 188.0, 112.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 8, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#17(Rect.fromLTRB(192.0, 80.0, 224.0, 112.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 9, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#18(Rect.fromLTRB(228.0, 80.0, 260.0, 112.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 10, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#19(Rect.fromLTRB(12.0, 116.0, 44.0, 148.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 11, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#20(Rect.fromLTRB(48.0, 116.0, 80.0, 148.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 12, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#21(Rect.fromLTRB(84.0, 116.0, 116.0, 148.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 13, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#22(Rect.fromLTRB(120.0, 116.0, 152.0, 148.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 14, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#23(Rect.fromLTRB(156.0, 116.0, 188.0, 148.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 15, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#24(Rect.fromLTRB(192.0, 116.0, 224.0, 148.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 16, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#25(Rect.fromLTRB(228.0, 116.0, 260.0, 148.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 17, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#26(Rect.fromLTRB(12.0, 152.0, 44.0, 184.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 18, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#27(Rect.fromLTRB(48.0, 152.0, 80.0, 184.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 19, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#28(Rect.fromLTRB(84.0, 152.0, 116.0, 184.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 20, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#29(Rect.fromLTRB(120.0, 152.0, 152.0, 184.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 21, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#30(Rect.fromLTRB(156.0, 152.0, 188.0, 184.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 22, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#31(Rect.fromLTRB(192.0, 152.0, 224.0, 184.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 23, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#32(Rect.fromLTRB(228.0, 152.0, 260.0, 184.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 24, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#33(Rect.fromLTRB(12.0, 188.0, 44.0, 220.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 25, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#34(Rect.fromLTRB(48.0, 188.0, 80.0, 220.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 26, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#35(Rect.fromLTRB(84.0, 188.0, 116.0, 220.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 27, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#36(Rect.fromLTRB(120.0, 188.0, 152.0, 220.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 28, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#37(Rect.fromLTRB(156.0, 188.0, 188.0, 220.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 29, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#38(Rect.fromLTRB(192.0, 188.0, 224.0, 220.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 30, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#39(Rect.fromLTRB(228.0, 188.0, 260.0, 220.0), actions: [tap], flags: [isButton, hasEnabledState, isEnabled, hasSelectedState], label: "Mar 31, 2024", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(32.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/',
      ),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 331.0,
      rtlX: 455.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.029,
      p90Ms: 0.039,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 77, passed: true),
  ),
  'card': DocsScorecard(
    componentId: 'card',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.029,
      p90Ms: 0.046,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 36, passed: true),
  ),
  'card_image': DocsScorecard(
    componentId: 'card_image',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 26.0,
      rtlX: 690.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.029,
      p90Ms: 0.042,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 18, passed: true),
  ),
  'carousel': DocsScorecard(
    componentId: 'carousel',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 36.0, 48.0) with transform [[3.0,0.0,0.0,480.0]; [0.0,3.0,0.0,168.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Previous", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(36.0, 48.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 36.0, 48.0) with transform [[3.0,0.0,0.0,1812.0]; [0.0,3.0,0.0,168.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Next", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(36.0, 48.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1050.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isSelected, isFocusable, hasSelectedState], label: "Page 1 of 5", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(20.0, 20.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1110.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 2 of 5", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(20.0, 20.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1170.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 3 of 5", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(20.0, 20.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#6(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1230.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 4 of 5", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(20.0, 20.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#7(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1290.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 5 of 5", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(20.0, 20.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 36.0, 48.0) with transform [[3.0,0.0,0.0,480.0]; [0.0,3.0,0.0,168.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Previous", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(36.0, 48.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 36.0, 48.0) with transform [[3.0,0.0,0.0,1812.0]; [0.0,3.0,0.0,168.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Next", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(36.0, 48.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1050.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isSelected, isFocusable, hasSelectedState], label: "Page 1 of 5", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(20.0, 20.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1110.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 2 of 5", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(20.0, 20.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1170.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 3 of 5", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(20.0, 20.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#6(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1230.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 4 of 5", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(20.0, 20.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#7(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1290.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 5 of 5", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(20.0, 20.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/',
      ),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: -6.0,
      rtlX: 778.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.029,
      p90Ms: 0.07,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 38, passed: true),
  ),
  'chat': DocsScorecard(
    componentId: 'chat',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.029,
      p90Ms: 0.057,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 18, passed: true),
  ),
  'checkbox': DocsScorecard(
    componentId: 'checkbox',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.028,
      p90Ms: 0.04,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 39, passed: true),
  ),
  'chip': DocsScorecard(
    componentId: 'chip',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(172.0, 4.0, 184.0, 16.0), actions: [focus, tap], flags: [isFocusable], label: "Remove Design system", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(12.0, 12.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#4(Rect.fromLTRB(100.0, 4.0, 112.0, 16.0), actions: [focus, tap], flags: [isFocusable], label: "Remove Flutter", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(12.0, 12.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#6(Rect.fromLTRB(172.0, 4.0, 184.0, 16.0), actions: [focus, tap], flags: [isFocusable], label: "Remove Accessibility", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(12.0, 12.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#8(Rect.fromLTRB(124.0, 4.0, 136.0, 16.0), actions: [focus, tap], flags: [isFocusable], label: "Remove Dark mode", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(12.0, 12.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n\n',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(172.0, 4.0, 184.0, 16.0), actions: [focus, tap], flags: [isFocusable], label: "Remove Design system", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(12.0, 12.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#4(Rect.fromLTRB(100.0, 4.0, 112.0, 16.0), actions: [focus, tap], flags: [isFocusable], label: "Remove Flutter", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(12.0, 12.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#6(Rect.fromLTRB(172.0, 4.0, 184.0, 16.0), actions: [focus, tap], flags: [isFocusable], label: "Remove Accessibility", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(12.0, 12.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#8(Rect.fromLTRB(124.0, 4.0, 136.0, 16.0), actions: [focus, tap], flags: [isFocusable], label: "Remove Dark mode", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(12.0, 12.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n\n',
      ),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 72.0,
      rtlX: 572.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.029,
      p90Ms: 0.044,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 63, passed: true),
  ),
  'chip_input': DocsScorecard(
    componentId: 'chip_input',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(113.0, 12.0, 125.0, 24.0), tags: [PlaceholderSpanIndexSemanticsTag(0)], actions: [focus, tap], flags: [isFocusable], label: "Delete", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(12.0, 12.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(113.0, 12.0, 125.0, 24.0), tags: [PlaceholderSpanIndexSemanticsTag(0)], actions: [focus, tap], flags: [isFocusable], label: "Delete", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(12.0, 12.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n',
      ),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.029,
      p90Ms: 0.053,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 42, passed: true),
  ),
  'code_snippet': DocsScorecard(
    componentId: 'code_snippet',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 17.0,
      rtlX: 393.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.028,
      p90Ms: 0.046,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 9, passed: true),
  ),
  'collapsible': DocsScorecard(
    componentId: 'collapsible',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 16.0,
      rtlX: 68.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.027,
      p90Ms: 0.044,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 8, passed: true),
  ),
  'color_picker': DocsScorecard(
    componentId: 'color_picker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.023,
      p90Ms: 0.035,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 22, passed: true),
  ),
  'command': DocsScorecard(
    componentId: 'command',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#6(Rect.fromLTRB(4.0, 4.0, 316.0, 30.0), tags: [RenderViewport.twoPane], actions: [focus, tap], flags: [isFocusable], label: "Calendar", textDirection: ltr, indexInParent: 0): expected tap target size of at least Size(48.0, 48.0), but found Size(312.0, 26.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#7(Rect.fromLTRB(4.0, 30.0, 316.0, 56.0), tags: [RenderViewport.twoPane], actions: [focus, tap], flags: [isFocusable], label: "Search Emoji", textDirection: ltr, indexInParent: 1): expected tap target size of at least Size(48.0, 48.0), but found Size(312.0, 26.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#8(Rect.fromLTRB(4.0, 56.0, 316.0, 82.0), tags: [RenderViewport.twoPane], actions: [focus, tap], flags: [isFocusable], label: "Launch", textDirection: ltr, indexInParent: 2): expected tap target size of at least Size(48.0, 48.0), but found Size(312.0, 26.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#9(Rect.fromLTRB(4.0, 82.0, 316.0, 108.0), tags: [RenderViewport.twoPane], actions: [focus, tap], flags: [isFocusable], label: "Profile", textDirection: ltr, indexInParent: 3): expected tap target size of at least Size(48.0, 48.0), but found Size(312.0, 26.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#10(Rect.fromLTRB(4.0, 108.0, 316.0, 134.0), tags: [RenderViewport.twoPane], actions: [focus, tap], flags: [isFocusable], label: "Mail", textDirection: ltr, indexInParent: 4): expected tap target size of at least Size(48.0, 48.0), but found Size(312.0, 26.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#11(Rect.fromLTRB(4.0, 134.0, 316.0, 160.0), tags: [RenderViewport.twoPane], actions: [focus, tap], flags: [isFocusable], label: "Settings", textDirection: ltr, indexInParent: 5): expected tap target size of at least Size(48.0, 48.0), but found Size(312.0, 26.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#6(Rect.fromLTRB(4.0, 4.0, 316.0, 30.0), tags: [RenderViewport.twoPane], actions: [focus, tap], flags: [isFocusable], label: "Calendar", textDirection: ltr, indexInParent: 0): expected tap target size of at least Size(44.0, 44.0), but found Size(312.0, 26.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#7(Rect.fromLTRB(4.0, 30.0, 316.0, 56.0), tags: [RenderViewport.twoPane], actions: [focus, tap], flags: [isFocusable], label: "Search Emoji", textDirection: ltr, indexInParent: 1): expected tap target size of at least Size(44.0, 44.0), but found Size(312.0, 26.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#8(Rect.fromLTRB(4.0, 56.0, 316.0, 82.0), tags: [RenderViewport.twoPane], actions: [focus, tap], flags: [isFocusable], label: "Launch", textDirection: ltr, indexInParent: 2): expected tap target size of at least Size(44.0, 44.0), but found Size(312.0, 26.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#9(Rect.fromLTRB(4.0, 82.0, 316.0, 108.0), tags: [RenderViewport.twoPane], actions: [focus, tap], flags: [isFocusable], label: "Profile", textDirection: ltr, indexInParent: 3): expected tap target size of at least Size(44.0, 44.0), but found Size(312.0, 26.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#10(Rect.fromLTRB(4.0, 108.0, 316.0, 134.0), tags: [RenderViewport.twoPane], actions: [focus, tap], flags: [isFocusable], label: "Mail", textDirection: ltr, indexInParent: 4): expected tap target size of at least Size(44.0, 44.0), but found Size(312.0, 26.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#11(Rect.fromLTRB(4.0, 134.0, 316.0, 160.0), tags: [RenderViewport.twoPane], actions: [focus, tap], flags: [isFocusable], label: "Settings", textDirection: ltr, indexInParent: 5): expected tap target size of at least Size(44.0, 44.0), but found Size(312.0, 26.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n',
      ),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.023,
      p90Ms: 0.047,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 11, passed: true),
  ),
  'context_menu': DocsScorecard(
    componentId: 'context_menu',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 293.0,
      rtlX: 293.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.022,
      p90Ms: 0.032,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 13, passed: true),
  ),
  'country_flag': DocsScorecard(
    componentId: 'country_flag',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.023,
      p90Ms: 0.044,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 13, passed: true),
  ),
  'date_picker': DocsScorecard(
    componentId: 'date_picker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.023,
      p90Ms: 0.033,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 19, passed: true),
  ),
  'dialog': DocsScorecard(
    componentId: 'dialog',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 323.0,
      rtlX: 323.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.038,
      p90Ms: 0.077,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 15, passed: true),
  ),
  'divider': DocsScorecard(
    componentId: 'divider',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(
        present: false,
        message: 'no semantic label, value, hint or tooltip found',
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
      p50Ms: 0.043,
      p90Ms: 0.079,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 18, passed: true),
  ),
  'dot_indicator': DocsScorecard(
    componentId: 'dot_indicator',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,24.0]; [0.0,3.0,0.0,24.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isSelected, isFocusable, hasSelectedState], label: "Page 1 of 5", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(20.0, 20.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,84.0]; [0.0,3.0,0.0,24.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 2 of 5", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(20.0, 20.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,144.0]; [0.0,3.0,0.0,24.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 3 of 5", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(20.0, 20.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,204.0]; [0.0,3.0,0.0,24.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 4 of 5", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(20.0, 20.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,264.0]; [0.0,3.0,0.0,24.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 5 of 5", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(20.0, 20.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n\n\n\n\n\n\n',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,24.0]; [0.0,3.0,0.0,24.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isSelected, isFocusable, hasSelectedState], label: "Page 1 of 5", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(20.0, 20.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,84.0]; [0.0,3.0,0.0,24.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 2 of 5", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(20.0, 20.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,144.0]; [0.0,3.0,0.0,24.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 3 of 5", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(20.0, 20.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,204.0]; [0.0,3.0,0.0,24.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 4 of 5", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(20.0, 20.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,264.0]; [0.0,3.0,0.0,24.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 5 of 5", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(20.0, 20.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n\n\n\n\n\n\n',
      ),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 0.0,
      rtlX: 716.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.022,
      p90Ms: 0.049,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 18, passed: true),
  ),
  'drawer': DocsScorecard(
    componentId: 'drawer',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 12.0,
      rtlX: 662.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.02,
      p90Ms: 0.037,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 19, passed: true),
  ),
  'dropdown_menu': DocsScorecard(
    componentId: 'dropdown_menu',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.021,
      p90Ms: 0.028,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 10, passed: true),
  ),
  'dropzone': DocsScorecard(
    componentId: 'dropzone',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.02,
      p90Ms: 0.036,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 30, passed: true),
  ),
  'empty_state': DocsScorecard(
    componentId: 'empty_state',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.028,
      p90Ms: 0.042,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 31, passed: true),
  ),
  'feature_carousel': DocsScorecard(
    componentId: 'feature_carousel',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.02,
      p90Ms: 0.04,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 19, passed: true),
  ),
  'file_diff_viewer': DocsScorecard(
    componentId: 'file_diff_viewer',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.031,
      p90Ms: 0.058,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 9, passed: true),
  ),
  'file_picker': DocsScorecard(
    componentId: 'file_picker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#7(Rect.fromLTRB(0.0, 0.0, 28.0, 28.0) with transform [[3.0,0.0,0.0,2280.0]; [0.0,3.0,0.0,630.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "Remove file", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(28.0, 28.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n\n\nSemanticsNode#10(Rect.fromLTRB(0.0, 0.0, 28.0, 28.0) with transform [[3.0,0.0,0.0,2280.0]; [0.0,3.0,0.0,858.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "Remove file", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(28.0, 28.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#7(Rect.fromLTRB(0.0, 0.0, 28.0, 28.0) with transform [[3.0,0.0,0.0,2280.0]; [0.0,3.0,0.0,630.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "Remove file", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(28.0, 28.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n\n\nSemanticsNode#10(Rect.fromLTRB(0.0, 0.0, 28.0, 28.0) with transform [[3.0,0.0,0.0,2280.0]; [0.0,3.0,0.0,858.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "Remove file", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(28.0, 28.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/',
      ),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.032,
      p90Ms: 0.051,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 23, passed: true),
  ),
  'filter_bar': DocsScorecard(
    componentId: 'filter_bar',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 180.0, 36.0) with transform [[3.0,0.0,0.0,732.0]; [0.0,3.0,0.0,36.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "Sort", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(180.0, 36.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 180.0, 36.0) with transform [[3.0,0.0,0.0,732.0]; [0.0,3.0,0.0,36.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "Sort", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(180.0, 36.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n',
      ),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 53.0,
      rtlX: 663.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.02,
      p90Ms: 0.025,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 18, passed: true),
  ),
  'form': DocsScorecard(
    componentId: 'form',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.021,
      p90Ms: 0.037,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 10, passed: true),
  ),
  'formatted_input': DocsScorecard(
    componentId: 'formatted_input',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.02,
      p90Ms: 0.07,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 39, passed: true),
  ),
  'gooey_toast': DocsScorecard(
    componentId: 'gooey_toast',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 68.0,
      rtlX: 634.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.019,
      p90Ms: 0.027,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 21, passed: true),
  ),
  'hover_card': DocsScorecard(
    componentId: 'hover_card',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.019,
      p90Ms: 0.024,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 10, passed: true),
  ),
  'image': DocsScorecard(
    componentId: 'image',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.025,
      p90Ms: 0.047,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 13, passed: true),
  ),
  'input': DocsScorecard(
    componentId: 'input',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.023,
      p90Ms: 0.034,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 81, passed: true),
  ),
  'input_otp': DocsScorecard(
    componentId: 'input_otp',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.04,
      p90Ms: 0.082,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 55, passed: true),
  ),
  'item_picker': DocsScorecard(
    componentId: 'item_picker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.019,
      p90Ms: 0.023,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 13, passed: true),
  ),
  'keyboard_shortcut': DocsScorecard(
    componentId: 'keyboard_shortcut',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 6.0,
      rtlX: 782.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.019,
      p90Ms: 0.029,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 27, passed: true),
  ),
  'markdown': DocsScorecard(
    componentId: 'markdown',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.023,
      p90Ms: 0.049,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 31, passed: true),
  ),
  'menu': DocsScorecard(
    componentId: 'menu',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 230.0, 169.0), actions: [focus], flags: [isFocusable], label: "Delete", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 3.79 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.5137, green: 0.5137, blue: 0.5137, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n',
      ),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.02,
      p90Ms: 0.036,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 38, passed: true),
  ),
  'menubar': DocsScorecard(
    componentId: 'menubar',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 96.0, 32.0), actions: [focus, tap], flags: [isFocusable], label: "File", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(96.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#3(Rect.fromLTRB(96.0, 0.0, 192.0, 32.0), actions: [focus, tap], flags: [isFocusable], label: "Edit", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(96.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#4(Rect.fromLTRB(192.0, 0.0, 288.0, 32.0), actions: [focus, tap], flags: [isFocusable], label: "View", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(96.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 96.0, 32.0), actions: [focus, tap], flags: [isFocusable], label: "File", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(96.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#3(Rect.fromLTRB(96.0, 0.0, 192.0, 32.0), actions: [focus, tap], flags: [isFocusable], label: "Edit", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(96.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#4(Rect.fromLTRB(192.0, 0.0, 288.0, 32.0), actions: [focus, tap], flags: [isFocusable], label: "View", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(96.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n',
      ),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.019,
      p90Ms: 0.025,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 13, passed: true),
  ),
  'multi_select': DocsScorecard(
    componentId: 'multi_select',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(88.0, 294.0, 100.0, 306.0), actions: [focus, tap], flags: [isFocusable], label: "Delete", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(12.0, 12.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(88.0, 294.0, 100.0, 306.0), actions: [focus, tap], flags: [isFocusable], label: "Delete", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(12.0, 12.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/',
      ),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.022,
      p90Ms: 0.035,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 9, passed: true),
  ),
  'navigation_bar': DocsScorecard(
    componentId: 'navigation_bar',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.023,
      p90Ms: 0.035,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 18, passed: true),
  ),
  'navigation_menu': DocsScorecard(
    componentId: 'navigation_menu',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 16.0,
      rtlX: 728.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.02,
      p90Ms: 0.031,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 12, passed: true),
  ),
  'number_ticker': DocsScorecard(
    componentId: 'number_ticker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.029,
      p90Ms: 0.039,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 10, passed: true),
  ),
  'object_input': DocsScorecard(
    componentId: 'object_input',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#5(Rect.fromLTRB(163.0, 292.0, 179.0, 308.0), actions: [focus, tap], flags: [isFocusable], label: "Pick a date", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(16.0, 16.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#5(Rect.fromLTRB(163.0, 292.0, 179.0, 308.0), actions: [focus, tap], flags: [isFocusable], label: "Pick a date", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(16.0, 16.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/',
      ),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.019,
      p90Ms: 0.034,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 19, passed: true),
  ),
  'overflow_marquee': DocsScorecard(
    componentId: 'overflow_marquee',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 8.0,
      rtlX: -711.6666666666666,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.883,
      p90Ms: 1.717,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 10, passed: true),
  ),
  'pagination': DocsScorecard(
    componentId: 'pagination',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.022,
      p90Ms: 0.029,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 14, passed: true),
  ),
  'phone_input': DocsScorecard(
    componentId: 'phone_input',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 136.0, 36.0) with transform [[3.0,0.0,0.0,3.0]; [0.0,3.0,0.0,846.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "Indonesia\\n+62", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(136.0, 36.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 136.0, 36.0) with transform [[3.0,0.0,0.0,3.0]; [0.0,3.0,0.0,846.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "Indonesia\\n+62", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(136.0, 36.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n',
      ),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.032,
      p90Ms: 0.06,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 21, passed: true),
  ),
  'pinned_sheet': DocsScorecard(
    componentId: 'pinned_sheet',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.018,
      p90Ms: 0.033,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 13, passed: true),
  ),
  'popup': DocsScorecard(
    componentId: 'popup',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.019,
      p90Ms: 0.087,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 8, passed: true),
  ),
  'progress': DocsScorecard(
    componentId: 'progress',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.018,
      p90Ms: 0.034,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 11, passed: true),
  ),
  'radio_group': DocsScorecard(
    componentId: 'radio_group',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.018,
      p90Ms: 0.03,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 33, passed: true),
  ),
  'refresh_trigger': DocsScorecard(
    componentId: 'refresh_trigger',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 800.0, 26.0), tags: [RenderViewport.twoPane], label: "Row 1", textDirection: ltr, indexInParent: 0):\nExpected contrast ratio of at least 4.5 but found 1.41 for a font size of null.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.8510, green: 0.8510, blue: 0.8510, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\n\n\n\n\n',
      ),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.018,
      p90Ms: 0.026,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 11, passed: true),
  ),
  'resizable': DocsScorecard(
    componentId: 'resizable',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.024,
      p90Ms: 0.034,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 11, passed: true),
  ),
  'scaffold': DocsScorecard(
    componentId: 'scaffold',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 36.0, 48.0) with transform [[3.0,0.0,0.0,54.0]; [0.0,3.0,0.0,36.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Back", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(36.0, 48.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n\n\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 36.0, 48.0) with transform [[3.0,0.0,0.0,2238.0]; [0.0,3.0,0.0,36.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "More", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(36.0, 48.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n\n\n\n',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 36.0, 48.0) with transform [[3.0,0.0,0.0,54.0]; [0.0,3.0,0.0,36.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Back", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(36.0, 48.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n\n\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 36.0, 48.0) with transform [[3.0,0.0,0.0,2238.0]; [0.0,3.0,0.0,36.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "More", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(36.0, 48.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n\n\n\n',
      ),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: null,
      message: 'symmetric layout (no directional shift)',
      ltrX: 72.0,
      rtlX: 72.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.018,
      p90Ms: 0.033,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 12, passed: true),
  ),
  'scrollbar': DocsScorecard(
    componentId: 'scrollbar',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.018,
      p90Ms: 0.026,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 10, passed: true),
  ),
  'select': DocsScorecard(
    componentId: 'select',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.019,
      p90Ms: 0.041,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 22, passed: true),
  ),
  'skeleton': DocsScorecard(
    componentId: 'skeleton',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.628,
      p90Ms: 0.741,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 18, passed: true),
  ),
  'slider': DocsScorecard(
    componentId: 'slider',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.018,
      p90Ms: 0.026,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 20, passed: true),
  ),
  'sortable': DocsScorecard(
    componentId: 'sortable',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.028,
      p90Ms: 0.039,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 7, passed: true),
  ),
  'spinner': DocsScorecard(
    componentId: 'spinner',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.898,
      p90Ms: 1.355,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 9, passed: true),
  ),
  'star_rating': DocsScorecard(
    componentId: 'star_rating',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.018,
      p90Ms: 0.022,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 12, passed: true),
  ),
  'stepper': DocsScorecard(
    componentId: 'stepper',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.033,
      p90Ms: 0.056,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 18, passed: true),
  ),
  'steps': DocsScorecard(
    componentId: 'steps',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.033,
      p90Ms: 0.066,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 7, passed: true),
  ),
  'swipe_actions': DocsScorecard(
    componentId: 'swipe_actions',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 652.0,
      rtlX: 96.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.017,
      p90Ms: 0.02,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 9, passed: true),
  ),
  'switch': DocsScorecard(
    componentId: 'switch',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.018,
      p90Ms: 0.041,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 27, passed: true),
  ),
  'table': DocsScorecard(
    componentId: 'table',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#7(Rect.fromLTRB(0.0, 0.0, 236.7, 44.0) with transform [[3.0,0.0,0.0,1420.0]; [0.0,3.0,0.0,474.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "Writer", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(236.7, 44.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#8(Rect.fromLTRB(0.0, 0.0, 236.7, 30.0) with transform [[3.0,0.0,0.0,1420.0]; [0.0,3.0,0.0,384.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "PM", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(236.7, 30.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#9(Rect.fromLTRB(0.0, 0.0, 236.7, 44.0) with transform [[3.0,0.0,0.0,1420.0]; [0.0,3.0,0.0,252.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "Engineer", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(236.7, 44.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#10(Rect.fromLTRB(0.0, 0.0, 236.7, 44.0) with transform [[3.0,0.0,0.0,1420.0]; [0.0,3.0,0.0,120.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "Designer", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(236.7, 44.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n\n\n\n\n\n\n\n',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#8(Rect.fromLTRB(0.0, 0.0, 236.7, 30.0) with transform [[3.0,0.0,0.0,1420.0]; [0.0,3.0,0.0,384.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "PM", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(236.7, 30.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n\n\n\n\n\n\n\n\n\n',
      ),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 8.0,
      rtlX: 334.6666666666667,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.018,
      p90Ms: 0.028,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 22, passed: true),
  ),
  'tabs': DocsScorecard(
    componentId: 'tabs',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.018,
      p90Ms: 0.03,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 14, passed: true),
  ),
  'text_animate': DocsScorecard(
    componentId: 'text_animate',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.018,
      p90Ms: 0.027,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 29, passed: true),
  ),
  'text_area': DocsScorecard(
    componentId: 'text_area',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.018,
      p90Ms: 0.026,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 33, passed: true),
  ),
  'time_picker': DocsScorecard(
    componentId: 'time_picker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 37.0,
      rtlX: 693.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.018,
      p90Ms: 0.027,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 22, passed: true),
  ),
  'timeline': DocsScorecard(
    componentId: 'timeline',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.018,
      p90Ms: 0.023,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 24, passed: true),
  ),
  'toast': DocsScorecard(
    componentId: 'toast',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.018,
      p90Ms: 0.027,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 14, passed: true),
  ),
  'toggle': DocsScorecard(
    componentId: 'toggle',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
    ),
    rtl: DocsScorecardRtl(
      passed: true,
      renders: true,
      mirrored: true,
      message: null,
      ltrX: 8.0,
      rtlX: 750.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.024,
      p90Ms: 0.055,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 11, passed: true),
  ),
  'tooltip': DocsScorecard(
    componentId: 'tooltip',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.031,
      p90Ms: 0.055,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 16, passed: true),
  ),
  'tracker': DocsScorecard(
    componentId: 'tracker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.02,
      p90Ms: 0.035,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 15, passed: true),
  ),
  'tree': DocsScorecard(
    componentId: 'tree',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(passed: true, message: null),
      iOSTapTarget: DocsScorecardCheck(passed: true, message: null),
      semantics: DocsScorecardSemantics(present: true, message: null),
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
      p50Ms: 0.017,
      p90Ms: 0.023,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 40, passed: true),
  ),
};

/// Generator timestamp (UTC ISO) for the card footer.
const String kScorecardsGeneratedAt = '2026-10-12T23:26:22.637024Z';

/// Full commit hash at generation time.
const String kScorecardsCommit = '75fc4980c3e6c72c17deed50f4fa2a47eab2ad42';

/// Short commit hash (7 chars) for the card footer.
const String kScorecardsCommitShort = '75fc498';

/// Flutter/Dart version at generation time.
const String kScorecardsFlutter = '3.47.7 / Dart 3.13.5';
