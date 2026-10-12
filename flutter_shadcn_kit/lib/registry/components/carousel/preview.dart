// Named examples for the `carousel` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. Every example is a working carousel: card-style
// numbered slides clipped to the viewport, prev/next buttons, synced dots,
// drag/swipe, and arrow-key stepping (tap the slides to focus, then use the
// arrow keys).

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/constants.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import '../dot_indicator/dot_indicator.dart';
import 'carousel.dart';

/// One numbered card slide.
Widget _slideCard(BuildContext context, int index) {
  final theme = ShadcnTheme.of(context);
  return Container(
    decoration: BoxDecoration(
      color: theme.colors.card,
      border: Border.all(color: theme.colors.border),
      borderRadius: theme.borderRadiusLg,
    ),
    alignment: Alignment.center,
    child: Text(
      '${index + 1}',
      style: TextStyle(
        color: theme.colors.cardForeground,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// Shared working shell: viewport + prev/next + dots (+ optional counter).
class _CarouselShell extends StatefulWidget {
  const _CarouselShell({
    this.viewportFraction,
    this.gap,
    this.direction = Axis.horizontal,
    this.autoplay = false,
    this.showCounter = false,
  });

  final double? viewportFraction;
  final double? gap;
  final Axis direction;
  final bool autoplay;
  final bool showCounter;

  @override
  State<_CarouselShell> createState() => _CarouselShellState();
}

/// Slides per example.
const int _slideCount = 5;

class _CarouselShellState extends State<_CarouselShell> {
  final CarouselController _controller = CarouselController();
  final FocusNode _keys = FocusNode(debugLabel: 'CarouselShell');
  int _index = 0;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _playing = widget.autoplay;
  }

  @override
  void dispose() {
    _controller.dispose();
    _keys.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final int next = (_index + delta) % _slideCount < 0
        ? _slideCount - 1
        : (_index + delta) % _slideCount;
    _controller.animateTo(next.toDouble(), kDefaultDuration);
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.logicalKey == LogicalKeyboardKey.arrowDown) {
      _go(1);
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
        event.logicalKey == LogicalKeyboardKey.arrowUp) {
      _go(-1);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final spacing = ShadcnTheme.of(context).spacing;
    final bool horizontal = widget.direction == Axis.horizontal;
    final Widget viewport = GestureDetector(
      onTap: _keys.requestFocus,
      child: Focus(
        focusNode: _keys,
        onKeyEvent: _onKey,
        child: SizedBox(
          height: horizontal ? 160 : 280,
          child: Carousel(
            itemCount: _slideCount,
            controller: _controller,
            viewportFraction: widget.viewportFraction,
            gap: widget.gap,
            direction: widget.direction,
            autoplayInterval: _playing ? const Duration(seconds: 2) : null,
            onIndexChanged: (int index) => setState(() => _index = index),
            itemBuilder: _slideCard,
          ),
        ),
      ),
    );
    final Widget prev = Button(
      size: ButtonSize.icon,
      variant: ButtonVariant.outline,
      onPressed: () => _go(-1),
      child: Icon(
        horizontal ? LucideIcons.chevronLeft : LucideIcons.chevronUp,
        size: 16,
      ),
    );
    final Widget next = Button(
      size: ButtonSize.icon,
      variant: ButtonVariant.outline,
      onPressed: () => _go(1),
      child: Icon(
        horizontal ? LucideIcons.chevronRight : LucideIcons.chevronDown,
        size: 16,
      ),
    );
    final Widget dots = DotIndicator(
      index: _index,
      length: _slideCount,
      direction: widget.direction,
      onChanged: (int page) =>
          _controller.animateTo(page.toDouble(), kDefaultDuration),
    );

    // P7-TH1: the pager fills the 480px box (no `min`): with an `Expanded`
    // viewport a min-sized row sizes unpredictably and strands 8px, which
    // reads as off-centre. The outer Column stays min-sized and centred.
    final Widget pager = horizontal
        ? Row(
            children: <Widget>[
              prev,
              Gap(spacing.sm),
              Expanded(child: viewport),
              Gap(spacing.sm),
              next,
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[prev, Gap(spacing.sm), next],
              ),
              Gap(spacing.sm),
              Expanded(child: viewport),
              Gap(spacing.sm),
              dots,
            ],
          );
    return Align(
      // P7-TH1: centred on both axes so the stage (and the centred-example
      // audit) sees the demo in the middle, not pinned to the top.
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            pager,
            if (horizontal) ...<Widget>[Gap(spacing.sm), dots],
            if (widget.autoplay) ...<Widget>[
              Gap(spacing.sm),
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.outline,
                onPressed: () => setState(() => _playing = !_playing),
                leading: Icon(
                  _playing ? LucideIcons.pause : LucideIcons.play,
                  size: 16,
                ),
                child: Text(_playing ? 'Pause' : 'Play'),
              ),
            ],
            if (widget.showCounter) ...<Widget>[
              Gap(spacing.sm),
              Text('Slide ${_index + 1} of $_slideCount'),
              Gap(spacing.xs),
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.secondary,
                onPressed: () => _controller.animateTo(
                  (_slideCount - 1).toDouble(),
                  kDefaultDuration,
                ),
                child: const Text('Jump to last'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Default: full-width slides with prev/next and dots.
Widget _carouselDefault(BuildContext context) => const _CarouselShell();

/// Three-up slides (`basis-1/3`) with spacing.
Widget _carouselSizes(BuildContext context) =>
    const _CarouselShell(viewportFraction: 1 / 3, gap: 8);

/// Vertical orientation with up/down buttons and a vertical dot run.
Widget _carouselVertical(BuildContext context) =>
    const _CarouselShell(direction: Axis.vertical);

/// Autoplaying slides with a play/pause toggle.
Widget _carouselAutoplay(BuildContext context) =>
    const _CarouselShell(autoplay: true);

/// Controller API: live current/total counter plus a jump button.
Widget _carouselApi(BuildContext context) =>
    const _CarouselShell(showCounter: true);

/// Named docs examples for `carousel`; the first entry is the default.
const List<ComponentPreview> carouselPreviews = <ComponentPreview>[
  ComponentPreview('Default', _carouselDefault),
  ComponentPreview('Sizes', _carouselSizes),
  ComponentPreview('Vertical', _carouselVertical),
  ComponentPreview('Autoplay', _carouselAutoplay),
  ComponentPreview('With API', _carouselApi),
];
