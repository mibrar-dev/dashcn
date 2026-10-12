// Named examples for the `progress` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// P7-C2: the determinate row keeps its frozen reference values, and a live
// example steps the fill so the demo shows what a determinate bar reports.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../button/button.dart';
import '../../theme/theme.dart';
import 'progress.dart';

/// Determinate values at a few fill levels and heights.
Widget _progressDeterminate(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  final bar = <Widget>[
    const Progress(value: 0.25, semanticsLabel: 'Quarter'),
    Gap(spacing.lg),
    const Progress(value: 0.6, semanticsLabel: 'Sixty percent'),
    Gap(spacing.lg),
    const Progress(
      value: 0.85,
      showSparks: true,
      semanticsLabel: 'Eighty five percent',
    ),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      ...bar,
      Gap(spacing.lg),
      SizedBox(
        width: 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Progress(value: 0.4, height: 4),
            Gap(spacing.lg),
            const Progress(value: 0.5, height: 14),
          ],
        ),
      ),
    ],
  );
}

/// Indeterminate mode.
Widget _progressIndeterminate(BuildContext context) {
  return const Progress(semanticsLabel: 'Loading');
}

/// A bar the example drives between 0 and 100%.
class _ProgressLive extends StatefulWidget {
  const _ProgressLive();

  @override
  State<_ProgressLive> createState() => _ProgressLiveState();
}

class _ProgressLiveState extends State<_ProgressLive> {
  double _value = 0.35;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Progress(
          value: _value,
          showSparks: true,
          semanticsLabel: 'Upload progress',
        ),
        Gap(theme.spacing.md),
        Text(
          '${(_value * 100).round()}% uploaded',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
        Gap(theme.spacing.md),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Button(
              size: ButtonSize.sm,
              variant: ButtonVariant.outline,
              onPressed: () =>
                  setState(() => _value = _value >= 0.15 ? _value - 0.15 : 0),
              child: const Text('-15%'),
            ),
            Gap(theme.spacing.sm),
            Button(
              size: ButtonSize.sm,
              variant: ButtonVariant.outline,
              onPressed: () =>
                  setState(() => _value = _value <= 0.85 ? _value + 0.15 : 1),
              child: const Text('+15%'),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _progressLive(BuildContext context) => const _ProgressLive();

/// Named docs examples for `progress`; the first entry is the default.
const List<ComponentPreview> progressPreviews = <ComponentPreview>[
  ComponentPreview('Determinate', _progressDeterminate),
  ComponentPreview('Live', _progressLive),
  ComponentPreview('Indeterminate', _progressIndeterminate),
];
