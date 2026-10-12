// Playground builder for the `slider` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/slider/slider.dart';
import 'package:flutter/widgets.dart';

/// Renders a [Slider] from playground values.
///
/// Interaction is display-only (a no-op callback): the `value` control owns
/// the position.
Widget buildSliderPlayground(BuildContext context, PlaygroundValues values) {
  return Slider(
    value: values.getDouble('value') ?? 0,
    onChanged: (_) {},
    min: values.getDouble('min') ?? 0,
    max: values.getDouble('max') ?? 1,
    variant: SliderVariant.values.byName(
      values.getEnum('variant') ?? 'standard',
    ),
    enabled: values.getBoolOr('enabled', true),
    semanticLabel: values.getString('semanticLabel'),
  );
}
