// The motion pickers of the Theme Studio rail: intensity plus the four
// custom legs (press scale, enter offset, duration multiplier, curve).
//
// Split out for the ~400-line rule; the popup chrome (`showPicker`), rows
// (`RailPickerPanel`, `RailPickerRow`) and the draft slider are shared.
// Every control commits ON SELECT: preset taps commit immediately, slider
// drags stay local until release, `Done` flushes then closes. Dismissal
// without a pick keeps the old value.

import 'package:flutter/widgets.dart';

import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/primitives/overlay.dart';
import '../ui/dashcn/theme/motion.dart';
import 'docs_tokens.dart';
import 'rail_picker_rows.dart';
import 'rail_picker_scroll.dart';
import 'rail_picker_slider.dart';
import 'rail_pickers.dart';

/// Short label for an intensity (the rail row value).
String motionIntensityLabel(MotionIntensity? intensity) {
  return switch (intensity ?? MotionIntensity.standard) {
    MotionIntensity.subtle => 'Subtle',
    MotionIntensity.standard => 'Standard',
    MotionIntensity.expressive => 'Expressive',
    MotionIntensity.custom => 'Custom',
  };
}

/// Short label for a custom curve choice.
String motionCurveLabel(MotionCurveName? curve) {
  return switch (curve ?? MotionCurveName.emphasizedOut) {
    MotionCurveName.standard => 'Standard',
    MotionCurveName.emphasizedOut => 'Emphasized out',
    MotionCurveName.emphasizedIn => 'Emphasized in',
    MotionCurveName.spring => 'Spring',
  };
}

/// Shows the intensity popup: Subtle / Standard / Expressive / Custom.
///
/// Only a pick commits; hovering, scrolling and focus movement stay local.
/// Closing without picking keeps the current value.
Future<void> showMotionIntensityPicker(
  BuildContext context,
  MotionIntensity? current, {
  required ValueChanged<MotionIntensity> onChanged,
}) {
  final MotionIntensity committed = current ?? MotionIntensity.standard;
  const Map<MotionIntensity, String> details = <MotionIntensity, String>{
    MotionIntensity.subtle: '0.75x · 0.98 · 4 px',
    MotionIntensity.standard: '1.0x · 0.96 · 8 px',
    MotionIntensity.expressive: '1.5x · 0.94 · 12 px',
    MotionIntensity.custom: 'explicit legs',
  };
  return showPicker<void>(
    context: context,
    builder: (BuildContext context) => RailPickerPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (final MotionIntensity kind in MotionIntensity.values)
            revealSelectedOnMount(
              selected: kind == committed,
              child: RailPickerRow(
                label: motionIntensityLabel(kind),
                detail: details[kind]!,
                selected: kind == committed,
                onPick: () {
                  onChanged(kind);
                  closeOverlay(context);
                },
              ),
            ),
        ],
      ),
    ),
    title: 'Intensity',
  );
}

/// Shows the custom curve popup; only a pick commits.
Future<void> showMotionCurvePicker(
  BuildContext context,
  MotionCurveName? current, {
  required ValueChanged<MotionCurveName> onChanged,
}) {
  final MotionCurveName committed = current ?? MotionCurveName.emphasizedOut;
  const Map<MotionCurveName, String> details = <MotionCurveName, String>{
    MotionCurveName.standard: 'state changes',
    MotionCurveName.emphasizedOut: 'enter transitions',
    MotionCurveName.emphasizedIn: 'exit transitions',
    MotionCurveName.spring: 'press-release overshoot',
  };
  return showPicker<void>(
    context: context,
    builder: (BuildContext context) => RailPickerPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (final MotionCurveName kind in MotionCurveName.values)
            revealSelectedOnMount(
              selected: kind == committed,
              child: RailPickerRow(
                label: motionCurveLabel(kind),
                detail: details[kind]!,
                selected: kind == committed,
                onPick: () {
                  onChanged(kind);
                  closeOverlay(context);
                },
              ),
            ),
        ],
      ),
    ),
    title: 'Custom curve',
  );
}

/// Shows the custom press-scale popup: presets plus the fine slider.
///
/// Preset taps commit immediately (the popup stays open for fine-tuning).
/// Slider drags stay local until release; `Done` flushes then closes.
Future<void> showMotionPressScalePicker(
  BuildContext context,
  double? current, {
  required ValueChanged<double> onChanged,
}) {
  double applied = (current ?? 0.96).clamp(0.8, 1.0).toDouble();
  double shown = applied;
  final GlobalKey<DraftSliderState> sliderKey = GlobalKey<DraftSliderState>();
  bool near(double preset) => (applied - preset).abs() < 0.005;
  const List<(String, double)> presets = <(String, double)>[
    ('Subtle', 0.98),
    ('Standard', 0.96),
    ('Expressive', 0.94),
  ];
  return showPicker<void>(
    context: context,
    builder: (BuildContext context) => RailPickerPanel(
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          void commit(double next) {
            final double clamped = next.clamp(0.8, 1.0).toDouble();
            if (clamped == applied) {
              return;
            }
            setState(() {
              applied = clamped;
              shown = clamped;
            });
            onChanged(clamped);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (final (String label, double value) in presets)
                RailPickerRow(
                  label: label,
                  detail: value.toStringAsFixed(2),
                  selected: near(value),
                  onPick: () => commit(value),
                ),
              const Gap(8),
              Text(
                shown.toStringAsFixed(2),
                style: docsText(context, size: 14, weight: FontWeight.w500),
              ),
              const Gap(8),
              SizedBox(
                width: kDocsPickerWidth - 24,
                child: DraftSlider(
                  key: sliderKey,
                  value: applied,
                  min: 0.8,
                  max: 1.0,
                  onCommit: commit,
                  onDraft: (double draft) => setState(() => shown = draft),
                ),
              ),
              const Gap(4),
              Button(
                variant: ButtonVariant.secondary,
                size: ButtonSize.sm,
                onPressed: () {
                  sliderKey.currentState?.flush();
                  closeOverlay(context);
                },
                child: const Text('Done'),
              ),
            ],
          );
        },
      ),
    ),
    title: 'Press scale',
  );
}

