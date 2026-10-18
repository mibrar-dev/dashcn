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

const List<String> _searchFruits = <String>[
  'Apple',
  'Apricot',
  'Avocado',
  'Banana',
  'Cherry',
  'Grape',
  'Kiwi',
  'Lemon',
  'Mango',
  'Orange',
  'Peach',
  'Pear',
  'Pineapple',
  'Strawberry',
  'Watermelon',
];

/// The status line every interactive example writes to.
class _StatusLine extends StatelessWidget {
  const _StatusLine(this.status);

  final String status;

  @override
  Widget build(BuildContext context) {
    return Text(
      status,
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
            hintText: 'Search fruit',
            onChanged: (String query) => setState(() => _query = query),
            onSelected: (String item) => setState(() => _selected = item),
          ),
          Gap(spacing.sm),
          _StatusLine(
            _selected.isEmpty
                ? (_query.isEmpty ? 'Type to filter' : 'query: $_query')
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

  static const List<SearchBarGroup<String>> _groups = <SearchBarGroup<String>>[
    SearchBarGroup<String>(
      label: 'Suggestions',
      items: <String>['Calendar', 'Search Emoji', 'Launch'],
    ),
    SearchBarGroup<String>(
      label: 'Settings',
      items: <String>['Profile', 'Mail', 'Settings'],
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
            hintText: 'Search commands',
            onSelected: (String item) => setState(() => _selected = item),
          ),
          Gap(spacing.sm),
          _StatusLine(_selected.isEmpty ? 'Pick a command' : 'Ran $_selected'),
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
  String _status = 'Type, then cancel';

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
            hintText: 'Search fruit',
            showCancelButton: true,
            onCancelled: () => setState(() => _status = 'Cancelled'),
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
            hintText: 'Search fruit',
            itemBuilder: (context, item, highlight, highlighted) =>
                Text('$item (${highlight.length} hits)'),
            onSelected: (String item) => setState(() => _selected = item),
          ),
          Gap(Theme.of(context).spacing.sm),
          _StatusLine(
            _selected.isEmpty ? 'Custom rows' : 'Selected $_selected',
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
const List<ComponentPreview> searchBarPreviews = <ComponentPreview>[
  ComponentPreview('Default', _searchBarDefault),
  ComponentPreview('With groups', _searchBarGroups),
  ComponentPreview('With cancel', _searchBarCancel),
  ComponentPreview('Custom row', _searchBarCustomRow),
];
