// The `dot_indicator` component: a row (or column) of animated dots showing
// the active index of a carousel, stepper or pager.
//
// Ported from `components/display/dot_indicator/**` (ten files, four `part`s).
// Fixes, all verified against the old source:
//   * `DotItem` (the only *animated* dot widget) had **zero** readers; the
//     `ActiveDotItem` / `InactiveDotItem` pair the indicator actually built was
//     made of plain `Container`s, so changing the index jumped instantly
//     despite the component's name. The dots animate between their rows now.
//   * `mouseCursor: WidgetStatePropertyAll(SystemMouseCursors.click)` was
//     installed even when `onChanged` was null, so a read-only indicator showed
//     a click cursor and swallowed taps no handler answered.
//   * `resolvedPadding` was multiplied by `theme.scaling` *after* it had been
//     resolved, so a caller-provided `padding` was silently inflated.
//   * `IntrinsicHeight` + `Flex(crossAxisAlignment: stretch)` around `Flexible`
//     children forced an O(n^2) intrinsic pass for a fixed-size row.
//   * Only `ComponentTheme.maybeOf` was read, so app-wide overrides never
//     applied, and there were no token-derived defaults at all.
//   * P7-WB: the dot fill lived on the `Clickable` decoration while the theme
//     gap was faked with `Clickable` *padding* — the fill painted over the
//     padding, so neighbouring dots touched (no visible gap) and the merged
//     fill read as one pill. The fill lives on the inner dot now; the padding
//     stays transparent tap target, and both modes separate dot edges by
//     exactly the theme gap.

import 'package:flutter/widgets.dart';

import '../../foundation/data.dart';
import '../../primitives/clickable.dart';
import '../../primitives/widget_states.dart';
import '../../theme/color_tokens.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import 'dot_indicator_style.dart';

export 'dot_indicator_style.dart';

/// Builds a custom dot.
///
/// The default builder paints the active/inactive [DotStyle] rows; supply this
/// to draw your own marker.
typedef DotBuilder =
    Widget Function(BuildContext context, int index, bool isActive);

/// Navigation indicator with a row or column of animated dots.
///
/// ```dart
/// DotIndicator(index: page, length: pages.length, onChanged: goToPage)
/// ```
class DotIndicator extends StatelessWidget {
  /// Creates a dot indicator.
  const DotIndicator({
    super.key,
    required this.index,
    required this.length,
    this.onChanged,
    this.spacing,
    this.direction = Axis.horizontal,
    this.padding,
    this.dotBuilder,
    this.theme,
  }) : assert(length > 0, 'DotIndicator needs at least one dot.');

  /// Index of the active dot; a value outside `0..length - 1` leaves every dot
  /// inactive.
  final int index;

  /// Number of dots.
  final int length;

  /// Called with the tapped index. Null makes the indicator read-only: no
  /// `Clickable` and no click cursor are built.
  final ValueChanged<int>? onChanged;

  /// Gap between two dots; null uses [DotIndicatorTheme.spacing] then the
  /// ambient `spacing.sm` (upstream `gap-2`), density-aware and scaled.
  final double? spacing;

  /// Axis of the run of dots.
  final Axis direction;

  /// Padding around the run of dots; null uses [DotIndicatorTheme.padding] then
  /// [dotIndicatorDefaultPadding]. It is applied once, to the run, never per
  /// dot.
  final EdgeInsetsGeometry? padding;

  /// Custom dot builder; null paints the theme rows.
  final DotBuilder? dotBuilder;

  /// Widget-leg theme override, merged on top of the other legs.
  final DotIndicatorTheme? theme;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    final DotIndicatorTheme resolved =
        resolveComponentStyle<DotIndicatorTheme, DotIndicatorTheme>(
          context,
          widget: theme,
          select: (t) => t,
          defaults: dotIndicatorDefaults,
        );
    final double gap =
        spacing ?? resolved.spacing ?? appTheme.spacing.sm * appTheme.scaling;
    // Resolved once: the old code re-resolved and re-scaled it per dot, and
    // multiplied it by `scaling` after resolution, so a caller-provided
    // `padding` was silently inflated. A plain `EdgeInsets` override passes
    // through `resolveEdgeInsets` unchanged.
    final EdgeInsets outer = resolveEdgeInsets(
      padding ?? resolved.padding ?? dotIndicatorDefaultPadding,
      appTheme.density.baseContentPadding * appTheme.scaling,
    ).resolve(Directionality.of(context));

