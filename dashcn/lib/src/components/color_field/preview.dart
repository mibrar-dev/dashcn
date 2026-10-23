// Named examples for the `color_field` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../theme/theme.dart';
import 'color_field.dart';

/// A section label above a field.
class _ColorFieldLabel extends StatelessWidget {
  const _ColorFieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: theme.colors.foreground,
        ),
      ),
    );
  }
}

/// The HSV saturation/value field.
Widget _colorFieldDefault(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      _ColorFieldLabel(docsSample(context, 'HSV field')),
      SizedBox(
        width: 240,
        height: 140,
        child: ColorField(
          color: Color(0xFF2563EB),
          saturationAxis: ColorFieldAxis.horizontal,
          valueAxis: ColorFieldAxis.vertical,
        ),
      ),
    ],
  );
}

/// The hue strip.
Widget _colorFieldHue(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      _ColorFieldLabel(docsSample(context, 'Hue strip')),
      SizedBox(
        width: 240,
        height: 24,
        child: ColorField(
          color: Color(0xFF2563EB),
          hueAxis: ColorFieldAxis.horizontal,
        ),
      ),
    ],
  );
}

/// The HSL lightness field.
Widget _colorFieldHsl(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      _ColorFieldLabel(docsSample(context, 'HSL field')),
      SizedBox(
        width: 240,
        height: 140,
        child: ColorField(
          color: Color(0x8022C55E),
          mode: ColorFieldMode.hsl,
          saturationAxis: ColorFieldAxis.horizontal,
          lightnessAxis: ColorFieldAxis.vertical,
        ),
      ),
    ],
  );
}

/// The alpha ramp.
Widget _colorFieldAlpha(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      _ColorFieldLabel(docsSample(context, 'Alpha ramp')),
      SizedBox(
        width: 240,
        height: 24,
        child: ColorField(
          color: Color(0xFF2563EB),
          alphaAxis: ColorFieldAxis.horizontal,
        ),
      ),
    ],
  );
}

/// Named docs examples for `color_field`; the first entry is the default.
List<ComponentPreview> get colorFieldPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _colorFieldDefault),
  ComponentPreview(docsSample(null, 'Hue'), _colorFieldHue),
  ComponentPreview(docsSample(null, 'HSL'), _colorFieldHsl),
  ComponentPreview(docsSample(null, 'Alpha'), _colorFieldAlpha),
];
