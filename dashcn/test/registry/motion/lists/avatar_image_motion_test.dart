// Motion contract for avatar and picture: the image fades in over the 200 ms
// base token once its first frame arrives. Reduced motion or an image that
// is already decoded paints at once.

import 'dart:ui' as ui;

import 'package:dashcn/src/components/avatar/avatar.dart';
import 'package:dashcn/src/components/image/image.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Image provider that delivers one frame asynchronously (never synchronous).
class _OneFrameProvider extends ImageProvider<_OneFrameProvider> {
  const _OneFrameProvider(this.image);

  final ui.Image image;

  @override
  Future<_OneFrameProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<_OneFrameProvider>(this);
  }

  @override
  ImageStreamCompleter loadImage(
    _OneFrameProvider key,
    ImageDecoderCallback decode,
  ) {
    return OneFrameImageStreamCompleter(
      Future<ImageInfo>.value(ImageInfo(image: image)),
    );
  }
}

Future<ui.Image> _makeImage(WidgetTester tester) async {
  late ui.Image image;
  await tester.runAsync(() async {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas(recorder);
    image = await recorder.endRecording().toImage(4, 4);
  });
  return image;
}

Future<void> _pump(WidgetTester tester, Widget child, {bool reduced = false}) {
  return tester.pumpWidget(
    MediaQuery(
      data: const MediaQueryData(
        size: Size(400, 300),
      ).copyWith(disableAnimations: reduced),
      child: Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(child: child),
        ),
      ),
    ),
  );
}

/// The fade driving the avatar image (AnimatedOpacity's FadeTransition).
double _fadeValue(WidgetTester tester) {
  return tester
      .widget<FadeTransition>(
        find
            .descendant(
              of: find.byType(AnimatedOpacity),
              matching: find.byType(FadeTransition),
            )
            .first,
      )
      .opacity
      .value;
}

void main() {
  testWidgets('avatar image fades in over 200 ms once the frame arrives', (
    WidgetTester tester,
  ) async {
    final ui.Image image = await _makeImage(tester);
    await _pump(
      tester,
      Avatar(initials: 'IB', image: _OneFrameProvider(image)),
    );
    await tester.pump();
    await tester.pump();
    expect(find.byType(AnimatedOpacity), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 100));
    expect(_fadeValue(tester), greaterThan(0));
    expect(_fadeValue(tester), lessThan(1));
    await tester.pump(const Duration(milliseconds: 200));
    expect(_fadeValue(tester), 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('picture uses the 200 ms fade-in duration', (
    WidgetTester tester,
  ) async {
    final ui.Image image = await _makeImage(tester);
    await _pump(
      tester,
      Picture(image: _OneFrameProvider(image), width: 80, height: 80),
    );
    await tester.pump();
    final AnimatedOpacity fade = tester.widget<AnimatedOpacity>(
      find.byType(AnimatedOpacity).first,
    );
    expect(fade.duration, const Duration(milliseconds: 200));
  });

  testWidgets('reduced motion paints the avatar image without a fade ticker', (
    WidgetTester tester,
  ) async {
    final ui.Image image = await _makeImage(tester);
    await _pump(
      tester,
      Avatar(initials: 'IB', image: _OneFrameProvider(image)),
      reduced: true,
    );
    await tester.pump();
    await tester.pump();
    final AnimatedOpacity fade = tester.widget<AnimatedOpacity>(
      find.byType(AnimatedOpacity),
    );
    expect(fade.duration, Duration.zero);
    expect(tester.binding.transientCallbackCount, 0);
  });
}
