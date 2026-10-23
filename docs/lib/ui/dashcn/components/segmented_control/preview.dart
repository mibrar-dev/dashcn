// Named examples for the `segmented_control` component (P6-F3 preview
// contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/color_tokens.dart';
import 'segmented_control.dart';

/// The default example: one selected segment out of three.
class _SegmentedDefault extends StatefulWidget {
  const _SegmentedDefault();

  @override
  State<_SegmentedDefault> createState() => _SegmentedDefaultState();
}

class _SegmentedDefaultState extends State<_SegmentedDefault> {
  String _value = 'day';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedControl<String>(
        value: _value,
        onChanged: (String value) => setState(() => _value = value),
        segments: <SegmentedControlSegment<String>>[
          SegmentedControlSegment<String>(value: 'day', label: Text('Day')),
          SegmentedControlSegment<String>(
            value: 'week',
            label: Text(docsSample(context, 'Week')),
          ),
          SegmentedControlSegment<String>(
            value: 'month',
            label: Text(docsSample(context, 'Month')),
          ),
        ],
      ),
    );
  }
}

Widget _segmentedDefault(BuildContext context) => const _SegmentedDefault();

/// Icons only.
class _SegmentedIcons extends StatefulWidget {
  const _SegmentedIcons();

  @override
  State<_SegmentedIcons> createState() => _SegmentedIconsState();
}

class _SegmentedIconsState extends State<_SegmentedIcons> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedControl<int>(
        value: _value,
        onChanged: (int value) => setState(() => _value = value),
        segments: <SegmentedControlSegment<int>>[
          SegmentedControlSegment<int>(
            value: 0,
            icon: Icon(LucideIcons.list),
            semanticLabel: docsSample(context, 'List'),
          ),
          SegmentedControlSegment<int>(
            value: 1,
            icon: Icon(LucideIcons.layoutGrid),
            semanticLabel: docsSample(context, 'Grid'),
          ),
          SegmentedControlSegment<int>(
            value: 2,
            icon: Icon(LucideIcons.layers),
            semanticLabel: docsSample(context, 'Layers'),
          ),
        ],
      ),
    );
  }
}

Widget _segmentedIcons(BuildContext context) => const _SegmentedIcons();

/// Multiple selection: any number of segments can be picked.
class _SegmentedMultiple extends StatefulWidget {
  const _SegmentedMultiple();

  @override
  State<_SegmentedMultiple> createState() => _SegmentedMultipleState();
}

class _SegmentedMultipleState extends State<_SegmentedMultiple> {
  Set<String> _values = <String>{'bold'};

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedControl<String>(
        selection: SegmentedControlSelection.multiple,
        values: _values,
        onValuesChanged: (Set<String> values) =>
            setState(() => _values = values),
        segments: <SegmentedControlSegment<String>>[
          SegmentedControlSegment<String>(
            value: 'bold',
            icon: Icon(LucideIcons.bold),
            semanticLabel: docsSample(context, 'Bold'),
          ),
          SegmentedControlSegment<String>(
            value: 'italic',
            icon: Icon(LucideIcons.italic),
            semanticLabel: docsSample(context, 'Italic'),
          ),
          SegmentedControlSegment<String>(
            value: 'underline',
            icon: Icon(LucideIcons.underline),
            semanticLabel: docsSample(context, 'Underline'),
          ),
        ],
      ),
    );
  }
}

Widget _segmentedMultiple(BuildContext context) => const _SegmentedMultiple();

/// A disabled segment.
class _SegmentedDisabled extends StatefulWidget {
  const _SegmentedDisabled();

  @override
  State<_SegmentedDisabled> createState() => _SegmentedDisabledState();
}

class _SegmentedDisabledState extends State<_SegmentedDisabled> {
  String _value = 'a';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedControl<String>(
        value: _value,
        onChanged: (String value) => setState(() => _value = value),
        segments: const <SegmentedControlSegment<String>>[
          SegmentedControlSegment<String>(value: 'a', label: Text('A')),
          SegmentedControlSegment<String>(
            value: 'b',
            label: Text('B'),
            enabled: false,
          ),
          SegmentedControlSegment<String>(value: 'c', label: Text('C')),
        ],
      ),
    );
  }
}

Widget _segmentedDisabled(BuildContext context) => const _SegmentedDisabled();

/// The control filling the width it is given.
class _SegmentedFullWidth extends StatefulWidget {
  const _SegmentedFullWidth();

  @override
  State<_SegmentedFullWidth> createState() => _SegmentedFullWidthState();
}

class _SegmentedFullWidthState extends State<_SegmentedFullWidth> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 320,
        child: SegmentedControl<int>(
          expand: true,
          value: _value,
          onChanged: (int value) => setState(() => _value = value),
          segments: <SegmentedControlSegment<int>>[
            SegmentedControlSegment<int>(value: 0, label: Text('One')),
            SegmentedControlSegment<int>(value: 1, label: Text('Two')),
            SegmentedControlSegment<int>(
              value: 2,
              label: Text(docsSample(context, 'Three')),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _segmentedFullWidth(BuildContext context) => const _SegmentedFullWidth();

/// A customised control: a rounded track and a filled thumb.
Widget _segmentedCustomized(BuildContext context) {
  return Center(
    child: SegmentedControl<String>(
      value: 'left',
      onChanged: _noop,
      style: const SegmentedControlStyle(
        background: ThemedColor.ref(ColorRef.accent, alpha: 0.25),
        thumbBackground: ThemedColor.ref(ColorRef.accent),
        thumbBorderColor: ThemedColor.ref(ColorRef.accent),
        thumbBorderWidth: 1,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        padding: EdgeInsets.all(4),
      ),
      segments: <SegmentedControlSegment<String>>[
        SegmentedControlSegment<String>(
          value: 'left',
          label: Text(docsSample(context, 'Left')),
        ),
        SegmentedControlSegment<String>(
          value: 'right',
          label: Text(docsSample(context, 'Right')),
        ),
      ],
    ),
  );
}

void _noop(String value) {}

/// Named docs examples for `segmented_control`; the first entry is the
/// default.
List<ComponentPreview> get segmentedControlPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _segmentedDefault),
  ComponentPreview(docsSample(null, 'Icons'), _segmentedIcons),
  ComponentPreview(docsSample(null, 'Multiple'), _segmentedMultiple),
  ComponentPreview(docsSample(null, 'Disabled'), _segmentedDisabled),
  ComponentPreview(docsSample(null, 'Full width'), _segmentedFullWidth),
  ComponentPreview(docsSample(null, 'Customized'), _segmentedCustomized),
];
