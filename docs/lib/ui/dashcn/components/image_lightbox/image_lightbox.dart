// The `image_lightbox` component: a full-screen image viewer opened from a
// thumbnail with a hero-like scale+fade transition. Pinch or scroll to zoom,
// drag to pan, double-tap to toggle zoom, swipe between images, and close on
// Escape, the backdrop or the × button. Captions, a counter and a thumbnail
// strip are optional chrome.
//
// Images render through the `image` component's `Picture`, so loading and
// error slots behave exactly like everywhere else in the kit.
//
// Widgets-only; no Material/Cupertino.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/motion/motion_scope.dart';
import '../../primitives/surface.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import '../image/image.dart';
import 'image_lightbox_style.dart';

export 'image_lightbox_style.dart';

/// One image in a [ImageLightbox].
class LightboxImage {
  /// Creates a lightbox image.
  const LightboxImage({
    required this.image,
    this.caption,
    this.semanticLabel,
  });

  /// The image to decode.
  final ImageProvider image;

  /// Optional caption shown under the image.
  final String? caption;

  /// Accessible label; also marks the node as an image.
  final String? semanticLabel;
}

/// A full-screen lightbox over a list of [LightboxImage]s.
///
/// ```dart
/// ImageLightbox(
///   images: photos,
///   initialIndex: 0,
///   onChanged: (index) => print(index),
/// )
/// ```
///
/// Open it from a thumbnail with [showImageLightbox], which pushes a route
/// with a hero-like scale+fade transition.
class ImageLightbox extends StatefulWidget {
  /// Creates a lightbox.
  const ImageLightbox({
    super.key,
    required this.images,
    this.initialIndex = 0,
    this.showThumbnails = true,
    this.showCounter = true,
    this.minScale = 1,
    this.maxScale = 4,
    this.doubleTapScale = 2,
    this.onChanged,
    this.heroTag,
    this.theme,
  }) : assert(images.length > 0, 'A lightbox needs at least one image.');

  /// The images to show.
  final List<LightboxImage> images;

  /// The image to open on.
  final int initialIndex;

  /// Whether the thumbnail strip shows.
  final bool showThumbnails;

  /// Whether the counter shows.
  final bool showCounter;

  /// Minimum zoom scale.
  final double minScale;

  /// Maximum zoom scale.
  final double maxScale;

  /// Scale a double-tap zooms to.
  final double doubleTapScale;

  /// Called with the current image index on every page change.
  final ValueChanged<int>? onChanged;

  /// Optional hero tag for the open transition.
  final Object? heroTag;

  /// Widget-leg theme override, merged over the component/app/defaults legs.
  final ImageLightboxTheme? theme;

  @override
  State<ImageLightbox> createState() => _ImageLightboxState();
}

/// Opens an [ImageLightbox] over a hero-like scale+fade route transition.
///
/// The returned future completes when the lightbox closes. Under reduced
/// motion the route snaps with no transition.
Future<T?> showImageLightbox<T>({
  required BuildContext context,
  required List<LightboxImage> images,
  int initialIndex = 0,
  bool showThumbnails = true,
  bool showCounter = true,
  double minScale = 1,
  double maxScale = 4,
  double doubleTapScale = 2,
  ValueChanged<int>? onChanged,
  Object? heroTag,
  ImageLightboxTheme? theme,
}) {
  final ImageLightboxTheme style = resolveComponentStyle<ImageLightboxTheme,
      ImageLightboxTheme>(
    context,
    widget: theme,
    select: (t) => t,
    defaults: imageLightboxDefaults,
  );
  final Duration duration = motionReduced(context)
      ? Duration.zero
      : style.transitionDuration ?? const Duration(milliseconds: 250);
  return Navigator.of(context).push<T>(
    PageRouteBuilder<T>(
      opaque: false,
      barrierDismissible: false,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder: (_, _, _) => ImageLightbox(
        images: images,
        initialIndex: initialIndex,
        showThumbnails: showThumbnails,
        showCounter: showCounter,
        minScale: minScale,
        maxScale: maxScale,
        doubleTapScale: doubleTapScale,
        onChanged: onChanged,
        heroTag: heroTag,
        theme: theme,
      ),
      transitionsBuilder: (_, Animation<double> animation, _, Widget child) {
        final CurvedAnimation curved = CurvedAnimation(
          parent: animation,
          curve: Theme.of(context).motion.curves.emphasizedOut,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.85, end: 1).animate(curved),
            child: child,
          ),
        );
      },
    ),
  );
}

