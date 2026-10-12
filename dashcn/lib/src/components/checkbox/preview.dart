// Named examples for the `checkbox` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../theme/theme.dart';
import 'checkbox.dart';

/// One labelled checkbox row; the component owns the label gap (upstream
/// `gap-2`) and makes the whole row clickable.
Widget _checkboxRow(BuildContext context, Checkbox checkbox, String label) {
  return Checkbox(
    value: checkbox.value,
    controller: checkbox.controller,
    onChanged: checkbox.onChanged,
    tristate: checkbox.tristate,
    enabled: checkbox.enabled,
    size: checkbox.size,
    gap: checkbox.gap,
    padding: checkbox.padding,
    theme: checkbox.theme,
    focusNode: checkbox.focusNode,
    label: Text(label),
  );
}

/// Unchecked, the default.
class _CheckboxDefaultCheckbox extends StatefulWidget {
  const _CheckboxDefaultCheckbox();

  @override
  State<_CheckboxDefaultCheckbox> createState() =>
      _CheckboxDefaultCheckboxState();
}

class _CheckboxDefaultCheckboxState extends State<_CheckboxDefaultCheckbox> {
  CheckboxValue _value = CheckboxValue.unchecked;

  @override
  Widget build(BuildContext context) {
    return _checkboxRow(
      context,
      Checkbox(
        value: _value,
        onChanged: (CheckboxValue value) => setState(() => _value = value),
      ),
      'Accept terms',
    );
  }
}

/// Checked.
class _CheckboxCheckedCheckbox extends StatefulWidget {
  const _CheckboxCheckedCheckbox();

  @override
  State<_CheckboxCheckedCheckbox> createState() =>
      _CheckboxCheckedCheckboxState();
}

class _CheckboxCheckedCheckboxState extends State<_CheckboxCheckedCheckbox> {
  CheckboxValue _value = CheckboxValue.checked;

  @override
  Widget build(BuildContext context) {
    return _checkboxRow(
      context,
      Checkbox(
        value: _value,
        onChanged: (CheckboxValue value) => setState(() => _value = value),
      ),
      'Notify me',
    );
  }
}

/// Tri-state: the unchecked -> indeterminate -> checked cycle.
class _CheckboxTristateCheckbox extends StatefulWidget {
  const _CheckboxTristateCheckbox();

  @override
  State<_CheckboxTristateCheckbox> createState() =>
      _CheckboxTristateCheckboxState();
}

class _CheckboxTristateCheckboxState extends State<_CheckboxTristateCheckbox> {
  CheckboxValue _value = CheckboxValue.unchecked;

  @override
  Widget build(BuildContext context) {
    return _checkboxRow(
      context,
      Checkbox(
        tristate: true,
        value: _value,
        onChanged: (CheckboxValue value) => setState(() => _value = value),
      ),
      _value.name,
    );
  }
}

/// Disabled in both states.
Widget _checkboxDisabled(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    spacing: spacing.md,
    children: <Widget>[
      _checkboxRow(
        context,
        const Checkbox(value: CheckboxValue.checked),
        'On (disabled)',
      ),
      _checkboxRow(
        context,
        const Checkbox(value: CheckboxValue.unchecked),
        'Off',
      ),
    ],
  );
}

Widget _checkboxDefault(BuildContext context) =>
    const _CheckboxDefaultCheckbox();

Widget _checkboxChecked(BuildContext context) =>
    const _CheckboxCheckedCheckbox();

Widget _checkboxIndeterminate(BuildContext context) =>
    const _CheckboxTristateCheckbox();

/// Named docs examples for `checkbox`; the first entry is the default.
const List<ComponentPreview> checkboxPreviews = <ComponentPreview>[
  ComponentPreview('Default', _checkboxDefault),
  ComponentPreview('Checked', _checkboxChecked),
  ComponentPreview('Indeterminate', _checkboxIndeterminate),
  ComponentPreview('Disabled', _checkboxDisabled),
];
