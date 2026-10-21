// [SkeletonMirror]: a builder that mirrors the real child's layout.
//
// While loading, the real [child] is laid out invisibly (no semantics, no
// hit test) and the placeholder fills its exact box, so the loading state
// matches content size with no measurement code at the call site:
//
// ```dart
// SkeletonMirror(
//   enabled: loading,
//   child: ProfileRow(user: user),
//   placeholderBuilder: (context) => const SkeletonList(itemCount: 1),
// );
// ```

import 'package:flutter/widgets.dart';

import '../../theme/density_tokens.dart';
import 'skeleton_style.dart';

/// Builds the placeholder shown while [SkeletonMirror.enabled] is true.
typedef SkeletonMirrorBuilder = Widget Function(BuildContext context);

/// Sizes a placeholder from the real child's box.
class SkeletonMirror extends StatelessWidget {
  /// Creates a layout-mirroring placeholder.
  const SkeletonMirror({
    super.key,
    required this.child,
    required this.placeholderBuilder,
    this.enabled = true,
    this.theme,
    this.style,
    this.densityTokens,
    this.semanticsLabel,
  });

  /// The real content; laid out always, painted only when disabled.
  final Widget child;

  /// Builds the placeholder that fills the child's box.
  final SkeletonMirrorBuilder placeholderBuilder;

  /// Whether the placeholder shows; false paints [child].
  final bool enabled;

  /// Widget-leg theme override, forwarded to the default placeholder.
  final SkeletonTheme? theme;

  /// Per-instance style override.
  final SkeletonStyle? style;

  /// Per-instance density tokens.
  final DensityTokens? densityTokens;

  /// Accessible label; null reads `Loading`.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }
    final Widget placeholder = placeholderBuilder(context);
    return Semantics(
      label: semanticsLabel ?? 'Loading',
      child: Stack(
        children: <Widget>[
          ExcludeSemantics(
            child: IgnorePointer(child: Opacity(opacity: 0, child: child)),
          ),
          Positioned.fill(
            child: ClipRect(
              child: LayoutBuilder(
                builder: (context, constraints) => OverflowBox(
                  alignment: AlignmentDirectional.topStart,
                  minWidth: constraints.maxWidth,
                  maxWidth: constraints.maxWidth,
                  minHeight: 0,
                  maxHeight: double.infinity,
                  child: placeholder,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
