---
title: "Class: FilterBarGroupedContent"
description: "Renders custom filters under [FilterGroup] headers."
---

```dart
/// Renders custom filters under [FilterGroup] headers.
///
/// Every filter renders exactly once: grouped ids under their group, all
/// other ids (and [trailing] controls) in a final ungrouped wrap. With an
/// empty [groups] list this is the flat control wrap.
class FilterBarGroupedContent extends StatelessWidget {
  /// Creates the grouped (or flat) filter content.
  const FilterBarGroupedContent({super.key, required this.state, required this.onChanged, required this.groups, required this.customFilters, this.trailing = const <Widget>[], this.spacing = 12, this.runSpacing = 8});
  /// Current filter state.
  final FilterState state;
  /// Receives the next state from a custom filter.
  final FilterStateChanged onChanged;
  /// Groups to render; empty renders [customFilters] and [trailing] flat.
  final List<FilterGroup> groups;
  /// Custom filters offered by the bar.
  final List<FilterCustomFilter> customFilters;
  /// Controls appended after the groups (sort/date/trailing widgets).
  final List<Widget> trailing;
  /// Gap between controls on the same run.
  final double spacing;
  /// Gap between wrapped runs.
  final double runSpacing;
  Widget build(BuildContext context);
}
```
