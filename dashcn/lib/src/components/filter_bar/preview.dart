// Named examples for the `filter_bar` component (P6-F3 preview contract).
//
// Demonstrates default inline layout, active removable chips, compact overflow
// menu, the open menu surface, and token/density customization.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import 'filter_bar.dart';

const List<FilterSortOption> _sortOptions = <FilterSortOption>[
  FilterSortOption(id: 'newest', label: 'Newest'),
  FilterSortOption(id: 'oldest', label: 'Oldest'),
  FilterSortOption(id: 'popular', label: 'Most popular'),
];

/// Inline bar with sort options, query applied, and a result count.
class _DefaultFilterBar extends StatefulWidget {
  const _DefaultFilterBar();

  @override
  State<_DefaultFilterBar> createState() => _DefaultFilterBarState();
}

class _DefaultFilterBarState extends State<_DefaultFilterBar> {
  FilterState _state = const FilterState(sortId: 'newest');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 520,
      child: FilterBar(
        state: _state,
        onStateChanged: (FilterState next) => setState(() => _state = next),
        sortOptions: _sortOptions,
        resultsCount: 42,
        presentation: FilterBarPresentation.inline,
      ),
    );
  }
}

Widget _default(BuildContext context) => const _DefaultFilterBar();

/// Inline bar with active filter chips and clear-all control.
class _ChipsFilterBar extends StatefulWidget {
  const _ChipsFilterBar();

  @override
  State<_ChipsFilterBar> createState() => _ChipsFilterBarState();
}

class _ChipsFilterBarState extends State<_ChipsFilterBar> {
  FilterState _state = const FilterState(
    sortId: 'newest',
    chips: <FilterChipData>[
      FilterChipData(key: 'tag:design', label: 'Tag: Design'),
      FilterChipData(key: 'status:active', label: 'Status: Active'),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 520,
      child: FilterBar(
        state: _state,
        onStateChanged: (FilterState next) => setState(() => _state = next),
        sortOptions: _sortOptions,
        resultsCount: 3,
        presentation: FilterBarPresentation.inline,
      ),
    );
  }
}

Widget _withChips(BuildContext context) => const _ChipsFilterBar();

/// Narrow bar that overflows secondary controls into a compact menu trigger.
class _OverflowFilterBar extends StatefulWidget {
  const _OverflowFilterBar();

  @override
  State<_OverflowFilterBar> createState() => _OverflowFilterBarState();
}

class _OverflowFilterBarState extends State<_OverflowFilterBar> {
  FilterState _state = const FilterState(search: 'theme', sortId: 'newest');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      child: FilterBar(
        state: _state,
        onStateChanged: (FilterState next) => setState(() => _state = next),
        sortOptions: _sortOptions,
        enableDateRange: true,
        resultsCount: 12,
        presentation: FilterBarPresentation.menu,
      ),
    );
  }
}

Widget _overflowMenu(BuildContext context) => const _OverflowFilterBar();

/// Overflow menu shown open with a filter applied.
class _OpenMenuFilterBar extends StatefulWidget {
  const _OpenMenuFilterBar();

  @override
  State<_OpenMenuFilterBar> createState() => _OpenMenuFilterBarState();
}

class _OpenMenuFilterBarState extends State<_OpenMenuFilterBar> {
  FilterState _state = const FilterState(
    sortId: 'newest',
    chips: <FilterChipData>[FilterChipData(key: 'tag:ui', label: 'Tag: UI')],
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FilterBar(
            state: _state,
            onStateChanged: (FilterState next) => setState(() => _state = next),
            sortOptions: _sortOptions,
            resultsCount: 7,
            presentation: FilterBarPresentation.menu,
          ),
          const Gap(kSpace2),
          FilterBarOverflowMenu(
            title: 'Filters',
            activeCount: _state.activeFilterCount,
            resultsCount: 7,
            width: 320,
            onClearAll: () => setState(() => _state = _state.cleared()),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FilterBarSortControl(
                  value: _state.sortId,
                  options: _sortOptions,
                  onChanged: (String? next) =>
                      setState(() => _state = _state.copyWith(sortId: next)),
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _openMenu(BuildContext context) => const _OpenMenuFilterBar();

/// Customized filter bar with style overrides and comfortable density.
class _CustomizedFilterBar extends StatefulWidget {
  const _CustomizedFilterBar();

  @override
  State<_CustomizedFilterBar> createState() => _CustomizedFilterBarState();
}

class _CustomizedFilterBarState extends State<_CustomizedFilterBar> {
  FilterState _state = const FilterState(search: 'compact', sortId: 'popular');

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    return SizedBox(
      width: 560,
      child: FilterBar(
        state: _state,
        onStateChanged: (FilterState next) => setState(() => _state = next),
        sortOptions: _sortOptions,
        resultsCount: 19,
        densityTokens: DensityTokens.comfortable,
        presentation: FilterBarPresentation.inline,
        style: FilterBarStyle(
          borderRadius: ambient.borderRadiusXl,
          padding: const EdgeInsets.all(kSpace3),
          searchWidth: 240,
          controlWidth: 200,
          controlHeight: 40,
          iconSize: 20,
        ),
      ),
    );
  }
}

Widget _customized(BuildContext context) => const _CustomizedFilterBar();

/// Named docs examples for `filter_bar`; the first entry is the default.
const List<ComponentPreview> filterBarPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('With chips', _withChips),
  ComponentPreview('Overflow menu', _overflowMenu),
  ComponentPreview('Overflow menu open', _openMenu),
  ComponentPreview('Customized', _customized),
];
