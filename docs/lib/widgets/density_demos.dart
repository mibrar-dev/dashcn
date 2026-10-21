// Live sizing + density demos for the Theming page "Sizing and density"
// section (Batch 1A).
//
// One row per preset (compact default, comfortable, touch): a button and a
// list tile rendered under that preset, with the token numbers beside them.
// They render against the synced kit copy under `lib/ui/dashcn`.

import 'package:flutter/widgets.dart';

import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/list_tile/list_tile.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/theme/density_tokens.dart';
import '../ui/dashcn/theme/theme.dart';

/// Sizing/density live examples: one preset per row.
class DensityDemos extends StatelessWidget {
  /// Creates the density demos.
  const DensityDemos({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _DensityRow(
          tokens: DensityTokens.compact,
          label: 'Compact (default)',
          blurb: 'control 32 · icon 16 · row 32-36 · hPad 12 · gap 8',
        ),
        Gap(16),
        _DensityRow(
          tokens: DensityTokens.comfortable,
          label: 'Comfortable',
          blurb: 'control 40 · icon 20 · row 40-44 · hPad 14 · gap 10',
        ),
        Gap(16),
        _DensityRow(
          tokens: DensityTokens.touch,
          label: 'Touch (phone widths)',
          blurb: 'control 48 · icon 24 · row 48-56 · hPad 16 · gap 12',
        ),
      ],
    );
  }
}

class _DensityRow extends StatelessWidget {
  const _DensityRow({
    required this.tokens,
    required this.label,
    required this.blurb,
  });

  final DensityTokens tokens;
  final String label;
  final String blurb;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    return Theme(
      data: ambient.copyWith(densityTokens: () => tokens),
      child: Builder(
        builder: (context) {
          final ThemeData theme = Theme.of(context);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                label,
                style: theme.typography.small.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colors.foreground,
                ),
              ),
              Text(
                blurb,
                style: theme.typography.textSmall.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
              const Gap(8),
              Wrap(
                spacing: tokens.gap,
                runSpacing: tokens.gap,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Button(
                    densityTokens: tokens,
                    onPressed: () {},
                    child: const Text('Save changes'),
                  ),
                  Button(
                    densityTokens: tokens,
                    size: ButtonSize.icon,
                    variant: ButtonVariant.outline,
                    onPressed: () {},
                    child: const Text('+'),
                  ),
                ],
              ),
              const Gap(8),
              SizedBox(
                width: 360,
                child: ListTile(
                  densityTokens: tokens,
                  leading: const Text('L'),
                  title: const Text('List tile title truncates, never grows'),
                  subtitle: const Text('Subtitle one step smaller'),
                  trailing: const Text('T'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
