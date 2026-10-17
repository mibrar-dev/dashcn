// The F1 app screen: one component preview placed where it belongs on a
// real device (see `preview.placement` in the component's `meta.json`).
//
// `FramedScreen` is the only child a `DeviceFrame` screen ever shows in
// framed mode: the raw preview widget on the theme `background` (painted by
// `DeviceFrame` itself), laid out inside the device safe area
// (`MediaQuery.padding`, set by the frame from the spec) per the component's
// placement. The docs chrome — the Preview|Code toolbar, the theme toggle,
// the copy button, the dotted `PreviewStage` — never enters the frame.
//
// Overflow contract: the child always sees a bounded width (the safe-area
// width, minus 16 px gutters for `center`), and any content taller than the
// safe area scrolls vertically. Horizontal overflow is never introduced by
// this widget: widths are forced or clamped, never scrolled.

import 'package:flutter/widgets.dart';

import '../../generated/docs_data.dart';

/// Where a component's default preview sits on a real device screen.
///
/// From `meta.json` `preview.placement` (via the manifest into
/// `DocsComponent.placement`); absent means [center].
enum PreviewPlacement {
  /// Small control at its natural size, centred, padded 16 px horizontally.
  center('center'),

  /// Bar pinned under the top safe inset, full safe width.
  top('top'),

  /// Bar pinned above the bottom safe inset, full safe width.
  bottom('bottom'),

  /// Whole-screen content: fills the safe width, scrolls vertically.
  fill('fill'),

  /// Rail pinned to the leading edge, full safe height.
  leading('leading');

  const PreviewPlacement(this.queryValue);

  /// The `meta.json` / manifest / generated-data value.
  final String queryValue;

  /// Parses a placement value; unknown values fall back to [center].
  static PreviewPlacement parse(String? value) {
    for (final PreviewPlacement placement in PreviewPlacement.values) {
      if (placement.queryValue == value) {
        return placement;
      }
    }
    return PreviewPlacement.center;
  }
}

/// The placement of [componentId] from the generated registry data.
PreviewPlacement previewPlacementOf(String componentId) {
  for (final DocsComponent component in kComponents) {
    if (component.id == componentId) {
      return PreviewPlacement.parse(component.placement);
    }
  }
  return PreviewPlacement.center;
}

/// Horizontal gutter around centred previews (F1).
const double kFramedScreenGutter = 16;

/// One component preview placed on the device screen.
///
/// Must be built under a `DeviceFrame` (which supplies the screen `size`
/// and the safe-area `padding` through `MediaQuery`). The widget pads out
/// the safe insets, then positions [child] per [placement] (or the
/// component's generated placement when [placement] is null).
///
/// Test hooks: the safe-area box carries
/// `ValueKey('framed-safe-<componentId>')` and the positioned content unit
/// carries `ValueKey('framed-content-<componentId>')` (see the F1 sweep
/// test).
class FramedScreen extends StatelessWidget {
  /// Creates the placed screen for [componentId] around [child].
  const FramedScreen({
    super.key,
    required this.componentId,
    required this.child,
    this.placement,
  });

  /// The registry component id (namespaces the test keys and resolves the
  /// generated placement when [placement] is null).
  final String componentId;

  /// The raw preview widget (no docs chrome around it).
  final Widget child;

  /// Explicit placement; null reads the generated data.
  final PreviewPlacement? placement;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final EdgeInsets safe = media.padding;
    final double safeWidth = media.size.width - safe.left - safe.right;
    final double safeHeight = media.size.height - safe.top - safe.bottom;
    final PreviewPlacement effective =
        placement ?? previewPlacementOf(componentId);
    return Padding(
      padding: safe,
      child: SizedBox(
        key: ValueKey<String>('framed-safe-$componentId'),
        width: safeWidth,
        height: safeHeight,
        child: _PlacedChild(
          componentId: componentId,
          placement: effective,
          safeWidth: safeWidth,
          safeHeight: safeHeight,
          child: child,
        ),
      ),
    );
  }
}

/// Positions the preview inside the fixed safe-area box.
class _PlacedChild extends StatelessWidget {
  const _PlacedChild({
    required this.componentId,
    required this.placement,
    required this.safeWidth,
    required this.safeHeight,
    required this.child,
  });

  final String componentId;
  final PreviewPlacement placement;
  final double safeWidth;
  final double safeHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // The positioned unit: full safe width for the edge-pinned and
    // screen-filling placements (the child complies with the tight width —
    // parents win over the child's own width, so no horizontal overflow is
    // introduced), a padded natural-size box for centred and rail content.
    final Widget unit = KeyedSubtree(
      key: ValueKey<String>('framed-content-$componentId'),
      child: switch (placement) {
        PreviewPlacement.top ||
        PreviewPlacement.bottom ||
        PreviewPlacement.fill => SizedBox(width: safeWidth, child: child),
        PreviewPlacement.center => Padding(
          padding: const EdgeInsets.symmetric(horizontal: kFramedScreenGutter),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: safeWidth - kFramedScreenGutter * 2,
            ),
            child: child,
          ),
        ),
        PreviewPlacement.leading => ConstrainedBox(
          constraints: BoxConstraints(minHeight: safeHeight),
          child: child,
        ),
      },
    );
    final Alignment alignment = switch (placement) {
      PreviewPlacement.center => Alignment.center,
      PreviewPlacement.top => Alignment.topCenter,
      PreviewPlacement.bottom => Alignment.bottomCenter,
      PreviewPlacement.fill => Alignment.topCenter,
      PreviewPlacement.leading => Alignment.centerLeft,
    };
    // Bounded width (the safe width) with unbounded height: taller content
    // scrolls vertically instead of overflowing the screen.
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: safeWidth, minHeight: safeHeight),
        child: Align(alignment: alignment, child: unit),
      ),
    );
  }
}
