// Named examples for the `text_animate` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import 'text_animate.dart';

String _sample = docsSample(null, 'Ship a new build to production.');

/// Opacity-only entrance.
Widget _default(BuildContext context) {
  return TextAnimate(text: _sample, effect: TextAnimateEffect.fade());
}

/// Vertical slide entrance.
Widget _slide(BuildContext context) {
  return TextAnimate(text: _sample, effect: TextAnimateEffect.slide());
}

/// Blur-to-sharp entrance.
Widget _blur(BuildContext context) {
  return TextAnimate(text: _sample, effect: TextAnimateEffect.blur());
}

/// Scramble-then-resolve entrance.
Widget _scramble(BuildContext context) {
  return TextAnimate(text: _sample, effect: TextAnimateEffect.scramble());
}

/// Word-by-word slide with a blinking cursor.
Widget _words(BuildContext context) {
  return TextAnimate(
    text: _sample,
    animateByWord: true,
    effect: TextAnimateEffect.slide(),
    cursor: TextAnimateCursor.blink(),
  );
}

/// Named docs examples for `text_animate`; the first entry is the default.
List<ComponentPreview> get textAnimatePreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _default),
  ComponentPreview(docsSample(null, 'Slide'), _slide),
  ComponentPreview(docsSample(null, 'Blur'), _blur),
  ComponentPreview(docsSample(null, 'Scramble'), _scramble),
  ComponentPreview(docsSample(null, 'Words'), _words),
];
