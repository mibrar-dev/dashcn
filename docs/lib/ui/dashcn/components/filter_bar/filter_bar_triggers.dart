// Trigger and clear action buttons for `filter_bar`.
//
// All triggers are 36 px (ButtonSize.md, the sizing-scale control height)
// on every variant — inline, popup, dialog and sheet — same on desktop
// and mobile. Dense mode drops to 32 px (sm); touch comfort is invisible
// hit area, never larger visuals.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/localizations/localizations.dart';
import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import '../button/button.dart';

/// The clear-all action of a `FilterBar`.
class FilterBarClearButton extends StatelessWidget {
  /// Creates the clear button.
  const FilterBarClearButton({
    super.key,
    required this.enabled,
    required this.onPressed,
    this.dense = false,
    this.iconSize,
    this.densityTokens,
  });

  /// Whether the action is active.
  final bool enabled;

  /// Called when pressed.
  final VoidCallback onPressed;

  /// Compact size.
  final bool dense;

  /// Icon size override.
  final double? iconSize;

  /// Density tokens driving control dimensions.
  final DensityTokens? densityTokens;

  @override
  Widget build(BuildContext context) {
    // 36 px (md) by default, 32 px (sm) when dense. Same desktop/mobile.
    final ButtonSize size = dense ? ButtonSize.sm : ButtonSize.md;

    return Button(
      variant: ButtonVariant.ghost,
      size: size,
      onPressed: enabled ? onPressed : null,
      child: Text(ComponentLocalizations.of(context).filterClearAll),
    );
  }
}

/// The responsive overflow and sheet trigger of a `FilterBar`.
class FilterBarSheetTrigger extends StatelessWidget {
  /// Creates the trigger.
  const FilterBarSheetTrigger({
    super.key,
    required this.activeCount,
    required this.onPressed,
    this.dense = false,
    this.iconSize,
    this.densityTokens,
  });

  /// Number of active filters, appended to the label when non-zero.
  final int activeCount;

  /// Opens the sheet or menu.
  final VoidCallback onPressed;

  /// Compact size.
  final bool dense;

  /// Icon size override.
  final double? iconSize;

  /// Density tokens driving control dimensions.
  final DensityTokens? densityTokens;

  @override
  Widget build(BuildContext context) {
    final String label = ComponentLocalizations.of(context).filterFilters;
    final DensityTokens tokens =
        densityTokens ?? Theme.of(context).densityTokens;
    // 36 px (md) by default, 32 px (sm) when dense. Same desktop/mobile.
    final ButtonSize size = dense ? ButtonSize.sm : ButtonSize.md;
    final double effectiveIconSize = iconSize ?? tokens.iconSize;

    return Button(
      variant: ButtonVariant.secondary,
      size: size,
      onPressed: onPressed,
      leading: Icon(LucideIcons.slidersHorizontal, size: effectiveIconSize),
      child: Text(activeCount == 0 ? label : '$label ($activeCount)'),
    );
  }
}

/// Alias for [FilterBarSheetTrigger] when used for menu overflow.
typedef FilterBarOverflowTrigger = FilterBarSheetTrigger;
