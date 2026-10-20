// Live motion demos embedded in the Theming page Motion section.
//
// Small stateful demos (no timers of their own): a presence banner that
// plays its exit before unmounting, a collapsing error message, and a
// per-instance MotionSpec override. They render against the synced kit copy
// under `lib/ui/dashcn`, refreshed by `tool/sync_registry.sh`.

import 'package:flutter/widgets.dart';

import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/primitives/motion/motion_collapse.dart';
import '../ui/dashcn/primitives/motion/motion_presence.dart';
import '../ui/dashcn/primitives/motion/motion_spec.dart';
import '../ui/dashcn/theme/theme.dart';

/// Presence + collapse + per-instance override, side by side.
class MotionDemos extends StatelessWidget {
  /// Creates the motion demos.
  const MotionDemos({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _PresenceDemo(),
        Gap(16),
        _CollapseDemo(),
        Gap(16),
        _SpecDemo(),
      ],
    );
  }
}

/// A banner that fades/slides out before it unmounts.
class _PresenceDemo extends StatefulWidget {
  const _PresenceDemo();

  @override
  State<_PresenceDemo> createState() => _PresenceDemoState();
}

class _PresenceDemoState extends State<_PresenceDemo> {
  bool _show = true;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Button(
          size: ButtonSize.sm,
          onPressed: () => setState(() => _show = !_show),
          child: Text(_show ? 'Hide banner' : 'Show banner'),
        ),
        const Gap(8),
        MotionPresence(
          visible: _show,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colors.muted,
              borderRadius: theme.borderRadiusMd,
            ),
            child: Text(
              'I exit before I unmount.',
              style: theme.typography.textSmall.copyWith(
                color: theme.colors.foreground,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// An error-style message that collapses (height + fade) on clear.
class _CollapseDemo extends StatefulWidget {
  const _CollapseDemo();

  @override
  State<_CollapseDemo> createState() => _CollapseDemoState();
}

class _CollapseDemoState extends State<_CollapseDemo> {
  bool _error = true;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Button(
          size: ButtonSize.sm,
          onPressed: () => setState(() => _error = !_error),
          child: Text(_error ? 'Clear error' : 'Show error'),
        ),
        MotionCollapse(
          visible: _error,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Enter a full number.',
              style: theme.typography.textSmall.copyWith(
                color: theme.colors.destructive,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// The same presence exit, retimed per instance (slow) without touching
/// the theme.
class _SpecDemo extends StatefulWidget {
  const _SpecDemo();

  @override
  State<_SpecDemo> createState() => _SpecDemoState();
}

class _SpecDemoState extends State<_SpecDemo> {
  bool _show = true;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Button(
          size: ButtonSize.sm,
          onPressed: () => setState(() => _show = !_show),
          child: Text(_show ? 'Hide (slow)' : 'Show (slow)'),
        ),
        const Gap(8),
        MotionPresence(
          visible: _show,
          motion: const MotionSpec(
            enterDuration: Duration(milliseconds: 450),
            exitDuration: Duration(milliseconds: 450),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colors.muted,
              borderRadius: theme.borderRadiusMd,
            ),
            child: Text(
              'Per-instance timing.',
              style: theme.typography.textSmall.copyWith(
                color: theme.colors.foreground,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
