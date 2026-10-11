// Named examples for the `formatted_input` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. State lives in
// the example's own widget. Segments size from the text style and the field
// hugs its content, so no example sets a width.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/form_core/form_core.dart';
import 'formatted_input.dart';

/// A `(555) 123-4567` phone field in controlled mode.
class _PhoneExample extends StatefulWidget {
  const _PhoneExample();

  @override
  State<_PhoneExample> createState() => _PhoneExampleState();
}

class _PhoneExampleState extends State<_PhoneExample> {
  static final SegmentedValue _initial = SegmentedValue(<SegmentPart>[
    const SegmentPart.separator('('),
    SegmentPart.editable(
      length: 3,
      placeholder: const Text('555'),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
    ),
    const SegmentPart.separator(') '),
    SegmentPart.editable(
      length: 3,
      placeholder: const Text('123'),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
    ),
    const SegmentPart.separator('-'),
    SegmentPart.editable(
      length: 4,
      placeholder: const Text('4567'),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
    ),
  ]);

  SegmentedValue _value = _initial;

  @override
  Widget build(BuildContext context) {
    return FormattedInput(
      leading: const Icon(LucideIcons.phone, size: 16),
      value: _value,
      onChanged: (SegmentedValue value) => setState(() => _value = value),
    );
  }
}

Widget _phone(BuildContext context) => const _PhoneExample();

/// A date field reporting a validation error while incomplete.
Widget _date(BuildContext context) {
  return FormattedInput(
    initialValue: SegmentedValue(<SegmentPart>[
      SegmentPart.editable(
        length: 2,
        placeholder: const Text('MM'),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
      const SegmentPart.separator('/'),
      SegmentPart.editable(
        length: 2,
        placeholder: const Text('DD'),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
      const SegmentPart.separator('/'),
      SegmentPart.editable(
        length: 4,
        placeholder: const Text('YYYY'),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    ]),
    validator: _validateDate,
    autovalidateMode: FormValidationMode.changed,
  );
}

String? _validateDate(String? text) {
  final String value = text ?? '';
  if (value.length == 8) {
    return null;
  }
  return 'Enter a full date (MM/DD/YYYY).';
}

/// A 16-digit card field.
Widget _card(BuildContext context) {
  return FormattedInput(
    initialValue: SegmentedValue(<SegmentPart>[
      SegmentPart.editable(
        length: 4,
        placeholder: const Text('1234'),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
      const SegmentPart.separator(' '),
      SegmentPart.editable(
        length: 4,
        placeholder: const Text('5678'),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
      const SegmentPart.separator(' '),
      SegmentPart.editable(
        length: 4,
        placeholder: const Text('9012'),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
      const SegmentPart.separator(' '),
      SegmentPart.editable(
        length: 4,
        placeholder: const Text('3456'),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    ]),
  );
}

/// Named docs examples for `formatted_input`; the first entry is the default.
const List<ComponentPreview> formattedInputPreviews = <ComponentPreview>[
  ComponentPreview('Phone', _phone),
  ComponentPreview('Date', _date),
  ComponentPreview('Card', _card),
];
