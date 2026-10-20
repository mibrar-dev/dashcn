// The `segmented_control` component: [SegmentedControl], a row of mutually
// exclusive (or multi-selectable) choices with a sliding thumb.
//
// A segmented control is *not* a tab strip: it selects a value, it does not
// own content. Use `Tabs` for navigation and `Toolbar` for actions.
//
// The thumb slides between the segments with the theme motion tokens and
// collapses to zero under reduced motion.

import 'package:flutter/widgets.dart';

import '../../foundation/data.dart';
import '../../primitives/roving_group.dart';
import '../../theme/theme.dart';
import 'segmented_control_keys.dart';
import 'segmented_control_button.dart';
import 'segmented_control_metrics.dart';
import 'segmented_control_segment.dart';
import 'segmented_control_selection.dart';
import 'segmented_control_thumb.dart';

export 'segmented_control_button.dart';
export 'segmented_control_keys.dart';
export 'segmented_control_metrics.dart';
export 'segmented_control_segment.dart';
export 'segmented_control_selection.dart';
export 'segmented_control_thumb.dart';
export 'segmented_control_style.dart';

/// A row of choices with a sliding thumb.
///
/// Three modes:
/// * single, controlled — pass [value] and [onChanged];
/// * multiple, controlled — pass [values] and [onValuesChanged];
/// * uncontrolled — pass a [controller]; the control owns the selection.
class SegmentedControl<T> extends StatefulWidget {
  /// Creates a segmented control.
  const SegmentedControl({
    super.key,
    required this.segments,
    this.selection = SegmentedControlSelection.single,
    this.value,
    this.onChanged,
    this.values,
    this.onValuesChanged,
    this.controller,
    this.size = SegmentedControlSize.md,
    this.expand = false,
    this.disabledValues = const <Never>{},
    this.segmentBuilder,
    this.style,
    this.theme,
  }) : assert(
         controller == null ||
             (value == null &&
                 onChanged == null &&
                 values == null &&
                 onValuesChanged == null),
         'A controller-driven segmented control must not also receive '
         'value/onChanged/values/onValuesChanged',
       ),
       assert(
         selection != SegmentedControlSelection.single ||
             (values == null && onValuesChanged == null),
         'A single-select segmented control uses value/onChanged, '
         'not values/onValuesChanged',
       ),
       assert(
         selection != SegmentedControlSelection.multiple ||
             (value == null && onChanged == null),
         'A multiple-select segmented control uses values/onValuesChanged, '
         'not value/onChanged',
       ),
       assert(
         value == null || onChanged != null,
         'A controlled segmented control needs onChanged',
       ),
       assert(
         values == null || onValuesChanged != null,
         'A controlled segmented control needs onValuesChanged',
       );

  /// The choices of the control.
  final List<SegmentedControlSegment<T>> segments;

  /// Whether one or many segments are selected at once.
  final SegmentedControlSelection selection;

  /// The selected value in single, controlled mode.
  final T? value;

  /// Called with the next value in single, controlled mode.
  final ValueChanged<T>? onChanged;

  /// The selected values in multiple, controlled mode.
  final Set<T>? values;

  /// Called with the next selection in multiple, controlled mode.
  final ValueChanged<Set<T>>? onValuesChanged;

  /// Uncontrolled mode: the controller owns the selection.
  final SegmentedControlController<T>? controller;

  /// Fixed size of the control.
  final SegmentedControlSize size;

  /// Whether the control fills the width it is given.
  final bool expand;

  /// Values that cannot be picked, on top of each segment's own flag.
  final Set<T> disabledValues;

  /// Builder slot for the segments' content.
  final SegmentedControlSegmentBuilder<T>? segmentBuilder;

  /// Widget-leg style override for the whole control.
  final SegmentedControlStyle? style;

  /// Generic widget-leg style override, merged under [style].
  final SegmentedControlStyle? theme;

  @override
  State<SegmentedControl<T>> createState() => _SegmentedControlState<T>();
}

class _SegmentedControlState<T> extends State<SegmentedControl<T>> {
  final RovingGroupRegistry<T> _registry = RovingGroupRegistry<T>();
  late final SegmentedControlWidths _widths = SegmentedControlWidths(
    onChanged: () {
      if (mounted) {
        setState(() {});
      }
    },
  );
  Set<T> _internal = <T>{};

  bool get _single => widget.selection == SegmentedControlSelection.single;

  @override
  void initState() {
    super.initState();
    _internal = _single
        ? segmentedControlInitialSelection<T>(
            widget.segments,
            widget.disabledValues,
          )
        : <T>{};
  }

