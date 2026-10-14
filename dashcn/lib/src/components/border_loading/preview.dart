// Named examples for the `border_loading` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// P7-C2: the determinate example is live — the stepper drives the progress the
// border paints, so the demo shows what `mode: progress` does.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../button/button.dart';
import '../../theme/theme.dart';
import 'border_loading.dart';

/// A labelled card carrying the loading border.
Widget _borderLoadingCard(BuildContext context, String label, Widget child) {
  final theme = Theme.of(context);
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      child,
      Gap(theme.spacing.sm),
      Text(
        label,
        style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
      ),
    ],
  );
}

/// The default rotating sweep.
Widget _borderLoadingSweep(BuildContext context) {
  return Center(
    child: _borderLoadingCard(
      context,
      'Indeterminate sweep',
      const BorderLoading(child: SizedBox(width: 120, height: 48)),
    ),
  );
}

/// Determinate progress around the outline, driven by the example.
class _BorderLoadingProgress extends StatefulWidget {
  const _BorderLoadingProgress();

  @override
  State<_BorderLoadingProgress> createState() => _BorderLoadingProgressState();
}

class _BorderLoadingProgressState extends State<_BorderLoadingProgress> {
  double _progress = 0.6;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _borderLoadingCard(
            context,
            'Determinate - ${(_progress * 100).round()}%',
            BorderLoading(
              mode: BorderLoadingMode.progress,
              progress: _progress,
              child: const SizedBox(width: 120, height: 48),
            ),
          ),
          Gap(spacing.md),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.outline,
                onPressed: () => setState(
                  () => _progress = (_progress - 0.2).clamp(0.0, 1.0),
                ),
                child: const Text('-20%'),
              ),
              Gap(spacing.sm),
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.outline,
                onPressed: () => setState(
                  () => _progress = (_progress + 0.2).clamp(0.0, 1.0),
                ),
                child: const Text('+20%'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A static outline, no animation.
Widget _borderLoadingOutline(BuildContext context) {
  return Center(
    child: _borderLoadingCard(
      context,
      'Static outline',
      const BorderLoading(
        mode: BorderLoadingMode.staticBorder,
        child: SizedBox(width: 120, height: 48),
      ),
    ),
  );
}

/// A live progress example; the `const` bridge keeps the preview list const.
Widget _borderLoadingProgressExample(BuildContext context) =>
    const _BorderLoadingProgress();

/// Named docs examples for `border_loading`; the first entry is the default.
const List<ComponentPreview> borderLoadingPreviews = <ComponentPreview>[
  ComponentPreview('Sweep', _borderLoadingSweep),
  ComponentPreview('Progress', _borderLoadingProgressExample),
  ComponentPreview('Outline', _borderLoadingOutline),
];