class _ImageLightboxState extends State<ImageLightbox> {
  late final PageController _pageController;
  late int _index;
  final FocusNode _focus = FocusNode(debugLabel: 'ImageLightbox');

  ImageLightboxTheme _style(BuildContext context) =>
      resolveComponentStyle<ImageLightboxTheme, ImageLightboxTheme>(
        context,
        widget: widget.theme,
        select: (t) => t,
        defaults: imageLightboxDefaults,
      );

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex
        .clamp(0, widget.images.length - 1)
        .toDouble()
        .toInt();
    _pageController = PageController(initialPage: _index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    final int next = index.clamp(0, widget.images.length - 1);
    if (next == _index) {
      return;
    }
    setState(() => _index = next);
    widget.onChanged?.call(next);
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }
    switch (event.logicalKey) {
      case LogicalKeyboardKey.escape:
        Navigator.of(context).maybePop();
      case LogicalKeyboardKey.arrowLeft:
        _goTo(_index - 1);
      case LogicalKeyboardKey.arrowRight:
        _goTo(_index + 1);
      default:
        return KeyEventResult.ignored;
    }
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    final ImageLightboxTheme style = _style(context);
    final ThemeData theme = Theme.of(context);
    final Color barrier = (style.barrierColor ??
            const ThemedColor.value(Color(0x99000000)))
        .resolve(theme.colors);
    final Color foreground = (style.foreground ??
            const ThemedColor.ref(ColorRef.foreground))
        .resolve(theme.colors);
    final Color muted = (style.mutedForeground ??
            const ThemedColor.ref(ColorRef.mutedForeground))
        .resolve(theme.colors);
    final double maxScale = style.maxScale ?? 4;
    final double minScale = style.minScale ?? 1;
    final double doubleTapScale = style.doubleTapScale ?? 2;
    final bool showThumbnails =
        widget.showThumbnails && (style.showThumbnails ?? true);
    final bool showCounter = widget.showCounter && (style.showCounter ?? true);

    final Widget pager = PageView.builder(
      controller: _pageController,
      itemCount: widget.images.length,
      onPageChanged: _goTo,
      itemBuilder: (BuildContext context, int index) {
        return _ZoomableImage(
          image: widget.images[index],
          minScale: minScale,
          maxScale: maxScale,
          doubleTapScale: doubleTapScale,
          zoomDuration: style.zoomDuration ?? kDefaultZoomDuration,
          onClose: () => Navigator.of(context).maybePop(),
        );
      },
    );

    final Widget content = Column(
      children: <Widget>[
        _topBar(style, theme, foreground, muted, showCounter),
        Expanded(child: pager),
        _caption(style, theme, foreground),
        if (showThumbnails) _thumbnails(style, theme),
      ],
    );

