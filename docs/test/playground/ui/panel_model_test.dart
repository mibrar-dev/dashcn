// Playground model unit tests: query helpers, dependent-range clamps and
// registry coverage. No widgets are pumped here (see `panel_test.dart`).

import 'package:docs/generated/docs_controls.dart';
import 'package:docs/playground/builders.dart';
import 'package:docs/playground/ui/bounds.dart';
import 'package:docs/playground/ui/query.dart';
import 'package:docs/playground/values.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('query helpers', () {
    test('playgroundUri keeps unrelated params and drops defaults', () {
      final ComponentControls spec = kControlSpecs['button']!;
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      values.set('variant', 'outline');
      final Uri merged = playgroundUri(
        Uri.parse('/docs/components/button?frame=iphone&tab=usage'),
        spec,
        values,
      );
      expect(merged.queryParameters['p.variant'], 'outline');
      expect(merged.queryParameters['frame'], 'iphone');
      expect(merged.queryParameters['tab'], 'usage');
      values.set('variant', 'primary');
      final Uri stripped = playgroundUri(merged, spec, values);
      expect(stripped.queryParameters.containsKey('p.variant'), isFalse);
      expect(stripped.queryParameters['frame'], 'iphone');
    });

    test('null survives the query round-trip', () {
      final ComponentControls spec = kControlSpecs['switch']!;
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      values.set('enabled', true);
      expect(values.toQuery(spec)['p.enabled'], 'true');
      values.set('enabled', null);
      expect(values.toQuery(spec).containsKey('p.enabled'), isFalse);
      final PlaygroundValues restored = PlaygroundValues.fromQuery(
        spec,
        <String, String>{'p.enabled': 'null'},
      );
      expect(restored.getBool('enabled'), isNull);
    });
  });

  group('dependent ranges', () {
    test('clampBoundedValues orders inverted seeds generically', () {
      final ComponentControls spec = kControlSpecs['slider']!;
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      values
        ..set('min', 8.0)
        ..set('max', 2.0)
        ..set('value', 5.0);
      final List<String> touched = clampBoundedValues(spec, values);
      expect(values.getDouble('min'), 2.0);
      expect(values.getDouble('max'), 8.0);
      expect(values.getDouble('value'), 5.0);
      expect(touched, containsAll(<String>['min', 'max']));
      final ({double min, double max})? live = sliderBounds(
        spec,
        values,
        spec.controls.firstWhere(
          (ControlSpec control) => control.name == 'value',
        ),
      );
      expect(live, isNotNull);
      expect(live!.min, 2.0);
      expect(live.max, 8.0);
    });

    test('unknown bounded entries are ignored', () {
      final ComponentControls spec = kControlSpecs['button']!;
      final PlaygroundValues values = PlaygroundValues.defaults(spec);
      expect(
        clampBoundedValues(
          spec,
          values,
          boundedBy: const <String, List<String>>{
            'variant': <String>['size'],
            'missing': <String>['also-missing'],
          },
        ),
        isEmpty,
      );
    });
  });

  group('registry coverage', () {
    test('every builder id resolves a spec and vice versa', () {
      for (final String id in kPlaygroundBuilders.keys) {
        expect(
          kControlSpecs[id],
          isNotNull,
          reason: 'builder $id has a control spec',
        );
      }
      // The two P9-2a gaps still render nothing instead of throwing.
      expect(kControlSpecs['toggle_group'], isNull);
      expect(kPlaygroundBuilders.containsKey('label'), isFalse);
    });
  });
}
