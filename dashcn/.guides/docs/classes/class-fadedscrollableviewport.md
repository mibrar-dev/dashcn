---
title: "Class: FadedScrollableViewport"
description: "Fades the leading and trailing edges of [child] while it is scrolled."
---

```dart
/// Fades the leading and trailing edges of [child] while it is scrolled.
///
/// ```dart
/// FadedScrollableViewport(
///   child: SingleChildScrollView(child: content),
/// );
/// ```
class FadedScrollableViewport extends StatefulWidget {
  /// Creates a fade viewport.
  const FadedScrollableViewport({super.key, required this.child, this.fadeExtent, this.fadeSize, this.theme});
  /// The scrollable subtree the fade is drawn over.
  final Widget child;
  /// Scroll distance over which the fade reaches full strength.
  final double? fadeExtent;
  /// Length of the fade gradient.
  final double? fadeSize;
  /// Widget-leg style override, merged on top of the other resolver legs.
  final ScrollableTheme? theme;
  /// Resolves the effective fade geometry for [context].
  ///
  /// Exposed so custom masks can reuse the same four-leg resolution:
  /// `widget argument > ComponentTheme in tree > app overrides > defaults`.
  static ({double fadeExtent, double fadeSize}) resolveGeometry(BuildContext context, {double? fadeExtent, double? fadeSize, ScrollableTheme? theme});
  /// Colour the edge fade blends into: the ambient `background` token, so the
  /// fade follows the selected preset in light and dark.
  ///
  /// Exposed so custom masks can paint the same surface the built-in one does.
  static Color resolveFadeSurface(BuildContext context);
  /// Gradient stops for the fade mask over an axis of [axisExtent].
  ///
  /// Stops are clamped monotonic so short content cannot produce a crossed
  /// gradient. Exposed for custom masks.
  static List<double> gradientStops({required double leading, required double trailing, required double fadeSize, required double axisExtent});
  /// Gradient begin/end alignments for a fade viewport on [axis].
  ///
  /// The old viewport always faded top-to-bottom, so a horizontal scrollable
  /// faded the wrong edges. Exposed for custom masks.
  static ({Alignment begin, Alignment end}) gradientAxis(Axis axis);
  State<FadedScrollableViewport> createState();
}
```
