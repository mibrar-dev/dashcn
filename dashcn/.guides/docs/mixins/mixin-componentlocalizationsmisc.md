---
title: "Mixin: ComponentLocalizationsMisc"
description: "Shared action, refresh, color-picker, table and empty-state text for  [ComponentLocalizations]."
---

```dart
/// Shared action, refresh, color-picker, table and empty-state text for
/// [ComponentLocalizations].
///
/// Applied by `ComponentLocalizations`; every getter has an English default and
/// translated locale tables may override it.
mixin ComponentLocalizationsMisc {
  String get buttonCancel;
  String get buttonSave;
  String get buttonPrevious;
  String get buttonNext;
  String get refreshTriggerRefreshing;
  String get refreshTriggerComplete;
  String get refreshTriggerPull;
  String get refreshTriggerRelease;
  String get placeholderColorPicker;
  String get colorPickerTabRGB;
  String get colorPickerTabHSL;
  String get colorPickerTabHSV;
  String get colorPickerTabHEX;
  String get colorRed;
  String get colorGreen;
  String get colorBlue;
  String get colorAlpha;
  String get colorHue;
  String get colorSaturation;
  String get colorLightness;
  String get colorValue;
  /// Semantics label for a column resize handle.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get tableResizeColumn;
  /// Semantics label for a row resize handle.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get tableResizeRow;
  /// Semantics label for a resizable pane divider handle.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get resizableHandle;
  /// Default title of an `empty_state` with no content yet.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get emptyStateEmptyTitle;
  /// Default description of an `empty_state` with no content yet.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get emptyStateEmptyDescription;
  /// Default title of an `empty_state` after a search returned nothing.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get emptyStateNoResultsTitle;
  /// Default description of an `empty_state` after a search returned nothing.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get emptyStateNoResultsDescription;
  /// Default title of an `empty_state` standing in for a failed load.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get emptyStateErrorTitle;
  /// Default description of an `empty_state` standing in for a failed load.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get emptyStateErrorDescription;
  /// Placeholder and semantics label of a `filter_bar` search field.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get filterSearch;
  /// Placeholder of a `filter_bar` sort control.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get filterSort;
  /// Placeholder of a `filter_bar` date-range control.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get filterDateRange;
  /// Label of a `filter_bar` clear action.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get filterClearAll;
  /// Trigger label and sheet title of a `filter_bar`.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String get filterFilters;
  /// Counter text of a `filter_bar` with [count] active filters.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String filterActiveCount(int count);
  /// Counter text of a `filter_bar` showing [count] results.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  String filterResultsCount(int count);
}
```
