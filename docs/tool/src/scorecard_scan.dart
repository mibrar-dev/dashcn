// Scorecard scan for the docs codegen (P9-5b).
//
// Reads `dashcn/lib/src/manifests/scorecards.json` (written by
// `dashcn/tool/gen_scorecards.dart`). `null` always means "not measured"
// and is never rendered as a pass.

import 'dart:convert';
import 'dart:io';

import 'registry_scan.dart';

/// One guideline check (`passed` null means not measured).
class ScorecardCheckFacts {
  /// Creates the facts.
  const ScorecardCheckFacts({required this.passed, this.message});

  /// Whether the guideline passed, or null when not measured.
  final bool? passed;

  /// Failing guideline message, or null when passing/not measured.
  final String? message;
}

/// Semantics presence (`present` null means not measured).
class ScorecardSemanticsFacts {
  /// Creates the facts.
  const ScorecardSemanticsFacts({required this.present, this.message});

  /// Whether any label/value/hint/tooltip was found, or null.
  final bool? present;

  /// Detail message, or null.
  final String? message;
}

/// Accessibility facts for one component.
class ScorecardA11yFacts {
  /// Creates the facts.
  const ScorecardA11yFacts({
    required this.textContrast,
    required this.labeledTapTarget,
    required this.androidTapTarget,
    required this.iOSTapTarget,
    required this.semantics,
  });

  /// Text contrast guideline.
  final ScorecardCheckFacts textContrast;

  /// Labeled tap-target guideline.
  final ScorecardCheckFacts labeledTapTarget;

  /// Android tap-target guideline.
  final ScorecardCheckFacts androidTapTarget;

  /// iOS tap-target guideline.
  final ScorecardCheckFacts iOSTapTarget;

  /// Semantics presence.
  final ScorecardSemanticsFacts semantics;
}

