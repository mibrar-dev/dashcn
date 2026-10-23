// Named examples for the `swipe_actions` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. Rows are list tiles (32 px single-line, 48 px
// two-line) with 8 px horizontal row padding, grouped in one surface with
// 1 px dividers — never a card per row.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../primitives/motion/motion_spec.dart';
import '../../theme/color_tokens.dart';
import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import '../card/card.dart';
import '../list_tile/list_tile.dart';
import 'swipe_actions.dart';

// List-tile row padding: 8 px horizontal (sizing scale). Vertical 4 px so
// the rendered rows land exactly on the list-tile heights under both the
// test font and real fonts (Geist runs ~1.3 line height: single-line content
// ~26 clamps to the 32 minimum; two-line ~47 clamps to the 48 minimum).
const EdgeInsets _rowPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);

/// 1 px divider between rows inside the shared surface.
Widget _rowDivider(ThemeData appTheme) => Container(
  height: 1,
  color: ThemedColor.ref(ColorRef.border).resolve(appTheme.colors),
);

/// One surface holding the swipeable rows (never a card per row).
Widget _listSurface(ThemeData appTheme, List<Widget> rows) => Card(
  padding: EdgeInsets.zero,
  clipBehavior: Clip.antiAlias,
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      for (int i = 0; i < rows.length; i++) ...<Widget>[
        rows[i],
        if (i < rows.length - 1) _rowDivider(appTheme),
      ],
    ],
  ),
);

/// Single-line 32 px list-tile row. Uses the list tile's own token
/// typography (natural line heights) with an explicit foreground pair so the
/// text stays readable on the card surface under bare-Theme harnesses.
Widget _singleRow(ThemeData appTheme, String label) => ListTile(
  contentPadding: _rowPadding,
  textColor: ThemedColor.ref(ColorRef.foreground),
  title: Text(label),
);

/// Two-line 48 px list-tile row. Plain [Text] children so the tile's token
/// title/subtitle styles (and their natural line heights) apply; explicit
/// foreground pairs keep contrast on the card surface.
Widget _twoLineRow(ThemeData appTheme, String title, String subtitle) =>
    ListTile(
      contentPadding: _rowPadding,
      textColor: ThemedColor.ref(ColorRef.foreground),
      subtitleColor: ThemedColor.ref(ColorRef.foreground),
      title: Text(title),
      subtitle: Text(subtitle),
    );

/// Three inbox rows; Archive and Delete both file the row away, Delete by
/// button or by full swipe, with a live inbox count 8 px below the list.
class _SwipeActionsDemo extends StatefulWidget {
  const _SwipeActionsDemo();

  @override
  State<_SwipeActionsDemo> createState() => _SwipeActionsDemoState();
}

class _SwipeActionsDemoState extends State<_SwipeActionsDemo> {
  final List<String> _rows = <String>[
    'Design review at 10',
    'Your invoice is ready',
    'Weekend trip photos',
  ];

