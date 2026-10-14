// Playground builder for the `date_picker` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/calendar/calendar.dart';
import 'package:docs/ui/dashcn/components/date_picker/date_picker.dart';
import 'package:docs/ui/dashcn/primitives/form_core/object_form_field.dart';
import 'package:flutter/widgets.dart';

/// Renders a [DatePicker] from playground values.
///
/// The picked date is builder-owned (null: the placeholder shows).
Widget buildDatePickerPlayground(
  BuildContext context,
  PlaygroundValues values,
) {
  final String? placeholder = values.textOrNull('placeholder');
  return DatePicker(
    value: null,
    placeholder: placeholder == null ? null : Text(placeholder),
    mode: _byNameOrNull(PromptMode.values, values.getEnum('mode')),
    initialViewType: _byNameOrNull(
      CalendarViewType.values,
      values.getEnum('initialViewType'),
    ),
    enabled: values.getBool('enabled'),
    expand: values.getBoolOr('expand', false),
  );
}

T? _byNameOrNull<T extends Enum>(List<T> values, String? name) {
  if (name == null) {
    return null;
  }
  for (final T value in values) {
    if (value.name == name) {
      return value;
    }
  }
  return null;
}
