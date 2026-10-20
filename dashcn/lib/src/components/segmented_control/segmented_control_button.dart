// The pickable segment of the `segmented_control` component.
//
// [SegmentedControlButton] is the button one segment paints; it carries the
// segment's content, its selection state and the roving focus. The segment
// model itself lives in `segmented_control_segment.dart`.

import 'package:flutter/widgets.dart';

import '../../foundation/data.dart';
import '../../primitives/clickable.dart';
import '../../primitives/measured_extent.dart';
import '../../primitives/roving_group.dart';
import '../../theme/color_tokens.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import 'segmented_control_segment.dart';

/// Builds the row of segment buttons of a segmented control.
///
/// Every segment is measured with [MeasuredExtent] so the thumb can be
/// placed on it; the measurement is reported through [onExtent]. [isEnabled]
/// decides whether a segment can be picked and [onSelect] reports the pick.
List<Widget> buildSegmentedControlRow<T>({
  required List<SegmentedControlSegment<T>> segments,
  required Set<T> selection,
  required bool single,
  required SegmentedControlStyle style,
  required double iconSize,
  required double gap,
  required bool expand,
  required SegmentedControlSegmentBuilder<T>? segmentBuilder,
  required bool Function(SegmentedControlSegment<T> segment) isEnabled,
  required void Function(T value, {required bool enabled}) onSelect,
  required void Function(int index, double extent) onExtent,
}) {
  final List<Widget> row = <Widget>[];
  for (int i = 0; i < segments.length; i++) {
    final SegmentedControlSegment<T> segment = segments[i];
    if (i > 0 && gap > 0) {
      row.add(SizedBox(width: gap));
    }
    final bool enabled = isEnabled(segment);
    final bool selected = selection.contains(segment.value);
    final Widget button = SegmentedControlButton<T>(
      segment: segment,
      index: i,
      selected: selected,
      enabled: enabled,
      single: single,
      onPressed: () => onSelect(segment.value, enabled: enabled),
      style: style,
      iconSize: iconSize,
      gap: gap,
      segmentBuilder: segmentBuilder,
      semanticLabel: segment.semanticLabel,
    );
    final Widget measured = MeasuredExtent(
      axis: Axis.horizontal,
      onExtent: (double extent) => onExtent(i, extent),
      content: button,
    );
    row.add(expand ? Expanded(child: measured) : measured);
  }
  return row;
}

/// One pickable segment of a segmented control.
class SegmentedControlButton<T> extends StatefulWidget {
  /// Creates a segment button.
  const SegmentedControlButton({
    super.key,
    required this.segment,
    required this.index,
    required this.selected,
    required this.enabled,
    required this.single,
    required this.onPressed,
    required this.style,
    required this.iconSize,
    required this.gap,
    this.segmentBuilder,
    this.semanticLabel,
    this.focusNode,
  });

  /// The segment this button stands for.
  final SegmentedControlSegment<T> segment;

  /// The segment's position in the control.
  final int index;

  /// Whether the segment is part of the selection.
  final bool selected;

  /// Whether the segment can be picked.
  final bool enabled;

  /// Whether the control selects one segment at a time.
  final bool single;

  /// Called when the segment is picked.
  final VoidCallback onPressed;

  /// The resolved segment style.
  final SegmentedControlStyle style;

  /// The icon size.
  final double iconSize;

  /// The gap between the icon and the label.
  final double gap;

  /// Builder slot for the segment's content.
  final SegmentedControlSegmentBuilder<T>? segmentBuilder;

  /// Accessible name of the segment.
  final String? semanticLabel;

  /// Focus node. A node is created internally when null.
  final FocusNode? focusNode;

  @override
  State<SegmentedControlButton<T>> createState() =>
      _SegmentedControlButtonState<T>();
}

class _SegmentedControlButtonState<T> extends State<SegmentedControlButton<T>> {
  final WidgetStatesController _states = WidgetStatesController();
  FocusNode? _ownedFocusNode;
  RovingGroupRegistry<T>? _registry;

