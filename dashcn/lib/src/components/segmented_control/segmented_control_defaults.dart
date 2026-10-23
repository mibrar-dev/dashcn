// Registry-owned theme data for the `segmented_control` component: the
// component theme container ([SegmentedControlTheme]) and the token-derived
// default rows.
//
// `segmented_control_style.dart` re-exports this file, so callers keep a
// single import.

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import 'segmented_control_style.dart';

/// Component theme container for the segmented control.
class SegmentedControlTheme extends ComponentThemeData
    implements Mergeable<SegmentedControlTheme> {
  /// Creates a segmented control theme.
  const SegmentedControlTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.control,
    this.segment,
  });

  /// Style of the control's track and thumb.
  final SegmentedControlStyle? control;

  /// Style of the control's segments.
  final SegmentedControlStyle? segment;

  /// Returns a copy with the given fields replaced.
  SegmentedControlTheme copyWith({
    ValueGetter<SegmentedControlStyle?>? control,
    ValueGetter<SegmentedControlStyle?>? segment,
  }) {
    return SegmentedControlTheme(
      themeDensity: themeDensity,
      themeSpacing: themeSpacing,
      themeShadows: themeShadows,
      control: control == null ? this.control : control(),
      segment: segment == null ? this.segment : segment(),
    );
  }

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  SegmentedControlTheme merge(SegmentedControlTheme? fallback) {
    if (fallback == null) {
      return this;
    }
    return SegmentedControlTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      control: control?.merge(fallback.control) ?? fallback.control,
      segment: segment?.merge(fallback.segment) ?? fallback.segment,
    );
  }

  /// Lerps each row; state scales step at t < 0.5.
  static SegmentedControlTheme lerp(
    SegmentedControlTheme a,
    SegmentedControlTheme b,
    double t,
  ) {
    SegmentedControlStyle? row(
      SegmentedControlStyle? x,
      SegmentedControlStyle? y,
    ) {
      if (x == null) {
        return y;
      }
      if (y == null) {
        return x;
      }
      return SegmentedControlStyle.lerp(x, y, t);
    }

    return SegmentedControlTheme(
      themeDensity: t < 0.5 ? a.themeDensity : b.themeDensity,
      themeSpacing: t < 0.5 ? a.themeSpacing : b.themeSpacing,
      themeShadows: t < 0.5 ? a.themeShadows : b.themeShadows,
      control: row(a.control, b.control),
      segment: row(a.segment, b.segment),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is SegmentedControlTheme &&
        other.themeDensity == themeDensity &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.control == control &&
        other.segment == segment;
  }

  @override
  int get hashCode =>
      Object.hash(themeDensity, themeSpacing, themeShadows, control, segment);
}

/// Default label style of a segmented control.
const TextStyle segmentedControlDefaultTextStyle = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w500,
);

// ---------------------------------------------------------------------------
// Defaults (registry-owned, tokens only).
// ---------------------------------------------------------------------------

const _trackBg = ThemedColor.ref(ColorRef.muted, alpha: 0.6);
const _thumbBg = ThemedColor.ref(ColorRef.background);
const _restFg = StateValue(
  rest: ThemedColor.ref(ColorRef.mutedForeground),
  hovered: ThemedColor.ref(ColorRef.foreground),
  pressed: ThemedColor.ref(ColorRef.foreground),
);
const _selectedFg = StateValue(
  rest: ThemedColor.ref(ColorRef.foreground),
  hovered: ThemedColor.ref(ColorRef.foreground),
  pressed: ThemedColor.ref(ColorRef.foreground),
);

const _controlRow = SegmentedControlStyle(
  background: _trackBg,
  thumbBackground: _thumbBg,
  thumbBorderColor: ThemedColor.ref(ColorRef.border),
  thumbBorderWidth: 1,
  borderRadius: BorderRadius.all(Radius.circular(8)),
  padding: EdgeInsetsDensity.pxAll(4),
  gap: 0,
);

const _segmentRow = SegmentedControlStyle(
  foreground: _restFg,
  selectedForeground: _selectedFg,
  segmentPadding: EdgeInsetsDensity.pxSymmetric(horizontal: 8),
  textStyle: segmentedControlDefaultTextStyle,
);

/// Token-derived baseline rows; every unset override field falls through
/// here.
const SegmentedControlTheme segmentedControlDefaults = SegmentedControlTheme(
  control: _controlRow,
  segment: _segmentRow,
);

/// Resolves the segmented control's theme.
///
/// The widget-leg [style] wins over the generic widget-leg [theme]; the
/// result is merged over the app theme and over [segmentedControlDefaults].
SegmentedControlTheme resolveSegmentedControlTheme({
  required BuildContext context,
  required SegmentedControlStyle? style,
  required SegmentedControlStyle? theme,
}) {
  final SegmentedControlStyle? widgetStyle = style == null
      ? theme
      : (theme == null ? style : style.merge(theme));
  return resolveComponentStyle<SegmentedControlTheme, SegmentedControlTheme>(
    context,
    widget: widgetStyle == null
        ? null
        : SegmentedControlTheme(control: widgetStyle, segment: widgetStyle),
    select: (SegmentedControlTheme t) => t,
    defaults: segmentedControlDefaults,
  );
}
