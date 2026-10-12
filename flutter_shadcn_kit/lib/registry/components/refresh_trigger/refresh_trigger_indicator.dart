// The default refresh pill for the `refresh_trigger` component: the
// [DefaultRefreshIndicator] (arrow, spinner, check + labels) with its
// private spinner and check-painter helpers.
//
// Split out of `refresh_trigger.dart` for the ~400-line rule: the trigger
// mechanics (pull tracking, lifecycle) live there, the default pill lives
// here. User-owned overrides live in `refresh_trigger_theme.dart`.

import 'dart:math' show pi;

import 'package:flutter/widgets.dart';

import '../../foundation/constants.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/localizations/localizations.dart';
import '../../theme/theme.dart';
import '../card/card.dart';
import 'refresh_trigger_style.dart';

/// Default refresh pill on a card surface.
class DefaultRefreshIndicator extends StatelessWidget {
  const DefaultRefreshIndicator({super.key, required this.stage});

  final RefreshTriggerStage stage;

  @override
  Widget build(BuildContext context) {
    final ShadcnLocalizations strings = ShadcnLocalizations.of(context);
    final ShadcnThemeData ambient = ShadcnTheme.of(context);
    final double pull = stage.extentValue.clamp(0, 1);
    final double angle = stage.direction == Axis.vertical
        ? -pi * pull
        : -pi / 2 - pi * pull;
    final Widget content = switch (stage.stage) {
      TriggerStage.refreshing => _row(
        Text(strings.refreshTriggerRefreshing),
        _SpinIcon(color: ambient.colors.foreground),
        ambient.spacing.sm,
      ),
      TriggerStage.completed => _row(
        Text(strings.refreshTriggerComplete),
        CustomPaint(
          size: const Size(16, 12),
          painter: _CheckPainter(ambient.colors.foreground),
        ),
        ambient.spacing.sm,
      ),
      TriggerStage.pulling || TriggerStage.idle => _row(
        Text(
          stage.extentValue < 1
              ? strings.refreshTriggerPull
              : strings.refreshTriggerRelease,
        ),
        Transform.rotate(
          angle: angle,
          child: const Icon(LucideIcons.arrowDown, size: 16),
        ),
        ambient.spacing.sm,
      ),
    };
    return Center(
      child: Card(
        padding: EdgeInsets.symmetric(
          horizontal: ambient.density.baseContentPadding * 0.75,
          vertical: ambient.density.baseGap * 0.5,
        ),
        borderRadius: ambient.borderRadiusXl,
        child: AnimatedSwitcher(
          duration: kDefaultDuration,
          child: KeyedSubtree(
            key: ValueKey<TriggerStage>(stage.stage),
            child: Padding(
              padding: EdgeInsets.all(
                ambient.density.baseGap * ambient.scaling * 0.5,
              ),
              child: content,
            ),
          ),
        ),
      ),
    );
  }

  /// One pill row: label, spacing-token gap (`spacing.sm` = shadcn `gap-2`),
  /// then the icon.
  Widget _row(Widget label, Widget icon, double gap) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(child: label),
        Gap(gap),
        icon,
      ],
    );
  }
}

class _SpinIcon extends StatefulWidget {
  const _SpinIcon({required this.color});

  final Color color;

  @override
  State<_SpinIcon> createState() => _SpinIconState();
}

class _SpinIconState extends State<_SpinIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Icon(LucideIcons.loaderCircle, size: 16, color: widget.color),
    );
  }
}

class _CheckPainter extends CustomPainter {
  const _CheckPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.15, size.height * 0.55)
        ..lineTo(size.width * 0.45, size.height * 0.85)
        ..lineTo(size.width * 0.9, size.height * 0.1),
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _CheckPainter old) => old.color != color;
}