/// Shows the custom enter-offset popup: presets plus the fine slider (0–24 px).
Future<void> showMotionEnterOffsetPicker(
  BuildContext context,
  double? current, {
  required ValueChanged<double> onChanged,
}) {
  double applied = (current ?? 8.0).clamp(0.0, 24.0).toDouble();
  double shown = applied;
  final GlobalKey<DraftSliderState> sliderKey = GlobalKey<DraftSliderState>();
  bool near(double preset) => (applied - preset).abs() < 0.25;
  const List<(String, double)> presets = <(String, double)>[
    ('Subtle', 4),
    ('Standard', 8),
    ('Expressive', 12),
  ];
  return showPicker<void>(
    context: context,
    builder: (BuildContext context) => RailPickerPanel(
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          void commit(double next) {
            final double clamped = next.clamp(0.0, 24.0).toDouble();
            if (clamped == applied) {
              return;
            }
            setState(() {
              applied = clamped;
              shown = clamped;
            });
            onChanged(clamped);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (final (String label, double value) in presets)
                RailPickerRow(
                  label: label,
                  detail: '${value.toStringAsFixed(0)} px',
                  selected: near(value),
                  onPick: () => commit(value),
                ),
              const Gap(8),
              Text(
                '${shown.toStringAsFixed(1)} px',
                style: docsText(context, size: 14, weight: FontWeight.w500),
              ),
              const Gap(8),
              SizedBox(
                width: kDocsPickerWidth - 24,
                child: DraftSlider(
                  key: sliderKey,
                  value: applied,
                  min: 0,
                  max: 24,
                  onCommit: commit,
                  onDraft: (double draft) => setState(() => shown = draft),
                ),
              ),
              const Gap(4),
              Button(
                variant: ButtonVariant.secondary,
                size: ButtonSize.sm,
                onPressed: () {
                  sliderKey.currentState?.flush();
                  closeOverlay(context);
                },
                child: const Text('Done'),
              ),
            ],
          );
        },
      ),
    ),
    title: 'Enter offset',
  );
}

/// Shows the custom duration-multiplier popup: presets plus slider (0.25–3.0).
Future<void> showMotionDurationPicker(
  BuildContext context,
  double? current, {
  required ValueChanged<double> onChanged,
}) {
  double applied = (current ?? 1.0).clamp(0.25, 3.0).toDouble();
  double shown = applied;
  final GlobalKey<DraftSliderState> sliderKey = GlobalKey<DraftSliderState>();
  bool near(double preset) => (applied - preset).abs() < 0.02;
  const List<(String, double)> presets = <(String, double)>[
    ('Subtle', 0.75),
    ('Standard', 1.0),
    ('Expressive', 1.5),
  ];
  return showPicker<void>(
    context: context,
    builder: (BuildContext context) => RailPickerPanel(
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          void commit(double next) {
            final double clamped = next.clamp(0.25, 3.0).toDouble();
            if (clamped == applied) {
              return;
            }
            setState(() {
              applied = clamped;
              shown = clamped;
            });
            onChanged(clamped);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (final (String label, double value) in presets)
                RailPickerRow(
                  label: label,
                  detail: '${value.toStringAsFixed(2)}x',
                  selected: near(value),
                  onPick: () => commit(value),
                ),
              const Gap(8),
              Text(
                '${shown.toStringAsFixed(2)}x',
                style: docsText(context, size: 14, weight: FontWeight.w500),
              ),
              const Gap(8),
              SizedBox(
                width: kDocsPickerWidth - 24,
                child: DraftSlider(
                  key: sliderKey,
                  value: applied,
                  min: 0.25,
                  max: 3.0,
                  onCommit: commit,
                  onDraft: (double draft) => setState(() => shown = draft),
                ),
              ),
              const Gap(4),
              Button(
                variant: ButtonVariant.secondary,
                size: ButtonSize.sm,
                onPressed: () {
                  sliderKey.currentState?.flush();
                  closeOverlay(context);
                },
                child: const Text('Done'),
              ),
            ],
          );
        },
      ),
    ),
    title: 'Duration',
  );
}
