// Unit tests for the P9-1 device specs: sizes, insets, orientation swaps
// and `?frame=` / `?orientation=` round-trips.

import 'package:docs/widgets/device_frame/device_spec.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('device specs', () {
    test('four framable specs in toolbar order', () {
      expect(kFramedSpecs.map((DeviceSpec s) => s.id), <DeviceFrameId>[
        DeviceFrameId.iphone,
        DeviceFrameId.android,
        DeviceFrameId.desktop,
        DeviceFrameId.web,
      ]);
    });

    test('iphone exposes its size, insets and platform', () {
      expect(kIphoneSpec.size, const Size(393, 852));
      expect(kIphoneSpec.devicePixelRatio, 3);
      expect(kIphoneSpec.platform, TargetPlatform.iOS);
      expect(
        kIphoneSpec.paddingFor(DeviceOrientation.portrait),
        const EdgeInsets.only(top: 59, bottom: 34),
      );
      // The island side swaps in landscape.
      expect(kIphoneSpec.paddingFor(DeviceOrientation.landscape).left, 59);
      expect(
        kIphoneSpec.sizeFor(DeviceOrientation.landscape),
        const Size(852, 393),
      );
    });

    test('android exposes its size, insets and platform', () {
      expect(kAndroidSpec.size, const Size(412, 915));
      expect(kAndroidSpec.platform, TargetPlatform.android);
      expect(
        kAndroidSpec.paddingFor(DeviceOrientation.portrait).top,
        greaterThan(0),
      );
      expect(
        kAndroidSpec.sizeFor(DeviceOrientation.landscape),
        const Size(915, 412),
      );
    });

    test('desktop and web resolve to different platforms', () {
      expect(kDesktopSpec.platform, TargetPlatform.macOS);
      expect(kWebSpec.platform, TargetPlatform.windows);
      expect(kDesktopSpec.size, const Size(1280, 800));
      expect(kWebSpec.size, const Size(1280, 800));
      // Title bar / browser chrome sits above the content.
      expect(kDesktopSpec.paddingFor(DeviceOrientation.portrait).top, 52);
      expect(kWebSpec.paddingFor(DeviceOrientation.portrait).top, 104);
    });
    test('totals include the chrome on every side', () {
      for (final DeviceSpec spec in kFramedSpecs) {
        for (final DeviceOrientation orientation in DeviceOrientation.values) {
          final Size screen = spec.sizeFor(orientation);
          final Size total = spec.totalFor(orientation);
          expect(total.width, greaterThan(screen.width));
          expect(total.height, greaterThan(screen.height));
        }
      }
    });

    test('only phones rotate; desktop and browser ignore orientation', () {
      expect(kIphoneSpec.rotatable, isTrue);
      expect(kAndroidSpec.rotatable, isTrue);
      expect(kDesktopSpec.rotatable, isFalse);
      expect(kWebSpec.rotatable, isFalse);
      for (final DeviceSpec spec in <DeviceSpec>[kDesktopSpec, kWebSpec]) {
        expect(
          spec.sizeFor(DeviceOrientation.landscape),
          spec.sizeFor(DeviceOrientation.portrait),
        );
        expect(
          spec.paddingFor(DeviceOrientation.landscape),
          spec.paddingFor(DeviceOrientation.portrait),
        );
        expect(
          spec.totalFor(DeviceOrientation.landscape),
          spec.totalFor(DeviceOrientation.portrait),
        );
      }
    });

    test('specForFrame resolves singles and nulls the rest', () {
      expect(specForFrame(DeviceFrameId.iphone), same(kIphoneSpec));
      expect(specForFrame(DeviceFrameId.android), same(kAndroidSpec));
      expect(specForFrame(DeviceFrameId.desktop), same(kDesktopSpec));
      expect(specForFrame(DeviceFrameId.web), same(kWebSpec));
      expect(specForFrame(DeviceFrameId.none), isNull);
      expect(specForFrame(DeviceFrameId.all), isNull);
    });
  });

  group('query values', () {
    test('frame ids round-trip through ?frame=', () {
      for (final DeviceFrameId id in DeviceFrameId.values) {
        expect(DeviceFrameId.parse(id.queryValue), id);
      }
      expect(DeviceFrameId.parse(null), DeviceFrameId.none);
      expect(DeviceFrameId.parse(''), DeviceFrameId.none);
      expect(DeviceFrameId.parse('blackberry'), DeviceFrameId.none);
    });

    test('orientations round-trip through ?orientation=', () {
      for (final DeviceOrientation orientation in DeviceOrientation.values) {
        expect(DeviceOrientation.parse(orientation.queryValue), orientation);
      }
      expect(DeviceOrientation.parse(null), DeviceOrientation.portrait);
      expect(
        DeviceOrientation.parse('upside-down'),
        DeviceOrientation.portrait,
      );
    });
  });
}
