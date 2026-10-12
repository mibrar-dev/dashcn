// P8-4: every Dart sample on the two new pages parses with the analyzer.
//
// The pages render their Dart figures from [kPackageOrOwnDartSamples] and
// [kMaterialDartSamples] verbatim, so parsing those lists covers every Dart
// sample the reader sees. Entries that are a full unit (imports,
// declarations) must parse directly; statements and expressions must parse
// inside a function body. Unresolved identifiers are fine: `parseString`
// reports syntax only, never resolution.

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:docs/pages/material_interop_page.dart';
import 'package:docs/pages/package_or_own_page.dart';
import 'package:flutter_test/flutter_test.dart';

/// Asserts [sample] parses, wrapping it in a function body when it is a
/// statement or expression rather than a full unit.
void expectSampleParses(String sample) {
  final direct = parseString(content: sample, throwIfDiagnostics: false);
  if (direct.errors.isEmpty) {
    return;
  }
  final wrapped = parseString(
    // An expression needs a trailing `;` to stand as a statement.
    content:
        'void _probe() {\n$sample'
        '${sample.trimRight().endsWith(';') ? '' : ';'}\n}',
    throwIfDiagnostics: false,
  );
  expect(
    wrapped.errors,
    isEmpty,
    reason: 'Dart sample fails to parse:\n$sample',
  );
}

void main() {
  group('p8-4 dart samples parse', () {
    test('package-or-own samples', () {
      expect(kPackageOrOwnDartSamples, isNotEmpty);
      for (final String sample in kPackageOrOwnDartSamples) {
        expectSampleParses(sample);
      }
    });

    test('material interop samples', () {
      expect(kMaterialDartSamples, isNotEmpty);
      for (final String sample in kMaterialDartSamples) {
        expectSampleParses(sample);
      }
    });
  });
}