/// Right-to-left facts for one component.
class ScorecardRtlFacts {
  /// Creates the facts.
  const ScorecardRtlFacts({
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

  /// True when the leading edge mirrored; null means symmetric or
  /// not applicable (see [message]), never "not measured" on its own.
  final bool? mirrored;

  /// Detail message (`symmetric layout …`, or `not measured`).
  final String? message;

  /// First-text x in LTR, or null.
  final double? ltrX;

  /// First-text x in RTL, or null.
  final double? rtlX;
}

/// Frame-time facts for one component.
class ScorecardFramesFacts {
  /// Creates the facts.
  const ScorecardFramesFacts({
    required this.p50Ms,
    required this.p90Ms,
    required this.frames,
    required this.label,
  });

  /// p50 build time in ms, or null when not measured.
  final double? p50Ms;

  /// p90 build time in ms, or null when not measured.
  final double? p90Ms;

  /// Number of pumped frames (120).
  final int frames;

  /// Always `test environment (relative)`.
  final String label;
}

/// Test-count facts for one component.
class ScorecardTestsFacts {
  /// Creates the facts.
  const ScorecardTestsFacts({required this.count, required this.passed});

  /// Registry test cases tagged to the component.
  final int count;

  /// Harness pass at generation time (false when not measured).
  final bool passed;
}

/// All scorecard facts for one component.
class ComponentScorecardFacts {
  /// Creates the facts.
  const ComponentScorecardFacts({
    required this.id,
    required this.a11y,
    required this.rtl,
    required this.frames,
    required this.tests,
  });

  /// Registry component id.
  final String id;

  /// Accessibility facts.
  final ScorecardA11yFacts a11y;

  /// RTL facts.
  final ScorecardRtlFacts rtl;

  /// Frame-time facts.
  final ScorecardFramesFacts frames;

  /// Test-count facts.
  final ScorecardTestsFacts tests;
}

/// The parsed `scorecards.json` document.
class ScorecardsDoc {
  /// Creates the document.
  const ScorecardsDoc({
    required this.generatedAt,
    required this.commit,
    required this.flutter,
    required this.components,
  });

  /// UTC ISO timestamp from the generator.
  final String generatedAt;

  /// Full commit hash (`unknown` outside git).
  final String commit;

  /// Flutter/Dart version string.
  final String flutter;

  /// Per-component facts keyed by id.
  final Map<String, ComponentScorecardFacts> components;

  /// Short commit for the card footer (7 chars, or `unknown`).
  String get commitShort {
    if (commit == 'unknown' || commit.length < 7) {
      return commit;
    }
    return commit.substring(0, 7);
  }
}

/// Reads `manifests/scorecards.json` under [registryRoot].
ScorecardsDoc scanScorecards(String registryRoot) {
  final File file = File('$registryRoot/manifests/scorecards.json');
  if (!file.existsSync()) {
    throw RegistryScanException(
      'missing ${file.path} (run `dart run tool/gen_scorecards.dart` '
      'in dashcn/ first)',
    );
  }
  final Object? decoded;
  try {
    decoded = jsonDecode(file.readAsStringSync());
  } on FormatException catch (error) {
    throw RegistryScanException('scorecards.json is not valid JSON: $error');
  }
  if (decoded is! Map<String, Object?>) {
    throw RegistryScanException('scorecards.json root must be an object');
  }
  final String generatedAt = decoded['generatedAt'] as String? ?? 'unknown';
  final String commit = decoded['commit'] as String? ?? 'unknown';
  final String flutter = decoded['flutter'] as String? ?? 'unknown';
  final Object? rawComponents = decoded['components'];
  if (rawComponents is! Map<String, Object?>) {
    throw RegistryScanException('scorecards.json `components` must be a map');
  }
  final Map<String, ComponentScorecardFacts> components =
      <String, ComponentScorecardFacts>{};
  for (final MapEntry<String, Object?> entry in rawComponents.entries) {
    if (entry.value is! Map<String, Object?>) {
      throw RegistryScanException(
        'scorecards.json component `${entry.key}` must be an object',
      );
    }
    components[entry.key] = _parseComponent(
      entry.key,
      entry.value! as Map<String, Object?>,
    );
  }
  return ScorecardsDoc(
    generatedAt: generatedAt,
    commit: commit,
    flutter: flutter,
    components: components,
  );
}

ComponentScorecardFacts _parseComponent(String id, Map<String, Object?> raw) {
  final Map<String, Object?> a11y =
      (raw['a11y'] as Map?)?.cast<String, Object?>() ?? <String, Object?>{};
  final Map<String, Object?> rtl =
      (raw['rtl'] as Map?)?.cast<String, Object?>() ?? <String, Object?>{};
  final Map<String, Object?> frames =
      (raw['frames'] as Map?)?.cast<String, Object?>() ?? <String, Object?>{};
  final Map<String, Object?> tests =
      (raw['tests'] as Map?)?.cast<String, Object?>() ?? <String, Object?>{};
  return ComponentScorecardFacts(
    id: id,
    a11y: ScorecardA11yFacts(
      textContrast: _parseCheck(a11y['textContrast']),
      labeledTapTarget: _parseCheck(a11y['labeledTapTarget']),
      androidTapTarget: _parseCheck(a11y['androidTapTarget']),
      iOSTapTarget: _parseCheck(a11y['iOSTapTarget']),
      semantics: _parseSemantics(a11y['semantics']),
    ),
    rtl: ScorecardRtlFacts(
      passed: _parseBool(rtl['passed']),
      renders: _parseBool(rtl['renders']),
      mirrored: _parseBool(rtl['mirrored']),
      message: rtl['message'] as String?,
      ltrX: _parseDouble(rtl['ltrX']),
      rtlX: _parseDouble(rtl['rtlX']),
    ),
    frames: ScorecardFramesFacts(
      p50Ms: _parseDouble(frames['p50Ms']),
      p90Ms: _parseDouble(frames['p90Ms']),
      frames: (frames['frames'] as num?)?.toInt() ?? 120,
      label: frames['label'] as String? ?? 'test environment (relative)',
    ),
    tests: ScorecardTestsFacts(
      count: (tests['count'] as num?)?.toInt() ?? 0,
      passed: tests['passed'] as bool? ?? false,
    ),
  );
}

ScorecardCheckFacts _parseCheck(Object? raw) {
  if (raw is! Map<String, Object?>) {
    return const ScorecardCheckFacts(passed: null);
  }
  return ScorecardCheckFacts(
    passed: _parseBool(raw['passed']),
    message: raw['message'] as String?,
  );
}

ScorecardSemanticsFacts _parseSemantics(Object? raw) {
  if (raw is! Map<String, Object?>) {
    return const ScorecardSemanticsFacts(present: null);
  }
  return ScorecardSemanticsFacts(
    present: _parseBool(raw['present']),
    message: raw['message'] as String?,
  );
}

bool? _parseBool(Object? raw) {
  if (raw is bool) {
    return raw;
  }
  return null;
}

double? _parseDouble(Object? raw) {
  if (raw is num) {
    return raw.toDouble();
  }
  return null;
}
