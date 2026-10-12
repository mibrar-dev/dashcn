// Default-text visibility tests: every builder whose spec carries a
// defaulted text control shows non-empty text in its initial preview.
//
// The generator synthesizes display defaults (component name, typing prompt)
// so the playground never opens empty; the builders resolve them through
// `PlaygroundValues.textOr/textOrNull` (no hard-coded `''` fallbacks).
// Builders without a defaulted text control (sliders, progress, tablists,
// trigger-owned demos) carry no requirement.

import 'package:docs/generated/docs_controls.dart';
import 'package:docs/playground/builders.dart';
import 'package:docs/playground/values.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../playground_harness.dart';

/// Visible strings of the pumped tree: `Text` content plus field content.
List<String> _visibleStrings(WidgetTester tester) {
  final List<String> out = <String>[];
  for (final Element element in find.byType(Text).evaluate()) {
    final Text text = element.widget as Text;
    final String plain = text.data ?? text.textSpan?.toPlainText() ?? '';
    if (plain.isNotEmpty) {
      out.add(plain);
    }
  }
  for (final Element element in find.byType(EditableText).evaluate()) {
    final String plain = (element.widget as EditableText).controller.text;
    if (plain.isNotEmpty) {
      out.add(plain);
    }
  }
  return out;
}

void main() {
  for (final String id in kPlaygroundBuilders.keys) {
    final ComponentControls spec = kControlSpecs[id]!;
    final List<String> defaulted = <String>[
      for (final ControlSpec control in spec.controls)
        if (control.isEditable &&
            control.kind == ControlKind.text &&
            control.defaultValue != null)
          control.name,
    ];
    if (defaulted.isEmpty) {
      continue;
    }
    testWidgets('builder $id shows its default text ($defaulted)', (
      WidgetTester tester,
    ) async {
      await pumpPlayground(tester, id);
      final List<String> shown = _visibleStrings(tester);
      expect(
        shown,
        isNotEmpty,
        reason: '$id has defaulted text $defaulted but shows nothing',
      );
      Object? error = tester.takeException();
      expect(error, isNull, reason: '$id pumps cleanly with defaults');
    });
  }

  test('every builder text control resolves without empty fallbacks', () {
    // The resolvers behind the builders: seeded values hit the value,
    // partial values hit the spec default, hand-built values hit '' only
    // when the spec carries no default at all.
    final ComponentControls spec = kControlSpecs['button']!;
    final PlaygroundValues seeded = PlaygroundValues.defaults(spec);
    expect(seeded.textOr('child'), 'Button');
    final PlaygroundValues partial = PlaygroundValues();
    partial.addAll(<String, Object?>{'variant': 'outline'});
    expect(partial.textOr('child'), '');
    expect(partial.textOrNull('child'), isNull);
    final PlaygroundValues seededSelect = PlaygroundValues.defaults(
      kControlSpecs['select']!,
    );
    expect(seededSelect.textOrNull('placeholder'), 'Type here…');
    expect(seededSelect.textOrNull('value'), isNull);
  });
}
