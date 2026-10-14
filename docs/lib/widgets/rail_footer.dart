// The footer of the Theme Studio rail (spec §2.7).
//
// The reference's footer is two stacked bars on `muted/50` with a top border:
// a monospace pill showing the active preset id, then `Open Preset`, `Shuffle`
// and a primary `Get Code`. Ours keeps that order and swaps the first pill for
// a real id field (typing an id loads that registry preset, which is what the
// reference's read-only pill invites you to do).

import 'package:flutter/widgets.dart';

import '../../ui/dashcn/components/button/button.dart';
import '../../ui/dashcn/components/input/input.dart';
import '../../ui/dashcn/foundation/gap.dart';
import '../../ui/dashcn/theme/theme.dart';

/// The rail footer: preset id field plus the four actions.
class RailFooter extends StatefulWidget {
  /// Creates the footer.
  const RailFooter({
    super.key,
    required this.presetId,
    required this.onOpenPreset,
    required this.onImport,
    required this.onShuffle,
    required this.onGetCode,
  });

  /// The active preset id, shown (and editable) in the mono pill.
  final String presetId;

  /// Opens the `Open Preset` paste dialog.
  final VoidCallback onOpenPreset;

  /// Opens the `Import Web Theme` dialog.
  final VoidCallback onImport;

  /// Picks a random valid combination.
  final VoidCallback onShuffle;

  /// Opens the `Get Code` dialog.
  final VoidCallback onGetCode;

  @override
  State<RailFooter> createState() => _RailFooterState();
}

class _RailFooterState extends State<RailFooter> {
  late final TextEditingController _id = TextEditingController(
    text: widget.presetId,
  );

  @override
  void didUpdateWidget(RailFooter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.presetId != _id.text) {
      _id.text = widget.presetId;
    }
  }

  @override
  void dispose() {
    _id.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: theme.colors.border)),
        color: theme.colors.muted.withValues(alpha: 0.5),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 28,
            child: Input(
              key: const ValueKey<String>('theme-rail-preset-id'),
              controller: _id,
              style: theme.typography.mono.copyWith(fontSize: 12),
              filled: true,
              decoration: BoxDecoration(
                color: theme.colors.background,
                // P7-TH1: inputs use the md radius token.
                borderRadius: theme.borderRadiusMd,
              ),
              border: Border.all(color: theme.colors.border),
              borderRadius: theme.borderRadiusMd,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
          const Gap(8),
          _FooterButton(label: 'Open Preset', onPressed: widget.onOpenPreset),
          const Gap(8),
          _FooterButton(
            key: const ValueKey<String>('theme-rail-import'),
            label: 'Import',
            onPressed: widget.onImport,
          ),
          const Gap(8),
          _FooterButton(label: 'Shuffle', onPressed: widget.onShuffle),
          const Gap(8),
          Button(
            key: const ValueKey<String>('theme-rail-get-code'),
            variant: ButtonVariant.primary,
            size: ButtonSize.sm,
            onPressed: widget.onGetCode,
            child: const Text('Get Code'),
          ),
        ],
      ),
    );
  }
}

class _FooterButton extends StatelessWidget {
  const _FooterButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
