// Named examples for the `sortable` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. Each example owns its item order in its own state.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/theme.dart';
import 'sortable.dart';

/// One draggable row in theme tokens.
class _Row extends StatelessWidget {
  const _Row({required this.item, this.candidate = false, this.last = false});

  final String item;
  final bool candidate;

  /// Whether this is the last row of the list: the last row keeps no bottom
  /// margin, so the staged list centres exactly (P7-TH1).
  final bool last;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      // Inter-item breathing room lives between rows only — never trailing
      // the list — so the demo centres in its stage.
      margin: EdgeInsets.only(bottom: last ? 0 : 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: candidate ? theme.colors.accent : theme.colors.card,
        border: Border.all(color: theme.colors.border),
        borderRadius: theme.borderRadiusMd,
      ),
      child: Row(
        children: <Widget>[
          SortableDragHandle(
            child: Icon(
              LucideIcons.gripVertical,
              size: 14,
              color: theme.colors.mutedForeground,
            ),
          ),
          Gap(theme.spacing.md),
          // Tile text inherits the surface color explicitly so the
          // rows stay readable outside the app's default text scope.
          Expanded(
            child: Text(
              item,
              style: TextStyle(
                color: candidate
                    ? theme.colors.accentForeground
                    : theme.colors.cardForeground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A reorderable vertical list.
class _ListDemo extends StatefulWidget {
  const _ListDemo();

  @override
  State<_ListDemo> createState() => _ListDemoState();
}

class _ListDemoState extends State<_ListDemo> {
  final List<String> _items = <String>[
    'Alpha',
    docsSample(null, 'Beta'),
    docsSample(null, 'Gamma'),
    docsSample(null, 'Delta'),
  ];

  void _move(String dragged, String target, bool above) {
    setState(() {
      _items.remove(dragged);
      final int index = _items.indexOf(target);
      _items.insert(above ? index : index + 1, dragged);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: SortableLayer(
        lock: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (int i = 0; i < _items.length; i++)
              Sortable<String>(
                key: ValueKey<String>(_items[i]),
                data: SortableData<String>(_items[i]),
                onAcceptTop: (SortableData<String> data) =>
                    _move(data.data, _items[i], true),
                onAcceptBottom: (SortableData<String> data) =>
                    _move(data.data, _items[i], false),
                candidateFallback: _Row(item: _items[i], candidate: true),
                fallback: Opacity(opacity: 0.3, child: _Row(item: _items[i])),
                child: _Row(item: _items[i], last: i == _items.length - 1),
              ),
          ],
        ),
      ),
    );
  }
}

/// One draggable tile in theme tokens.
class _Tile extends StatelessWidget {
  const _Tile({required this.item, this.candidate = false});

  final String item;
  final bool candidate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 104,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: candidate ? theme.colors.accent : theme.colors.card,
        border: Border.all(color: theme.colors.border),
        borderRadius: theme.borderRadiusMd,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SortableDragHandle(
            child: Icon(
              LucideIcons.gripVertical,
              size: 14,
              color: theme.colors.mutedForeground,
            ),
          ),
          Gap(theme.spacing.sm),
          Expanded(
            child: Text(
              item,
              style: TextStyle(
                color: candidate
                    ? theme.colors.accentForeground
                    : theme.colors.cardForeground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The same items as a wrapping grid of tiles.
class _GridDemo extends StatefulWidget {
  const _GridDemo();

  @override
  State<_GridDemo> createState() => _GridDemoState();
}

class _GridDemoState extends State<_GridDemo> {
  final List<String> _items = <String>[
    'Alpha',
    docsSample(null, 'Beta'),
    docsSample(null, 'Gamma'),
    docsSample(null, 'Delta'),
    docsSample(null, 'Epsilon'),
    docsSample(null, 'Zeta'),
  ];

  void _move(String dragged, String target, bool above) {
    setState(() {
      _items.remove(dragged);
      final int index = _items.indexOf(target);
      _items.insert(above ? index : index + 1, dragged);
    });
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return SizedBox(
      width: 340,
      child: SortableLayer(
        lock: true,
        // P7-TH1: the layer's Stack parks the shrink-wrapped Wrap at the
        // start; the Center keeps the runs in the middle of the 340px box
        // at every spacing (the Wrap alignment alone cannot — the Wrap
        // shrink-wraps to its runs).
        child: Center(
          child: Wrap(
            spacing: spacing.sm,
            runSpacing: spacing.sm,
            // P7-TH1: runs centre in the 340px box (the 3-up rows are 328
            // wide and would otherwise pack left).
            alignment: WrapAlignment.center,
            children: <Widget>[
              for (final String item in _items)
                Sortable<String>(
                  key: ValueKey<String>(item),
                  data: SortableData<String>(item),
                  onAcceptTop: (SortableData<String> data) =>
                      _move(data.data, item, true),
                  onAcceptBottom: (SortableData<String> data) =>
                      _move(data.data, item, false),
                  candidateFallback: _Tile(item: item, candidate: true),
                  fallback: Opacity(opacity: 0.3, child: _Tile(item: item)),
                  child: _Tile(item: item),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _default(BuildContext context) => const _ListDemo();

Widget _grid(BuildContext context) => const _GridDemo();

/// Named docs examples for `sortable`; the first entry is the default.
List<ComponentPreview> get sortablePreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _default),
  ComponentPreview(docsSample(null, 'Grid'), _grid),
];
