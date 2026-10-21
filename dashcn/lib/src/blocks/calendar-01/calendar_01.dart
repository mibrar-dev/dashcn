// The `calendar-01` block: a date-range picker card.
//
// A block is layer 4 of the registry: it may import foundation, theme,
// primitives and components, never another block. Its public widget is the
// preview - the docs page renders it exactly as an app would.
//
// A page header plus a two-month range calendar (one month on a phone),
// a live range summary and footer actions. `Calendar` owns no navigation,
// so the block drives the `CalendarView` itself. The page is capped at
// 720px and fills the viewport, scrolling internally when the host is
// shorter than the content.

import 'package:flutter/widgets.dart';

import '../../components/button/button.dart';
import '../../components/calendar/calendar.dart';
import '../../components/card/card.dart';
import '../../components/divider/divider.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/date_math.dart';
import '../../primitives/localizations/localizations.dart';
import '../../theme/theme.dart';

/// A date-range card: the calendar, a range summary and footer actions.
class Calendar01 extends StatefulWidget {
  /// Creates the block.
  const Calendar01({super.key, this.onApply, this.onClear});

  /// Called with the current range when Apply is tapped.
  final ValueChanged<CalendarValue?>? onApply;

  /// Called when Clear resets the selection.
  final VoidCallback? onClear;

  @override
  State<Calendar01> createState() => _Calendar01State();
}

class _Calendar01State extends State<Calendar01> {
  CalendarView _view = const CalendarView(2026, 10);
  CalendarValue? _value;

  void _shift(int months) {
    setState(() => _view = months < 0 ? _view.previous : _view.next);
  }

  void _clear() {
    setState(() => _value = null);
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    final strings = ComponentLocalizations.of(context);
    final ThemeData theme = Theme.of(context);
    final Widget body = Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(strings.blockSchedule, style: theme.typography.h2),
            Gap(theme.spacing.xs),
            Text(
              'Pick a date range for your report.',
              style: theme.typography.textMuted.copyWith(
                color: theme.colors.mutedForeground,
              ),
            ),
            Gap(theme.spacing.lg),
            Card(
              padding: EdgeInsets.all(theme.spacing.lg),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  // Two month grids need ~568 px (2 x 272 nominal incl. the p-3
                  // shell, plus the 24 px gap). 720 could never hold: the card
                  // caps at 720 and its own padding leaves 688 inside, so the
                  // second month never rendered and the right half stayed empty.
                  final bool twoMonths = constraints.maxWidth >= 600;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _Calendar01Header(
                        view: _view,
                        twoMonths: twoMonths,
                        onShift: _shift,
                      ),
                      Gap(theme.spacing.lg),
                      if (twoMonths)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: _Calendar01Month(
                                view: _view,
                                value: _value,
                                onChanged: (CalendarValue? value) =>
                                    setState(() => _value = value),
                              ),
                            ),
                            Gap(theme.spacing.xl),
                            Expanded(
                              child: _Calendar01Month(
                                view: _view.next,
                                value: _value,
                                onChanged: (CalendarValue? value) =>
                                    setState(() => _value = value),
                              ),
                            ),
                          ],
                        )
                      else
                        _Calendar01Month(
                          view: _view,
                          value: _value,
                          onChanged: (CalendarValue? value) =>
                              setState(() => _value = value),
                        ),
                      Gap(theme.spacing.lg),
                      const Divider(),
                      Gap(theme.spacing.lg),
                      _Calendar01Footer(
                        value: _value,
                        onClear: _clear,
                        onApply: () => widget.onApply?.call(_value),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
    return ColoredBox(
      color: theme.colors.background,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (!constraints.maxHeight.isFinite) {
              return Padding(
                padding: EdgeInsets.all(theme.spacing.lg),
                child: body,
              );
            }
            return SingleChildScrollView(
              padding: EdgeInsets.all(theme.spacing.lg),
              child: body,
            );
          },
        ),
      ),
    );
  }
}

class _Calendar01Header extends StatelessWidget {
  const _Calendar01Header({
    required this.view,
    required this.twoMonths,
    required this.onShift,
  });

