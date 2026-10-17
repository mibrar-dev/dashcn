// Guaranteed minimum tap target: centers [child] in a [minWidth] x
// [minHeight] box (48x48 by default) on touch platforms.
//
// Desktop kits size controls at 28-40 px; touch platforms require 44x44
// (iOS) or 48x48 (Android). This wrapper grows the *layout* with transparent
// space around an unchanged visual, so the painted control never changes and
// desktop layouts are pixel-identical (it returns [child] unchanged off
// touch platforms and under `TouchTargets.shrinkWrap`, exactly like
// `TouchHitArea`).
//
// Place it *inside* the pressable (as the `Clickable`/`GestureDetector`
// child, wrapping the visual) so the pressable's own hit box — and therefore
// the reported semantics tap target — grows to the minimum. Wrapping outside
// the pressable only pads the parent: the inner tappable node stays small
// and assistive tech would announce a target that misses real taps.
//
// Unlike `TouchHitArea` (fixed per-side padding the caller sizes for one
// known child), the minimum holds for any child size or density scale:
// smaller visuals centre in the minimum box, larger ones pass through.

import 'package:flutter/widgets.dart';

import '../foundation/platform.dart';
import '../theme/theme.dart';

/// Centres [child] in a guaranteed minimum hit area on touch platforms.
///
/// See the library docs for placement rules.
class TapTarget extends StatelessWidget {
  /// Creates a tap target.
  const TapTarget({
    super.key,
    this.minWidth = 48,
    this.minHeight = 48,
    required this.child,
  });

  /// Minimum hit width; children wider than this pass through unchanged.
  final double minWidth;

  /// Minimum hit height; children taller than this pass through unchanged.
  final double minHeight;

  /// The visual, painted at its own size and centred in the minimum box.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).touchTargets == TouchTargets.shrinkWrap) {
      return child;
    }
    if (!isMobile(Theme.of(context).platform)) {
      return child;
    }
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: minWidth, minHeight: minHeight),
      // Factors of 1 shrink-wrap the child (a bare Center would expand to
      // fill a bounded parent, e.g. a Wrap run or stretched row); the
      // incoming minimum still floors the box.
      child: Center(widthFactor: 1, heightFactor: 1, child: child),
    );
  }
}
