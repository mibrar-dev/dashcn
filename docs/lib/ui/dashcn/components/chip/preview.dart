// P7-T1: every example centres its content (`CrossAxisAlignment.center`,
// `Align.center`) so the stage centres the column instead of pinning it
// top-start.
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. Every example is a working control: removable chips
// delete (tap the x, or focus a chip and press Backspace/Delete) with a reset,
// filter chips toggle, and the icon/variant rows show realistic tokens.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import 'chip.dart';

/// Hint line under the interactive rows.
Widget _hint(BuildContext context, String text) {
  final theme = Theme.of(context);
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(color: theme.colors.mutedForeground, fontSize: 12),
  );
}

/// Removable tokens: the x removes the chip, Reset restores the list.
class _RemovableChips extends StatefulWidget {
  const _RemovableChips();

  @override
  State<_RemovableChips> createState() => _RemovableChipsState();
}

class _RemovableChipsState extends State<_RemovableChips> {
  static const List<String> _all = <String>[
    'Design system',
    'Flutter',
    'Accessibility',
    'Dark mode',
  ];
  final List<String> _tags = List<String>.of(_all);

  void _remove(String tag) => setState(() => _tags.remove(tag));

  void _reset() => setState(() {
    _tags
      ..clear()
      ..addAll(_all);
  });

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          children: <Widget>[
            for (final tag in _tags)
              Chip(
                key: ValueKey<String>('chip-$tag'),
                onDeleted: () => _remove(tag),
                trailing: ChipButton(
                  onPressed: () => _remove(tag),
                  child: const Icon(LucideIcons.x, size: 12),
                ),
                child: Text(tag),
              ),
            if (_tags.isEmpty) const Chip(child: Text('No tags')),
          ],
        ),
        Gap(spacing.sm),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('${_tags.length} of ${_all.length} shown'),
            if (_tags.length != _all.length) ...<Widget>[
              Gap(spacing.sm),
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.outline,
                onPressed: _reset,
                child: const Text('Reset'),
              ),
            ],
          ],
        ),
        Gap(spacing.xs),
        _hint(context, 'Tip: focus a chip and press Backspace to remove it.'),
      ],
    );
  }
}

/// Filter chips: tap toggles each interest on and off.
class _FilterChips extends StatefulWidget {
  const _FilterChips();

  @override
  State<_FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<_FilterChips> {
  static const List<String> _options = <String>[
    'Music',
    'Sports',
    'Travel',
    'Cooking',
    'Reading',
  ];
  final Set<String> _selected = <String>{'Music', 'Travel'};

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          children: <Widget>[
            for (final option in _options)
              Chip(
                key: ValueKey<String>('filter-$option'),
                onPressed: () => setState(() {
                  if (!_selected.remove(option)) {
                    _selected.add(option);
                  }
                }),
                variant: _selected.contains(option)
                    ? ButtonVariant.primary
                    : ButtonVariant.outline,
                leading: _selected.contains(option)
                    ? const Icon(LucideIcons.check, size: 12)
                    : null,
                child: Text(option),
              ),
          ],
        ),
        Gap(spacing.sm),
        Text('${_selected.length} selected'),
      ],
    );
  }
}

/// Chips with icons: realistic status tokens, static (non-pressable).
Widget _chipsWithIcon(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Align(
    alignment: Alignment.center,
    child: Wrap(
      spacing: spacing.sm,
      runSpacing: spacing.sm,
      children: const <Widget>[
        Chip(
          leading: Icon(LucideIcons.star, size: 12),
          child: Text('Featured'),
        ),
        Chip(
          leading: Icon(LucideIcons.check, size: 12),
          child: Text('Verified'),
        ),
        Chip(
          leading: Icon(LucideIcons.folder, size: 12),
          child: Text('Archived'),
        ),
        Chip(
          trailing: Icon(LucideIcons.chevronRight, size: 12),
          child: Text('See all'),
        ),
      ],
    ),
  );
}

/// One chip per button variant plus a larger density.
Widget _chipsVariants(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Wrap(
        spacing: spacing.sm,
        runSpacing: spacing.sm,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: const <Widget>[
          Chip(child: Text('Active')),
          Chip(variant: ButtonVariant.outline, child: Text('On hold')),
          Chip(variant: ButtonVariant.destructive, child: Text('Overdue')),
          Chip(variant: ButtonVariant.ghost, child: Text('Draft')),
        ],
      ),
      Gap(spacing.sm),
      const Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Chip(
            theme: ChipTheme(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
            child: Text('Large'),
          ),
        ],
      ),
    ],
  );
}

Widget _chipsRemovable(BuildContext context) => const _RemovableChips();

Widget _chipsSelectable(BuildContext context) => const _FilterChips();

/// Named docs examples for `chip`; the first entry is the default.
const List<ComponentPreview> chipPreviews = <ComponentPreview>[
  ComponentPreview('Removable', _chipsRemovable),
  ComponentPreview('Selectable', _chipsSelectable),
  ComponentPreview('With icon', _chipsWithIcon),
  ComponentPreview('Variants', _chipsVariants),
];
