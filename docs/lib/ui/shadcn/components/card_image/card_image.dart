// The `card_image` component: [CardImage], a pressable card pairing an image
// with the `Basic` leading/title/subtitle/trailing composition.
//
// Ported from `components/layout/card_image/**` (a barrel plus two `part`s).
// Fixes, all verified against the old source:
//   * `card_image.dart` imported `package:flutter/material.dart` for `Axis` and
//     `Colors` — banned. `Axis` comes from `widgets.dart`; the transparent
//     defaults are alpha-0 token refs.
//   * The old default style was `ButtonStyle.fixed(density: compact)`, a
//     removed variant. The card runs on `ButtonSize.icon` (chrome-free, zero
//     padding, no forced text style) with the `cardImageButtonStyle` leg, which
//     matches the old fixed look.
//   * `_CardImageState` created a `WidgetStatesController` and never disposed
//     it. The hover state is driven by `Button.onHover` now; no controller.
//   * P7-WB: the content was wrapped in `IntrinsicWidth` so the card collapsed
//     to the title's intrinsic width — a tall thin bar even inside a bounded
//     box. The vertical image surface keeps the theme `aspectRatio` (16/9)
//     and fills the card width now; the intrinsic wrapper is gone.

import 'package:flutter/widgets.dart';

import '../../foundation/constants.dart';
import '../../foundation/gap.dart';
import '../../primitives/layout.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import '../outlined_container/outlined_container.dart';
import 'card_image_style.dart';

export 'card_image_style.dart';

/// An interactive card with an image and an optional text block.
///
/// ```dart
/// CardImage(
///   image: Image.network(url),
///   title: const Text('Sunset'),
///   subtitle: const Text('18:42'),
///   onPressed: open,
/// );
/// ```
class CardImage extends StatefulWidget {
  /// Creates a card image.
  const CardImage({
    super.key,
    required this.image,
    this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.onPressed,
    this.enabled,
    this.focusNode,
    this.autofocus = false,
    this.theme,
  });

  /// The image (or any widget) shown in the image surface.
  final Widget image;

  /// Title passed to the [Basic] text block.
  final Widget? title;

  /// Subtitle passed to the [Basic] text block.
  final Widget? subtitle;

  /// Trailing widget passed to the [Basic] text block.
  final Widget? trailing;

  /// Leading widget passed to the [Basic] text block.
  final Widget? leading;

  /// Called on tap. When null the card is disabled unless [enabled] is true.
  final VoidCallback? onPressed;

  /// Overrides the enabled state; null means `onPressed != null`.
  final bool? enabled;

  /// Focus node of the card. The card creates and owns one when this is null.
  final FocusNode? focusNode;

  /// Whether the card requests focus when first built.
  final bool autofocus;

  /// Widget-leg override, merged over the component/app/defaults legs.
  final CardImageTheme? theme;

  @override
  State<CardImage> createState() => _CardImageState();
}

class _CardImageState extends State<CardImage> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final CardImageTheme resolved =
        resolveComponentStyle<CardImageTheme, CardImageTheme>(
          context,
          widget: widget.theme,
          select: (t) => t,
          defaults: cardImageDefaults,
        );
    final Axis direction = resolved.direction ?? Axis.vertical;
    final double hoverScale = resolved.hoverScale ?? cardImageDefaultHoverScale;
    final double normalScale = resolved.normalScale ?? 1;
    final double gap = resolved.gap ?? cardImageDefaultGap;
    final double aspectRatio =
        resolved.aspectRatio ?? cardImageDefaultAspectRatio;

    final Widget image = OutlinedContainer(
      backgroundColor: resolved.imageBackground,
      borderColor: resolved.imageBorderColor,
      borderRadius: resolved.imageRadius,
      child: AnimatedScale(
        duration: kDefaultDuration,
        curve: Curves.easeOut,
        scale: _hovered ? hoverScale : normalScale,
        child: widget.image,
      ),
    );

    // Vertical: the image surface keeps the theme aspect ratio and fills the
    // card width, so the card follows a bounded parent instead of collapsing
    // to the text width. (P7-WB: the old `IntrinsicWidth` shrank the card to
    // the title's intrinsic width — a tall thin bar even inside a 220px box.)
    // A fully unbounded parent (both axes loose, e.g. a `Row`) cannot resolve
    // a ratio — `RenderAspectRatio` throws there — so the image keeps its
    // natural size in that case; bound the card's width instead.
    final Widget media = direction == Axis.vertical
        ? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.hasBoundedWidth || constraints.hasBoundedHeight) {
                return AspectRatio(aspectRatio: aspectRatio, child: image);
              }
              return image;
            },
          )
        : image;

    final Widget content = Flex(
      direction: direction,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (direction == Axis.vertical) media else Flexible(child: media),
        Gap(gap),
        Basic(
          title: widget.title,
          subtitle: widget.subtitle,
          trailing: widget.trailing,
          leading: widget.leading,
        ),
      ],
    );

    return Button(
      size: ButtonSize.icon,
      variant: ButtonVariant.ghost,
      theme: cardImageButtonStyle,
      onPressed: widget.onPressed,
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      onHover: _handleHover,
      // Horizontal: the stretched children need a bounded height, which the
      // image's intrinsic height provides (a bare `Row` under an unbounded
      // parent hands `Gap` an infinite height and throws).
      child: direction == Axis.horizontal
          ? IntrinsicHeight(child: content)
          : content,
    );
  }

  void _handleHover(bool hovered) {
    if (_hovered == hovered) {
      return;
    }
    setState(() => _hovered = hovered);
  }
}
