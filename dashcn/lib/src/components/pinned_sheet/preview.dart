// Named examples for the `pinned_sheet` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. Each example owns its bounded stage (the sheet
// stack requires bounded constraints) and its own controller: a visible
// trigger row opens the sheet, the sheet slides in from its edge, drags
// between its snap stages, and closes from its own Close button.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import '../drawer_container/drawer_container.dart';
import 'pinned_sheet.dart';

/// Sheet body with a title and a Close button wired to [controller].
class _SheetBody extends StatelessWidget {
  const _SheetBody({required this.title, required this.controller});

  final String title;
  final SheetController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Gap(theme.spacing.sm),
          Text(
            'Drag the handle to move between snap stages.',
            style: TextStyle(color: theme.colors.mutedForeground),
          ),
          Gap(theme.spacing.md),
          Button(
            size: ButtonSize.sm,
            variant: ButtonVariant.outline,
            onPressed: controller.close,
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}

/// One working sheet inside its own bounded stage.
class _SheetDemo extends StatefulWidget {
  const _SheetDemo({
    required this.position,
    required this.title,
    this.stages = const <SheetStage>[
      SheetStage.closed(),
      SheetStage.expanded(),
    ],
    this.initialStage,
    this.showFraction = false,
  });

  final OverlayPosition position;
  final String title;
  final List<SheetStage> stages;
  final SheetStage? initialStage;
  final bool showFraction;

  @override
  State<_SheetDemo> createState() => _SheetDemoState();
}

class _SheetDemoState extends State<_SheetDemo> {
  final SheetController _controller = SheetController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool vertical =
        widget.position == OverlayPosition.top ||
        widget.position == OverlayPosition.bottom;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Button(
              size: ButtonSize.sm,
              onPressed: _controller.open,
              child: const Text('Open sheet'),
            ),
            if (widget.stages.length > 2) ...<Widget>[
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.secondary,
                onPressed: () => _controller.animateTo(widget.stages[1]),
                child: const Text('Half'),
              ),
            ],
            Button(
              size: ButtonSize.sm,
              variant: ButtonVariant.outline,
              onPressed: _controller.close,
              child: const Text('Close'),
            ),
            if (widget.showFraction)
              ListenableBuilder(
                listenable: _controller,
                builder: (BuildContext context, Widget? child) => Text(
                  '${(_controller.fraction * 100).round()}% open',
                  style: TextStyle(color: theme.colors.mutedForeground),
                ),
              ),
          ],
        ),
        Gap(theme.spacing.sm),
        SizedBox(
          width: 320,
          height: vertical ? 240 : 220,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colors.muted,
              border: Border.all(color: theme.colors.border),
              borderRadius: theme.borderRadiusLg,
            ),
            clipBehavior: Clip.hardEdge,
            child: PinnedSheet(
              controller: _controller,
              position: widget.position,
              stages: widget.stages,
              initialStage:
                  widget.initialStage ??
                  (widget.stages.isNotEmpty
                      ? widget.stages.first
                      : const SheetStage.closed()),
              child: DrawerContainer(
                child: _SheetBody(title: widget.title, controller: _controller),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Bottom sheet, starting open so the chrome is visible.
Widget _sheetBottom(BuildContext context) => const _SheetDemo(
  position: OverlayPosition.bottom,
  title: 'Bottom sheet',
  initialStage: SheetStage.expanded(),
);

/// Right-side sheet.
Widget _sheetRight(BuildContext context) =>
    const _SheetDemo(position: OverlayPosition.right, title: 'Right sheet');

/// Left-side sheet.
Widget _sheetLeft(BuildContext context) =>
    const _SheetDemo(position: OverlayPosition.left, title: 'Left sheet');

/// Top sheet.
Widget _sheetTop(BuildContext context) =>
    const _SheetDemo(position: OverlayPosition.top, title: 'Top sheet');

/// Snap points: closed, half and expanded with a live fraction readout.
Widget _sheetSnapping(BuildContext context) => const _SheetDemo(
  position: OverlayPosition.bottom,
  title: 'Snap points',
  stages: <SheetStage>[
    SheetStage.closed(),
    SheetStage.fraction(0.4),
    SheetStage.expanded(),
  ],
  initialStage: SheetStage.fraction(0.4),
  showFraction: true,
);

/// Named docs examples for `pinned_sheet`; the first entry is the default.
const List<ComponentPreview> pinnedSheetPreviews = <ComponentPreview>[
  ComponentPreview('Bottom sheet', _sheetBottom),
  ComponentPreview('Right side', _sheetRight),
  ComponentPreview('Left side', _sheetLeft),
  ComponentPreview('Top sheet', _sheetTop),
  ComponentPreview('Snap points', _sheetSnapping),
];
