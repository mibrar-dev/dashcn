// Registry-owned theme data for the `sidebar` component: [SidebarTheme],
// the token [sidebarDefaults] and the sizing constants. Overrides live in
// `sidebar_theme.dart`.

import 'package:flutter/widgets.dart';

import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';

/// Expanded rail width: 256 px (SIZING.md sidebar).
const double kSidebarExpandedWidth = 256.0;

/// Collapsed rail width: 64 px, icons only with tooltips.
const double kSidebarCollapsedWidth = 64.0;

/// Navigation row height: 32 px (SIZING.md row minimum).
const double kSidebarItemHeight = 32.0;

/// Nested sub-menu row height: 28 px (SIZING.md bars' inner items).
const double kSidebarSubItemHeight = 28.0;

/// Navigation and header icon size: 16 px (compact density icon).
const double kSidebarIconSize = 16.0;

/// Group label size: 12 px, muted.
const double kSidebarGroupLabelSize = 12.0;

/// Visual contract of the dashboard sidebar. Every field is nullable: an
/// override leg sets only what it changes and [merge] keeps the lower leg's
/// remaining fields.
class SidebarTheme extends ComponentThemeData
    implements Mergeable<SidebarTheme> {
  /// Creates a sidebar theme.
  const SidebarTheme({
    super.themeDensity,
    super.themeDensityTokens,
    super.themeSpacing,
    super.themeShadows,
    this.expandedWidth,
    this.collapsedWidth,
    this.itemHeight,
    this.iconSize,
    this.background,
    this.foreground,
    this.borderColor,
    this.activeBackground,
    this.activeForeground,
    this.groupLabelColor,
    this.itemRadius,
    this.itemPadding,
    this.surfaceOpacity,
    this.surfaceBlur,
  });

  /// Expanded rail width. Default: [kSidebarExpandedWidth] (256).
  final double? expandedWidth;

  /// Collapsed rail width. Default: [kSidebarCollapsedWidth] (64).
  final double? collapsedWidth;

  /// Navigation row height. Default: [kSidebarItemHeight] (32).
  final double? itemHeight;

  /// Navigation and header icon size. Default: [kSidebarIconSize] (16).
  final double? iconSize;

  /// Rail fill. Default: the `sidebar` token.
  final ThemedColor? background;

  /// Rail foreground (labels, icons). Default: `sidebarForeground`.
  final ThemedColor? foreground;

  /// Rail edge border. Default: `sidebarBorder`.
  final ThemedColor? borderColor;

  /// Selected row fill. Default: `sidebarAccent`.
  final ThemedColor? activeBackground;

  /// Selected row foreground. Default: `sidebarAccentForeground`.
  final ThemedColor? activeForeground;

  /// Group label colour. Default: `mutedForeground`.
  final ThemedColor? groupLabelColor;

  /// Row corner radius. Default: `theme.borderRadiusMd`.
  final BorderRadiusGeometry? itemRadius;

  /// Row inner padding. Default: 8 horizontal, 4 vertical.
  final EdgeInsetsGeometry? itemPadding;

  /// Frosted-glass opacity leg for the rail surface. Default: null (opaque).
  final double? surfaceOpacity;

  /// Frosted-glass blur leg for the rail surface. Default: null (no blur).
  final double? surfaceBlur;

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  SidebarTheme merge(SidebarTheme? fallback) {
    if (fallback == null) {
      return this;
    }
    return SidebarTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeDensityTokens: themeDensityTokens ?? fallback.themeDensityTokens,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      expandedWidth: expandedWidth ?? fallback.expandedWidth,
      collapsedWidth: collapsedWidth ?? fallback.collapsedWidth,
      itemHeight: itemHeight ?? fallback.itemHeight,
      iconSize: iconSize ?? fallback.iconSize,
      background: background ?? fallback.background,
      foreground: foreground ?? fallback.foreground,
      borderColor: borderColor ?? fallback.borderColor,
      activeBackground: activeBackground ?? fallback.activeBackground,
      activeForeground: activeForeground ?? fallback.activeForeground,
      groupLabelColor: groupLabelColor ?? fallback.groupLabelColor,
      itemRadius: itemRadius ?? fallback.itemRadius,
      itemPadding: itemPadding ?? fallback.itemPadding,
      surfaceOpacity: surfaceOpacity ?? fallback.surfaceOpacity,
      surfaceBlur: surfaceBlur ?? fallback.surfaceBlur,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SidebarTheme &&
          other.themeDensity == themeDensity &&
          other.themeDensityTokens == themeDensityTokens &&
          other.themeSpacing == themeSpacing &&
          other.themeShadows == themeShadows &&
          other.expandedWidth == expandedWidth &&
          other.collapsedWidth == collapsedWidth &&
          other.itemHeight == itemHeight &&
          other.iconSize == iconSize &&
          other.background == background &&
          other.foreground == foreground &&
          other.borderColor == borderColor &&
          other.activeBackground == activeBackground &&
          other.activeForeground == activeForeground &&
          other.groupLabelColor == groupLabelColor &&
          other.itemRadius == itemRadius &&
          other.itemPadding == itemPadding &&
          other.surfaceOpacity == surfaceOpacity &&
          other.surfaceBlur == surfaceBlur;

  @override
  int get hashCode => Object.hashAll(<Object?>[
    themeDensity,
    themeDensityTokens,
    themeSpacing,
    themeShadows,
    expandedWidth,
    collapsedWidth,
    itemHeight,
    iconSize,
    background,
    foreground,
    borderColor,
    activeBackground,
    activeForeground,
    groupLabelColor,
    itemRadius,
    itemPadding,
    surfaceOpacity,
    surfaceBlur,
  ]);
}

/// Token-derived baseline; every unset override field falls through here.
///
/// `itemHeight` stays null on purpose: top-level rows resolve 32 px and
/// nested sub-menu rows 28 px in the sidebar (SIZING.md).
const SidebarTheme sidebarDefaults = SidebarTheme(
  expandedWidth: kSidebarExpandedWidth,
  collapsedWidth: kSidebarCollapsedWidth,
  iconSize: kSidebarIconSize,
  background: ThemedColor.ref(ColorRef.sidebar),
  foreground: ThemedColor.ref(ColorRef.sidebarForeground),
  borderColor: ThemedColor.ref(ColorRef.sidebarBorder),
  activeBackground: ThemedColor.ref(ColorRef.sidebarAccent),
  activeForeground: ThemedColor.ref(ColorRef.sidebarAccentForeground),
  groupLabelColor: ThemedColor.ref(ColorRef.mutedForeground),
  itemPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
);
