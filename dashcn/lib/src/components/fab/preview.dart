// Named examples for the `fab` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'fab.dart';

/// The default example: one round floating action button.
Widget _fabDefault(BuildContext context) {
  return const Center(
    child: Fab(
      icon: Icon(LucideIcons.plus),
      semanticLabel: 'Add item',
      tooltip: 'Add item',
    ),
  );
}

/// The three fixed sizes, side by side.
Widget _fabSizes(BuildContext context) {
  final double spacing = Theme.of(context).spacing.md;
  return Center(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Fab(
          icon: Icon(LucideIcons.plus),
          size: FabSize.sm,
          semanticLabel: 'Add item (small)',
        ),
        Gap(spacing),
        const Fab(
          icon: Icon(LucideIcons.plus),
          size: FabSize.md,
          semanticLabel: 'Add item (regular)',
        ),
        Gap(spacing),
        const Fab(
          icon: Icon(LucideIcons.plus),
          size: FabSize.lg,
          semanticLabel: 'Add item (large)',
        ),
      ],
    ),
  );
}

/// The extended (pill) shape with a label.
Widget _fabExtended(BuildContext context) {
  return const Center(
    child: Fab(
      icon: Icon(LucideIcons.pencil),
      label: Text('Compose'),
      semanticLabel: 'Compose',
    ),
  );
}

/// The speed dial: a main button that unfolds three mini actions.
class _FabSpeedDialExample extends StatefulWidget {
  const _FabSpeedDialExample();

  @override
  State<_FabSpeedDialExample> createState() => _FabSpeedDialExampleState();
}

class _FabSpeedDialExampleState extends State<_FabSpeedDialExample> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FabSpeedDial(
        icon: const Icon(LucideIcons.plus),
        expanded: _expanded,
        onExpandedChanged: (bool value) => setState(() => _expanded = value),
        semanticLabel: 'Create',
        tooltip: 'Create',
        actions: <FabSpeedDialAction>[
          FabSpeedDialAction(
            icon: const Icon(LucideIcons.fileText),
            tooltip: 'New document',
            semanticLabel: 'New document',
          ),
          FabSpeedDialAction(
            icon: const Icon(LucideIcons.image),
            tooltip: 'New image',
            semanticLabel: 'New image',
          ),
          FabSpeedDialAction(
            icon: const Icon(LucideIcons.camera),
            tooltip: 'Take a photo',
            semanticLabel: 'Take a photo',
          ),
        ],
      ),
    );
  }
}

Widget _fabSpeedDial(BuildContext context) => const _FabSpeedDialExample();

/// The positions helper: the same button in four anchor positions.
Widget _fabPositions(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  return Center(
    child: SizedBox(
      width: 260,
      height: 200,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colors.muted.withValues(alpha: 0.4),
          borderRadius: theme.borderRadiusLg,
        ),
        child: const Stack(
          children: <Widget>[
            FabPositioner(
              position: FabPosition.topStart,
              child: Fab(
                icon: Icon(LucideIcons.heart),
                size: FabSize.sm,
                semanticLabel: 'Favourite',
              ),
            ),
            FabPositioner(
              position: FabPosition.topEnd,
              child: Fab(
                icon: Icon(LucideIcons.share),
                size: FabSize.sm,
                semanticLabel: 'Share',
              ),
            ),
            FabPositioner(
              position: FabPosition.bottomStart,
              child: Fab(
                icon: Icon(LucideIcons.trash),
                size: FabSize.sm,
                semanticLabel: 'Delete',
              ),
            ),
            FabPositioner(
              position: FabPosition.bottomEnd,
              child: Fab(
                icon: Icon(LucideIcons.settings),
                size: FabSize.sm,
                semanticLabel: 'Settings',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Hide on scroll: the button slides away while the list scrolls down.
class _FabHideOnScrollExample extends StatefulWidget {
  const _FabHideOnScrollExample();

  @override
  State<_FabHideOnScrollExample> createState() =>
      _FabHideOnScrollExampleState();
}

class _FabHideOnScrollExampleState extends State<_FabHideOnScrollExample> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: SizedBox(
        width: 280,
        height: 220,
        child: Stack(
          children: <Widget>[
            ListView.builder(
              controller: _controller,
              padding: EdgeInsets.all(theme.spacing.md),
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: theme.spacing.sm),
                  child: Text('Row ${index + 1}'),
                );
              },
            ),
            Positioned(
              right: theme.spacing.md,
              bottom: theme.spacing.md,
              child: FabHideOnScroll(
                controller: _controller,
                child: const Fab(
                  icon: Icon(LucideIcons.plus),
                  size: FabSize.sm,
                  semanticLabel: 'Add item',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _fabHideOnScroll(BuildContext context) =>
    const _FabHideOnScrollExample();

/// A customised button: secondary fill, custom radius and no elevation.
Widget _fabCustomized(BuildContext context) {
  return const Center(
    child: Fab(
      icon: Icon(LucideIcons.zap),
      label: Text('Launch'),
      semanticLabel: 'Launch',
      style: FabStyle(
        background: StateValue(rest: ThemedColor.ref(ColorRef.secondary)),
        foreground: StateValue(
          rest: ThemedColor.ref(ColorRef.secondaryForeground),
        ),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        elevation: 0,
        gap: 6,
      ),
    ),
  );
}

/// Named docs examples for `fab`; the first entry is the default.
const List<ComponentPreview> fabPreviews = <ComponentPreview>[
  ComponentPreview('Default', _fabDefault),
  ComponentPreview('Sizes', _fabSizes),
  ComponentPreview('Extended', _fabExtended),
  ComponentPreview('Speed dial', _fabSpeedDial),
  ComponentPreview('Positions', _fabPositions),
  ComponentPreview('Hide on scroll', _fabHideOnScroll),
  ComponentPreview('Customized', _fabCustomized),
];