  /// The current selection, whichever mode the control runs in.
  Set<T> get _selection {
    return segmentedControlSelection<T>(
      single: _single,
      fallback: _internal,
      controllerValue: widget.controller?.value,
      value: widget.value,
      onChanged: widget.onChanged,
      values: widget.values,
      onValuesChanged: widget.onValuesChanged,
    );
  }

  bool _isEnabled(SegmentedControlSegment<T> segment) {
    return segmentedControlIsEnabled<T>(segment, widget.disabledValues);
  }

  void _select(T value, {required bool enabled}) {
    if (!enabled) {
      return;
    }
    final SegmentedControlController<T>? controller = widget.controller;
    if (controller != null) {
      if (_single) {
        controller.select(value, single: true);
      } else {
        controller.toggle(value);
      }
      return;
    }
    if (_single) {
      if (widget.onChanged != null) {
        widget.onChanged!.call(value);
        return;
      }
      setState(() => _internal = <T>{value});
      return;
    }
    final Set<T> next = segmentedControlToggled<T>(_selection, value);
    if (widget.onValuesChanged != null) {
      widget.onValuesChanged!.call(next);
      return;
    }
    setState(() => _internal = next);
  }

  @override
  Widget build(BuildContext context) {
    final SegmentedControlTheme resolved = resolveSegmentedControlTheme(
      context: context,
      style: widget.style,
      theme: widget.theme,
    );
    final SegmentedControlStyle controlStyle = resolved.control!;
    final SegmentedControlStyle segmentStyle = resolved.segment!;
    final SegmentedControlMetrics metrics = segmentedControlMetrics(
      context: context,
      controlStyle: controlStyle,
      segmentStyle: segmentStyle,
      size: widget.size,
    );
    final double iconSize = metrics.iconSize;
    final double gap = metrics.gap;
    final EdgeInsets padding = metrics.padding;
    final bool rtl = Directionality.of(context) == TextDirection.rtl;

    _registry.direction = Axis.horizontal;
    // The arrow keys walk the segments and pick them, like a radio group.
    _registry.onSelect = (T value) {
      final SegmentedControlSegment<T>? segment = segmentedControlSegmentFor<T>(
        widget.segments,
        value,
      );
      if (segment != null) {
        _select(value, enabled: _isEnabled(segment));
      }
    };

    final Set<T> selection = _selection;
    final List<SegmentedControlSegment<T>> segments = widget.segments;
    // The thumb is positioned from the measured segment widths. Until every
    // segment has been measured there is nothing to place, so the thumb is
    // held back for the one frame it takes; it then appears straight on its
    // segment instead of sliding in from the control's edge.
    final bool measured = _widths.length >= segments.length;

    final List<Widget> row = buildSegmentedControlRow<T>(
      segments: segments,
      selection: selection,
      single: _single,
      style: segmentStyle,
      iconSize: iconSize,
      gap: gap,
      expand: widget.expand,
      segmentBuilder: widget.segmentBuilder,
      isEnabled: _isEnabled,
      onSelect: _select,
      onExtent: _widths.report,
    );

    // The painted track keeps the requested height on every platform. Touch
    // platforms grow the control's *box* to the platform tap minimum so every
    // segment stays a 48 px target; the growth is transparent space around
    // the track, never a change of the painted control.
    final double trackHeight = metrics.trackHeight;
    final double boxHeight = metrics.boxHeight;
    final double margin = metrics.margin;

    final Widget line = Row(
      mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: row,
    );

    final BorderRadiusGeometry radius =
        controlStyle.borderRadius ?? Theme.of(context).borderRadiusMd;

    // The track is its own layer: it paints at [trackHeight] and is centred in
    // the control's box, so the touch growth stays invisible.
    final Widget track = buildSegmentedControlTrack(
      context: context,
      style: controlStyle,
      height: trackHeight,
      radius: radius,
    );

    final Widget stack = buildSegmentedControlStack<T>(
      context: context,
      style: controlStyle,
      selection: selection,
      segments: segments,
      widths: _widths.values,
      margin: margin,
      boxHeight: boxHeight,
      rtl: rtl,
      measured: measured,
      track: track,
      line: line,
    );

    final Widget surface = Padding(padding: padding, child: stack);

    return RovingGroupScope<T>(
      registry: _registry,
      child: Data<SegmentedControlScope>.inherit(
        data: SegmentedControlScope(
          shortcuts: segmentedControlShortcuts(rtl),
          actions: segmentedControlActions<T>(_registry),
        ),
        child: surface,
      ),
    );
  }
}
