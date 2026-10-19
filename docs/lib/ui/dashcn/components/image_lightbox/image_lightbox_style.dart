// Registry-owned theme data for the `image_lightbox` component: the
// [ImageLightboxTheme] container and the token-derived `imageLightboxDefaults`.
//
// User-owned overrides live in `image_lightbox_theme.dart`; CLI updates may
// replace this file. The widget resolves the four legs through
// `resolveComponentStyle<ImageLightboxTheme, ImageLightboxTheme>` from
// `theme/theme.dart`.

import 'package:flutter/widgets.dart';

import '../../foundation/constants.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';

/// One image lightbox's visual contract.
///
/// Every field is nullable, so an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields. `thumbnailBorderRadius`
/// resolves at build because its default follows the theme's radius token.
class ImageLightboxTheme extends ComponentThemeData
    implements Mergeable<ImageLightboxTheme> {
  /// Creates an image lightbox theme.
  const ImageLightboxTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.barrierColor,
    this.surfaceColor,
    this.foreground,
    this.mutedForeground,
    this.closeButtonColor,
    this.closeButtonBackground,
    this.thumbnailBorderRadius,
    this.thumbnailBorderWidth,
    this.thumbnailBorderColor,
    this.thumbnailHeight,
    this.minScale,
    this.maxScale,
    this.doubleTapScale,
    this.transitionDuration,
    this.zoomDuration,
    this.showThumbnails,
    this.showCounter,
    this.captionPadding,
  });

  /// Scrim behind the image; null resolves 60% black.
  final ThemedColor? barrierColor;

  /// Fill of the caption/thumbnail chrome; null resolves the `background`
  /// token (frosted through the surface primitive).
  final ThemedColor? surfaceColor;

  /// Counter and caption text; null resolves the `foreground` token.
  final ThemedColor? foreground;

  /// Thumbnail counter and hints; null resolves `mutedForeground`.
  final ThemedColor? mutedForeground;

  /// Close (×) glyph colour; null resolves the `foreground` token.
  final ThemedColor? closeButtonColor;

  /// Close button fill; null resolves the `background` token.
  final ThemedColor? closeButtonBackground;

  /// Corner radius of the thumbnails; null resolves `radiusMd`.
  final BorderRadiusGeometry? thumbnailBorderRadius;

  /// Border width of the selected thumbnail; null resolves 2.
  final double? thumbnailBorderWidth;

  /// Border colour of the selected thumbnail; null resolves `accent`.
  final ThemedColor? thumbnailBorderColor;

  /// Height of the thumbnail strip; null resolves 56.
  final double? thumbnailHeight;

  /// Minimum zoom scale; null resolves 1.
  final double? minScale;

  /// Maximum zoom scale; null resolves 4.
  final double? maxScale;

  /// Scale a double-tap zooms to; null resolves 2.
  final double? doubleTapScale;

  /// Open/close transition duration; null resolves 250 ms.
  final Duration? transitionDuration;

  /// Double-tap zoom duration; null resolves 150 ms.
  final Duration? zoomDuration;

  /// Whether the thumbnail strip shows; null resolves true.
  final bool? showThumbnails;

  /// Whether the counter shows; null resolves true.
  final bool? showCounter;

  /// Padding around the caption; null resolves 12 horizontal / 8 vertical.
  final EdgeInsetsGeometry? captionPadding;

  /// Returns a copy with the given fields replaced.
  ImageLightboxTheme copyWith({
    ValueGetter<ThemedColor?>? barrierColor,
    ValueGetter<ThemedColor?>? surfaceColor,
    ValueGetter<ThemedColor?>? foreground,
    ValueGetter<ThemedColor?>? mutedForeground,
    ValueGetter<ThemedColor?>? closeButtonColor,
    ValueGetter<ThemedColor?>? closeButtonBackground,
    ValueGetter<BorderRadiusGeometry?>? thumbnailBorderRadius,
    ValueGetter<double?>? thumbnailBorderWidth,
    ValueGetter<ThemedColor?>? thumbnailBorderColor,
    ValueGetter<double?>? thumbnailHeight,
    ValueGetter<double?>? minScale,
    ValueGetter<double?>? maxScale,
    ValueGetter<double?>? doubleTapScale,
    ValueGetter<Duration?>? transitionDuration,
    ValueGetter<Duration?>? zoomDuration,
    ValueGetter<bool?>? showThumbnails,
    ValueGetter<bool?>? showCounter,
    ValueGetter<EdgeInsetsGeometry?>? captionPadding,
  }) {
    return ImageLightboxTheme(
      themeDensity: themeDensity,
      themeSpacing: themeSpacing,
      themeShadows: themeShadows,
      barrierColor: barrierColor == null ? this.barrierColor : barrierColor(),
      surfaceColor: surfaceColor == null ? this.surfaceColor : surfaceColor(),
      foreground: foreground == null ? this.foreground : foreground(),
      mutedForeground:
          mutedForeground == null ? this.mutedForeground : mutedForeground(),
      closeButtonColor:
          closeButtonColor == null ? this.closeButtonColor : closeButtonColor(),
      closeButtonBackground: closeButtonBackground == null
          ? this.closeButtonBackground
          : closeButtonBackground(),
      thumbnailBorderRadius: thumbnailBorderRadius == null
          ? this.thumbnailBorderRadius
          : thumbnailBorderRadius(),
      thumbnailBorderWidth: thumbnailBorderWidth == null
          ? this.thumbnailBorderWidth
          : thumbnailBorderWidth(),
      thumbnailBorderColor: thumbnailBorderColor == null
          ? this.thumbnailBorderColor
          : thumbnailBorderColor(),
      thumbnailHeight:
          thumbnailHeight == null ? this.thumbnailHeight : thumbnailHeight(),
      minScale: minScale == null ? this.minScale : minScale(),
      maxScale: maxScale == null ? this.maxScale : maxScale(),
      doubleTapScale:
          doubleTapScale == null ? this.doubleTapScale : doubleTapScale(),
      transitionDuration:
          transitionDuration == null ? this.transitionDuration : transitionDuration(),
      zoomDuration: zoomDuration == null ? this.zoomDuration : zoomDuration(),
      showThumbnails:
          showThumbnails == null ? this.showThumbnails : showThumbnails(),
      showCounter: showCounter == null ? this.showCounter : showCounter(),
      captionPadding:
          captionPadding == null ? this.captionPadding : captionPadding(),
    );
  }

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  ImageLightboxTheme merge(ImageLightboxTheme? fallback) {
    if (fallback == null) {
      return this;
    }
    return ImageLightboxTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      barrierColor: barrierColor ?? fallback.barrierColor,
      surfaceColor: surfaceColor ?? fallback.surfaceColor,
      foreground: foreground ?? fallback.foreground,
      mutedForeground: mutedForeground ?? fallback.mutedForeground,
      closeButtonColor: closeButtonColor ?? fallback.closeButtonColor,
      closeButtonBackground:
          closeButtonBackground ?? fallback.closeButtonBackground,
      thumbnailBorderRadius:
          thumbnailBorderRadius ?? fallback.thumbnailBorderRadius,
      thumbnailBorderWidth:
          thumbnailBorderWidth ?? fallback.thumbnailBorderWidth,
      thumbnailBorderColor:
          thumbnailBorderColor ?? fallback.thumbnailBorderColor,
      thumbnailHeight: thumbnailHeight ?? fallback.thumbnailHeight,
      minScale: minScale ?? fallback.minScale,
      maxScale: maxScale ?? fallback.maxScale,
      doubleTapScale: doubleTapScale ?? fallback.doubleTapScale,
      transitionDuration: transitionDuration ?? fallback.transitionDuration,
      zoomDuration: zoomDuration ?? fallback.zoomDuration,
      showThumbnails: showThumbnails ?? fallback.showThumbnails,
      showCounter: showCounter ?? fallback.showCounter,
      captionPadding: captionPadding ?? fallback.captionPadding,
    );
  }

  /// Discrete fields step at t < 0.5, matching the other component themes.
  static ImageLightboxTheme lerp(
    ImageLightboxTheme a,
    ImageLightboxTheme b,
    double t,
  ) {
    return ImageLightboxTheme(
      themeDensity: t < 0.5 ? a.themeDensity : b.themeDensity,
      themeSpacing: t < 0.5 ? a.themeSpacing : b.themeSpacing,
      themeShadows: t < 0.5 ? a.themeShadows : b.themeShadows,
      barrierColor: t < 0.5 ? a.barrierColor : b.barrierColor,
      surfaceColor: t < 0.5 ? a.surfaceColor : b.surfaceColor,
      foreground: t < 0.5 ? a.foreground : b.foreground,
      mutedForeground: t < 0.5 ? a.mutedForeground : b.mutedForeground,
      closeButtonColor: t < 0.5 ? a.closeButtonColor : b.closeButtonColor,
      closeButtonBackground:
          t < 0.5 ? a.closeButtonBackground : b.closeButtonBackground,
      thumbnailBorderRadius:
          t < 0.5 ? a.thumbnailBorderRadius : b.thumbnailBorderRadius,
      thumbnailBorderWidth:
          t < 0.5 ? a.thumbnailBorderWidth : b.thumbnailBorderWidth,
      thumbnailBorderColor:
          t < 0.5 ? a.thumbnailBorderColor : b.thumbnailBorderColor,
      thumbnailHeight: t < 0.5 ? a.thumbnailHeight : b.thumbnailHeight,
      minScale: t < 0.5 ? a.minScale : b.minScale,
      maxScale: t < 0.5 ? a.maxScale : b.maxScale,
      doubleTapScale: t < 0.5 ? a.doubleTapScale : b.doubleTapScale,
      transitionDuration: t < 0.5 ? a.transitionDuration : b.transitionDuration,
      zoomDuration: t < 0.5 ? a.zoomDuration : b.zoomDuration,
      showThumbnails: t < 0.5 ? a.showThumbnails : b.showThumbnails,
      showCounter: t < 0.5 ? a.showCounter : b.showCounter,
      captionPadding: t < 0.5 ? a.captionPadding : b.captionPadding,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ImageLightboxTheme &&
        other.themeDensity == themeDensity &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.barrierColor == barrierColor &&
        other.surfaceColor == surfaceColor &&
        other.foreground == foreground &&
        other.mutedForeground == mutedForeground &&
        other.closeButtonColor == closeButtonColor &&
        other.closeButtonBackground == closeButtonBackground &&
        other.thumbnailBorderRadius == thumbnailBorderRadius &&
        other.thumbnailBorderWidth == thumbnailBorderWidth &&
        other.thumbnailBorderColor == thumbnailBorderColor &&
        other.thumbnailHeight == thumbnailHeight &&
        other.minScale == minScale &&
        other.maxScale == maxScale &&
        other.doubleTapScale == doubleTapScale &&
        other.transitionDuration == transitionDuration &&
        other.zoomDuration == zoomDuration &&
        other.showThumbnails == showThumbnails &&
        other.showCounter == showCounter &&
        other.captionPadding == captionPadding;
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[
    themeDensity,
    themeSpacing,
    themeShadows,
    barrierColor,
    surfaceColor,
    foreground,
    mutedForeground,
    closeButtonColor,
    closeButtonBackground,
    thumbnailBorderRadius,
    thumbnailBorderWidth,
    thumbnailBorderColor,
    thumbnailHeight,
    minScale,
    maxScale,
    doubleTapScale,
    transitionDuration,
    zoomDuration,
    showThumbnails,
    showCounter,
    captionPadding,
  ]);
}

/// Token-derived baseline; every unset override field falls through here.
///
/// `thumbnailBorderRadius` stays null so it resolves from the ambient radius
/// token rather than freezing a value here.
const ImageLightboxTheme imageLightboxDefaults = ImageLightboxTheme(
  barrierColor: ThemedColor.value(Color(0x99000000)),
  surfaceColor: ThemedColor.ref(ColorRef.background),
  foreground: ThemedColor.ref(ColorRef.foreground),
  mutedForeground: ThemedColor.ref(ColorRef.mutedForeground),
  closeButtonColor: ThemedColor.ref(ColorRef.foreground),
  closeButtonBackground: ThemedColor.ref(ColorRef.background),
  thumbnailBorderWidth: 2,
  thumbnailBorderColor: ThemedColor.ref(ColorRef.accent),
  thumbnailHeight: 56,
  minScale: 1,
  maxScale: 4,
  doubleTapScale: 2,
  transitionDuration: Duration(milliseconds: 250),
  zoomDuration: kDefaultDuration,
  showThumbnails: true,
  showCounter: true,
  captionPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
);
