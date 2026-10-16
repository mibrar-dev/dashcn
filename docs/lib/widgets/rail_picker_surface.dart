// Surface glass pickers of the Theme Studio rail: opacity and blur presets.
//
// Split from the scale pickers so the ~400-line rule stays green. Same
// commit contract as the radius popup: preset taps commit immediately via
// [onChanged] (applied on select, never on hover); closing without picking
// keeps the current value.

import 'package:flutter/widgets.dart';

import 'rail_picker_rows.dart';
import 'rail_pickers.dart';

/// Opacity presets: opaque plus three frosted steps.
const List<(String, double?)> kSurfaceOpacityPresets = <(String, double?)>[
  ('Opaque', null),
  ('90%', 0.9),
  ('80%', 0.8),
  ('70%', 0.7),
];

/// Blur presets in logical px: none plus three frosted steps.
const List<(String, double?)> kSurfaceBlurPresets = <(String, double?)>[
  ('None', null),
  ('Subtle', 4),
  ('Frosted', 8),
  ('Heavy', 16),
];

/// Shows the surface opacity popup: presets commit on tap.
Future<void> showSurfaceOpacityPicker(
  BuildContext context,
  double? opacity, {
  required ValueChanged<double?> onChanged,
}) {
  bool selected(double? preset) {
    if (preset == null) return opacity == null;
    if (opacity == null) return false;
    return (opacity - preset).abs() < 0.005;
  }

  String detail(double? preset) =>
      preset == null ? 'opaque' : '${(preset * 100).round()}%';
  return showPicker<void>(
    context: context,
    builder: (BuildContext context) => RailPickerPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (final (String label, double? value) in kSurfaceOpacityPresets)
            RailPickerRow(
              label: label,
              detail: detail(value),
              selected: selected(value),
              onPick: () => onChanged(value),
            ),
        ],
      ),
    ),
    title: 'Surface opacity',
  );
}

/// Shows the surface blur popup: presets commit on tap.
Future<void> showSurfaceBlurPicker(
  BuildContext context,
  double? blur, {
  required ValueChanged<double?> onChanged,
}) {
  bool selected(double? preset) {
    if (preset == null) return blur == null;
    if (blur == null) return false;
    return (blur - preset).abs() < 0.25;
  }

  String detail(double? preset) =>
      preset == null ? 'no blur' : '${preset.toStringAsFixed(0)} px';
  return showPicker<void>(
    context: context,
    builder: (BuildContext context) => RailPickerPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (final (String label, double? value) in kSurfaceBlurPresets)
            RailPickerRow(
              label: label,
              detail: detail(value),
              selected: selected(value),
              onPick: () => onChanged(value),
            ),
        ],
      ),
    ),
    title: 'Surface blur',
  );
}
