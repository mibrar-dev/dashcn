// Registry-owned theme data for the `toolbar` component: the component theme
// container ([ToolbarTheme]) and the token-derived default rows.
//
// `toolbar_style.dart` re-exports this file, so callers keep a single import.

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import 'toolbar_style.dart';

/// Component theme container for the toolbar.
class ToolbarTheme extends ComponentThemeData
    implements Mergeable<ToolbarTheme> {
  /// Creates a toolbar theme with one nullable slice per part.
  const ToolbarTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.container,
    this.item,
    this.group,
    this.separator,
  });

  /// Style of the toolbar's container.
  final ToolbarStyle? container;

  /// Style of the toolbar's items.
  final ToolbarStyle? item;

  /// Style of the toolbar's groups.
  final ToolbarStyle? group;

  /// Style of the toolbar's separators.
  final ToolbarStyle? separator;

  /// Returns a copy with the given fields replaced.
  ToolbarTheme copyWith({
    ValueGetter<ToolbarStyle?>? container,
    ValueGetter<ToolbarStyle?>? item,
    ValueGetter<ToolbarStyle?>? group,
    ValueGetter<ToolbarStyle?>? separator,
  }) {
    return ToolbarTheme(
      themeDensity: themeDensity,
      themeSpacing: themeSpacing,
      themeShadows: themeShadows,
      container: container == null ? this.container : container(),
      item: item == null ? this.item : item(),
      group: group == null ? this.group : group(),
      separator: separator == null ? this.separator : separator(),
    );
  }

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  ToolbarTheme merge(ToolbarTheme? fallback) {
    if (fallback == null) {
      return this;
    }
    return ToolbarTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      container: container?.merge(fallback.container) ?? fallback.container,
      item: item?.merge(fallback.item) ?? fallback.item,
      group: group?.merge(fallback.group) ?? fallback.group,
      separator: separator?.merge(fallback.separator) ?? fallback.separator,
    );
  }

  /// Lerps each row; state scales step at t < 0.5.
  static ToolbarTheme lerp(ToolbarTheme a, ToolbarTheme b, double t) {
    ToolbarStyle? row(ToolbarStyle? x, ToolbarStyle? y) {
      if (x == null) {
        return y;
      }
      if (y == null) {
        return x;
      }
      return ToolbarStyle.lerp(x, y, t);
    }

    return ToolbarTheme(
      themeDensity: t < 0.5 ? a.themeDensity : b.themeDensity,
      themeSpacing: t < 0.5 ? a.themeSpacing : b.themeSpacing,
      themeShadows: t < 0.5 ? a.themeShadows : b.themeShadows,
      container: row(a.container, b.container),
      item: row(a.item, b.item),
      group: row(a.group, b.group),
      separator: row(a.separator, b.separator),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ToolbarTheme &&
        other.themeDensity == themeDensity &&
        other.themeSpacing == themeSpacing &&
        other.themeShadows == themeShadows &&
        other.container == container &&
        other.item == item &&
        other.group == group &&
        other.separator == separator;
  }

  @override
  int get hashCode => Object.hash(
    themeDensity,
    themeSpacing,
    themeShadows,
    container,
    item,
    group,
    separator,
  );
}

/// Default gap between two toolbar items (8 px, density-scaled).
const double toolbarDefaultGap = 8;

/// Default item label style.
const TextStyle toolbarDefaultTextStyle = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w500,
);

// ---------------------------------------------------------------------------
// Defaults (registry-owned, tokens only).
// ---------------------------------------------------------------------------

const _itemBg = StateValue(
  rest: ThemedColor.ref(ColorRef.muted, alpha: 0),
  hovered: ThemedColor.ref(ColorRef.muted, alpha: 0.8),
  pressed: ThemedColor.ref(ColorRef.muted, alpha: 0.8),
);
const _itemFg = StateValue(
  rest: ThemedColor.ref(ColorRef.foreground),
  hovered: ThemedColor.ref(ColorRef.foreground),
  pressed: ThemedColor.ref(ColorRef.foreground),
);
const _toggleOnBg = StateValue(
  rest: ThemedColor.ref(ColorRef.primary, alpha: 0.15),
  hovered: ThemedColor.ref(ColorRef.primary, alpha: 0.2),
  pressed: ThemedColor.ref(ColorRef.primary, alpha: 0.2),
);

const _containerRow = ToolbarStyle(
  padding: EdgeInsetsDensity.pxAll(4),
  gap: toolbarDefaultGap,
);

const _itemRow = ToolbarStyle(
  itemBackground: _itemBg,
  itemForeground: _itemFg,
  itemPadding: EdgeInsetsDensity.pxSymmetric(horizontal: 8),
  textStyle: toolbarDefaultTextStyle,
);

const _groupRow = ToolbarStyle(
  groupBackground: ThemedColor.ref(ColorRef.muted, alpha: 0.4),
  groupPadding: EdgeInsetsDensity.pxAll(2),
);

const _separatorRow = ToolbarStyle(
  separatorColor: ThemedColor.ref(ColorRef.border),
  separatorThickness: 1,
);

/// Token-derived baseline rows; every unset override field falls through
/// here.
const ToolbarTheme toolbarDefaults = ToolbarTheme(
  container: _containerRow,
  item: _itemRow,
  group: _groupRow,
  separator: _separatorRow,
);

/// The fill a pressed toggle item paints.
const StateValue<ThemedColor> toolbarToggleBackground = _toggleOnBg;

/// Resolves the toolbar's theme.
///
/// The widget-leg [style] wins over the generic widget-leg [theme]; the
/// result is merged over the app theme and over [toolbarDefaults]. The size
/// table fills the gaps the theme leaves, while an explicit `itemSize` /
/// `iconSize` in the theme still wins.
ToolbarTheme resolveToolbarTheme({
  required BuildContext context,
  required ToolbarStyle? style,
  required ToolbarStyle? theme,
  required ToolbarSize size,
}) {
  final ToolbarStyle? widgetStyle = style == null
      ? theme
      : (theme == null ? style : style.merge(theme));
  final ToolbarTheme resolved =
      resolveComponentStyle<ToolbarTheme, ToolbarTheme>(
        context,
        widget: widgetStyle == null
            ? null
            : ToolbarTheme(
                container: widgetStyle,
                item: widgetStyle,
                group: widgetStyle,
                separator: widgetStyle,
              ),
        select: (ToolbarTheme t) => t,
        defaults: toolbarDefaults,
      );
  return ToolbarTheme(
    themeDensity: resolved.themeDensity,
    themeSpacing: resolved.themeSpacing,
    themeShadows: resolved.themeShadows,
    container: resolved.container,
    item: resolved.item?.merge(
      ToolbarStyle(
        itemSize: toolbarItemBoxFor(size),
        iconSize: toolbarIconFor(size),
      ),
    ),
    group: resolved.group,
    separator: resolved.separator,
  );
}