    return Focus(
      focusNode: _focus,
      autofocus: true,
      onKeyEvent: _onKey,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).maybePop(),
              child: ColoredBox(color: barrier),
            ),
          ),
          Positioned.fill(child: content),
        ],
      ),
    );
  }

  Widget _topBar(
    ImageLightboxTheme style,
    ThemeData theme,
    Color foreground,
    Color muted,
    bool showCounter,
  ) {
    final Color closeColor = (style.closeButtonColor ??
            const ThemedColor.ref(ColorRef.foreground))
        .resolve(theme.colors);
    final Color closeBackground = (style.closeButtonBackground ??
            const ThemedColor.ref(ColorRef.background))
        .resolve(theme.colors);
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            if (showCounter)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  '${_index + 1} / ${widget.images.length}',
                  style: TextStyle(color: foreground, fontSize: 14),
                ),
              ),
            const Spacer(),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).maybePop(),
              child: Semantics(
                label: 'Close',
                button: true,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: closeBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(LucideIcons.x, size: 20, color: closeColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _caption(ImageLightboxTheme style, ThemeData theme, Color foreground) {
    final LightboxImage current = widget.images[_index];
    final EdgeInsetsGeometry padding = style.captionPadding ??
        const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
    return SafeArea(
      top: false,
      child: Padding(
        padding: padding,
        child: Text(
          current.caption ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(color: foreground, fontSize: 14),
        ),
      ),
    );
  }

  Widget _thumbnails(ImageLightboxTheme style, ThemeData theme) {
    final Color borderColor = (style.thumbnailBorderColor ??
            const ThemedColor.ref(ColorRef.accent))
        .resolve(theme.colors);
    final double borderWidth = style.thumbnailBorderWidth ?? 2;
    final double height = style.thumbnailHeight ?? 56;
    final BorderRadiusGeometry radius =
        style.thumbnailBorderRadius ?? theme.borderRadiusMd;
    return _LightboxChrome(
      style: style,
      theme: theme,
      child: SizedBox(
        height: height + 16,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          itemCount: widget.images.length,
          itemBuilder: (BuildContext context, int index) {
            final bool selected = index == _index;
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _goTo(index),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                  width: height * 1.5,
                  decoration: BoxDecoration(
                    borderRadius: radius,
                    border: Border.all(
                      color: selected ? borderColor : const Color(0x00000000),
                      width: borderWidth,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: radius,
                    child: Picture(
                      image: widget.images[index].image,
                      width: height * 1.5,
                      height: height,
                      fit: BoxFit.cover,
                      semanticLabel: widget.images[index].semanticLabel,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// The frosted chrome surface behind the caption and thumbnail strip.
class _LightboxChrome extends StatelessWidget {
  const _LightboxChrome({
    required this.style,
    required this.theme,
    required this.child,
  });

  final ImageLightboxTheme style;
  final ThemeData theme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Color fill = (style.surfaceColor ??
            const ThemedColor.ref(ColorRef.background))
        .resolve(theme.colors);
    final double? opacity = resolveSurfaceOpacity(context);
    final double? blur = resolveSurfaceBlur(context);
    return GlassSurface(
      key: const ValueKey<String>('dashcn.image_lightbox.chrome'),
      surfaceBlur: blur,
      child: ColoredBox(color: surfaceColor(fill, opacity), child: child),
    );
  }
}

/// One zoomable, pannable image page.
class _ZoomableImage extends StatefulWidget {
  const _ZoomableImage({
    required this.image,
    required this.minScale,
    required this.maxScale,
    required this.doubleTapScale,
    required this.zoomDuration,
    required this.onClose,
  });

  final LightboxImage image;
  final double minScale;
  final double maxScale;
  final double doubleTapScale;
  final Duration zoomDuration;
  final VoidCallback onClose;

  @override
  State<_ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<_ZoomableImage>
    with SingleTickerProviderStateMixin {
  final TransformationController _controller = TransformationController();
  late final AnimationController _zoomController;
  Animation<Matrix4>? _zoomAnimation;
  double _scale = 1;

  @override
  void initState() {
    super.initState();
    _zoomController = AnimationController(vsync: this, duration: widget.zoomDuration);
    _zoomController.addListener(_onZoomTick);
    _controller.addListener(_onTransform);
  }

  @override
  void dispose() {
    _zoomController.removeListener(_onZoomTick);
    _zoomController.dispose();
    _controller.removeListener(_onTransform);
    _controller.dispose();
    super.dispose();
  }

  void _onZoomTick() {
    _controller.value = _zoomAnimation?.value ?? _controller.value;
  }

  void _onTransform() {
    final double scale = _controller.value.getMaxScaleOnAxis();
    if ((scale - _scale).abs() > 0.001) {
      setState(() => _scale = scale);
    }
  }

  void _animateTo(Matrix4 target) {
    _zoomAnimation = Matrix4Tween(
      begin: _controller.value,
      end: target,
    ).animate(CurvedAnimation(parent: _zoomController, curve: Curves.easeOut));
    _zoomController.forward(from: 0);
  }

  void _onDoubleTapDown(TapDownDetails details) {
    if (_scale > 1.01) {
      _animateTo(Matrix4.identity());
      return;
    }
    final Offset p = details.localPosition;
    final double s = widget.doubleTapScale;
    _animateTo(_zoomAround(p, s));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onClose,
          onDoubleTapDown: _onDoubleTapDown,
          child: InteractiveViewer(
            transformationController: _controller,
            minScale: widget.minScale,
            maxScale: widget.maxScale,
            panEnabled: _scale > 1.01,
            scaleEnabled: true,
            child: Center(
              child: Picture(
                image: widget.image.image,
                width: width,
                height: height,
                fit: BoxFit.contain,
                semanticLabel: widget.image.semanticLabel,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// A zoom by [s] around the point [p], built without the deprecated
/// `translate`/`scale` matrix helpers.
Matrix4 _zoomAround(Offset p, double s) {
  final Matrix4 m = Matrix4.identity();
  m.setEntry(0, 0, s);
  m.setEntry(1, 1, s);
  m.setEntry(2, 2, s);
  m.setEntry(0, 3, p.dx * (1 - s));
  m.setEntry(1, 3, p.dy * (1 - s));
  return m;
}

/// Default double-tap zoom duration.
const Duration kDefaultZoomDuration = Duration(milliseconds: 150);
