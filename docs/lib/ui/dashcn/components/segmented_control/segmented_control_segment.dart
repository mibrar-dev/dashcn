// The pieces of the `segmented_control` component: [SegmentedControlSegment]
// (one choice) and [SegmentedControlController] (the uncontrolled mode).
//
// The pickable button lives in `segmented_control_button.dart`.

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

export 'segmented_control_style.dart';

/// What the control tells its segments about itself.
class SegmentedControlScope {
  /// Creates the scope data.
  const SegmentedControlScope({required this.shortcuts, required this.actions});

  /// The arrow-key map of the control's roving group.
  final Map<LogicalKeySet, Intent> shortcuts;

  /// The action map of the control's roving group.
  final Map<Type, Action<Intent>> actions;
}

/// One choice of a segmented control.
class SegmentedControlSegment<T> {
  /// Creates a segment.
  const SegmentedControlSegment({
    required this.value,
    this.icon,
    this.label,
    this.enabled = true,
    this.semanticLabel,
    this.tooltip,
  });

  /// The value the segment stands for.
  final T value;

  /// The segment's icon; usually an `Icon`.
  final Widget? icon;

  /// The segment's label; usually a `Text`.
  final Widget? label;

  /// Whether the segment can be picked.
  final bool enabled;

  /// Accessible name of the segment; falls back to the label's text.
  final String? semanticLabel;

  /// Hover label of the segment.
  final String? tooltip;

  /// Returns a copy with the given fields replaced.
  SegmentedControlSegment<T> copyWith({
    T? value,
    Widget? icon,
    Widget? label,
    bool? enabled,
    String? semanticLabel,
    String? tooltip,
  }) {
    return SegmentedControlSegment<T>(
      value: value ?? this.value,
      icon: icon ?? this.icon,
      label: label ?? this.label,
      enabled: enabled ?? this.enabled,
      semanticLabel: semanticLabel ?? this.semanticLabel,
      tooltip: tooltip ?? this.tooltip,
    );
  }
}

/// Holds the selection of an uncontrolled [SegmentedControl].
class SegmentedControlController<T> extends ValueNotifier<Set<T>> {
  /// Creates a controller with an optional initial selection.
  SegmentedControlController([Set<T>? value]) : super(value ?? <T>{});

  /// Whether [value] is selected.
  bool contains(T value) => this.value.contains(value);

  /// Selects [value]; in [single] mode the other values are dropped.
  void select(T value, {bool single = false}) {
    final Set<T> next = single ? <T>{value} : <T>{...this.value, value};
    if (!setEquals(next, this.value)) {
      this.value = next;
    }
  }

  /// Deselects [value].
  void deselect(T value) {
    final Set<T> next = <T>{...this.value}..remove(value);
    if (!setEquals(next, this.value)) {
      this.value = next;
    }
  }

  /// Flips [value]; in [single] mode the other values are dropped.
  void toggle(T value, {bool single = false}) {
    if (contains(value)) {
      deselect(value);
    } else {
      select(value, single: single);
    }
  }
}

/// Builds one segment of a segmented control.
///
/// [selected] tells whether the segment is part of the selection and
/// [enabled] whether it can be picked.
typedef SegmentedControlSegmentBuilder<T> =
    Widget Function(
      BuildContext context,
      SegmentedControlSegment<T> segment, {
      required bool selected,
      required bool enabled,
    });