  void _remove(String row) {
    setState(() => _rows.remove(row));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    // Explicit background surface: standalone harnesses (scorecard,
    // preview boxes) stage examples on transparency, and text needs an
    // opaque token pair to measure contrast against.
    return ColoredBox(
      color: appTheme.colors.background,
      child: Padding(
        padding: EdgeInsets.all(appTheme.spacing.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _listSurface(appTheme, <Widget>[
              for (final String row in _rows)
                SwipeActions(
                  actions: <SwipeAction>[
                    SwipeAction(
                      label: 'Archive',
                      onPressed: () => _remove(row),
                    ),
                    SwipeAction(
                      label: 'Delete',
                      destructive: true,
                      onPressed: () => _remove(row),
                    ),
                  ],
                  onDismissed: () => _remove(row),
                  child: _singleRow(appTheme, row),
                ),
            ]),
            // Caption sits 8 px (sm) below the list.
            Gap(appTheme.spacing.sm),
            Text(
              'Inbox: ${_rows.length}',
              // Foreground, not muted: muted small text lands just under
              // the 4.5 contrast bar in the fallback theme
              // (scorecard-measured).
              style: appTheme.typography.textSmall.copyWith(
                color: appTheme.colors.foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _default(BuildContext context) => const _SwipeActionsDemo();

Widget _compact(BuildContext context) {
  final ThemeData appTheme = Theme.of(context);
  return ColoredBox(
    color: appTheme.colors.background,
    child: Padding(
      padding: EdgeInsets.all(appTheme.spacing.sm),
      child: _listSurface(appTheme, <Widget>[
        SwipeActions(
          densityTokens: DensityTokens.compact,
          actions: <SwipeAction>[
            SwipeAction(label: 'Archive', onPressed: () {}),
            SwipeAction(label: 'Delete', destructive: true, onPressed: () {}),
          ],
          onDismissed: () {},
          // List-tile single-line row (32); the 64 px action tiles
          // stretch to this full row height.
          child: _singleRow(appTheme, 'Compact row 32, tile 64'),
        ),
      ]),
    ),
  );
}

Widget _comfortable(BuildContext context) {
  final ThemeData appTheme = Theme.of(context);
  return ColoredBox(
    color: appTheme.colors.background,
    child: Padding(
      padding: EdgeInsets.all(appTheme.spacing.sm),
      child: _listSurface(appTheme, <Widget>[
        SwipeActions(
          densityTokens: DensityTokens.comfortable,
          actions: <SwipeAction>[
            SwipeAction(label: 'Archive', onPressed: () {}),
            SwipeAction(label: 'Delete', destructive: true, onPressed: () {}),
          ],
          onDismissed: () {},
          // List-tile two-line row (48); the 64 px action tiles stretch
          // to this full row height.
          child: _twoLineRow(
            appTheme,
            'Comfortable two-line 48, tile 64',
            'Subtitle keeps the 48 px list-tile height',
          ),
        ),
      ]),
    ),
  );
}

Widget _rightToLeft(BuildContext context) => const Directionality(
  textDirection: TextDirection.rtl,
  child: _SwipeActionsDemo(),
);

/// Custom action builders: each button scales/fades in with its own reveal
/// progress, so callers can paint anything behind the row.
Widget _customBuilders(BuildContext context) {
  final ThemeData appTheme = Theme.of(context);
  return ColoredBox(
    color: appTheme.colors.background,
    child: Padding(
      padding: EdgeInsets.all(appTheme.spacing.sm),
      child: _listSurface(appTheme, <Widget>[
        SwipeActions(
          actions: <SwipeAction>[
            SwipeAction(
              label: 'Pin',
              builder: (BuildContext context, double progress) => Opacity(
                opacity: progress,
                child: Transform.scale(
                  scale: 0.6 + 0.4 * progress,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: appTheme.colors.primary,
                    ),
                    child: Center(
                      child: Text(
                        'Pin',
                        style: appTheme.typography.textSmall.copyWith(
                          color: appTheme.colors.primaryForeground,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              onPressed: () {},
            ),
            SwipeAction(label: 'Delete', destructive: true, onPressed: () {}),
          ],
          onDismissed: () {},
          // List-tile single-line row (32); the custom builders above
          // center in its full height.
          child: _singleRow(appTheme, 'Custom builders'),
        ),
      ]),
    ),
  );
}

/// Per-instance motion override: a slower settle and collapse for this row
/// only; the rest of the app keeps the theme timing.
Widget _motionOverride(BuildContext context) {
  final ThemeData appTheme = Theme.of(context);
  return ColoredBox(
    color: appTheme.colors.background,
    child: Padding(
      padding: EdgeInsets.all(appTheme.spacing.sm),
      child: _listSurface(appTheme, <Widget>[
        SwipeActions(
          motion: const MotionSpec(
            enterDuration: Duration(milliseconds: 450),
            exitDuration: Duration(milliseconds: 450),
          ),
          actions: <SwipeAction>[
            SwipeAction(label: 'Archive', onPressed: () {}),
            SwipeAction(label: 'Delete', destructive: true, onPressed: () {}),
          ],
          onDismissed: () {},
          // List-tile single-line row (32).
          child: _singleRow(appTheme, 'Slow motion'),
        ),
      ]),
    ),
  );
}

/// Named docs examples for `swipe_actions`; the first entry is the default.
const List<ComponentPreview> swipeActionsPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('Compact', _compact),
  ComponentPreview('Comfortable', _comfortable),
  ComponentPreview('Right to left', _rightToLeft),
  ComponentPreview('Custom builders', _customBuilders),
  ComponentPreview('Motion override', _motionOverride),
];
