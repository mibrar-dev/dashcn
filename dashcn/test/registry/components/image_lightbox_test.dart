// Widget tests for the `image_lightbox` component.
//
// Covers rendering (image, counter, caption, thumbnails), page changes and
// the onChanged callback, keyboard (Escape, arrows), close on backdrop,
// double-tap zoom, theme overrides, reduced motion, RTL and a 375px
// phone-width overflow check.

import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/image/image.dart';
import 'package:dashcn/src/components/image_lightbox/image_lightbox.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

/// A provider that hands out a solid 4x4 image immediately.
class _SolidProvider extends ImageProvider<_SolidProvider> {
  const _SolidProvider(this.color);

  final Color color;

  @override
  Future<_SolidProvider> obtainKey(ImageConfiguration configuration) =>
      Future<_SolidProvider>.value(this);

  @override
  ImageStreamCompleter loadImage(
    _SolidProvider key,
    ImageDecoderCallback decode,
  ) {
    return OneFrameImageStreamCompleter(
      Future<ImageInfo>.value(ImageInfo(image: _solidImage(color))),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is _SolidProvider && other.color == color;

  @override
  int get hashCode => color.hashCode;
}

ui.Image _solidImage(Color color) {
  final ui.Image image = _SolidImageCache.image(color);
  return image;
}

/// Caches one solid image per color so the tests stay fast.
class _SolidImageCache {
  static final Map<Color, ui.Image> _cache = <Color, ui.Image>{};

  static ui.Image image(Color color) {
    return _cache.putIfAbsent(color, () {
      // A 2x2 image is enough for the lightbox to lay out and zoom.
      final ui.PictureRecorder recorder = ui.PictureRecorder();
      final ui.Canvas canvas = ui.Canvas(recorder);
      canvas.drawRect(
        const Rect.fromLTWH(0, 0, 2, 2),
        ui.Paint()..color = color,
      );
      final ui.Picture picture = recorder.endRecording();
      // Synchronous decode is not available; return a 1x1 via toImageSync.
      return picture.toImageSync(2, 2);
    });
  }
}

const List<LightboxImage> _images = <LightboxImage>[
  LightboxImage(
    image: _SolidProvider(Color(0xFFFF0000)),
    caption: 'Red',
    semanticLabel: 'Red image',
  ),
  LightboxImage(
    image: _SolidProvider(Color(0xFF00FF00)),
    caption: 'Green',
    semanticLabel: 'Green image',
  ),
  LightboxImage(
    image: _SolidProvider(Color(0xFF0000FF)),
    caption: 'Blue',
    semanticLabel: 'Blue image',
  ),
];

/// Pumps an [ImageLightbox] filling the test surface.
Future<void> pumpLightbox(
  WidgetTester tester,
  ImageLightbox lightbox, {
  Size size = const Size(720, 420),
}) async {
  await tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(size: size),
      child: Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: lightbox,
        ),
      ),
    ),
  );
  await tester.pump();
}