  FocusNode get _focusNode =>
      widget.focusNode ?? (_ownedFocusNode ??= FocusNode());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _registry = Data.maybeOf<RovingGroupRegistry<T>>(context);
  }

  @override
  void dispose() {
    _registry?.unregister(this);
    _ownedFocusNode?.dispose();
    _states.dispose();
    super.dispose();
  }

  void _register() {
    final RovingGroupRegistry<T>? registry = _registry;
    if (registry == null) {
      return;
    }
    registry.register(
      RovingItem<T>(
        key: this,
        value: widget.segment.value,
        enabled: widget.enabled,
        selected: widget.selected,
        requestFocus: () => _focusNode.requestFocus(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _register();
    final ThemeData ambient = Theme.of(context);
    final SegmentedControlScope? scope = Data.maybeOf<SegmentedControlScope>(
      context,
    );
    final SegmentedControlStyle style = widget.style;
    final bool selected = widget.selected;
    final bool enabled = widget.enabled;

    Color? colorFor(StateValue<ThemedColor>? value, Set<WidgetState> states) {
      return value?.resolve(states)?.resolve(ambient.colors);
    }

    final String? label = widget.semanticLabel ?? _labelText;
    final Widget content = _content(context, label);
    final Widget button = Semantics(
      button: true,
      enabled: enabled,
      selected: widget.single ? selected : null,
      checked: widget.single ? null : selected,
      inMutuallyExclusiveGroup: widget.single ? true : null,
      label: label,
      child: Opacity(
        opacity: enabled ? 1 : 0.5,
        child: Clickable(
          enabled: enabled,
          statesController: _states,
          onPressed: enabled ? widget.onPressed : null,
          focusNode: _focusNode,
          shortcuts: scope?.shortcuts,
          actions: scope?.actions,
          mouseCursor: const StateValue<MouseCursor>(
            rest: SystemMouseCursors.click,
            disabled: SystemMouseCursors.basic,
          ),
          decoration: const WidgetStatePropertyAll<Decoration?>(null),
          textStyle: WidgetStateProperty.resolveWith((Set<WidgetState> s) {
            final Color? color = colorFor(
              selected ? style.selectedForeground : style.foreground,
              s,
            );
            return (style.textStyle ?? segmentedControlDefaultTextStyle)
                .copyWith(color: color);
          }),
          iconTheme: WidgetStateProperty.resolveWith((Set<WidgetState> s) {
            final Color? color = colorFor(
              selected ? style.selectedForeground : style.foreground,
              s,
            );
            return IconThemeData(color: color, size: widget.iconSize);
          }),
          padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
            _segmentPadding(context, style),
          ),
          child: content,
        ),
      ),
    );
    return button;
  }

  Widget _content(BuildContext context, String? semanticLabel) {
    final SegmentedControlSegmentBuilder<T>? builder = widget.segmentBuilder;
    final Widget inner;
    if (builder != null) {
      inner = builder(
        context,
        widget.segment,
        selected: widget.selected,
        enabled: widget.enabled,
      );
    } else {
      final Widget? icon = widget.segment.icon;
      final Widget? label = widget.segment.label;
      if (icon == null && label == null) {
        inner = const SizedBox.shrink();
      } else if (icon == null) {
        inner = label!;
      } else if (label == null) {
        inner = icon;
      } else {
        inner = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            icon,
            SizedBox(width: widget.gap),
            label,
          ],
        );
      }
    }
    // The segment's own name is announced once: the explicit label replaces
    // the text's own semantics instead of doubling it.
    final Widget content = semanticLabel == null
        ? inner
        : ExcludeSemantics(child: inner);
    return Center(child: content);
  }

  EdgeInsetsGeometry _segmentPadding(
    BuildContext context,
    SegmentedControlStyle style,
  ) {
    final ThemeData ambient = Theme.of(context);
    return resolveEdgeInsets(
      style.segmentPadding ?? const EdgeInsets.symmetric(horizontal: 8),
      ambient.density.baseContentPadding * ambient.scaling,
    );
  }

  /// The label's text when the label is a plain `Text`; else null.
  String? get _labelText {
    final Widget? label = widget.segment.label;
    if (label is Text) {
      return label.data;
    }
    return null;
  }
}
