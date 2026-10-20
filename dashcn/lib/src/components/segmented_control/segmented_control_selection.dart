// The selection rules of the `segmented_control` component.
//
// A control selects either one value (single mode) or a set of values
// (multiple mode). The helpers here hold the rules that do not depend on
// the widget's own state: which segment starts selected, which segment can
// be picked, which segment carries a value and what the next selection looks
// like in multiple mode.

import 'package:flutter/widgets.dart';

import 'segmented_control_segment.dart';

/// The value of the first segment that can be picked, or null when there is
/// none.
///
/// [disabledValues] disables values on top of each segment's own flag.
T? segmentedControlInitialValue<T>(
  List<SegmentedControlSegment<T>> segments,
  Set<T> disabledValues,
) {
  for (final SegmentedControlSegment<T> segment in segments) {
    if (segment.enabled && !disabledValues.contains(segment.value)) {
      return segment.value;
    }
  }
  return null;
}

/// The selection a single-select control starts with: the first segment that
/// can be picked.
Set<T> segmentedControlInitialSelection<T>(
  List<SegmentedControlSegment<T>> segments,
  Set<T> disabledValues,
) {
  final T? value = segmentedControlInitialValue<T>(segments, disabledValues);
  return value == null ? <T>{} : <T>{value};
}

/// The current selection of a control, whichever mode it runs in.
///
/// A controller owns the selection when it is given. Otherwise a controlled
/// control reads the value it was given and an uncontrolled one falls back
/// to [fallback], the state it owns.
Set<T> segmentedControlSelection<T>({
  required bool single,
  required Set<T> fallback,
  Set<T>? controllerValue,
  T? value,
  ValueChanged<T>? onChanged,
  Set<T>? values,
  ValueChanged<Set<T>>? onValuesChanged,
}) {
  if (controllerValue != null) {
    return controllerValue;
  }
  if (single) {
    if (onChanged != null) {
      return value == null ? <T>{} : <T>{value};
    }
    return fallback;
  }
  if (onValuesChanged != null) {
    return values ?? <T>{};
  }
  return fallback;
}

/// Whether the segment can be picked.
///
/// [disabledValues] disables values on top of the segment's own flag.
bool segmentedControlIsEnabled<T>(
  SegmentedControlSegment<T> segment,
  Set<T> disabledValues,
) {
  return segment.enabled && !disabledValues.contains(segment.value);
}

/// The segment that carries [value], or null when there is none.
SegmentedControlSegment<T>? segmentedControlSegmentFor<T>(
  List<SegmentedControlSegment<T>> segments,
  T value,
) {
  for (final SegmentedControlSegment<T> segment in segments) {
    if (segment.value == value) {
      return segment;
    }
  }
  return null;
}

/// The next selection in multiple mode: the value is added when it is not
/// selected and removed when it is.
Set<T> segmentedControlToggled<T>(Set<T> current, T value) {
  final Set<T> next = <T>{...current};
  if (next.contains(value)) {
    next.remove(value);
  } else {
    next.add(value);
  }
  return next;
}
