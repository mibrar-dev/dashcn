// Named examples for the `steps` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../theme/color_tokens.dart';
import 'steps.dart';

/// The default vertical flow.
Widget _default(BuildContext context) {
  return Steps(
    children: <Widget>[
      StepItem(
        title: Text(docsSample(context, 'Account')),
        content: <Widget>[
          Text(docsSample(context, 'Sign up with your email address.')),
        ],
      ),
      StepItem(
        title: Text(docsSample(context, 'Verify')),
        content: <Widget>[
          Text(docsSample(context, 'Check your inbox for a code.')),
        ],
      ),
      StepItem(
        title: Text(docsSample(context, 'Profile')),
        content: <Widget>[
          Text(docsSample(context, 'Add your personal information.')),
        ],
      ),
    ],
  );
}

/// Larger indicators tinted with the primary token.
Widget _custom(BuildContext context) {
  return Steps(
    theme: const StepsTheme(
      indicatorSize: 32,
      indicatorColor: ThemedColor.ref(ColorRef.primary),
      indicatorForeground: ThemedColor.ref(ColorRef.primaryForeground),
      connectorColor: ThemedColor.ref(ColorRef.primary, alpha: 0.4),
    ),
    children: <Widget>[
      StepItem(
        title: Text(docsSample(context, 'Cart')),
        content: <Widget>[Text(docsSample(context, 'Review items.'))],
      ),
      StepItem(
        title: Text('Pay'),
        content: <Widget>[Text(docsSample(context, 'Choose a method.'))],
      ),
    ],
  );
}

/// A single step.
Widget _single(BuildContext context) {
  return Steps(
    children: <Widget>[
      StepItem(
        title: Text(docsSample(context, 'Done')),
        content: <Widget>[Text(docsSample(context, 'Nothing else.'))],
      ),
    ],
  );
}

/// Named docs examples for `steps`; the first entry is the default.
List<ComponentPreview> get stepsPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _default),
  ComponentPreview(docsSample(null, 'Custom indicators'), _custom),
  ComponentPreview(docsSample(null, 'Single step'), _single),
];
