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

/// All 83 measured components, keyed by id (sorted).
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
      p50Ms: 0.069,
      p90Ms: 0.112,
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
      p50Ms: 0.067,
      p90Ms: 0.118,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 32, passed: true),
  ),
  'alert_dialog': DocsScorecard(
    componentId: 'alert_dialog',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 164.0, 32.0) with transform [[3.0,0.0,0.0,954.0]; [0.0,3.0,0.0,1066.5]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Show again", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
      ),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 108.0, 32.0) with transform [[3.0,0.0,0.0,574.5]; [0.0,3.0,0.0,930.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Cancel", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(108.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 108.0, 32.0) with transform [[3.0,0.0,0.0,922.5]; [0.0,3.0,0.0,930.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Delete", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(108.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 164.0, 32.0) with transform [[3.0,0.0,0.0,954.0]; [0.0,3.0,0.0,1066.5]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Show again", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(164.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 108.0, 32.0) with transform [[3.0,0.0,0.0,574.5]; [0.0,3.0,0.0,930.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Cancel", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(108.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 108.0, 32.0) with transform [[3.0,0.0,0.0,922.5]; [0.0,3.0,0.0,930.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Delete", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(108.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 164.0, 32.0) with transform [[3.0,0.0,0.0,954.0]; [0.0,3.0,0.0,1066.5]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Show again", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(164.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/',
      ),
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
      p50Ms: 0.078,
      p90Ms: 0.132,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 17, passed: true),
  ),
  'autocomplete': DocsScorecard(
    componentId: 'autocomplete',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 192.0, 12.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,144.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Last selected: -", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      rtlX: 339.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.052,
      p90Ms: 0.103,
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
      p50Ms: 0.049,
      p90Ms: 0.094,
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
      p50Ms: 0.051,
      p90Ms: 0.099,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 25, passed: true),
  ),
  'border_loading': DocsScorecard(
    componentId: 'border_loading',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 228.0, 12.0) with transform [[3.0,0.0,0.0,858.0]; [0.0,3.0,0.0,972.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Indeterminate sweep", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      ltrX: 286.0,
      rtlX: 286.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 1.179,
      p90Ms: 1.723,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 12, passed: true),
  ),
  'breadcrumb': DocsScorecard(
    componentId: 'breadcrumb',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 56.0, 14.0), actions: [focus, tap], flags: [isFocusable], label: "Home", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#3(Rect.fromLTRB(80.0, 0.0, 220.0, 14.0), actions: [focus, tap], flags: [isFocusable], label: "Components", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#4(Rect.fromLTRB(244.0, 0.0, 384.0, 14.0), label: "Breadcrumb", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 288.0, 12.0) with transform [[3.0,0.0,0.0,768.0]; [0.0,3.0,0.0,66.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Current page: Breadcrumb", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      ltrX: 208.0,
      rtlX: 536.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.062,
      p90Ms: 0.111,
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
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 116.0, 36.0) with transform [[3.0,0.0,0.0,1026.0]; [0.0,3.0,0.0,846.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Button", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(116.0, 36.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 116.0, 36.0) with transform [[3.0,0.0,0.0,1026.0]; [0.0,3.0,0.0,846.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Button", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(116.0, 36.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/',
      ),
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
      p50Ms: 0.057,
      p90Ms: 0.106,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 11, passed: true),
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
      p50Ms: 0.063,
      p90Ms: 0.134,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 77, passed: true),
  ),
  'card': DocsScorecard(
    componentId: 'card',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 272.0, 56.0) with transform [[3.0,0.0,0.0,792.0]; [0.0,3.0,0.0,252.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Every deploy is immutable; roll back from the history tab.", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.00 for a font size of null.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\n\nSemanticsNode#6(Rect.fromLTRB(0.0, 0.0, 180.0, 12.0) with transform [[3.0,0.0,0.0,930.0]; [0.0,3.0,0.0,672.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Ready to deploy", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
      ),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 108.0, 32.0) with transform [[3.0,0.0,0.0,936.0]; [0.0,3.0,0.0,468.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Cancel", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(108.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 108.0, 32.0) with transform [[3.0,0.0,0.0,1284.0]; [0.0,3.0,0.0,468.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Deploy", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(108.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 108.0, 32.0) with transform [[3.0,0.0,0.0,936.0]; [0.0,3.0,0.0,468.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Cancel", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(108.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 108.0, 32.0) with transform [[3.0,0.0,0.0,1284.0]; [0.0,3.0,0.0,468.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Deploy", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(108.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n',
      ),
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
      p50Ms: 0.034,
      p90Ms: 0.071,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 36, passed: true),
  ),
  'card_image': DocsScorecard(
    componentId: 'card_image',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 276.0, 12.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,510.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Tap the card to open it", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      ltrX: 26.0,
      rtlX: 690.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.037,
      p90Ms: 0.067,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 18, passed: true),
  ),
  'carousel': DocsScorecard(
    componentId: 'carousel',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 36.0, 36.0) with transform [[3.0,0.0,0.0,480.0]; [0.0,3.0,0.0,186.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable]): expected tappable node to have semantic label, but none was found.\nSemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 392.0, 160.0) with transform [[3.0,0.0,0.0,612.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable]): expected tappable node to have semantic label, but none was found.\nSemanticsNode#8(Rect.fromLTRB(0.0, 0.0, 36.0, 36.0) with transform [[3.0,0.0,0.0,1812.0]; [0.0,3.0,0.0,186.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable]): expected tappable node to have semantic label, but none was found.\n\n\n\n\n',
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 36.0, 36.0) with transform [[3.0,0.0,0.0,480.0]; [0.0,3.0,0.0,186.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable]): expected tap target size of at least Size(48.0, 48.0), but found Size(36.0, 36.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n\nSemanticsNode#8(Rect.fromLTRB(0.0, 0.0, 36.0, 36.0) with transform [[3.0,0.0,0.0,1812.0]; [0.0,3.0,0.0,186.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable]): expected tap target size of at least Size(48.0, 48.0), but found Size(36.0, 36.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#9(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1050.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isSelected, isFocusable, hasSelectedState], label: "Page 1 of 5", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(20.0, 20.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#10(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1110.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 2 of 5", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(20.0, 20.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#11(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1170.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 3 of 5", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(20.0, 20.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#12(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1230.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 4 of 5", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(20.0, 20.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#13(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1290.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 5 of 5", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(20.0, 20.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 36.0, 36.0) with transform [[3.0,0.0,0.0,480.0]; [0.0,3.0,0.0,186.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable]): expected tap target size of at least Size(44.0, 44.0), but found Size(36.0, 36.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n\nSemanticsNode#8(Rect.fromLTRB(0.0, 0.0, 36.0, 36.0) with transform [[3.0,0.0,0.0,1812.0]; [0.0,3.0,0.0,186.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable]): expected tap target size of at least Size(44.0, 44.0), but found Size(36.0, 36.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#9(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1050.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isSelected, isFocusable, hasSelectedState], label: "Page 1 of 5", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(20.0, 20.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#10(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1110.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 2 of 5", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(20.0, 20.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#11(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1170.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 3 of 5", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(20.0, 20.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#12(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1230.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 4 of 5", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(20.0, 20.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#13(Rect.fromLTRB(0.0, 0.0, 20.0, 20.0) with transform [[3.0,0.0,0.0,1290.0]; [0.0,3.0,0.0,528.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable, hasSelectedState], label: "Page 5 of 5", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(20.0, 20.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/',
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
      p50Ms: 0.05,
      p90Ms: 0.096,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 38, passed: true),
  ),
  'chat': DocsScorecard(
    componentId: 'chat',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 24.0, 12.0) with transform [[3.0,0.0,0.0,1956.0]; [0.0,3.0,0.0,612.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "AI", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.35 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.9608, green: 0.9608, blue: 0.9608, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 24.0, 12.0) with transform [[3.0,0.0,0.0,372.0]; [0.0,3.0,0.0,996.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "JO", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.35 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.9608, green: 0.9608, blue: 0.9608, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\n',
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
      ltrX: 392.0,
      rtlX: 172.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.052,
      p90Ms: 0.089,
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
      p50Ms: 0.049,
      p90Ms: 0.095,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 39, passed: true),
  ),
  'chip': DocsScorecard(
    componentId: 'chip',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#10(Rect.fromLTRB(0.0, 0.0, 612.0, 12.0) with transform [[3.0,0.0,0.0,282.0]; [0.0,3.0,0.0,138.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Tip: focus a chip and press Backspace to remove it.", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(172.0, 4.0, 184.0, 16.0), actions: [focus, tap], flags: [isFocusable]): expected tappable node to have semantic label, but none was found.\nSemanticsNode#4(Rect.fromLTRB(100.0, 4.0, 112.0, 16.0), actions: [focus, tap], flags: [isFocusable]): expected tappable node to have semantic label, but none was found.\nSemanticsNode#6(Rect.fromLTRB(172.0, 4.0, 184.0, 16.0), actions: [focus, tap], flags: [isFocusable]): expected tappable node to have semantic label, but none was found.\nSemanticsNode#8(Rect.fromLTRB(124.0, 4.0, 136.0, 16.0), actions: [focus, tap], flags: [isFocusable]): expected tappable node to have semantic label, but none was found.\n\n',
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(172.0, 4.0, 184.0, 16.0), actions: [focus, tap], flags: [isFocusable]): expected tap target size of at least Size(48.0, 48.0), but found Size(12.0, 12.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#4(Rect.fromLTRB(100.0, 4.0, 112.0, 16.0), actions: [focus, tap], flags: [isFocusable]): expected tap target size of at least Size(48.0, 48.0), but found Size(12.0, 12.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#6(Rect.fromLTRB(172.0, 4.0, 184.0, 16.0), actions: [focus, tap], flags: [isFocusable]): expected tap target size of at least Size(48.0, 48.0), but found Size(12.0, 12.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#8(Rect.fromLTRB(124.0, 4.0, 136.0, 16.0), actions: [focus, tap], flags: [isFocusable]): expected tap target size of at least Size(48.0, 48.0), but found Size(12.0, 12.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n\n',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(172.0, 4.0, 184.0, 16.0), actions: [focus, tap], flags: [isFocusable]): expected tap target size of at least Size(44.0, 44.0), but found Size(12.0, 12.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#4(Rect.fromLTRB(100.0, 4.0, 112.0, 16.0), actions: [focus, tap], flags: [isFocusable]): expected tap target size of at least Size(44.0, 44.0), but found Size(12.0, 12.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#6(Rect.fromLTRB(172.0, 4.0, 184.0, 16.0), actions: [focus, tap], flags: [isFocusable]): expected tap target size of at least Size(44.0, 44.0), but found Size(12.0, 12.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#8(Rect.fromLTRB(124.0, 4.0, 136.0, 16.0), actions: [focus, tap], flags: [isFocusable]): expected tap target size of at least Size(44.0, 44.0), but found Size(12.0, 12.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n\n',
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
      p50Ms: 0.049,
      p90Ms: 0.105,
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
      p50Ms: 0.049,
      p90Ms: 0.096,
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
      p50Ms: 0.045,
      p90Ms: 0.083,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 9, passed: true),
  ),
  'collapsible': DocsScorecard(
    componentId: 'collapsible',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#3(Rect.fromLTRB(748.0, 0.0, 784.0, 36.0), actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable]): expected tappable node to have semantic label, but none was found.\n',
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(16.0, 11.0, 732.0, 25.0), actions: [focus, tap], flags: [isFocusable], label: "Recent activity", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(716.0, 14.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n\n',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(16.0, 11.0, 732.0, 25.0), actions: [focus, tap], flags: [isFocusable], label: "Recent activity", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(716.0, 14.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n\n',
      ),
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
      p50Ms: 0.048,
      p90Ms: 0.086,
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
      p50Ms: 0.024,
      p90Ms: 0.042,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 22, passed: true),
  ),
  'command': DocsScorecard(
    componentId: 'command',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 320.0, 24.0) with transform [[3.0,0.0,0.0,720.0]; [0.0,3.0,0.0,1326.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Run a command to see it here", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
      ),
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
      p50Ms: 0.027,
      p90Ms: 0.062,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 11, passed: true),
  ),
  'context_menu': DocsScorecard(
    componentId: 'context_menu',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 220.0, 48.0) with transform [[3.0,0.0,0.0,870.0]; [0.0,3.0,0.0,792.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [longPress, tap], label: "Right-click anywhere on this card", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of null.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 336.0, 12.0) with transform [[3.0,0.0,0.0,696.0]; [0.0,3.0,0.0,972.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Pick an action from the menu", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      ltrX: 293.0,
      rtlX: 293.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.028,
      p90Ms: 0.043,
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
      p50Ms: 0.024,
      p90Ms: 0.036,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 13, passed: true),
  ),
  'date_picker': DocsScorecard(
    componentId: 'date_picker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 156.0, 12.0) scaled by 3.0x, label: "Empty trigger", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 240.0, 36.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,60.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "Pick a date", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.02 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 168.0, 12.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,216.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Filled trigger", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 246.0, 36.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,276.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "March 14, 2024", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      ltrX: 0.0,
      rtlX: 644.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.025,
      p90Ms: 0.05,
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
      p50Ms: 0.023,
      p90Ms: 0.047,
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
      p50Ms: 0.024,
      p90Ms: 0.046,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 18, passed: true),
  ),
  'dot_indicator': DocsScorecard(
    componentId: 'dot_indicator',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#6(Rect.fromLTRB(0.0, 0.0, 84.0, 12.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,144.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "index 0", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\n\n\n\n\nSemanticsNode#12(Rect.fromLTRB(0.0, 0.0, 504.0, 12.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,324.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "read-only (no click cursor, no tap target)", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
      ),
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
      p50Ms: 0.023,
      p90Ms: 0.034,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 18, passed: true),
  ),
  'drawer': DocsScorecard(
    componentId: 'drawer',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 150.0, 32.0) scaled by 3.0x, actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Open left", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 164.0, 32.0) with transform [[3.0,0.0,0.0,474.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Open right", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 136.0, 32.0) with transform [[3.0,0.0,0.0,990.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Open top", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 178.0, 32.0) with transform [[3.0,0.0,0.0,1422.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Open bottom", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      ltrX: 12.0,
      rtlX: 662.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.021,
      p90Ms: 0.037,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 19, passed: true),
  ),
  'dropdown_menu': DocsScorecard(
    componentId: 'dropdown_menu',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#6(Rect.fromLTRB(0.0, 0.0, 120.0, 12.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,381.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Pick a row", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      ltrX: 303.0,
      rtlX: 399.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.037,
      p90Ms: 0.072,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 10, passed: true),
  ),
  'dropzone': DocsScorecard(
    componentId: 'dropzone',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#3(Rect.fromLTRB(300.0, 123.0, 500.0, 159.0), actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Browse files", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 80.0, 32.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,588.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "idle", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 150.0, 32.0) with transform [[3.0,0.0,0.0,264.0]; [0.0,3.0,0.0,588.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "uploading", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#6(Rect.fromLTRB(0.0, 0.0, 122.0, 32.0) with transform [[3.0,0.0,0.0,738.0]; [0.0,3.0,0.0,588.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "success", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#7(Rect.fromLTRB(0.0, 0.0, 94.0, 32.0) with transform [[3.0,0.0,0.0,1128.0]; [0.0,3.0,0.0,588.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "error", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
      ),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#3(Rect.fromLTRB(300.0, 123.0, 500.0, 159.0), actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Browse files", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(200.0, 36.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n\nSemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 150.0, 32.0) with transform [[3.0,0.0,0.0,264.0]; [0.0,3.0,0.0,588.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "uploading", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(150.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#6(Rect.fromLTRB(0.0, 0.0, 122.0, 32.0) with transform [[3.0,0.0,0.0,738.0]; [0.0,3.0,0.0,588.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "success", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(122.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#7(Rect.fromLTRB(0.0, 0.0, 94.0, 32.0) with transform [[3.0,0.0,0.0,1128.0]; [0.0,3.0,0.0,588.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "error", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(94.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#3(Rect.fromLTRB(300.0, 123.0, 500.0, 159.0), actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Browse files", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(200.0, 36.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n\nSemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 150.0, 32.0) with transform [[3.0,0.0,0.0,264.0]; [0.0,3.0,0.0,588.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "uploading", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(150.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#6(Rect.fromLTRB(0.0, 0.0, 122.0, 32.0) with transform [[3.0,0.0,0.0,738.0]; [0.0,3.0,0.0,588.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "success", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(122.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#7(Rect.fromLTRB(0.0, 0.0, 94.0, 32.0) with transform [[3.0,0.0,0.0,1128.0]; [0.0,3.0,0.0,588.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "error", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(94.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/',
      ),
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
      p50Ms: 0.021,
      p90Ms: 0.033,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 30, passed: true),
  ),
  'empty_state': DocsScorecard(
    componentId: 'empty_state',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 384.0, 24.0) with transform [[3.0,0.0,0.0,624.0]; [0.0,3.0,0.0,348.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "No results found", textDirection: ltr):\nExpected contrast ratio of at least 3.0 but found 1.06 for a font size of 24.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 456.0, 38.0) with transform [[3.0,0.0,0.0,516.0]; [0.0,3.0,0.0,456.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Try adjusting your filters or search terms.", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 800.0, 12.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,882.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "No results for "rocket".", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
      ),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 214.0, 36.0) with transform [[3.0,0.0,0.0,879.0]; [0.0,3.0,0.0,642.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Clear filters", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(214.0, 36.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 214.0, 36.0) with transform [[3.0,0.0,0.0,879.0]; [0.0,3.0,0.0,642.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Clear filters", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(214.0, 36.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n',
      ),
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
      p50Ms: 0.022,
      p90Ms: 0.035,
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
      p50Ms: 0.021,
      p90Ms: 0.038,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 19, passed: true),
  ),
  'file_diff_viewer': DocsScorecard(
    componentId: 'file_diff_viewer',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#3(Rect.fromLTRB(419.0, 13.1, 443.0, 30.1), label: "+1", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.87 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.8275, green: 0.9098, blue: 0.9020, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0000, green: 0.5882, blue: 0.5373, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#4(Rect.fromLTRB(467.0, 13.1, 491.0, 30.1), label: "-1", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 3.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.9529, green: 0.8275, blue: 0.8314, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.9059, green: 0.0000, blue: 0.0431, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#5(Rect.fromLTRB(507.0, 13.1, 603.0, 30.1), label: "modified", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.35 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.9608, green: 0.9608, blue: 0.9608, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\nSemanticsNode#13(Rect.fromLTRB(12.0, 63.0, 47.0, 80.0), label: "11", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 3.74 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.9765, green: 0.8706, blue: 0.8745, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\n\nSemanticsNode#15(Rect.fromLTRB(118.0, 57.4, 130.0, 74.4), label: "-", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 3.44 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.9843, green: 0.8196, blue: 0.8275, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.9059, green: 0.0000, blue: 0.0431, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\n\nSemanticsNode#18(Rect.fromLTRB(64.0, 93.2, 99.0, 110.2), label: "11", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 3.99 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.8706, green: 0.9373, blue: 0.9333, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#19(Rect.fromLTRB(118.0, 87.6, 130.0, 104.6), label: "+", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.95 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.8196, green: 0.9255, blue: 0.9176, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0000, green: 0.5882, blue: 0.5373, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\n\n\n\n\n',
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
      ltrX: 33.0,
      rtlX: 501.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.023,
      p90Ms: 0.045,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 9, passed: true),
  ),
  'file_picker': DocsScorecard(
    componentId: 'file_picker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#4(Rect.fromLTRB(300.0, 107.0, 500.0, 143.0), actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Browse files", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 800.0, 168.0), flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Uploading files...", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 126.0, 14.0) with transform [[3.0,0.0,0.0,192.0]; [0.0,3.0,0.0,594.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "notes.txt", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.18 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#6(Rect.fromLTRB(0.0, 0.0, 252.0, 12.0) with transform [[3.0,0.0,0.0,192.0]; [0.0,3.0,0.0,642.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "TXT · 1.1 KB · Queued", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\nSemanticsNode#8(Rect.fromLTRB(0.0, 0.0, 140.0, 14.0) with transform [[3.0,0.0,0.0,192.0]; [0.0,3.0,0.0,822.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "design.pdf", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.18 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#9(Rect.fromLTRB(0.0, 0.0, 312.0, 12.0) with transform [[3.0,0.0,0.0,192.0]; [0.0,3.0,0.0,870.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "PDF · 822.2 KB · Uploading", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n',
      ),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#4(Rect.fromLTRB(300.0, 107.0, 500.0, 143.0), actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Browse files", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(200.0, 36.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n\n\nSemanticsNode#7(Rect.fromLTRB(0.0, 0.0, 28.0, 28.0) with transform [[3.0,0.0,0.0,2280.0]; [0.0,3.0,0.0,594.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "Remove file", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(28.0, 28.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n\n\nSemanticsNode#10(Rect.fromLTRB(0.0, 0.0, 28.0, 28.0) with transform [[3.0,0.0,0.0,2280.0]; [0.0,3.0,0.0,822.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "Remove file", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(28.0, 28.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#4(Rect.fromLTRB(300.0, 107.0, 500.0, 143.0), actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Browse files", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(200.0, 36.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n\n\nSemanticsNode#7(Rect.fromLTRB(0.0, 0.0, 28.0, 28.0) with transform [[3.0,0.0,0.0,2280.0]; [0.0,3.0,0.0,594.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "Remove file", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(28.0, 28.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n\n\nSemanticsNode#10(Rect.fromLTRB(0.0, 0.0, 28.0, 28.0) with transform [[3.0,0.0,0.0,2280.0]; [0.0,3.0,0.0,822.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "Remove file", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(28.0, 28.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/',
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
      p50Ms: 0.021,
      p90Ms: 0.036,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 23, passed: true),
  ),
  'filter_bar': DocsScorecard(
    componentId: 'filter_bar',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 180.0, 36.0) with transform [[3.0,0.0,0.0,732.0]; [0.0,3.0,0.0,36.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable], label: "Sort", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 140.0, 14.0) with transform [[3.0,0.0,0.0,1308.0]; [0.0,3.0,0.0,69.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "42 results", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
      ),
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
      p50Ms: 0.023,
      p90Ms: 0.039,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 18, passed: true),
  ),
  'form': DocsScorecard(
    componentId: 'form',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 800.0, 14.0) scaled by 3.0x, label: "Email", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.40 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.9059, green: 0.0000, blue: 0.0431, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\nSemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 252.0, 14.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,192.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "We never share it.", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 378.0, 14.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,252.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "This field cannot be empty.", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.40 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.9059, green: 0.0000, blue: 0.0431, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\n',
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
      p50Ms: 0.025,
      p90Ms: 0.046,
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
      p50Ms: 0.025,
      p90Ms: 0.066,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 39, passed: true),
  ),
  'gooey_toast': DocsScorecard(
    componentId: 'gooey_toast',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 122.0, 32.0) with transform [[3.0,0.0,0.0,168.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "success", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 122.0, 32.0) with transform [[3.0,0.0,0.0,558.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "loading", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 94.0, 32.0) with transform [[3.0,0.0,0.0,948.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "error", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 122.0, 32.0) with transform [[3.0,0.0,0.0,1254.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "warning", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 80.0, 32.0) with transform [[3.0,0.0,0.0,1644.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "info", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#6(Rect.fromLTRB(0.0, 0.0, 108.0, 32.0) with transform [[3.0,0.0,0.0,1908.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "action", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      ltrX: 68.0,
      rtlX: 634.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.02,
      p90Ms: 0.051,
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
      p50Ms: 0.031,
      p90Ms: 0.045,
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
      p50Ms: 0.04,
      p90Ms: 0.085,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 13, passed: true),
  ),
  'input': DocsScorecard(
    componentId: 'input',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 800.0, 14.0) scaled by 3.0x, label: "Email", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n',
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
      p50Ms: 0.037,
      p90Ms: 0.069,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 81, passed: true),
  ),
  'input_otp': DocsScorecard(
    componentId: 'input_otp',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 96.0, 12.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,144.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "code: """, textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      ltrX: 18.0,
      rtlX: 562.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.024,
      p90Ms: 0.037,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 55, passed: true),
  ),
  'item_picker': DocsScorecard(
    componentId: 'item_picker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 73.0, 73.0), tags: [RenderViewport.twoPane], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "A", textDirection: ltr, indexInParent: 0):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\nSemanticsNode#4(Rect.fromLTRB(154.0, 0.0, 227.0, 73.0), tags: [RenderViewport.twoPane], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "C", textDirection: ltr, indexInParent: 2):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#5(Rect.fromLTRB(231.0, 0.0, 304.0, 73.0), tags: [RenderViewport.twoPane], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "D", textDirection: ltr, indexInParent: 3):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      ltrX: 37.5,
      rtlX: 748.5,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.023,
      p90Ms: 0.038,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 13, passed: true),
  ),
  'keyboard_shortcut': DocsScorecard(
    componentId: 'keyboard_shortcut',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 12.0, 12.0) with transform [[3.0,0.0,0.0,18.0]; [0.0,3.0,0.0,882.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "⌘", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.24 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 0.6980, red: 0.6980, green: 0.6980, blue: 0.6980, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 12.0, 12.0) with transform [[3.0,0.0,0.0,96.0]; [0.0,3.0,0.0,882.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "K", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.24 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 0.7843, red: 0.6980, green: 0.6980, blue: 0.6980, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      ltrX: 6.0,
      rtlX: 782.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.024,
      p90Ms: 0.048,
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
      p50Ms: 0.02,
      p90Ms: 0.033,
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
            'SemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 230.0, 169.0), actions: [focus], flags: [isFocusable], label: "Delete", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 3.79 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.5137, green: 0.5137, blue: 0.5137, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#7(Rect.fromLTRB(0.0, 0.0, 168.0, 12.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,573.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Pick a command", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      p90Ms: 0.043,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 38, passed: true),
  ),
  'menubar': DocsScorecard(
    componentId: 'menubar',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 360.0, 12.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,156.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Open a menu and pick a command", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
      ),
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
      p50Ms: 0.02,
      p90Ms: 0.033,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 13, passed: true),
  ),
  'multi_select': DocsScorecard(
    componentId: 'multi_select',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(88.0, 294.0, 100.0, 306.0), actions: [focus, tap], flags: [isFocusable]): expected tappable node to have semantic label, but none was found.',
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(88.0, 294.0, 100.0, 306.0), actions: [focus, tap], flags: [isFocusable]): expected tap target size of at least Size(48.0, 48.0), but found Size(12.0, 12.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(88.0, 294.0, 100.0, 306.0), actions: [focus, tap], flags: [isFocusable]): expected tap target size of at least Size(44.0, 44.0), but found Size(12.0, 12.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/',
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
      p50Ms: 0.036,
      p90Ms: 0.057,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 9, passed: true),
  ),
  'navigation_bar': DocsScorecard(
    componentId: 'navigation_bar',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 188.0, 584.0) with transform [[3.0,0.0,0.0,624.0]; [0.0,3.0,0.0,24.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable]): expected tappable node to have semantic label, but none was found.\nSemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 188.0, 584.0) with transform [[3.0,0.0,0.0,1212.0]; [0.0,3.0,0.0,24.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isFocusable]): expected tappable node to have semantic label, but none was found.\n',
      ),
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
      p90Ms: 0.044,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 18, passed: true),
  ),
  'navigation_menu': DocsScorecard(
    componentId: 'navigation_menu',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 88.0, 36.0) scaled by 3.0x, actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Home", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 164.0, 36.0) with transform [[3.0,0.0,0.0,264.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Products", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 122.0, 36.0) with transform [[3.0,0.0,0.0,756.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "About", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 144.0, 12.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,144.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Viewing Home", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      ltrX: 16.0,
      rtlX: 728.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.019,
      p90Ms: 0.032,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 12, passed: true),
  ),
  'number_ticker': DocsScorecard(
    componentId: 'number_ticker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 38.0, 32.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,90.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "0", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 80.0, 32.0) with transform [[3.0,0.0,0.0,138.0]; [0.0,3.0,0.0,90.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "1234", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 108.0, 32.0) with transform [[3.0,0.0,0.0,402.0]; [0.0,3.0,0.0,90.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "987654", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
      ),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 80.0, 32.0) with transform [[3.0,0.0,0.0,138.0]; [0.0,3.0,0.0,90.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "1234", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(80.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 108.0, 32.0) with transform [[3.0,0.0,0.0,402.0]; [0.0,3.0,0.0,90.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "987654", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(108.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 80.0, 32.0) with transform [[3.0,0.0,0.0,138.0]; [0.0,3.0,0.0,90.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "1234", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(80.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 108.0, 32.0) with transform [[3.0,0.0,0.0,402.0]; [0.0,3.0,0.0,90.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "987654", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(108.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/',
      ),
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
      p50Ms: 0.018,
      p90Ms: 0.028,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 10, passed: true),
  ),
  'object_input': DocsScorecard(
    componentId: 'object_input',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#5(Rect.fromLTRB(163.0, 292.0, 179.0, 308.0), actions: [focus, tap], flags: [isFocusable]): expected tappable node to have semantic label, but none was found.',
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#5(Rect.fromLTRB(163.0, 292.0, 179.0, 308.0), actions: [focus, tap], flags: [isFocusable]): expected tap target size of at least Size(48.0, 48.0), but found Size(16.0, 16.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#5(Rect.fromLTRB(163.0, 292.0, 179.0, 308.0), actions: [focus, tap], flags: [isFocusable]): expected tap target size of at least Size(44.0, 44.0), but found Size(16.0, 16.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/',
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
      p50Ms: 0.018,
      p90Ms: 0.029,
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
      p50Ms: 0.904,
      p90Ms: 1.333,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 10, passed: true),
  ),
  'pagination': DocsScorecard(
    componentId: 'pagination',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 38.0, 600.0) with transform [[3.0,0.0,0.0,480.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "1", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 38.0, 600.0) with transform [[3.0,0.0,0.0,606.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "2", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 38.0, 600.0) with transform [[3.0,0.0,0.0,732.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "3", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\nSemanticsNode#6(Rect.fromLTRB(0.0, 0.0, 52.0, 600.0) with transform [[3.0,0.0,0.0,990.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "10", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#7(Rect.fromLTRB(0.0, 0.0, 100.0, 600.0) with transform [[3.0,0.0,0.0,1158.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Next", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 40.0, 600.0) with transform [[3.0,0.0,0.0,858.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable]): expected tappable node to have semantic label, but none was found.\n\n',
      ),
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
      p50Ms: 0.023,
      p90Ms: 0.036,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 14, passed: true),
  ),
  'phone_input': DocsScorecard(
    componentId: 'phone_input',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 160.0, 36.0) with transform [[3.0,0.0,0.0,438.0]; [0.0,3.0,0.0,846.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], flags: [isTextField, hasEnabledState, isEnabled, isFocusable], value: "+62812345678", textDirection: ltr, inputType: phone):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
      ),
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
      p50Ms: 0.028,
      p90Ms: 0.043,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 21, passed: true),
  ),
  'pinned_sheet': DocsScorecard(
    componentId: 'pinned_sheet',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 94.0, 32.0) with transform [[3.0,0.0,0.0,516.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Close", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n',
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
      ltrX: 12.0,
      rtlX: 648.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.018,
      p90Ms: 0.023,
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
      p50Ms: 0.035,
      p90Ms: 0.069,
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
      p50Ms: 0.034,
      p90Ms: 0.064,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 11, passed: true),
  ),
  'radio_group': DocsScorecard(
    componentId: 'radio_group',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 84.0, 20.0) scaled by 3.0x, actions: [focus, tap], flags: [isSelected, hasEnabledState, isEnabled, isInMutuallyExclusiveGroup, isFocusable, hasSelectedState], label: "Free", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 70.0, 20.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,96.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [hasEnabledState, isEnabled, isInMutuallyExclusiveGroup, isFocusable, hasSelectedState], label: "Pro", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 84.0, 20.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,192.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [hasEnabledState, isEnabled, isInMutuallyExclusiveGroup, isFocusable, hasSelectedState], label: "Team", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      ltrX: 26.0,
      rtlX: 718.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.034,
      p90Ms: 0.048,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 33, passed: true),
  ),
  'refresh_trigger': DocsScorecard(
    componentId: 'refresh_trigger',
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
      p50Ms: 0.018,
      p90Ms: 0.024,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 11, passed: true),
  ),
  'resizable': DocsScorecard(
    componentId: 'resizable',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 98.0, 14.0) with transform [[3.0,0.0,0.0,33.0]; [0.0,3.0,0.0,879.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Sidebar", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.35 for a font size of null.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.9608, green: 0.9608, blue: 0.9608, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 56.0, 14.0) with transform [[3.0,0.0,0.0,579.0]; [0.0,3.0,0.0,879.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Main", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.35 for a font size of null.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.9608, green: 0.9608, blue: 0.9608, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n',
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
      ltrX: 11.0,
      rtlX: 691.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.019,
      p90Ms: 0.029,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 11, passed: true),
  ),
  'scaffold': DocsScorecard(
    componentId: 'scaffold',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 238.0, 14.0) with transform [[3.0,0.0,0.0,843.0]; [0.0,3.0,0.0,405.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Main content area", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.00 for a font size of null.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\n\nSemanticsNode#8(Rect.fromLTRB(0.0, 0.0, 800.0, 12.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,876.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Tap an app-bar action", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 36.0, 36.0) with transform [[3.0,0.0,0.0,54.0]; [0.0,3.0,0.0,36.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable]): expected tappable node to have semantic label, but none was found.\n\n\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 36.0, 36.0) with transform [[3.0,0.0,0.0,2238.0]; [0.0,3.0,0.0,36.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable]): expected tappable node to have semantic label, but none was found.\n\n\n\n',
      ),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 36.0, 36.0) with transform [[3.0,0.0,0.0,54.0]; [0.0,3.0,0.0,36.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable]): expected tap target size of at least Size(48.0, 48.0), but found Size(36.0, 36.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n\n\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 36.0, 36.0) with transform [[3.0,0.0,0.0,2238.0]; [0.0,3.0,0.0,36.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable]): expected tap target size of at least Size(48.0, 48.0), but found Size(36.0, 36.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n\n\n\n',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 36.0, 36.0) with transform [[3.0,0.0,0.0,54.0]; [0.0,3.0,0.0,36.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable]): expected tap target size of at least Size(44.0, 44.0), but found Size(36.0, 36.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n\n\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 36.0, 36.0) with transform [[3.0,0.0,0.0,2238.0]; [0.0,3.0,0.0,36.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable]): expected tap target size of at least Size(44.0, 44.0), but found Size(36.0, 36.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n\n\n\n',
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
      p90Ms: 0.03,
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
      p50Ms: 0.034,
      p90Ms: 0.052,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 10, passed: true),
  ),
  'select': DocsScorecard(
    componentId: 'select',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 800.0, 600.0) scaled by 3.0x, actions: [focus, tap], flags: [isFocusable], label: "Select a fruit", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      ltrX: 12.0,
      rtlX: 36.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.021,
      p90Ms: 0.065,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 22, passed: true),
  ),
  'skeleton': DocsScorecard(
    componentId: 'skeleton',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 192.0, 32.0) scaled by 3.0x, actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "Show content", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\nSemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 234.0, 42.0) with transform [[3.0,0.0,0.0,39.0]; [0.0,3.0,0.0,249.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Body copy that keeps its box while loading.", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.35 for a font size of null.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.9608, green: 0.9608, blue: 0.9608, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      ltrX: 12.0,
      rtlX: 620.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.66,
      p90Ms: 0.945,
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
      p90Ms: 0.03,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 20, passed: true),
  ),
  'sortable': DocsScorecard(
    componentId: 'sortable',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 800.0, 42.0) scaled by 3.0x, actions: [scrollDown, scrollLeft, scrollRight, scrollUp], label: "Alpha", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.00 for a font size of null.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 800.0, 42.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,126.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [scrollDown, scrollLeft, scrollRight, scrollUp], label: "Beta", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.00 for a font size of null.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 800.0, 42.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,252.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [scrollDown, scrollLeft, scrollRight, scrollUp], label: "Gamma", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.00 for a font size of null.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 800.0, 42.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,378.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [scrollDown, scrollLeft, scrollRight, scrollUp], label: "Delta", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.00 for a font size of null.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 1.0000, green: 1.0000, blue: 1.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      ltrX: 39.0,
      rtlX: 13.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.018,
      p90Ms: 0.028,
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
      p50Ms: 1.012,
      p90Ms: 1.551,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 9, passed: true),
  ),
  'star_rating': DocsScorecard(
    componentId: 'star_rating',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(passed: true, message: null),
      labeledTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 800.0, 600.0) scaled by 3.0x, actions: [decrease, focus, increase, scrollLeft, scrollRight, tap], flags: [hasEnabledState, isEnabled, isFocusable, isSlider], value: "3.5", increasedValue: "4.0", decreasedValue: "3.0", textDirection: ltr): expected tappable node to have semantic label, but none was found.',
      ),
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
      p90Ms: 0.029,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 12, passed: true),
  ),
  'stepper': DocsScorecard(
    componentId: 'stepper',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 105.3, 32.0) with transform [[3.0,0.0,0.0,144.0]; [0.0,3.0,0.0,12.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Account", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 16.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\nSemanticsNode#4(Rect.fromLTRB(0.0, 0.0, 105.3, 32.0) with transform [[3.0,0.0,0.0,944.0]; [0.0,3.0,0.0,12.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Profile", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 16.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\nSemanticsNode#6(Rect.fromLTRB(0.0, 0.0, 112.0, 16.0) with transform [[3.0,0.0,0.0,1744.0]; [0.0,3.0,0.0,36.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Payment", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 16.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n',
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 40.0, 40.0) scaled by 3.0x, actions: [focus, tap], flags: [isFocusable]): expected tappable node to have semantic label, but none was found.\n\n\n\n\n\n',
      ),
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
      p50Ms: 0.021,
      p90Ms: 0.034,
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
      p50Ms: 0.02,
      p90Ms: 0.04,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 7, passed: true),
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
      p50Ms: 0.023,
      p90Ms: 0.066,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 27, passed: true),
  ),
  'table': DocsScorecard(
    componentId: 'table',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#18(Rect.fromLTRB(0.0, 0.0, 800.0, 12.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,684.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Tap a row to select it", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
      ),
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
      p50Ms: 0.029,
      p90Ms: 0.045,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 22, passed: true),
  ),
  'tabs': DocsScorecard(
    componentId: 'tabs',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#3(Rect.fromLTRB(117.0, 3.0, 245.0, 597.0), actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable, hasSelectedState], label: "Password", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.35 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.9608, green: 0.9608, blue: 0.9608, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#4(Rect.fromLTRB(245.0, 3.0, 373.0, 597.0), actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable, hasSelectedState], label: "Settings", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.35 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.9608, green: 0.9608, blue: 0.9608, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      ltrX: 11.0,
      rtlX: 691.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.018,
      p90Ms: 0.033,
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
      p90Ms: 0.029,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 29, passed: true),
  ),
  'text_area': DocsScorecard(
    componentId: 'text_area',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 800.0, 600.0) scaled by 3.0x, flags: [isTextField, hasEnabledState, isEnabled, isMultiline, isFocusable], value: "Hello, World!", textDirection: ltr, inputType: text):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      message: null,
      ltrX: null,
      rtlX: null,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.018,
      p90Ms: 0.03,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 33, passed: true),
  ),
  'time_picker': DocsScorecard(
    componentId: 'time_picker',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 800.0, 600.0) scaled by 3.0x, actions: [focus, tap], flags: [isFocusable], label: "14:30", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 632.0, 16.0) with transform [[3.0,0.0,0.0,504.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Kickoff", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.17 for a font size of 16.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0902, green: 0.0902, blue: 0.0902, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#3(Rect.fromLTRB(0.0, 0.0, 632.0, 14.0) with transform [[3.0,0.0,0.0,504.0]; [0.0,3.0,0.0,96.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Project kickoff meeting.", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\nSemanticsNode#5(Rect.fromLTRB(0.0, 0.0, 632.0, 16.0) with transform [[3.0,0.0,0.0,504.0]; [0.0,3.0,0.0,186.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Design review", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.17 for a font size of 16.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0902, green: 0.0902, blue: 0.0902, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#6(Rect.fromLTRB(0.0, 0.0, 632.0, 14.0) with transform [[3.0,0.0,0.0,504.0]; [0.0,3.0,0.0,282.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Review the first concept batch.", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\nSemanticsNode#8(Rect.fromLTRB(0.0, 0.0, 632.0, 16.0) with transform [[3.0,0.0,0.0,504.0]; [0.0,3.0,0.0,372.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Delivery", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.17 for a font size of 16.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0902, green: 0.0902, blue: 0.0902, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#9(Rect.fromLTRB(0.0, 0.0, 632.0, 14.0) with transform [[3.0,0.0,0.0,504.0]; [0.0,3.0,0.0,468.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Share the final assets.", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      ltrX: 50.0,
      rtlX: 680.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.018,
      p90Ms: 0.024,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 24, passed: true),
  ),
  'toast': DocsScorecard(
    componentId: 'toast',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#7(Rect.fromLTRB(0.0, 0.0, 164.0, 32.0) scaled by 3.0x, actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "topLeading", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#8(Rect.fromLTRB(0.0, 0.0, 150.0, 32.0) with transform [[3.0,0.0,0.0,516.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "topCenter", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#9(Rect.fromLTRB(0.0, 0.0, 178.0, 32.0) with transform [[3.0,0.0,0.0,990.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "topTrailing", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#10(Rect.fromLTRB(0.0, 0.0, 206.0, 32.0) with transform [[3.0,0.0,0.0,1548.0]; [0.0,3.0,0.0,0.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "bottomLeading", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\nSemanticsNode#11(Rect.fromLTRB(0.0, 0.0, 192.0, 32.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,120.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "bottomCenter", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 2.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 0.2980, red: 0.2706, green: 0.2706, blue: 0.2706, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html\n\n',
      ),
      labeledTapTarget: DocsScorecardCheck(passed: true, message: null),
      androidTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#12(Rect.fromLTRB(0.0, 0.0, 220.0, 32.0) with transform [[3.0,0.0,0.0,600.0]; [0.0,3.0,0.0,120.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "bottomTrailing", textDirection: ltr): expected tap target size of at least Size(48.0, 48.0), but found Size(220.0, 32.0)\nSee also: https://support.google.com/accessibility/android/answer/7101858?hl=en\n',
      ),
      iOSTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#12(Rect.fromLTRB(0.0, 0.0, 220.0, 32.0) with transform [[3.0,0.0,0.0,600.0]; [0.0,3.0,0.0,120.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, isFocusable], label: "bottomTrailing", textDirection: ltr): expected tap target size of at least Size(44.0, 44.0), but found Size(220.0, 32.0)\nSee also: https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/\n',
      ),
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
      p90Ms: 0.028,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 14, passed: true),
  ),
  'toggle': DocsScorecard(
    componentId: 'toggle',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#1(Rect.fromLTRB(0.0, 0.0, 58.0, 36.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,846.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], actions: [focus, tap], flags: [isButton, hasEnabledState, isEnabled, hasToggledState, isFocusable], label: "Off", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 1.06 for a font size of 14.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.0392, green: 0.0392, blue: 0.0392, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
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
      ltrX: 8.0,
      rtlX: 750.0,
    ),
    frames: DocsScorecardFrames(
      p50Ms: 0.018,
      p90Ms: 0.03,
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
      p50Ms: 0.018,
      p90Ms: 0.028,
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
      p50Ms: 0.018,
      p90Ms: 0.022,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 15, passed: true),
  ),
  'tree': DocsScorecard(
    componentId: 'tree',
    a11y: DocsScorecardA11y(
      textContrast: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#11(Rect.fromLTRB(0.0, 0.0, 192.0, 12.0) with transform [[3.0,0.0,0.0,0.0]; [0.0,3.0,0.0,744.0]; [0.0,0.0,1.0,0.0]; [0.0,0.0,0.0,1.0]], label: "Nothing selected", textDirection: ltr):\nExpected contrast ratio of at least 4.5 but found 4.43 for a font size of 12.0.\nThe computed colors was:\nlight - Color(alpha: 1.0000, red: 0.4510, green: 0.4510, blue: 0.4510, colorSpace: ColorSpace.sRGB), dark - Color(alpha: 0.0000, red: 0.0000, green: 0.0000, blue: 0.0000, colorSpace: ColorSpace.sRGB)\nSee also: https://www.w3.org/TR/UNDERSTANDING-WCAG20/visual-audio-contrast-contrast.html',
      ),
      labeledTapTarget: DocsScorecardCheck(
        passed: false,
        message:
            'SemanticsNode#2(Rect.fromLTRB(0.0, 0.0, 800.0, 40.0), tags: [RenderViewport.twoPane], actions: [tap], indexInParent: 0): expected tappable node to have semantic label, but none was found.\n\n\nSemanticsNode#6(Rect.fromLTRB(0.0, 120.0, 800.0, 160.0), tags: [RenderViewport.twoPane], actions: [tap], indexInParent: 3): expected tappable node to have semantic label, but none was found.\n\n\n',
      ),
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
      p50Ms: 0.018,
      p90Ms: 0.024,
      frames: 120,
      label: 'test environment (relative)',
    ),
    tests: DocsScorecardTests(count: 40, passed: true),
  ),
};

/// Generator timestamp (UTC ISO) for the card footer.
const String kScorecardsGeneratedAt = '2026-10-12T17:07:22.731815Z';

/// Full commit hash at generation time.
const String kScorecardsCommit = '0ffdb3e38b5db8ab5f4464062b51f171cdd87427';

/// Short commit hash (7 chars) for the card footer.
const String kScorecardsCommitShort = '0ffdb3e';

/// Flutter/Dart version at generation time.
const String kScorecardsFlutter = '3.47.7 / Dart 3.13.5';
