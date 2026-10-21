// Trigger and clear action buttons for `filter_bar`.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/localizations/localizations.dart';
import '../../theme/density_tokens.dart';
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
    final DensityTokens tokens = resolveDensityTokens(
      context,
      override: densityTokens,
    );
    final ButtonSize size = dense
        ? ButtonSize.xs
        : (tokens.preset == DensityPreset.compact
              ? ButtonSize.sm
              : ButtonSize.md);

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
    final DensityTokens tokens = resolveDensityTokens(
      context,
      override: densityTokens,
    );
    final ButtonSize size = dense
        ? ButtonSize.sm
        : (tokens.preset == DensityPreset.compact
              ? ButtonSize.sm
              : ButtonSize.md);
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
