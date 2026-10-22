// The framed, page-size block viewport (P7-B2 full-page layouts): the
// reference `/blocks` card renders each block inside an iframe sized to the
// device it targets, with desktop / tablet / mobile toggles beside the
// Preview | Code tabs.
//
// Ours is the same idea without an iframe: the block widget itself is laid
// out inside a fixed page frame — desktop 1280×800, tablet 768×1024, mobile
// 390×844 — scaled down to fit the card width when the card is narrower
// (like the reference iframe zoom), centred in the card. The block always
// gets tight page constraints (full width + full height), so split layouts
// fill halves edge to edge, sidebars run full height and dashboards fill the
// viewport. Every block is responsive (they lay out from `LayoutBuilder`
// breakpoints), so the mobile frame shows the phone layout of the same
// source. Blocks may use vertical `Expanded`/`Flexible`: the host is always
// bounded. The `/blocks/<id>` page reuses the same frame; its desktop page
// is the full-window render.

import 'package:flutter/widgets.dart';

import '../routing/docs_router.dart';
import '../state/docs_strings.dart';

import '../previews/block_previews.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/spinner/spinner.dart';
import '../ui/dashcn/components/tooltip/tooltip.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/theme/theme.dart';

/// The three viewport presets of a block card, in reference order.
///
/// Each preset is a realistic page size: desktop ≈ 1280×800, tablet
/// 768×1024, mobile 390×844. The frame scales the page down to fit the card
/// when the card is narrower, never up.
enum BlockViewport {
  /// 1280×800 desktop page.
  desktop('Desktop', LucideIcons.monitor, 1280, 800),

  /// 768×1024 tablet page.
  tablet('Tablet', LucideIcons.tablet, 768, 1024),

  /// 390×844 phone page.
  mobile('Mobile', LucideIcons.smartphone, 390, 844);

  const BlockViewport(this.label, this.icon, this.pageWidth, this.pageHeight);

  /// Visible label (tooltip).
  final String label;

  /// Toolbar icon.
  final IconData icon;

  /// Fixed page width the block is laid out at.
  final double pageWidth;

  /// Fixed page height the block is laid out at.
  final double pageHeight;
}

/// Shortest frame a block ever gets (P7-B1 compat): the page frames are
/// fixed heights now, but the constant stays for tests importing it.
const double kBlockPreviewMinHeight = 360;

/// The device toggle group: three icon buttons, the active one filled.
class BlockViewportToggle extends StatelessWidget {
  /// Creates the toggle group.
  const BlockViewportToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  /// The selected viewport.
  final BlockViewport value;

  /// Called with the new viewport.
  final ValueChanged<BlockViewport> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (final BlockViewport viewport in BlockViewport.values) ...<Widget>[
          if (viewport != BlockViewport.values.first) const Gap(4),
          Tooltip(
            tooltip: (BuildContext context) => Text(viewport.label),
            child: SizedBox(
              width: 28,
              height: 28,
              child: Button(
                variant: value == viewport
                    ? ButtonVariant.secondary
                    : ButtonVariant.ghost,
                size: ButtonSize.xs,
                theme: const ButtonVariantStyle(padding: EdgeInsets.zero),
                onPressed: () => onChanged(viewport),
                child: Icon(viewport.icon, size: 14),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// The framed viewport that hosts the block preview at [viewport]'s page
/// size.
///
/// The viewport sits *inside* the card's one continuous border (the card
/// clips it to the bottom radius): the page is centred on the card
/// background and scaled down only when the card is narrower than the page
/// (desktop 1280 in a ~1100 px card renders at ~0.86×, like the reference
/// iframe zoom). Tablet and mobile keep their bordered device frame;
/// desktop paints no inner border of its own, so header + tabs + viewport
/// read as a single framed card (upstream `/blocks`). The block always gets
/// tight page constraints (full width + full height), so splits fill halves
/// edge to edge and sidebars run full height. Nothing is ever clipped: the
/// frame is exactly the page, and the block scrolls internally when its
/// content exceeds the page height.
class BlockPreviewFrame extends StatelessWidget {
  /// Creates the frame.
  const BlockPreviewFrame({
    super.key,
    required this.blockId,
    required this.viewport,
  });

  /// The block id (`dashboard-01`).
  final String blockId;

  /// The selected viewport page size.
  final BlockViewport viewport;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: double.infinity,
      color: theme.colors.background,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double available = constraints.maxWidth;
          final double pageW = viewport.pageWidth;
          final double pageH = viewport.pageHeight;
          // Never upscale: a wide card centres the page, a narrow card
          // scales it down uniformly (text included, like an iframe zoom).
          final double scale = available >= pageW ? 1 : available / pageW;
          final double outW = pageW * scale;
          final double outH = pageH * scale;
          final Widget page = SizedBox(
            width: pageW,
            height: pageH,
            child: BlockPreviewLoader(blockId: blockId),
          );
          final Widget stage;
          if (scale == 1) {
            stage = SizedBox(width: outW, height: outH, child: page);
          } else {
            // Tight output box + FittedBox: the child lays out at the full
            // page size, then paints scaled to fit. `contain` on a box with
            // the page aspect is exactly `scale`.
            stage = SizedBox(
              width: outW,
              height: outH,
              child: FittedBox(fit: BoxFit.contain, child: page),
            );
          }
          // Desktop paints no inner border of its own, so the card's own
          // border is the single continuous frame. Narrower viewports keep
          // their bordered device frame.
          if (viewport == BlockViewport.desktop) {
            return DecoratedBox(
              key: ValueKey<String>('block-frame-$blockId'),
              decoration: BoxDecoration(color: theme.colors.background),
              child: ClipRect(child: stage),
            );
          }
          return DecoratedBox(
            key: ValueKey<String>('block-frame-$blockId'),
            decoration: BoxDecoration(
              color: theme.colors.background,
              border: Border.all(color: theme.colors.border),
              borderRadius: theme.borderRadiusLg,
            ),
            child: ClipRRect(borderRadius: theme.borderRadiusLg, child: stage),
          );
        },
      ),
    );
  }
}

/// Loads one deferred block widget and rebuilds when it arrives.
///
/// The future is cached per block id, so a viewport switch (which rebuilds
/// through the card's state) re-uses the loaded widget instead of refetching
/// its chunk.
class BlockPreviewLoader extends StatefulWidget {
  /// Creates the loader for [blockId].
  const BlockPreviewLoader({super.key, required this.blockId});

  /// The block id.
  final String blockId;

  @override
  State<BlockPreviewLoader> createState() => BlockPreviewLoaderState();
}

/// State of [BlockPreviewLoader] (public for the ~400-line rule).
class BlockPreviewLoaderState extends State<BlockPreviewLoader> {
  Future<Widget>? _future;
  String? _key;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _maybeLoad();
  }

  @override
  void didUpdateWidget(covariant BlockPreviewLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    _maybeLoad();
  }

  void _maybeLoad() {
    if (_key != widget.blockId) {
      _key = widget.blockId;
      _future = loadBlockPreview(widget.blockId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasData) {
          return KeyedSubtree(
            key: ValueKey<String>(widget.blockId),
            child: snapshot.data!,
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                docsChrome(
                  DocsRouterScope.maybeOf(context)?.state.locale ??
                      const Locale('en'),
                  'cmpPreviewFailed',
                ),
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colors.mutedForeground,
                ),
              ),
            ),
          );
        }
        return const Center(child: Spinner());
      },
    );
  }
}