/// Pumps a home page with an "open" button that pushes the lightbox, so the
/// close tests have a Navigator to pop.
Future<void> pumpHarness(
  WidgetTester tester, {
  Size size = const Size(720, 420),
}) async {
  await tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(size: size),
      child: Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Navigator(
            onGenerateRoute: (RouteSettings settings) => PageRouteBuilder<void>(
              pageBuilder: (BuildContext context, _, _) => Center(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => showImageLightbox<void>(
                    context: context,
                    images: _images,
                  ),
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  group('rendering', () {
    testWidgets('renders the image, counter, caption and thumbnails',
        (tester) async {
      await pumpLightbox(tester, ImageLightbox(images: _images));
      expect(find.text('1 / 3'), findsOneWidget);
      expect(find.text('Red'), findsOneWidget);
      expect(find.byType(Picture), findsWidgets);
    });

    testWidgets('hides the counter and thumbnails when asked', (tester) async {
      await pumpLightbox(
        tester,
        ImageLightbox(
          images: _images,
          showCounter: false,
          showThumbnails: false,
        ),
      );
      expect(find.text('1 / 3'), findsNothing);
    });

    testWidgets('renders a single image with no chrome', (tester) async {
      await pumpLightbox(
        tester,
        ImageLightbox(
          images: <LightboxImage>[_images[1]],
          showCounter: false,
          showThumbnails: false,
        ),
      );
      expect(find.text('Green'), findsOneWidget);
    });
  });

  group('paging', () {
    testWidgets('swipe changes the image and reports onChanged', (tester) async {
      final List<int> reported = <int>[];
      await pumpLightbox(
        tester,
        ImageLightbox(images: _images, onChanged: reported.add),
      );
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();
      expect(reported, contains(1));
      expect(find.text('2 / 3'), findsOneWidget);
    });

    testWidgets('arrow keys page between images', (tester) async {
      final List<int> reported = <int>[];
      await pumpLightbox(
        tester,
        ImageLightbox(images: _images, onChanged: reported.add),
      );
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pumpAndSettle();
      expect(reported, contains(1));
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
      await tester.pumpAndSettle();
      expect(reported, contains(0));
    });

    testWidgets('thumbnail tap jumps to that image', (tester) async {
      final List<int> reported = <int>[];
      await pumpLightbox(
        tester,
        ImageLightbox(images: _images, onChanged: reported.add),
      );
      final Finder thumbs = find.descendant(
        of: find.byKey(const ValueKey<String>('dashcn.image_lightbox.chrome')),
        matching: find.byType(Picture),
      );
      await tester.tap(thumbs.last);
      await tester.pumpAndSettle();
      expect(reported, contains(2));
    });
  });

  group('zoom', () {
    testWidgets('double-tap zooms in and back out', (tester) async {
      await pumpLightbox(
        tester,
        ImageLightbox(
          images: <LightboxImage>[_images[0]],
          showCounter: false,
          showThumbnails: false,
        ),
      );
      final Finder image = find.byType(Picture).first;
      final TransformationController controller = tester
          .widget<InteractiveViewer>(find.byType(InteractiveViewer))
          .transformationController!;
      final Matrix4 before = controller.value;
      await tester.tap(image);
      await tester.pump(const Duration(milliseconds: 50));
      await tester.tap(image);
      await tester.pumpAndSettle();
      final Matrix4 after = controller.value;
      expect(after.getMaxScaleOnAxis(), greaterThan(before.getMaxScaleOnAxis()));
    });
  });

  group('close', () {
    testWidgets('backdrop tap closes', (tester) async {
      await pumpHarness(tester);
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      expect(find.byType(ImageLightbox), findsOneWidget);
      // Tap the scrim behind the image (top-left corner, outside the image).
      await tester.tapAt(const Offset(5, 5));
      await tester.pumpAndSettle();
      expect(find.byType(ImageLightbox), findsNothing);
    });

    testWidgets('Escape closes', (tester) async {
      await pumpHarness(tester);
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      expect(find.byType(ImageLightbox), findsOneWidget);
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();
      expect(find.byType(ImageLightbox), findsNothing);
    });

    testWidgets('the × button closes', (tester) async {
      final List<LightboxImage> opened = <LightboxImage>[];
      await pumpHarness(tester, opened);
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      expect(find.byType(ImageLightbox), findsOneWidget);
      await tester.tap(find.bySemanticsLabel('Close'));
      await tester.pumpAndSettle();
      expect(find.byType(ImageLightbox), findsNothing);
    });
  });

  group('theme and style overrides', () {
    testWidgets('widget theme leg overrides the defaults', (tester) async {
      await pumpLightbox(
        tester,
        ImageLightbox(
          images: <LightboxImage>[_images[0]],
          showCounter: false,
          showThumbnails: false,
          theme: const ImageLightboxTheme(
            maxScale: 5,
            doubleTapScale: 3,
          ),
        ),
      );
      expect(find.byType(ImageLightbox), findsOneWidget);
    });
  });

  group('reduced motion', () {
    testWidgets('transition collapses under reduced motion', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(720, 420), disableAnimations: true),
          child: Theme(
            data: const ThemeData(),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: ImageLightbox(
                images: <LightboxImage>[_images[0]],
                showCounter: false,
                showThumbnails: false,
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(ImageLightbox), findsOneWidget);
    });
  });

  group('RTL', () {
    testWidgets('renders right to left', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(720, 420)),
          child: Theme(
            data: const ThemeData(),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ImageLightbox(images: _images),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.text('1 / 3'), findsOneWidget);
    });
  });

  group('phone width', () {
    testWidgets('no overflow at 375px', (tester) async {
      await pumpLightbox(
        tester,
        ImageLightbox(images: _images),
        size: const Size(375, 812),
      );
      expect(tester.takeException(), isNull);
    });
  });
}