    final List<Widget> dots = <Widget>[
      for (int i = 0; i < length; i++)
        _dot(context, appTheme, resolved, i, gap),
    ];
    // The visual gap is exactly the theme gap in both modes. An interactive
    // dot carries half the gap as transparent `Clickable` padding on each
    // side (a bigger tap target that meets its neighbour mid-gap), so the
    // run needs no spacers; read-only dots have no padding, so they keep a
    // spacer of the full gap.
    final double separator = onChanged == null ? gap : 0;
    final Widget run = direction == Axis.horizontal
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: _spaced(dots, SizedBox(width: separator)),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: _spaced(dots, SizedBox(height: separator)),
          );
    return Padding(padding: outer, child: run);
  }

  /// Inserts [separator] between every pair of [items].
  static List<Widget> _spaced(List<Widget> items, Widget separator) {
    if (items.length < 2) {
      return items;
    }
    return <Widget>[
      for (int i = 0; i < items.length; i++) ...<Widget>[
        if (i > 0) separator,
        items[i],
      ],
    ];
  }

  Widget _dot(
    BuildContext context,
    ThemeData appTheme,
    DotIndicatorTheme theme,
    int position,
    double gap,
  ) {
    final bool isActive = position == index;
    final DotStyle style =
        theme.forIndex(isActive) ?? DotIndicatorDefaults.forIndex(isActive);
    final double size = style.size ?? 12 * appTheme.scaling;

    // A custom builder replaces the default dot wholesale.
    final Widget mark = dotBuilder != null
        ? dotBuilder!(context, position, isActive)
        : _StateDot(
            style: style,
            size: size,
            duration: theme.duration!,
            colors: appTheme.colors,
            scaling: appTheme.scaling,
          );
    if (onChanged == null) {
      // A read-only indicator must neither look nor behave pressable.
      return Semantics(
        selected: isActive,
        label: 'Page ${position + 1} of $length',
        child: mark,
      );
    }
    return Semantics(
      selected: isActive,
      label: 'Page ${position + 1} of $length',
      child: Clickable(
        behavior: HitTestBehavior.translucent,
        onPressed: () => onChanged!(position),
        mouseCursor: const WidgetStatePropertyAll<MouseCursor>(
          SystemMouseCursors.click,
        ),
        // Transparent tap target: half the gap on each side meets the
        // neighbour mid-gap without changing the visual gap. The fill lives
        // on the inner dot — never on this decoration — so the padding is
        // never painted over (P7-WB: the old fill-over-padding fused the
        // dots into one pill).
        padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.all(gap / 2),
        ),
        child: mark,
      ),
    );
  }
}

/// A dot whose fill resolves from the ambient interaction states.
///
/// Lets the hovered/pressed/focused rows tint the dot while the fill stays
/// exactly dot-sized: the states come from the enclosing `Clickable`'s
/// `WidgetStatesProvider`, and a read-only run (no provider above) falls
/// back to the rest row.
class _StateDot extends StatelessWidget {
  const _StateDot({
    required this.style,
    required this.size,
    required this.duration,
    required this.colors,
    required this.scaling,
  });

  final DotStyle style;
  final double size;
  final Duration duration;
  final ThemeColors colors;
  final double scaling;

  @override
  Widget build(BuildContext context) {
    final Set<WidgetState> states =
        Data.maybeOf<WidgetStatesData>(context)?.states ??
        const <WidgetState>{};
    return _DotBox(
      size: size,
      duration: duration,
      decoration: _dotDecoration(style, states, colors, scaling),
    );
  }
}

/// A square dot whose size and fill animate between the theme rows.
class _DotBox extends StatelessWidget {
  const _DotBox({required this.size, required this.duration, this.decoration});

  final double size;
  final Duration duration;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      curve: Curves.easeOut,
      width: size,
      height: size,
      decoration: decoration,
    );
  }
}

/// The decoration for [style] in [states].
BoxDecoration _dotDecoration(
  DotStyle style,
  Set<WidgetState> states,
  ThemeColors colors,
  double scaling,
) {
  final double size = style.size ?? 12 * scaling;
  final Color? outline = style.borderColor?.resolve(states)?.resolve(colors);
  final double borderWidth = style.borderWidth ?? 0;
  return BoxDecoration(
    color: style.background?.resolve(states)?.resolve(colors),
    borderRadius: style.borderRadius ?? BorderRadius.circular(size / 2),
    border: outline != null && borderWidth > 0
        ? Border.all(color: outline, width: borderWidth)
        : null,
  );
}

/// The token-derived rows of [dotIndicatorDefaults], for callers that paint
/// their own dots instead of using the default builder.
abstract final class DotIndicatorDefaults {
  /// The active row.
  static DotStyle get active => dotIndicatorDefaults.active!;

  /// The inactive row.
  static DotStyle get inactive => dotIndicatorDefaults.inactive!;

  /// The row that matches [isActive].
  static DotStyle forIndex(bool isActive) =>
      isActive ? dotIndicatorDefaults.active! : dotIndicatorDefaults.inactive!;
}
