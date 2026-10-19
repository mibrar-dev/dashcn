// Named examples for the `wheel_picker` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// The interactive examples own their selection and echo it, so a scroll or a
// key press shows what the widget reports; the read-only example stays inert.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'wheel_picker.dart';

/// One wheel column of numbers, 01-12.
const List<String> _hours = <String>[
  '01', '02', '03', '04', '05', '06',
  '07', '08', '09', '10', '11', '12',
];

/// A single-column hour wheel; owns its selection.
class _DefaultWheel extends StatefulWidget {
  const _DefaultWheel();

  @override
  State<_DefaultWheel> createState() => _DefaultWheelState();
}

class _DefaultWheelState extends State<_DefaultWheel> {
  List<int> _value = <int>[3];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        WheelPicker(
          columns: <WheelColumn>[WheelColumn(items: _hours)],
          value: _value,
          onChanged: (List<int> value) => setState(() => _value = value),
        ),
        Gap(theme.spacing.lg),
        Text(
          _value[0] == 0 ? '—' : _hours[_value[0]],
          style: TextStyle(color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _default(BuildContext context) => const _DefaultWheel();

/// A three-column time picker (hours / minutes / meridiem).
class _TimeWheel extends StatefulWidget {
  const _TimeWheel();

  @override
  State<_TimeWheel> createState() => _TimeWheelState();
}

class _TimeWheelState extends State<_TimeWheel> {
  List<int> _value = <int>[3, 25, 1];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        WheelPicker(
          columns: <WheelColumn>[
            WheelColumn(items: _hours),
            WheelColumn(
              items: <String>[
                for (int m = 0; m < 60; m += 5) m.toString().padLeft(2, '0'),
              ],
            ),
            WheelColumn(items: <String>['AM', 'PM']),
          ],
          value: _value,
          onChanged: (List<int> value) => setState(() => _value = value),
        ),
        Gap(theme.spacing.lg),
        Text(
          '${_hours[_value[0]]}:${_value[1].toString().padLeft(2, '0')} '
          '${_value[2] == 0 ? 'AM' : 'PM'}',
          style: TextStyle(color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _time(BuildContext context) => const _TimeWheel();

/// A looping wheel that never clamps at the ends.
class _LoopingWheel extends StatefulWidget {
  const _LoopingWheel();

  @override
  State<_LoopingWheel> createState() => _LoopingWheelState();
}

class _LoopingWheelState extends State<_LoopingWheel> {
  List<int> _value = <int>[0];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        WheelPicker(
          columns: <WheelColumn>[WheelColumn(items: <String>[
            'Red', 'Orange', 'Yellow', 'Green', 'Blue', 'Violet',
          ])],
          value: _value,
          looping: true,
          onChanged: (List<int> value) => setState(() => _value = value),
        ),
        Gap(theme.spacing.lg),
        Text(
          <String>[
            'Red', 'Orange', 'Yellow', 'Green', 'Blue', 'Violet',
          ][_value[0]],
          style: TextStyle(color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _looping(BuildContext context) => const _LoopingWheel();

/// A 3D cylinder wheel with custom row content.
class _PerspectiveWheel extends StatefulWidget {
  const _PerspectiveWheel();

  @override
  State<_PerspectiveWheel> createState() => _PerspectiveWheelState();
}

class _PerspectiveWheelState extends State<_PerspectiveWheel> {
  List<int> _value = <int>[2];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        WheelPicker(
          columns: <WheelColumn>[
            WheelColumn(
              items: <String>['A', 'B', 'C', 'D', 'E', 'F', 'G'],
              builder: (BuildContext context, int index) {
                final bool selected = index == _value[0];
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selected
                            ? theme.colors.accent
                            : theme.colors.mutedForeground,
                      ),
                    ),
                    const Gap(6),
                    Text(
                      String.fromCharCode(65 + index),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
          value: _value,
          perspective: true,
          onChanged: (List<int> value) => setState(() => _value = value),
        ),
        Gap(theme.spacing.lg),
        Text(
          'letter ${String.fromCharCode(65 + _value[0])}',
          style: TextStyle(color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _perspective(BuildContext context) => const _PerspectiveWheel();

/// A customized wheel: theme overrides and a fixed column width.
class _CustomizedWheel extends StatefulWidget {
  const _CustomizedWheel();

  @override
  State<_CustomizedWheel> createState() => _CustomizedWheelState();
}

class _CustomizedWheelState extends State<_CustomizedWheel> {
  List<int> _value = <int>[1, 0];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        WheelPicker(
          columns: <WheelColumn>[
            WheelColumn(
              items: <String>['Small', 'Medium', 'Large'],
              width: 120,
            ),
            WheelColumn(items: <String>['S', 'M', 'L', 'XL']),
          ],
          value: _value,
          theme: const WheelPickerTheme(
            itemHeight: 36,
            visibleItems: 3,
            selectionColor: ThemedColor.ref(ColorRef.accent, alpha: 0.25),
            fontSize: 15,
          ),
          onChanged: (List<int> value) => setState(() => _value = value),
        ),
        Gap(theme.spacing.lg),
        Text(
          '${<String>['Small', 'Medium', 'Large'][_value[0]]} / '
          '${<String>['S', 'M', 'L', 'XL'][_value[1]]}',
          style: TextStyle(color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _customized(BuildContext context) => const _CustomizedWheel();

/// A read-only wheel with no callback.
Widget _readOnly(BuildContext context) {
  return const WheelPicker(
    columns: <WheelColumn>[
      WheelColumn(items: <String>['One', 'Two', 'Three']),
    ],
    initialValue: <int>[1],
  );
}

/// Named docs examples for `wheel_picker`; the first entry is the default.
const List<ComponentPreview> wheelPickerPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('Time', _time),
  ComponentPreview('Looping', _looping),
  ComponentPreview('3D Perspective', _perspective),
  ComponentPreview('Customized', _customized),
  ComponentPreview('Read-only', _readOnly),
];
