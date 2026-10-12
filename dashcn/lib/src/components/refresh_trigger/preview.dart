// Named examples for the `refresh_trigger` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. Each example carries its own bounded box because
// the pull viewport cannot lay out under unbounded constraints.
//
// P7-C2: the pull really refreshes — it prepends a freshly-fetched row and
// stamps the time, so the gesture has a visible outcome.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import 'refresh_trigger.dart';

/// A live pull-to-refresh list in a bounded box.
class _DefaultRefresh extends StatefulWidget {
  const _DefaultRefresh();

  @override
  State<_DefaultRefresh> createState() => _DefaultRefreshState();
}

class _DefaultRefreshState extends State<_DefaultRefresh> {
  final List<String> _rows = <String>[
    'Row 1',
    'Row 2',
    'Row 3',
    'Row 4',
    'Row 5',
    'Row 6',
  ];
  int _refreshes = 0;

  Future<void> _refresh() async {
    await Future<void>.delayed(Duration.zero);
    if (!mounted) {
      return;
    }
    setState(() {
      _refreshes++;
      _rows.insert(0, 'Fresh row $_refreshes');
    });
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          width: 320,
          height: 200,
          child: RefreshTrigger(
            onRefresh: _refresh,
            child: ListView.builder(
              itemCount: _rows.length,
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(_rows[index]),
              ),
            ),
          ),
        ),
        Gap(spacing.sm),
        Text('Refreshed $_refreshes time(s)'),
      ],
    );
  }
}

/// The pill indicator frozen in its refreshing stage.
Widget _refreshing(BuildContext context) {
  return const DefaultRefreshIndicator(
    stage: RefreshTriggerStage(
      TriggerStage.refreshing,
      AlwaysStoppedAnimation<double>(0.8),
      Axis.vertical,
      false,
    ),
  );
}

Widget _default(BuildContext context) => const _DefaultRefresh();

/// Named docs examples for `refresh_trigger`; the first entry is the default.
const List<ComponentPreview> refreshTriggerPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('Refreshing', _refreshing),
];
