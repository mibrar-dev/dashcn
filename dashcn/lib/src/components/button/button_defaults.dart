// Token-derived variant rows for the `button` component: the baseline
// [ButtonTheme] every unset override field falls through to.
//
// Registry-owned data (moved out of `button_style.dart` so that file stays
// on the theme shape). CLI updates may replace this file.
//
// Disabled states are intentionally absent: every `StateValue` falls back to
// its `rest` entry, and `Button` dims the whole control to 50% opacity when
// disabled (upstream `disabled:opacity-50`). Pressed duplicates hovered because
// `StateValue.resolve` never falls back from one state to another.

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import 'button_style.dart';

const _primaryBg = StateValue(
  rest: ThemedColor.ref(ColorRef.primary),
  hovered: ThemedColor.ref(ColorRef.primary, alpha: 0.9),
  pressed: ThemedColor.ref(ColorRef.primary, alpha: 0.9),
);
const _primaryRow = ButtonVariantStyle(
  background: _primaryBg,
  foreground: StateValue(rest: ThemedColor.ref(ColorRef.primaryForeground)),
);

const _secondaryBg = StateValue(
  rest: ThemedColor.ref(ColorRef.secondary),
  hovered: ThemedColor.ref(ColorRef.secondary, alpha: 0.8),
  pressed: ThemedColor.ref(ColorRef.secondary, alpha: 0.8),
);
const _secondaryRow = ButtonVariantStyle(
  background: _secondaryBg,
  foreground: StateValue(rest: ThemedColor.ref(ColorRef.secondaryForeground)),
);

const _outlineBg = StateValue(
  rest: ThemedColor.ref(ColorRef.input, alpha: 0.3),
  hovered: ThemedColor.ref(ColorRef.input, alpha: 0.5),
  pressed: ThemedColor.ref(ColorRef.input, alpha: 0.5),
);
const _outlineRow = ButtonVariantStyle(
  background: _outlineBg,
  foreground: StateValue(rest: ThemedColor.ref(ColorRef.foreground)),
  borderColor: StateValue(rest: ThemedColor.ref(ColorRef.input)),
  borderWidth: 1,
);

const _ghostBg = StateValue(
  rest: ThemedColor.ref(ColorRef.muted, alpha: 0),
  hovered: ThemedColor.ref(ColorRef.muted, alpha: 0.8),
  pressed: ThemedColor.ref(ColorRef.muted, alpha: 0.8),
);
const _ghostRow = ButtonVariantStyle(
  background: _ghostBg,
  foreground: StateValue(rest: ThemedColor.ref(ColorRef.foreground)),
);

const _linkRow = ButtonVariantStyle(
  foreground: StateValue(rest: ThemedColor.ref(ColorRef.foreground)),
  decoration: StateValue(
    hovered: TextDecoration.underline,
    pressed: TextDecoration.underline,
  ),
  // upstream link is a plain anchor (ml-auto): no horizontal padding, so an
  // end-aligned link's text meets the field's right edge.
  padding: EdgeInsets.zero,
);

const _textRow = ButtonVariantStyle(
  foreground: StateValue(
    rest: ThemedColor.ref(ColorRef.mutedForeground),
    hovered: ThemedColor.ref(ColorRef.primary),
    pressed: ThemedColor.ref(ColorRef.primary),
  ),
  // Same plain-anchor shape as link: no horizontal padding.
  padding: EdgeInsets.zero,
);

const _destructiveBg = StateValue(
  rest: ThemedColor.ref(ColorRef.destructive),
  hovered: ThemedColor.ref(ColorRef.destructive, alpha: 0.9),
  pressed: ThemedColor.ref(ColorRef.destructive, alpha: 0.9),
);
const _destructiveRow = ButtonVariantStyle(
  background: _destructiveBg,
  foreground: StateValue(rest: ThemedColor.ref(ColorRef.destructiveForeground)),
);

/// Token-derived baseline rows; every unset override field falls through here.
const ButtonTheme buttonDefaults = ButtonTheme(
  primary: _primaryRow,
  secondary: _secondaryRow,
  outline: _outlineRow,
  ghost: _ghostRow,
  link: _linkRow,
  text: _textRow,
  destructive: _destructiveRow,
);
