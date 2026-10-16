// Unit tests for the P9-1 device specs: sizes, insets, orientation swaps
// and `?frame=` / `?orientation=` round-trips.
//
// Every metric mirrors a `package:device_preview` preset (see
// `device_spec.dart`): the mirror tests pin each value against the preset it
// comes from, so a preset upgrade fails loudly instead of drifting.

import 'package:device_preview/device_preview.dart';
import 'package:device_preview/presets.dart';
import 'package:docs/widgets/device_frame/device_spec.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('device specs', () {
    test('five framable specs in toolbar order', () {
      expect(kFramedSpecs.map((DeviceSpec s) => s.id), <DeviceFrameId>[
        DeviceFrameId.iphone,
        DeviceFrameId.android,
        DeviceFrameId.ipad,
        DeviceFrameId.desktop,
        DeviceFrameId.web,
      ]);
    });

    test('specs mirror their presets', () {
      expect(kIphoneSpec.preset, same(DevicePresets.iPhone16Pro));
      expect(kAndroidSpec.preset, same(DevicePresets.galaxyS25));
      expect(kIpadSpec.preset, same(DevicePresets.iPadAir11M4));
      expect(kDesktopSpec.preset, same(DevicePresets.largeDesktopWindow));
      expect(kWebSpec.preset, same(DevicePresets.smallDesktopWindow));
      for (final DeviceSpec spec in kFramedSpecs) {
        expect(spec.size, spec.preset.portraitSize);
        expect(spec.devicePixelRatio, spec.preset.devicePixelRatio);
        expect(spec.platform, spec.preset.platform);
        expect(
          spec.paddingFor(DeviceOrientation.portrait),
          spec.preset.portraitPadding,
        );
      }
    });

    test('iphone exposes its size, insets and platform', () {
      expect(kIphoneSpec.size, const Size(402, 874));
      expect(kIphoneSpec.devicePixelRatio, 3);
      expect(kIphoneSpec.platform, TargetPlatform.iOS);
      expect(
        kIphoneSpec.paddingFor(DeviceOrientation.portrait),
        const EdgeInsets.only(top: 62, bottom: 34),
      );
      // The island side swaps in landscape.
      expect(kIphoneSpec.paddingFor(DeviceOrientation.landscape).left, 62);
      expect(
        kIphoneSpec.sizeFor(DeviceOrientation.landscape),
        const Size(874, 402),
      );
    });

    test('android exposes its size, insets and platform', () {
      expect(kAndroidSpec.size, const Size(360, 780));
      expect(kAndroidSpec.platform, TargetPlatform.android);
      expect(
        kAndroidSpec.paddingFor(DeviceOrientation.portrait),
        const EdgeInsets.only(top: 24, bottom: 24),
      );
      expect(
        kAndroidSpec.sizeFor(DeviceOrientation.landscape),
        const Size(780, 360),
      );
    });

    test('ipad exposes its size, insets and platform', () {
      expect(kIpadSpec.size, const Size(820, 1180));
      expect(kIpadSpec.devicePixelRatio, 2);
      expect(kIpadSpec.platform, TargetPlatform.iOS);
      expect(
        kIpadSpec.paddingFor(DeviceOrientation.portrait),
        const EdgeInsets.only(top: 32, bottom: 25),
      );
      expect(
        kIpadSpec.sizeFor(DeviceOrientation.landscape),
        const Size(1180, 820),
      );
      expect(kIpadSpec.rotatable, isTrue);
    });

    test('desktop and web resolve to different platforms', () {
      expect(kDesktopSpec.platform, TargetPlatform.macOS);
      expect(kWebSpec.platform, TargetPlatform.windows);
      expect(kDesktopSpec.size, const Size(1920, 1080));
      expect(kWebSpec.size, const Size(1024, 640));
    });

    test('totals include the letterbox on every side', () {
      for (final DeviceSpec spec in kFramedSpecs) {
        for (final DeviceOrientation orientation in DeviceOrientation.values) {
          final Size screen = spec.sizeFor(orientation);
          final Size total = spec.totalFor(orientation);
          expect(total.width, greaterThan(screen.width));
          expect(total.height, greaterThan(screen.height));
        }
      }
    });

    test('letterbox matches the package content bounds', () {
      for (final DeviceSpec spec in kFramedSpecs) {
        for (final DeviceOrientation orientation in DeviceOrientation.values) {
          final DeviceSimulation simulation = spec.simulationFor(orientation);
          final Size screen = spec.sizeFor(orientation);
          expect(simulation.screenSize, screen);
          final Rect bounds = simulation.contentBounds;
          final EdgeInsets letterbox = spec.letterboxFor(orientation);
          // The frame box (screen + letterbox) contains the painted body.
          expect(letterbox.left, greaterThanOrEqualTo(-bounds.left - 0.5));
          expect(letterbox.top, greaterThanOrEqualTo(-bounds.top - 0.5));
          expect(
            screen.width + letterbox.left + letterbox.right,
            greaterThanOrEqualTo(bounds.width - 0.5),
          );
          expect(
            screen.height + letterbox.top + letterbox.bottom,
            greaterThanOrEqualTo(bounds.height - 0.5),
          );
          expect(spec.totalFor(orientation).width, greaterThan(0));
          expect(spec.totalFor(orientation).height, greaterThan(0));
        }
      }
    });

    test('only phones and the tablet rotate; windows ignore orientation', () {
      expect(kIphoneSpec.rotatable, isTrue);
      expect(kAndroidSpec.rotatable, isTrue);
      expect(kIpadSpec.rotatable, isTrue);
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
      expect(specForFrame(DeviceFrameId.ipad), same(kIpadSpec));
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
