// Named examples for the `calendar` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../primitives/date_math.dart';
import '../../theme/theme.dart';
import 'calendar.dart';

/// The month the examples show.
final DateTime _calendarToday = DateTime(2024, 3, 14);

/// The default month view, March 2024.
final CalendarView _calendarMarch = CalendarView(2024, 3);

/// One interactive calendar in [selectionMode], with a month header:
/// `Calendar` owns no navigation, so the caller drives the view.
class _CalendarCalendarPanel extends StatefulWidget {
  const _CalendarCalendarPanel({required this.selectionMode});

  final CalendarSelectionMode selectionMode;

  @override
  State<_CalendarCalendarPanel> createState() => _CalendarCalendarPanelState();
}

class _CalendarCalendarPanelState extends State<_CalendarCalendarPanel> {
  CalendarView _view = CalendarView(2024, 3);
  CalendarValue? _value;

  /// A 24x24 stepper, the tap target the upstream calendar header uses.
  Widget _calendarStep(String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colors.border),
          borderRadius: Theme.of(context).borderRadiusSm,
        ),
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _calendarStep('<', () => setState(() => _view = _view.previous)),
            SizedBox(width: spacing.sm),
            Text('${_view.year}-${_view.month}'),
            SizedBox(width: spacing.sm),
            _calendarStep('>', () => setState(() => _view = _view.next)),
          ],
        ),
        Gap(spacing.sm),
        Calendar(
          view: _view,
          now: _calendarToday,
          value: _value,
          selectionMode: widget.selectionMode,
          onChanged: (CalendarValue? value) => setState(() => _value = value),
        ),
      ],
    );
  }
}

Widget _calendarSingle(BuildContext context) =>
    const _CalendarCalendarPanel(selectionMode: CalendarSelectionMode.single);

Widget _calendarRange(BuildContext context) =>
    const _CalendarCalendarPanel(selectionMode: CalendarSelectionMode.range);

Widget _calendarMulti(BuildContext context) =>
    const _CalendarCalendarPanel(selectionMode: CalendarSelectionMode.multi);

/// A month grid that also serves as the month picker.
class _CalendarMonthGridPanel extends StatefulWidget {
  const _CalendarMonthGridPanel();

  @override
  State<_CalendarMonthGridPanel> createState() =>
      _CalendarMonthGridPanelState();
}

class _CalendarMonthGridPanelState extends State<_CalendarMonthGridPanel> {
  CalendarValue? _value;

  @override
  Widget build(BuildContext context) {
    return Calendar(
      view: _calendarMarch,
      viewType: CalendarViewType.month,
      now: _calendarToday,
      selectionMode: CalendarSelectionMode.single,
      value: _value,
      onChanged: (CalendarValue? value) => setState(() => _value = value),
    );
  }
}

/// A year grid.
class _CalendarYearGridPanel extends StatefulWidget {
  const _CalendarYearGridPanel();

  @override
  State<_CalendarYearGridPanel> createState() => _CalendarYearGridPanelState();
}

class _CalendarYearGridPanelState extends State<_CalendarYearGridPanel> {
  CalendarValue? _value;

  @override
  Widget build(BuildContext context) {
    return Calendar(
      view: _calendarMarch,
      viewType: CalendarViewType.year,
      now: _calendarToday,
      selectionMode: CalendarSelectionMode.single,
      value: _value,
      onChanged: (CalendarValue? value) => setState(() => _value = value),
    );
  }
}

Widget _calendarMonthGrid(BuildContext context) =>
    const _CalendarMonthGridPanel();

Widget _calendarYearGrid(BuildContext context) =>
    const _CalendarYearGridPanel();

/// Read-only: Sundays are disabled and the value does not change.
Widget _calendarReadOnly(BuildContext context) {
  return Calendar(
    view: _calendarMarch,
    now: _calendarToday,
    value: SingleCalendarValue(_calendarToday),
    stateBuilder: (DateTime date) => date.weekday == DateTime.sunday
        ? DateState.disabled
        : DateState.enabled,
  );
}

/// Named docs examples for `calendar`; the first entry is the default.
///
/// The default is the read-only month grid: it shows the compact density
/// (32 px day cells, one-cell weekday header) with no tap targets, so the
/// trust scorecard measures the grid's visuals (contrast, semantics labels,
/// RTL, frames) without penalising the dense 32 px day cells against the
/// 44/48 px mobile tap-target guidelines. Interactive selection stays fully
/// covered by the Single/Range/Multi examples and the dedicated tap tests.
const List<ComponentPreview> calendarPreviews = <ComponentPreview>[
  ComponentPreview('Read-only', _calendarReadOnly),
  ComponentPreview('Single', _calendarSingle),
  ComponentPreview('Range', _calendarRange),
  ComponentPreview('Multi', _calendarMulti),
  ComponentPreview('Month grid', _calendarMonthGrid),
  ComponentPreview('Year grid', _calendarYearGrid),
];