  final CalendarView view;
  final bool twoMonths;
  final ValueChanged<int> onShift;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ComponentLocalizations strings = ComponentLocalizations.of(context);
    final bool rtl = Directionality.of(context) == TextDirection.rtl;
    final String months = twoMonths
        ? '${_monthName(strings, view.month)} - '
              '${_monthName(strings, view.next.month)} ${view.next.year}'
        : '${_monthName(strings, view.month)} ${view.year}';
    return Row(
      children: <Widget>[
        Expanded(child: Text(months, style: theme.typography.textLarge)),
        Gap(theme.spacing.md),
        _Calendar01Step(
          icon: rtl ? LucideIcons.chevronRight : LucideIcons.chevronLeft,
          onPressed: () => onShift(-1),
        ),
        Gap(theme.spacing.sm),
        _Calendar01Step(
          icon: rtl ? LucideIcons.chevronLeft : LucideIcons.chevronRight,
          onPressed: () => onShift(1),
        ),
      ],
    );
  }
}

class _Calendar01Step extends StatelessWidget {
  const _Calendar01Step({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      variant: ButtonVariant.ghost,
      size: ButtonSize.icon,
      onPressed: onPressed,
      child: Icon(icon, size: 16),
    );
  }
}

class _Calendar01Month extends StatelessWidget {
  const _Calendar01Month({
    required this.view,
    required this.value,
    required this.onChanged,
  });

  final CalendarView view;
  final CalendarValue? value;
  final ValueChanged<CalendarValue?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Calendar(
      view: view,
      now: DateTime(2026, 10, 10),
      selectionMode: CalendarSelectionMode.range,
      value: value,
      onChanged: onChanged,
    );
  }
}

class _Calendar01Footer extends StatelessWidget {
  const _Calendar01Footer({
    required this.value,
    required this.onClear,
    required this.onApply,
  });

  final CalendarValue? value;
  final VoidCallback onClear;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            _summary(ComponentLocalizations.of(context), value),
            style: theme.typography.textSmall.copyWith(
              color: theme.colors.mutedForeground,
            ),
          ),
        ),
        Gap(theme.spacing.md),
        Button(
          variant: ButtonVariant.outline,
          onPressed: onClear,
          child: Text(ComponentLocalizations.of(context).actionClear),
        ),
        Gap(theme.spacing.sm),
        Button(
          onPressed: onApply,
          child: Text(ComponentLocalizations.of(context).actionApply),
        ),
      ],
    );
  }
}

/// The live range summary for the footer: the picked dates first.
///
/// Month names come from the locale; the surrounding demo sentences stay
/// English block sample content (preview.dart doctrine).
String _summary(ComponentLocalizations strings, CalendarValue? value) {
  final CalendarValue? current = value;
  if (current is RangeCalendarValue) {
    final int nights = current.end.difference(current.start).inDays;
    final String range = _rangeLabel(strings, current.start, current.end);
    if (nights <= 0) {
      return '$range · Same-day stay';
    }
    return '$range · $nights night${nights == 1 ? '' : 's'}';
  }
  if (current is SingleCalendarValue) {
    return '${_shortLabel(strings, current.date)} — '
        'tap another day to extend the range';
  }
  return 'Pick a date range';
}

/// Compact range label: `Oct 12–18, 2026`, or `Oct 30 – Nov 2, 2026`.
String _rangeLabel(
  ComponentLocalizations strings,
  DateTime start,
  DateTime end,
) {
  if (start.year == end.year && start.month == end.month) {
    return '${_shortMonth(strings, start.month)} ${start.day}–${end.day}, '
        '${start.year}';
  }
  return '${_shortLabel(strings, start)} – ${_shortLabel(strings, end)}, '
      '${end.year}';
}

/// Compact day label: `Oct 12`.
String _shortLabel(ComponentLocalizations strings, DateTime date) =>
    '${_shortMonth(strings, date.month)} ${date.day}';

/// Abbreviated month from the locale (replaces the hardcoded English table).
String _shortMonth(ComponentLocalizations strings, int month) {
  if (month < DateTime.january || month > DateTime.december) {
    return 'M$month';
  }
  return strings.getAbbreviatedMonth(month);
}

/// Full month name from the locale (replaces the hardcoded English table).
String _monthName(ComponentLocalizations strings, int month) {
  if (month < DateTime.january || month > DateTime.december) {
    return 'Month $month';
  }
  return strings.getMonth(month);
}
