// Number and theme-token control rows for the playground panel.
//
// [NumberControlRow] pairs a kit [Slider] with an exact numeric readout (a
// kit [Input]): drag or arrow-key the slider for coarse changes, type the
// readout for exact ones. The slider domain is the live range from
// `bounds.dart` (a `value` slider tracks the live `min`/`max`); the readout
// clamps typed values into the same range. The kit slider asserts
// `max > min`, so a collapsed live range (`min == max`) is widened by one
// step for display only — committed values stay clamped, never widened.
//
// [TokenControlRow] is the theme-token swatch picker: one kit [Button] per
// token showing its live themed colour, plus a `Default` button that unsets
// nullable colours (the component default applies).

import 'package:flutter/widgets.dart';

import '../builder.dart';
import '../../generated/docs_controls.dart';
import '../../ui/dashcn/components/button/button.dart';
import '../../ui/dashcn/components/input/input.dart';
import '../../ui/dashcn/components/slider/slider.dart';
import '../../ui/dashcn/foundation/gap.dart';
import '../../ui/dashcn/theme/theme.dart';
import 'bounds.dart';
import 'control_label.dart';
import '../values.dart';

/// Slider + numeric readout row.
class NumberControlRow extends StatelessWidget {
  /// Creates the row for a `slider` [control].
  const NumberControlRow({
    super.key,
    required this.spec,
    required this.control,
    required this.values,
    required this.onCommit,
    required this.controller,
    this.boundedBy,
  });

  /// The component's full control spec (sibling lookup for bounds).
  final ComponentControls spec;

  /// The slider control this row edits.
  final ControlSpec control;

  /// Live values (read at build time).
  final PlaygroundValues values;

  /// Called with the next value.
  final ControlCommitted onCommit;

  /// Panel-owned readout controller (seeded/synced by the panel); null
  /// falls back to `initialValue` (first paint only, no reset sync).
  final TextEditingController? controller;

  /// Dependent-range table (see `bounds.dart`).
  final Map<String, List<String>>? boundedBy;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ({double min, double max}) live =
        sliderBounds(spec, values, control, boundedBy: boundedBy) ??
        (min: 0, max: 1);
    final double step = control.step ?? (control.isInt ? 1 : 0.01);
    // The kit slider asserts `max > min`: widen a collapsed live range by
    // one display step (committed values stay clamped below).
    final double displayMax = live.max <= live.min ? live.min + step : live.max;
    final double current = _current(values, control, live.min, live.max);
    final TextEditingController? controller = this.controller;
    final Widget readout = controller == null
        ? Input(
            key: ValueKey<String>('playground-number-${control.name}'),
            initialValue: formatControlNumber(control, current),
            keyboardType: TextInputType.number,
            onChanged: (String next) => _commitText(next),
          )
        : Input(
            key: ValueKey<String>('playground-number-${control.name}'),
            controller: controller,
            keyboardType: TextInputType.number,
            onChanged: (String next) => _commitText(next),
          );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ControlLabel(text: control.label),
        Gap(theme.spacing.xs),
        Row(
          children: <Widget>[
            Expanded(
              child: Slider(
                key: ValueKey<String>('playground-slider-${control.name}'),
                value: current.clamp(live.min, displayMax),
                min: live.min,
                max: displayMax,
                onChanged: (double next) =>
                    onCommit(control.name, _coerce(control, next)),
                semanticLabel: control.label,
              ),
            ),
            Gap(theme.spacing.sm),
            SizedBox(
              width: 84,
              child: Semantics(label: '${control.label} value', child: readout),
            ),
          ],
        ),
      ],
    );
  }

  void _commitText(String next) {
    final double? parsed = double.tryParse(next.trim());
    if (parsed == null) {
      return;
    }
    final ({double min, double max}) live =
        sliderBounds(spec, values, control, boundedBy: boundedBy) ??
        (min: 0, max: 1);
    onCommit(control.name, _coerce(control, parsed.clamp(live.min, live.max)));
  }
}

/// Theme-token swatch picker row.
class TokenControlRow extends StatelessWidget {
  /// Creates the row for a `colorToken` [control].
  const TokenControlRow({
    super.key,
    required this.control,
    required this.values,
    required this.onCommit,
  });

  /// The token control this row edits.
  final ControlSpec control;

  /// Live values (read at build time).
  final PlaygroundValues values;

  /// Called with the next token name (`null` unsets).
  final ControlCommitted onCommit;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String? current = values.getToken(control.name);
    final bool nullable = control.type.endsWith('?');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ControlLabel(text: control.label),
        Gap(theme.spacing.xs),
        Wrap(
          spacing: theme.spacing.xs,
          runSpacing: theme.spacing.xs,
          children: <Widget>[
            if (nullable)
              Button(
                key: ValueKey<String>(
                  'playground-token-${control.name}-default',
                ),
                variant: current == null
                    ? ButtonVariant.primary
                    : ButtonVariant.outline,
                size: ButtonSize.sm,
                onPressed: () => onCommit(control.name, null),
                child: const Text('Default'),
              ),
            for (final String token in control.options)
              Button(
                key: ValueKey<String>(
                  'playground-token-${control.name}-$token',
                ),
                variant: current == token
                    ? ButtonVariant.primary
                    : ButtonVariant.outline,
                size: ButtonSize.sm,
                onPressed: () => onCommit(control.name, token),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _Swatch(token: token),
                    Gap(theme.spacing.xs),
                    Text(token),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}

/// One 12 px themed swatch (bordered; empty when the token is unknown).
class _Swatch extends StatelessWidget {
  const _Swatch({required this.token});

  final String token;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color? color = playgroundTokenColor(context, token);
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color ?? const Color(0x00000000),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: theme.colors.border),
      ),
    );
  }
}

/// The live numeric value, clamped into the ordered `[lo, hi]` range.
double _current(
  PlaygroundValues values,
  ControlSpec control,
  double lo,
  double hi,
) {
  final double lower = lo <= hi ? lo : hi;
  final double upper = lo <= hi ? hi : lo;
  final Object? raw = values.valueOf(control.name);
  if (raw is! num) {
    return lower;
  }
  return raw.toDouble().clamp(lower, upper);
}

/// Coerces [value] to the control's int/double shape.
Object _coerce(ControlSpec control, double value) {
  return control.isInt ? value.round() : value;
}

/// Display text for the numeric readout (`4`, not `4.0`, for ints).
String formatControlNumber(ControlSpec control, double value) {
  if (control.isInt) {
    return '${value.round()}';
  }
  return value.toString();
}
