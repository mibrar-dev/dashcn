// Sub-widgets and controls for the `filter_bar` component.
//
// Sized from density tokens (compact default): search field, sort dropdown,
// date range picker, and re-exported action/trigger buttons.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/filter_core/filter_state.dart';
import '../../primitives/form_core/object_form_field.dart';
import '../../primitives/input_features/adornment_features.dart';
import '../../primitives/localizations/localizations.dart';
import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import '../date_picker/date_picker.dart';
import '../input/input.dart';
import '../select/select.dart';

export 'filter_bar_triggers.dart';

/// The search field of a `FilterBar` (leading icon + clear action).
class FilterBarSearchField extends StatelessWidget {
  /// Creates the search field.
  const FilterBarSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.width = 220,
    this.height,
    this.iconSize,
    this.textStyle,
    this.placeholder,
    this.densityTokens,
  });

  /// Owns the query text.
  final TextEditingController controller;

  /// Called on every edit (the bar debounces it).
  final ValueChanged<String> onChanged;

  /// Fixed field width; defaults to 220.
  final double width;

  /// Height override; defaults to token row height (36 compact).
  final double? height;

  /// Icon size override; defaults to token icon size (16 compact).
  final double? iconSize;

  /// Custom typography for the input.
  final TextStyle? textStyle;

  /// Custom placeholder widget.
  final Widget? placeholder;

  /// Density tokens driving control dimensions.
  final DensityTokens? densityTokens;

  @override
  Widget build(BuildContext context) {
    final ComponentLocalizations l10n = ComponentLocalizations.of(context);
    // Same visuals desktop/mobile: ambient tokens, no phone-width switch.
    final DensityTokens tokens =
        densityTokens ?? Theme.of(context).densityTokens;
    final double effectiveHeight = height ?? 36.0;
    final double effectiveIconSize = iconSize ?? tokens.iconSize;

    return SizedBox(
      width: width,
      height: effectiveHeight,
      child: Input(
        controller: controller,
        placeholder: placeholder ?? Text(l10n.filterSearch),
        onChanged: onChanged,
        style: textStyle,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        features: [
          InputLeadingFeature(
            Icon(LucideIcons.search, size: effectiveIconSize),
          ),
          InputClearFeature(
            icon: Semantics(
              label: l10n.filterClearAll,
              child: Icon(LucideIcons.x, size: effectiveIconSize),
            ),
          ),
        ],
      ),
    );
  }
}

/// The sort dropdown of a `FilterBar`.
class FilterBarSortControl extends StatelessWidget {
  /// Creates the sort control.
  const FilterBarSortControl({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.width = 180,
    this.height,
    this.iconSize,
    this.textStyle,
    this.densityTokens,
  });

  /// Selected option id, or null.
  final String? value;

  /// Options offered by the dropdown.
  final List<FilterSortOption> options;

  /// Called with the next option id (null clears the sort).
  final ValueChanged<String?> onChanged;

  /// Fixed control width; defaults to 180.
  final double width;

  /// Height override; defaults to 36 (sizing-scale control height, same
  /// desktop/mobile across inline, popup, dialog and sheet variants).
  final double? height;

  /// Icon size override; defaults to token icon size (16 compact).
  final double? iconSize;

  /// Custom text style.
  final TextStyle? textStyle;

  /// Density tokens driving control dimensions.
  final DensityTokens? densityTokens;

  @override
  Widget build(BuildContext context) {
    final DensityTokens tokens =
        densityTokens ?? Theme.of(context).densityTokens;
    // 36 px control height on every variant (same desktop/mobile).
    final double minH = height ?? 36.0;

    return SizedBox(
      width: width,
      child: Select<String>(
        value: value,
        onChanged: onChanged,
        triggerMinHeight: minH,
        placeholder: Text(
          ComponentLocalizations.of(context).filterSort,
          style: textStyle,
        ),
        itemBuilder: (context, val) => Text(
          _label(val),
          style: textStyle ?? TextStyle(fontSize: tokens.bodyTextSize),
        ),
        items: <Widget>[
          for (final FilterSortOption option in options)
            SelectItem<String>(
              value: option.id,
              child: Text(
                option.label,
                style: textStyle ?? TextStyle(fontSize: tokens.bodyTextSize),
              ),
            ),
        ],
      ),
    );
  }

  String _label(String id) {
    for (final FilterSortOption option in options) {
      if (option.id == id) {
        return option.label;
      }
    }
    return id;
  }
}

/// The date-range control of a `FilterBar` (popover editor).
class FilterBarDateControl extends StatelessWidget {
  /// Creates the date control.
  const FilterBarDateControl({
    super.key,
    required this.value,
    required this.onChanged,
    this.width = 180,
    this.height,
    this.densityTokens,
  });

  /// Selected span, or null.
  final FilterDateRange? value;

  /// Called with the next span (null clears it).
  final ValueChanged<FilterDateRange?> onChanged;

  /// Fixed control width; defaults to 180.
  final double width;

  /// Height override; defaults to 36 (sizing-scale control height, same
  /// desktop/mobile across inline, popup, dialog and sheet variants).
  final double? height;

  /// Density tokens driving control dimensions.
  final DensityTokens? densityTokens;

  @override
  Widget build(BuildContext context) {
    final FilterDateRange? range = value;
    // 36 px control height on every variant (same desktop/mobile).
    final double effectiveHeight = height ?? 36.0;

    return SizedBox(
      width: width,
      height: effectiveHeight,
      child: DateRangePicker(
        value: range == null
            ? null
            : DateTimeRange(
                range.start ?? range.end!,
                range.end ?? range.start!,
              ),
        mode: PromptMode.popover,
        placeholder: Text(ComponentLocalizations.of(context).filterDateRange),
        onChanged: (DateTimeRange? next) => onChanged(
          next == null
              ? null
              : FilterDateRange(start: next.start, end: next.end),
        ),
      ),
    );
  }
}
