// `dcn1_` preset-string codec tests: round-trip, canonical form, version
// and malformed-input rejection, token diff, and the store-resolver hook.

import 'dart:convert';
import 'dart:io';

import 'package:dashcn/src/theme/interop/interop.dart';
import 'package:flutter_test/flutter_test.dart';

Map<String, Object?> _neutralPreset() =>
    jsonDecode(File('lib/src/themes/neutral.json').readAsStringSync())
        as Map<String, Object?>;

void main() {
  group('encode/decode round-trip', () {
    test('neutral preset survives encode then decode identically', () {
      final Map<String, Object?> preset = _neutralPreset();
      final String encoded = encodePresetString(preset);
      expect(encoded, startsWith(kPresetStringPrefix));
      final Map<String, Object?> decoded = decodePresetString(encoded);
      expect(decoded, canonicalPresetJson(preset));
      expect(
        const JsonEncoder.withIndent('  ').convert(decoded),
        const JsonEncoder.withIndent('  ').convert(canonicalPresetJson(preset)),
      );
    });

    test('every registry preset round-trips its tokens', () {
      for (final FileSystemEntity entity in Directory(
        'lib/src/themes',
      ).listSync()) {
        if (entity is! File ||
            !entity.path.endsWith('.json') ||
            entity.path.endsWith('index.json') ||
            entity.path.endsWith('themes.schema.json')) {
          continue;
        }
        final Map<String, Object?> preset =
            jsonDecode(entity.readAsStringSync()) as Map<String, Object?>;
        final Map<String, Object?> decoded = decodePresetString(
          encodePresetString(preset),
        );
        expect(decoded, canonicalPresetJson(preset), reason: entity.path);
      }
    });

    test('this is encoding, not encryption: output is deterministic', () {
      final Map<String, Object?> preset = _neutralPreset();
      expect(encodePresetString(preset), encodePresetString(preset));
    });
  });

  group('canonical form', () {
    test('key order never changes the string', () {
      final Map<String, Object?> preset = _neutralPreset();
      final Map<String, Object?> reversed = <String, Object?>{
        for (final String key in preset.keys.toList().reversed)
          key: preset[key],
      };
      expect(encodePresetString(reversed), encodePresetString(preset));
    });
  });

  group('rejection', () {
    test('unknown versions are rejected with a clear message', () {
      expect(
        () => decodePresetString('dcn2_abc'),
        throwsA(
          isA<PresetStringException>().having(
            (Object e) => (e as PresetStringException).message,
            'message',
            contains('Unsupported preset string version "dcn2_"'),
          ),
        ),
      );
    });

    test('missing prefixes are rejected with a clear message', () {
      expect(
        () => decodePresetString('bciwvKBk'),
        throwsA(
          isA<PresetStringException>().having(
            (Object e) => (e as PresetStringException).message,
            'message',
            contains('expected a dcn1_'),
          ),
        ),
      );
    });

    test('malformed payloads are rejected with clear messages', () {
      expect(
        () => decodePresetString('dcn1_!!!not-base64!!!'),
        throwsA(isA<PresetStringException>()),
      );
      // Valid base64url, but not DEFLATE output: inflate is lenient, so
      // this surfaces as a JSON failure — still a clear rejection.
      expect(
        () => decodePresetString(
          'dcn1_${base64Url.encode(utf8.encode('plain json? no'))}',
        ),
        throwsA(
          isA<PresetStringException>().having(
            (Object e) => (e as PresetStringException).message,
            'message',
            contains('Malformed preset string'),
          ),
        ),
      );
    });
  });

  group('token diff', () {
    test('added, changed and removed paths are reported', () {
      final Map<String, Object?> oldPreset = _neutralPreset();
      final Map<String, Object?> newPreset = canonicalPresetJson(oldPreset);
      (newPreset['light'] as Map<String, Object?>)['primary'] = '#FF0000';
      (newPreset['light'] as Map<String, Object?>).remove('card');
      (newPreset['fonts'] as Map<String, Object?>)['sans'] =
          'Orbitron, sans-serif';
      final PresetDiff diff = diffPresetDocuments(oldPreset, newPreset);
      expect(diff.isEmpty, isFalse);
      expect(diff.added, isEmpty);
      expect(
        diff.changed,
        containsAll(<String>['light.primary', 'fonts.sans']),
      );
      expect(diff.removed, <String>['light.card']);
      expect(
        diff.reportLines(),
        containsAll(<String>['~ light.primary', '- light.card']),
      );
    });

    test('identical documents diff empty', () {
      final Map<String, Object?> preset = _neutralPreset();
      expect(diffPresetDocuments(preset, preset).isEmpty, isTrue);
    });
  });

  group('store-resolver hook', () {
    test('short ids fail loudly, never silently', () async {
      const PresetStoreResolver resolver = UnconfiguredPresetStoreResolver();
      await expectLater(
        resolver.resolvePresetString('bciwvKBk'),
        throwsA(
          isA<PresetStringException>().having(
            (Object e) => (e as PresetStringException).message,
            'message',
            allOf(contains('hosted preset store'), contains('dcn1_')),
          ),
        ),
      );
    });
  });
}
