// Named examples for the `star_rating` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// P7-C2: the interactive examples own their value and echo it, so a tap shows
// what the widget reports; read-only and disabled stay deliberately inert.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import 'star_rating.dart';

/// Interactive rating with half-star steps; owns its value.
class _InteractiveRating extends StatefulWidget {
  const _InteractiveRating();

  @override
  State<_InteractiveRating> createState() => _InteractiveRatingState();
}

class _InteractiveRatingState extends State<_InteractiveRating> {
  double _value = 3.5;

  @override
  Widget build(BuildContext context) {
    return StarRating(
      value: _value,
      onChanged: (double value) => setState(() => _value = value),
      semanticLabel: 'Rating',
    );
  }
}

Widget _default(BuildContext context) => const _InteractiveRating();

/// A non-interactive rating.
Widget _readOnly(BuildContext context) {
  return const StarRating(value: 4);
}

/// A vertical rating that reports the value it settles on.
class _VerticalRating extends StatefulWidget {
  const _VerticalRating();

  @override
  State<_VerticalRating> createState() => _VerticalRatingState();
}

class _VerticalRatingState extends State<_VerticalRating> {
  double _value = 3;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        StarRating(
          value: _value,
          direction: Axis.vertical,
          onChanged: (double value) => setState(() => _value = value),
        ),
        Gap(theme.spacing.lg),
        Text(
          'rated ${_value.toStringAsFixed(1)}',
          style: TextStyle(color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _vertical(BuildContext context) => const _VerticalRating();

/// A disabled rating.
Widget _disabled(BuildContext context) {
  return const StarRating(value: 3, enabled: false);
}

/// Named docs examples for `star_rating`; the first entry is the default.
const List<ComponentPreview> starRatingPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('Read-only', _readOnly),
  ComponentPreview('Vertical', _vertical),
  ComponentPreview('Disabled', _disabled),
];
