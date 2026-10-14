// Named examples for the `dot_indicator` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'dot_indicator.dart';

/// Horizontal dots the example taps through.
class _DotIndicatorHorizontalDots extends StatefulWidget {
  const _DotIndicatorHorizontalDots();

  @override
  State<_DotIndicatorHorizontalDots> createState() =>
      _DotIndicatorHorizontalDotsState();
}

class _DotIndicatorHorizontalDotsState
    extends State<_DotIndicatorHorizontalDots> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DotIndicator(
          index: _index,
          length: 5,
          onChanged: (int value) => setState(() => _index = value),
        ),
        Gap(theme.spacing.md),
        Text(
          'index $_index',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
        Gap(theme.spacing.md),
        DotIndicator(index: 1, length: 5),
        Gap(theme.spacing.sm),
        Text(
          'read-only (no click cursor, no tap target)',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

/// Vertical dots beside the horizontal ones.
class _DotIndicatorVerticalDots extends StatefulWidget {
  const _DotIndicatorVerticalDots();

  @override
  State<_DotIndicatorVerticalDots> createState() =>
      _DotIndicatorVerticalDotsState();
}

class _DotIndicatorVerticalDotsState extends State<_DotIndicatorVerticalDots> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DotIndicator(
          index: _index,
          length: 3,
          direction: Axis.vertical,
          onChanged: (int value) => setState(() => _index = value),
        ),
        Gap(theme.spacing.xl),
        DotIndicator(
          index: 1,
          length: 3,
          direction: Axis.vertical,
          onChanged: (int value) => setState(() => _index = value),
        ),
      ],
    );
  }
}

/// A scoped theme leg: bigger accent dots.
class _DotIndicatorThemed extends StatefulWidget {
  const _DotIndicatorThemed();

  @override
  State<_DotIndicatorThemed> createState() => _DotIndicatorThemedState();
}

class _DotIndicatorThemedState extends State<_DotIndicatorThemed> {
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ComponentTheme<DotIndicatorTheme>(
          data: const DotIndicatorTheme(
            active: DotStyle(
              background: StateValue(rest: ThemedColor.ref(ColorRef.accent)),
              size: 18,
            ),
            spacing: 14,
          ),
          child: DotIndicator(
            index: _index,
            length: 5,
            onChanged: (int value) => setState(() => _index = value),
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          'index $_index',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _dotIndicatorDefault(BuildContext context) =>
    const _DotIndicatorHorizontalDots();

Widget _dotIndicatorVertical(BuildContext context) =>
    const _DotIndicatorVerticalDots();

Widget _dotIndicatorThemed(BuildContext context) => const _DotIndicatorThemed();

/// Named docs examples for `dot_indicator`; the first entry is the default.
const List<ComponentPreview> dotIndicatorPreviews = <ComponentPreview>[
  ComponentPreview('Default', _dotIndicatorDefault),
  ComponentPreview('Vertical', _dotIndicatorVertical),
  ComponentPreview('Themed dots', _dotIndicatorThemed),
];
