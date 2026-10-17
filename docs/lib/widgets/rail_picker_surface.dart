// Surface glass pickers of the Theme Studio rail: opacity and blur presets.
//
// Split from the scale pickers so the ~400-line rule stays green. Same
// commit contract as the preset/font/transition popups: preset taps commit
// immediately via [onChanged] (applied on select, never on hover) and close
// the popup; closing without picking keeps the current value.

import 'package:flutter/widgets.dart';

import '../../ui/dashcn/primitives/overlay.dart';
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

/// Shows the surface opacity popup: presets commit on tap and close.
///
/// [current] is read on every rebuild (not captured at open), so the
/// highlight follows the live value while the popup is open; [listenable]
/// (the theme model) rebuilds the rows when the document changes.
/// [onChanged] runs exactly once per committed pick; closing without
/// picking keeps the current value.
Future<void> showSurfaceOpacityPicker(
  BuildContext context,
  ValueGetter<double?> current, {
  required ValueChanged<double?> onChanged,
  Listenable? listenable,
}) {
  bool isSelected(double? preset) {
    final double? opacity = current();
    if (preset == null) return opacity == null;
    if (opacity == null) return false;
    return (opacity - preset).abs() < 0.005;
  }

  String detail(double? preset) =>
      preset == null ? 'opaque' : '${(preset * 100).round()}%';
  Widget buildPanel(BuildContext context) => RailPickerPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (final (String label, double? value) in kSurfaceOpacityPresets)
          RailPickerRow(
            label: label,
            detail: detail(value),
            selected: isSelected(value),
            onPick: () {
              onChanged(value);
              closeOverlay(context);
            },
          ),
      ],
    ),
  );
  return showPicker<void>(
    context: context,
    builder: (BuildContext context) {
      if (listenable == null) {
        return buildPanel(context);
      }
      return ListenableBuilder(
        listenable: listenable,
        builder: (BuildContext context, Widget? _) => buildPanel(context),
      );
    },
    title: 'Surface opacity',
  );
}

/// Shows the surface blur popup: presets commit on tap and close.
///
/// Same live-selection contract as [showSurfaceOpacityPicker]: [current]
/// is re-read on every rebuild and [listenable] rebuilds the rows when
/// the document changes.
Future<void> showSurfaceBlurPicker(
  BuildContext context,
  ValueGetter<double?> current, {
  required ValueChanged<double?> onChanged,
  Listenable? listenable,
}) {
  bool isSelected(double? preset) {
    final double? blur = current();
    if (preset == null) return blur == null;
    if (blur == null) return false;
    return (blur - preset).abs() < 0.25;
  }

  String detail(double? preset) =>
      preset == null ? 'no blur' : '${preset.toStringAsFixed(0)} px';
  Widget buildPanel(BuildContext context) => RailPickerPanel(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (final (String label, double? value) in kSurfaceBlurPresets)
          RailPickerRow(
            label: label,
            detail: detail(value),
            selected: isSelected(value),
            onPick: () {
              onChanged(value);
              closeOverlay(context);
            },
          ),
      ],
    ),
  );
  return showPicker<void>(
    context: context,
    builder: (BuildContext context) {
      if (listenable == null) {
        return buildPanel(context);
      }
      return ListenableBuilder(
        listenable: listenable,
        builder: (BuildContext context, Widget? _) => buildPanel(context),
      );
    },
    title: 'Surface blur',
  );
}
