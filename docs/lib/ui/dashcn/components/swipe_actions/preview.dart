// Named examples for the `swipe_actions` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. Rows are fixed-height cards so the examples fit the
// preview stage at every width.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../primitives/motion/motion_spec.dart';
import '../../theme/theme.dart';
import '../card/card.dart';
import 'swipe_actions.dart';

/// Three inbox rows; Archive and Delete both file the row away, Delete by
/// button or by full swipe, with a live inbox count below.
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
            for (final String row in _rows) ...<Widget>[
              SwipeActions(
                actions: <SwipeAction>[
                  SwipeAction(label: 'Archive', onPressed: () => _remove(row)),
                  SwipeAction(
                    label: 'Delete',
                    destructive: true,
                    onPressed: () => _remove(row),
                  ),
                ],
                onDismissed: () => _remove(row),
                child: Card(
                  child: SizedBox(
                    height: 56,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        // Explicit token colour: under a bare Theme
                        // (scorecard harness, tests) there is no app
                        // DefaultTextStyle, and the raw white default
                        // fails contrast.
                        child: Text(
                          row,
                          style: appTheme.typography.textSmall.copyWith(
                            color: appTheme.colors.foreground,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Gap(appTheme.spacing.sm),
            ],
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
      child: SwipeActions(
        actions: <SwipeAction>[
          SwipeAction(
            label: 'Pin',
            builder: (BuildContext context, double progress) => Opacity(
              opacity: progress,
              child: Transform.scale(
                scale: 0.6 + 0.4 * progress,
                child: Container(
                  width: 56,
                  height: 56,
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
        child: Card(
          child: SizedBox(
            height: 56,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Custom builders',
                  style: appTheme.typography.textSmall.copyWith(
                    color: appTheme.colors.foreground,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
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
      child: SwipeActions(
        motion: const MotionSpec(
          enterDuration: Duration(milliseconds: 450),
          exitDuration: Duration(milliseconds: 450),
        ),
        actions: <SwipeAction>[
          SwipeAction(label: 'Archive', onPressed: () {}),
          SwipeAction(label: 'Delete', destructive: true, onPressed: () {}),
        ],
        onDismissed: () {},
        child: Card(
          child: SizedBox(
            height: 56,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Slow motion',
                  style: appTheme.typography.textSmall.copyWith(
                    color: appTheme.colors.foreground,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

/// Named docs examples for `swipe_actions`; the first entry is the default.
const List<ComponentPreview> swipeActionsPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('Right to left', _rightToLeft),
  ComponentPreview('Custom builders', _customBuilders),
  ComponentPreview('Motion override', _motionOverride),
];
