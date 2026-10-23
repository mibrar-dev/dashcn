// Named examples for the `search_bar` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import 'search_bar.dart';

List<String> _searchFruits = <String>[
  docsSample(null, 'Apple'),
  docsSample(null, 'Apricot'),
  docsSample(null, 'Avocado'),
  docsSample(null, 'Banana'),
  docsSample(null, 'Cherry'),
  docsSample(null, 'Grape'),
  docsSample(null, 'Kiwi'),
  docsSample(null, 'Lemon'),
  docsSample(null, 'Mango'),
  docsSample(null, 'Orange'),
  docsSample(null, 'Peach'),
  docsSample(null, 'Pear'),
  docsSample(null, 'Pineapple'),
  docsSample(null, 'Strawberry'),
  docsSample(null, 'Watermelon'),
];

/// The status line every interactive example writes to.
class _StatusLine extends StatelessWidget {
  const _StatusLine(this.status);

  final String status;

  @override
  Widget build(BuildContext context) {
    return Text(
      docsSample(context, status),
      style: TextStyle(
        fontSize: 12,
        color: Theme.of(context).colors.mutedForeground,
      ),
    );
  }
}

/// The default ranked field with a debounced echo and a selection echo.
class _SearchBarDefault extends StatefulWidget {
  const _SearchBarDefault();

  @override
  State<_SearchBarDefault> createState() => _SearchBarDefaultState();
}

class _SearchBarDefaultState extends State<_SearchBarDefault> {
  String _query = '';
  String _selected = '';

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SearchBar<String>(
            items: _searchFruits,
            hintText: docsSample(context, 'Search fruit'),
            onChanged: (String query) => setState(() => _query = query),
            onSelected: (String item) => setState(() => _selected = item),
          ),
          Gap(spacing.sm),
          _StatusLine(
            _selected.isEmpty
                ? (_query.isEmpty
                      ? docsSample(context, 'Type to filter')
                      : 'query: $_query')
                : 'Selected $_selected for "$_query"',
          ),
        ],
      ),
    );
  }
}

/// Ranked groups with headings; empty groups never render.
class _SearchBarGroups extends StatefulWidget {
  const _SearchBarGroups();

  @override
  State<_SearchBarGroups> createState() => _SearchBarGroupsState();
}

class _SearchBarGroupsState extends State<_SearchBarGroups> {
  String _selected = '';

  static final List<SearchBarGroup<String>> _groups = <SearchBarGroup<String>>[
    SearchBarGroup<String>(
      label: docsSample(null, 'Suggestions'),
      items: <String>[
        'Calendar',
        docsSample(null, 'Search Emoji'),
        docsSample(null, 'Launch'),
      ],
    ),
    SearchBarGroup<String>(
      label: docsSample(null, 'Settings'),
      items: <String>[
        docsSample(null, 'Profile'),
        docsSample(null, 'Mail'),
        docsSample(null, 'Settings'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SearchBar<String>(
            groups: _groups,
            hintText: docsSample(context, 'Search commands'),
            onSelected: (String item) => setState(() => _selected = item),
          ),
          Gap(spacing.sm),
          _StatusLine(
            _selected.isEmpty
                ? docsSample(context, 'Pick a command')
                : 'Ran $_selected',
          ),
        ],
      ),
    );
  }
}

/// A field with a cancel button that clears and reports.
class _SearchBarCancel extends StatefulWidget {
  const _SearchBarCancel();

  @override
  State<_SearchBarCancel> createState() => _SearchBarCancelState();
}

class _SearchBarCancelState extends State<_SearchBarCancel> {
  String _status = docsSample(null, 'Type, then cancel');

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SearchBar<String>(
            items: _searchFruits,
            hintText: docsSample(context, 'Search fruit'),
            showCancelButton: true,
            onCancelled: () =>
                setState(() => _status = docsSample(context, 'Cancelled')),
            onSelected: (String item) =>
                setState(() => _status = 'Selected $item'),
          ),
          Gap(spacing.sm),
          _StatusLine(_status),
        ],
      ),
    );
  }
}

/// A custom row builder with a leading count.
class _SearchBarCustomRow extends StatefulWidget {
  const _SearchBarCustomRow();

  @override
  State<_SearchBarCustomRow> createState() => _SearchBarCustomRowState();
}

class _SearchBarCustomRowState extends State<_SearchBarCustomRow> {
  String _selected = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SearchBar<String>(
            items: _searchFruits,
            hintText: docsSample(context, 'Search fruit'),
            itemBuilder: (context, item, highlight, highlighted) =>
                Text('$item (${highlight.length} hits)'),
            onSelected: (String item) => setState(() => _selected = item),
          ),
          Gap(Theme.of(context).spacing.sm),
          _StatusLine(
            _selected.isEmpty
                ? docsSample(context, 'Custom rows')
                : 'Selected $_selected',
          ),
        ],
      ),
    );
  }
}

Widget _searchBarDefault(BuildContext context) => const _SearchBarDefault();

Widget _searchBarGroups(BuildContext context) => const _SearchBarGroups();

Widget _searchBarCancel(BuildContext context) => const _SearchBarCancel();

Widget _searchBarCustomRow(BuildContext context) => const _SearchBarCustomRow();

/// Named docs examples for `search_bar`; the first entry is the default.
List<ComponentPreview> get searchBarPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _searchBarDefault),
  ComponentPreview(docsSample(null, 'With groups'), _searchBarGroups),
  ComponentPreview(docsSample(null, 'With cancel'), _searchBarCancel),
  ComponentPreview(docsSample(null, 'Custom row'), _searchBarCustomRow),
];
