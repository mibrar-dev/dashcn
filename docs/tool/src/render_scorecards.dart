// Renderer for lib/generated/docs_scorecards.dart (P9-5b).
//
// Renders the parsed scorecard facts (see scorecard_scan.dart). Deterministic:
// same manifest bytes produce same Dart bytes (timestamps copied verbatim).

import 'literals.dart';
import 'render_common.dart';
import 'scorecard_scan.dart';

/// Renders `lib/generated/docs_scorecards.dart` from [doc].
String renderDocsScorecards(ScorecardsDoc doc) {
  final StringBuffer out = StringBuffer()
    ..write(
      banner(
        sources: const <String>['dashcn/lib/src/manifests/scorecards.json'],
        regenerate: kRegenerateCommand,
        notes: <String>[
          'Measured quality facts per component (P9-5a harness output).',
          '`null` always means "not measured" and is never a pass.',
          'Frame times are test-environment relative, never device numbers.',
        ],
      ),
    )
    ..writeln()
    ..writeln('/// One guideline check: `passed` null means not measured.')
    ..writeln('class DocsScorecardCheck {')
    ..writeln('  /// Creates the check.')
    ..writeln(
      '  const DocsScorecardCheck({required this.passed, this.message, '
      'this.exempt});',
    )
    ..writeln()
    ..writeln('  /// Whether the guideline passed, or null when not measured.')
    ..writeln('  final bool? passed;')
    ..writeln()
    ..writeln('  /// Failing guideline message, or null.')
    ..writeln('  final String? message;')
    ..writeln()
    ..writeln(
      '  /// Documented exemption reason; exempt checks render as "Exempt"',
    )
    ..writeln('  /// and never count as failures.')
    ..writeln('  final String? exempt;')
    ..writeln('}')
    ..writeln()
    ..writeln('/// Semantics presence: `present` null means not measured.')
    ..writeln('class DocsScorecardSemantics {')
    ..writeln('  /// Creates the entry.')
    ..writeln(
      '  const DocsScorecardSemantics({required this.present, this.message, '
      'this.exempt});',
    )
    ..writeln()
    ..writeln('  /// Whether semantics were found, or null when not measured.')
    ..writeln('  final bool? present;')
    ..writeln()
    ..writeln('  /// Detail message, or null.')
    ..writeln('  final String? message;')
    ..writeln()
    ..writeln(
      '  /// Documented exemption reason (see [DocsScorecardCheck.exempt]).',
    )
    ..writeln('  final String? exempt;')
    ..writeln('}')
    ..writeln()
    ..writeln('/// Accessibility facts for one component.')
    ..writeln('class DocsScorecardA11y {')
    ..writeln('  /// Creates the facts.')
    ..writeln('  const DocsScorecardA11y({')
    ..writeln('    required this.textContrast,')
    ..writeln('    required this.labeledTapTarget,')
    ..writeln('    required this.androidTapTarget,')
    ..writeln('    required this.iOSTapTarget,')
    ..writeln('    required this.semantics,')
    ..writeln('  });')
    ..writeln()
    ..writeln('  /// Text contrast guideline.')
    ..writeln('  final DocsScorecardCheck textContrast;')
    ..writeln()
    ..writeln('  /// Labeled tap-target guideline.')
    ..writeln('  final DocsScorecardCheck labeledTapTarget;')
    ..writeln()
    ..writeln('  /// Android tap-target guideline (mobile, informational).')
    ..writeln('  final DocsScorecardCheck androidTapTarget;')
    ..writeln()
    ..writeln('  /// iOS tap-target guideline (mobile, informational).')
    ..writeln('  final DocsScorecardCheck iOSTapTarget;')
    ..writeln()
    ..writeln('  /// Semantics presence.')
    ..writeln('  final DocsScorecardSemantics semantics;')
    ..writeln('}')
    ..writeln()
    ..writeln('/// Right-to-left facts for one component.')
    ..writeln('class DocsScorecardRtl {')
    ..writeln('  /// Creates the facts.')
    ..writeln('  const DocsScorecardRtl({')
    ..writeln('    required this.passed,')
    ..writeln('    required this.renders,')
    ..writeln('    required this.mirrored,')
    ..writeln('    this.message,')
    ..writeln('    this.ltrX,')
    ..writeln('    this.rtlX,')
    ..writeln('  });')
    ..writeln()
    ..writeln('  /// Whether the RTL run passed, or null when not measured.')
    ..writeln('  final bool? passed;')
    ..writeln()
    ..writeln('  /// Whether the preview rendered under RTL, or null.')
    ..writeln('  final bool? renders;')
    ..writeln()
    ..writeln('  /// True when mirrored; null means symmetric/not applicable.')
    ..writeln('  final bool? mirrored;')
    ..writeln()
    ..writeln('  /// Detail message, or null.')
    ..writeln('  final String? message;')
    ..writeln()
    ..writeln('  /// First-text x in LTR, or null.')
    ..writeln('  final double? ltrX;')
    ..writeln()
    ..writeln('  /// First-text x in RTL, or null.')
    ..writeln('  final double? rtlX;')
    ..writeln('}')
    ..writeln()
    ..writeln('/// Frame-time facts for one component.')
    ..writeln('class DocsScorecardFrames {')
    ..writeln('  /// Creates the facts.')
    ..writeln('  const DocsScorecardFrames({')
    ..writeln('    required this.p50Ms,')
    ..writeln('    required this.p90Ms,')
    ..writeln('    required this.frames,')
    ..writeln('    required this.label,')
    ..writeln('  });')
    ..writeln()
    ..writeln('  /// p50 build time in ms, or null when not measured.')
    ..writeln('  final double? p50Ms;')
    ..writeln()
    ..writeln('  /// p90 build time in ms, or null when not measured.')
    ..writeln('  final double? p90Ms;')
    ..writeln()
    ..writeln('  /// Number of pumped frames.')
    ..writeln('  final int frames;')
    ..writeln()
    ..writeln('  /// Always `test environment (relative)`.')
    ..writeln('  final String label;')
    ..writeln('}')
    ..writeln()
    ..writeln('/// Test-count facts for one component.')
    ..writeln('class DocsScorecardTests {')
    ..writeln('  /// Creates the facts.')
    ..writeln(
      '  const DocsScorecardTests({required this.count, required this.passed});',
    )
    ..writeln()
    ..writeln('  /// Registry test cases tagged to the component.')
    ..writeln('  final int count;')
    ..writeln()
    ..writeln('  /// Harness pass at generation time.')
    ..writeln('  final bool passed;')
    ..writeln('}')
    ..writeln()
    ..writeln('/// All scorecard facts for one component.')
    ..writeln('class DocsScorecard {')
    ..writeln('  /// Creates the facts.')
    ..writeln('  const DocsScorecard({')
    ..writeln('    required this.componentId,')
    ..writeln('    required this.a11y,')
    ..writeln('    required this.rtl,')
    ..writeln('    required this.frames,')
    ..writeln('    required this.tests,')
    ..writeln('  });')
    ..writeln()
    ..writeln('  /// Registry component id.')
    ..writeln('  final String componentId;')
    ..writeln()
    ..writeln('  /// Accessibility facts.')
    ..writeln('  final DocsScorecardA11y a11y;')
    ..writeln()
    ..writeln('  /// Right-to-left facts.')
    ..writeln('  final DocsScorecardRtl rtl;')
    ..writeln()
    ..writeln('  /// Frame-time facts.')
    ..writeln('  final DocsScorecardFrames frames;')
    ..writeln()
    ..writeln('  /// Test-count facts.')
    ..writeln('  final DocsScorecardTests tests;')
    ..writeln()
    ..writeln('  /// Number of failing checks (a11y + semantics + rtl).')
    ..writeln('  /// Exempt checks never count as failures.')
    ..writeln('  int get failureCount {')
    ..writeln('    int count = 0;')
    ..writeln(
      '    if (a11y.textContrast.passed == false && '
      'a11y.textContrast.exempt == null) {',
    )
    ..writeln('      count++;')
    ..writeln('    }')
    ..writeln(
      '    if (a11y.labeledTapTarget.passed == false && '
      'a11y.labeledTapTarget.exempt == null) {',
    )
    ..writeln('      count++;')
    ..writeln('    }')
    ..writeln(
      '    if (a11y.androidTapTarget.passed == false && '
      'a11y.androidTapTarget.exempt == null) {',
    )
    ..writeln('      count++;')
    ..writeln('    }')
    ..writeln(
      '    if (a11y.iOSTapTarget.passed == false && '
      'a11y.iOSTapTarget.exempt == null) {',
    )
    ..writeln('      count++;')
    ..writeln('    }')
    ..writeln(
      '    if (a11y.semantics.present == false && '
      'a11y.semantics.exempt == null) {',
    )
    ..writeln('      count++;')
    ..writeln('    }')
    ..writeln('    if (rtl.passed == false) {')
    ..writeln('      count++;')
    ..writeln('    }')
    ..writeln('    return count;')
    ..writeln('  }')
    ..writeln()
    ..writeln('  /// Whether any measured check failed.')
    ..writeln('  bool get hasFailures => failureCount > 0;')
    ..writeln()
    ..writeln('  /// Number of checks with a documented exemption.')
    ..writeln('  int get exemptCount {')
    ..writeln('    int count = 0;')
    ..writeln('    if (a11y.textContrast.exempt != null) {')
    ..writeln('      count++;')
    ..writeln('    }')
    ..writeln('    if (a11y.labeledTapTarget.exempt != null) {')
    ..writeln('      count++;')
    ..writeln('    }')
    ..writeln('    if (a11y.androidTapTarget.exempt != null) {')
    ..writeln('      count++;')
    ..writeln('    }')
    ..writeln('    if (a11y.iOSTapTarget.exempt != null) {')
    ..writeln('      count++;')
    ..writeln('    }')
    ..writeln('    if (a11y.semantics.exempt != null) {')
    ..writeln('      count++;')
    ..writeln('    }')
    ..writeln('    return count;')
    ..writeln('  }')
    ..writeln('}')
    ..writeln();

  final List<String> ids = doc.components.keys.toList()..sort();
  out
    ..writeln(
      '/// All ${ids.length} measured components, keyed by id (sorted).',
    )
    ..writeln(
      'const Map<String, DocsScorecard> kScorecards = '
      '<String, DocsScorecard>{',
    );
  for (final String id in ids) {
    final ComponentScorecardFacts facts = doc.components[id]!;
    out
      ..writeln('  ${dartString(id)}: DocsScorecard(')
      ..writeln('    componentId: ${dartString(facts.id)},')
      ..writeln('    a11y: DocsScorecardA11y(')
      ..writeln(
        '      ${_checkLiteral('textContrast', facts.a11y.textContrast)},',
      )
      ..writeln(
        '      ${_checkLiteral('labeledTapTarget', facts.a11y.labeledTapTarget)},',
      )
      ..writeln(
        '      ${_checkLiteral('androidTapTarget', facts.a11y.androidTapTarget)},',
      )
      ..writeln(
        '      ${_checkLiteral('iOSTapTarget', facts.a11y.iOSTapTarget)},',
      )
      ..writeln(
        '      semantics: DocsScorecardSemantics('
        'present: ${_boolLiteral(facts.a11y.semantics.present)}, '
        'message: ${_stringLiteral(facts.a11y.semantics.message)}, '
        'exempt: ${_stringLiteral(facts.a11y.semantics.exempt)}),',
      )
      ..writeln('    ),')
      ..writeln('    rtl: DocsScorecardRtl(')
      ..writeln('      passed: ${_boolLiteral(facts.rtl.passed)},')
      ..writeln('      renders: ${_boolLiteral(facts.rtl.renders)},')
      ..writeln('      mirrored: ${_boolLiteral(facts.rtl.mirrored)},')
      ..writeln('      message: ${_stringLiteral(facts.rtl.message)},')
      ..writeln('      ltrX: ${_doubleLiteral(facts.rtl.ltrX)},')
      ..writeln('      rtlX: ${_doubleLiteral(facts.rtl.rtlX)},')
      ..writeln('    ),')
      ..writeln('    frames: DocsScorecardFrames(')
      ..writeln('      p50Ms: ${_doubleLiteral(facts.frames.p50Ms)},')
      ..writeln('      p90Ms: ${_doubleLiteral(facts.frames.p90Ms)},')
      ..writeln('      frames: ${facts.frames.frames},')
      ..writeln('      label: ${dartString(facts.frames.label)},')
      ..writeln('    ),')
      ..writeln('    tests: DocsScorecardTests(')
      ..writeln('      count: ${facts.tests.count},')
      ..writeln('      passed: ${facts.tests.passed},')
      ..writeln('    ),')
      ..writeln('  ),');
  }
  out
    ..writeln('};')
    ..writeln()
    ..writeln('/// Generator timestamp (UTC ISO) for the card footer.')
    ..writeln(
      'const String kScorecardsGeneratedAt = ${dartString(doc.generatedAt)};',
    )
    ..writeln()
    ..writeln('/// Full commit hash at generation time.')
    ..writeln('const String kScorecardsCommit = ${dartString(doc.commit)};')
    ..writeln()
    ..writeln('/// Short commit hash (7 chars) for the card footer.')
    ..writeln(
      'const String kScorecardsCommitShort = ${dartString(doc.commitShort)};',
    )
    ..writeln()
    ..writeln('/// Flutter/Dart version at generation time.')
    ..writeln('const String kScorecardsFlutter = ${dartString(doc.flutter)};');
  return out.toString();
}

String _boolLiteral(bool? value) {
  if (value == null) {
    return 'null';
  }
  return value ? 'true' : 'false';
}

String _stringLiteral(String? value) {
  if (value == null) {
    return 'null';
  }
  return dartString(value);
}

String _doubleLiteral(double? value) {
  if (value == null) {
    return 'null';
  }
  return value.toString();
}

String _checkLiteral(String name, ScorecardCheckFacts check) {
  return '$name: DocsScorecardCheck('
      'passed: ${_boolLiteral(check.passed)}, '
      'message: ${_stringLiteral(check.message)}, '
      'exempt: ${_stringLiteral(check.exempt)})';
}
