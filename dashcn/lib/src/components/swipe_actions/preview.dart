// Named examples for the `swipe_actions` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. Rows are fixed-height cards so the examples fit the
// preview stage at every width.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
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

/// Named docs examples for `swipe_actions`; the first entry is the default.
const List<ComponentPreview> swipeActionsPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('Right to left', _rightToLeft),
];
