// Playground control rows: one kit-built row per editable `ControlSpec`.
//
// Mapping (P9-2; kit components only):
// * `toggle` (`bool`) and `enabled` -> [Switch],
// * `toggle` (`bool?`) -> tri-state Unset/On/Off segmented [Button] row
//   (`values.dart` already round-trips the null),
// * `select` -> kit [Select] over the option names,
// * `text` (String or text-like Widget slot) -> kit [Input],
// * `slider` -> [NumberControlRow] (`numeric_controls.dart`),
// * `colorToken` -> [TokenControlRow] (`numeric_controls.dart`),
// * `readOnly` -> nothing (the spec reason says why).
//
// Every row shows its visible label and carries it as Semantics, so controls
// are keyboard reachable (kit focus handling) and labelled. Spacing comes
// from the theme (`spacing`), so density presets re-space the panel.

import 'package:flutter/widgets.dart';

import '../../generated/docs_controls.dart';
import '../../ui/dashcn/components/button/button.dart';
import '../../ui/dashcn/components/input/input.dart';
import '../../ui/dashcn/components/select/select.dart';
import '../../ui/dashcn/components/switch/switch.dart';
import '../../ui/dashcn/foundation/gap.dart';
import '../../ui/dashcn/theme/theme.dart';
import 'control_label.dart';
import 'numeric_controls.dart';
import '../values.dart';

/// One labelled row for [control], dispatched on its kind.
class ControlRow extends StatelessWidget {
  /// Creates the row for [control] of [spec].
  const ControlRow({
    super.key,
    required this.spec,
    required this.control,
    required this.values,
    required this.onCommit,
    this.textController,
    this.boundedBy,
  });

  /// The component's full control spec (sibling lookup for bounds).
  final ComponentControls spec;

  /// The control this row edits.
  final ControlSpec control;

  /// Live values (read at build time).
  final PlaygroundValues values;

  /// Called with the next value.
  final ControlCommitted onCommit;

  /// Panel-owned text controller for `text`/`slider` rows, else null.
  final TextEditingController? textController;

  /// Dependent-range table (see `bounds.dart`).
  final Map<String, List<String>>? boundedBy;

  @override
  Widget build(BuildContext context) {
    final Widget controlWidget = switch (control.kind) {
      ControlKind.toggle =>
        control.type == 'bool?'
            ? _TriStateRow(control: control, values: values, onCommit: onCommit)
            : _BoolRow(control: control, values: values, onCommit: onCommit),
      ControlKind.enabled => _BoolRow(
        control: control,
        values: values,
        onCommit: onCommit,
      ),
      ControlKind.select => _EnumRow(
        control: control,
        values: values,
        onCommit: onCommit,
      ),
      ControlKind.text => _TextRow(
        control: control,
        values: values,
        onCommit: onCommit,
        controller: textController,
      ),
      ControlKind.slider => NumberControlRow(
        spec: spec,
        control: control,
        values: values,
        onCommit: onCommit,
        controller: textController,
        boundedBy: boundedBy,
      ),
      ControlKind.colorToken => TokenControlRow(
        control: control,
        values: values,
        onCommit: onCommit,
      ),
      ControlKind.readOnly => const SizedBox.shrink(),
    };
    return Semantics(
      label: control.label,
      child: KeyedSubtree(
        key: ValueKey<String>('playground-control-${control.name}'),
        child: controlWidget,
      ),
    );
  }
}

/// On/off switch row (`bool` toggles and the synthetic `enabled`).
class _BoolRow extends StatelessWidget {
  const _BoolRow({
    required this.control,
    required this.values,
    required this.onCommit,
  });

  final ControlSpec control;
  final PlaygroundValues values;
  final ControlCommitted onCommit;

  @override
  Widget build(BuildContext context) {
    final bool current =
        values.getBool(control.name) ?? (control.kind == ControlKind.enabled);
    return Row(
      children: <Widget>[
        Expanded(child: ControlLabel(text: control.label)),
        Switch(
          key: ValueKey<String>('playground-switch-${control.name}'),
          value: current,
          onChanged: (bool next) => onCommit(control.name, next),
        ),
      ],
    );
  }
}

/// Tri-state row for nullable bools: Unset / On / Off segmented buttons.
class _TriStateRow extends StatelessWidget {
  const _TriStateRow({
    required this.control,
    required this.values,
    required this.onCommit,
  });

  final ControlSpec control;
  final PlaygroundValues values;
  final ControlCommitted onCommit;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool? current = values.getBool(control.name);
    Widget option(String label, bool? value) {
      final bool selected = current == value;
      return Expanded(
        child: Button(
          key: ValueKey<String>(
            'playground-tristate-${control.name}-${label.toLowerCase()}',
          ),
          variant: selected ? ButtonVariant.primary : ButtonVariant.outline,
          size: ButtonSize.sm,
          onPressed: () => onCommit(control.name, value),
          child: Text(label),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ControlLabel(text: control.label),
        Gap(theme.spacing.xs),
        Row(
          children: <Widget>[
            option('Unset', null),
            Gap(theme.spacing.xs),
            option('On', true),
            Gap(theme.spacing.xs),
            option('Off', false),
          ],
        ),
      ],
    );
  }
}

/// Enum dropdown row (kit `Select` over the option names).
class _EnumRow extends StatelessWidget {
  const _EnumRow({
    required this.control,
    required this.values,
    required this.onCommit,
  });

  final ControlSpec control;
  final PlaygroundValues values;
  final ControlCommitted onCommit;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String? current = values.getEnum(control.name);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ControlLabel(text: control.label),
        Gap(theme.spacing.xs),
        SizedBox(
          width: double.infinity,
          child: Select<String>(
            key: ValueKey<String>('playground-select-${control.name}'),
            value: current,
            onChanged: (String? next) => onCommit(control.name, next),
            itemBuilder: (BuildContext context, String value) => Text(value),
            placeholder: Text(current ?? 'None'),
            items: <Widget>[
              for (final String option in control.options)
                SelectItem<String>(value: option, child: Text(option)),
            ],
          ),
        ),
      ],
    );
  }
}

/// Free-text row (kit `Input` with the panel-owned controller).
class _TextRow extends StatelessWidget {
  const _TextRow({
    required this.control,
    required this.values,
    required this.onCommit,
    required this.controller,
  });

  final ControlSpec control;
  final PlaygroundValues values;
  final ControlCommitted onCommit;

  /// Panel-owned controller (the panel seeds and syncs it on reset/query);
  /// null falls back to `initialValue` (first paint only, no reset sync).
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextEditingController? controller = this.controller;
    final Widget field = controller == null
        ? Input(
            key: ValueKey<String>('playground-text-${control.name}'),
            initialValue: values.getString(control.name),
            onChanged: (String next) => onCommit(control.name, next),
          )
        : Input(
            key: ValueKey<String>('playground-text-${control.name}'),
            controller: controller,
            onChanged: (String next) => onCommit(control.name, next),
          );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ControlLabel(text: control.label),
        Gap(theme.spacing.xs),
        field,
      ],
    );
  }
}
