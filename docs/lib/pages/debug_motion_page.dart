// TEMPORARY visual-proof harness for the motion enter/exit pass.
//
// Serves one tap-driven demo per case at `/debug-motion?case=<name>` with
// big fixed targets, so interaction videos have deterministic coordinates.
// Uses the REAL kit components (same code paths as the docs pages);
// drags are driven through the components' controllers, which run the exact
// settle/collapse code the gesture release calls. DELETED before merge.

import 'dart:async';

import 'package:flutter/widgets.dart';

import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/card/card.dart';
import '../ui/dashcn/components/dialog/dialog.dart';
import '../ui/dashcn/components/dropdown_menu/dropdown_menu.dart';
import '../ui/dashcn/components/menu/menu.dart';
import '../ui/dashcn/components/swipe_actions/swipe_actions.dart';
import '../ui/dashcn/components/switch/switch.dart';
import '../ui/dashcn/components/toast/toast.dart';
import '../ui/dashcn/primitives/motion/motion_spec.dart';
import '../ui/dashcn/primitives/overlay.dart';
import '../ui/dashcn/theme/theme.dart';

/// Tap-driven motion demos, one per `case`.
class DebugMotionPage extends StatelessWidget {
  /// Creates the harness page.
  const DebugMotionPage({super.key, required this.demo});

  /// Which demo to show (`dialog`, `dropdown`, `toast`, `button`,
  /// `switch`, `swipe`).
  final String demo;

  @override
  Widget build(BuildContext context) {
    final Widget body = switch (demo) {
      'dropdown' => const _DropdownDemo(),
      'toast' => const _ToastDemo(),
      'button' => const _ButtonDemo(),
      'switch' => const _SwitchDemo(),
      'swipe' => const _SwipeDemo(),
      _ => const _DialogDemo(),
    };
    return ColoredBox(color: Theme.of(context).colors.background, child: body);
  }
}

/// Big centered trigger button at a fixed spot.
class _BigButton extends StatelessWidget {
  const _BigButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 280,
        height: 72,
        child: Button(onPressed: onPressed, child: Text(label)),
      ),
    );
  }
}

class _DialogDemo extends StatelessWidget {
  const _DialogDemo();

  @override
  Widget build(BuildContext context) {
    return _BigButton(
      label: 'OPEN DIALOG',
      onPressed: () => showDialog<void>(
        context: context,
        builder: (BuildContext context) => Center(
          child: SizedBox(
            width: 360,
            height: 280,
            child: ColoredBox(
              color: Theme.of(context).colors.card,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Debug dialog'),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 300,
                    height: 120,
                    child: Button(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('CLOSE DIALOG'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DropdownDemo extends StatelessWidget {
  const _DropdownDemo();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 280,
        height: 72,
        child: Button(
          variant: ButtonVariant.outline,
          onPressed: () => showDropdown<void>(
            context: context,
            children: <Widget>[
              MenuButton(
                child: const Text('Profile'),
                onPressed: (_) => closeOverlay(context, 'Profile'),
              ),
              MenuButton(
                child: const Text('Settings'),
                onPressed: (_) => closeOverlay(context, 'Settings'),
              ),
              MenuButton(
                child: const Text('Sign out'),
                onPressed: (_) => closeOverlay(context, 'Sign out'),
              ),
            ],
          ),
          child: const Text('OPEN MENU'),
        ),
      ),
    );
  }
}

class _ToastDemo extends StatelessWidget {
  const _ToastDemo();

  @override
  Widget build(BuildContext context) {
    return _BigButton(
      label: 'SHOW TOAST',
      onPressed: () => showToast(
        context,
        builder: (BuildContext context) =>
            const Text('Saved to your workspace.'),
      ),
    );
  }
}

class _ButtonDemo extends StatelessWidget {
  const _ButtonDemo();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 280,
        height: 72,
        child: Button(
          onPressedAsync: () =>
              Future<void>.delayed(const Duration(milliseconds: 1200)),
          child: const Text('SAVE'),
        ),
      ),
    );
  }
}

class _SwitchDemo extends StatefulWidget {
  const _SwitchDemo();

  @override
  State<_SwitchDemo> createState() => _SwitchDemoState();
}

class _SwitchDemoState extends State<_SwitchDemo> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: GestureDetector(
        onTap: () => setState(() => _value = !_value),
        child: ColoredBox(
          color: theme.colors.muted,
          child: SizedBox(
            width: 320,
            height: 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Switch(
                  value: _value,
                  onChanged: (bool v) => setState(() => _value = v),
                ),
                const SizedBox(height: 12),
                Text(
                  _value ? 'SWITCH IS ON' : 'SWITCH IS OFF',
                  style: theme.typography.textSmall.copyWith(
                    color: theme.colors.foreground,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SwipeDemo extends StatefulWidget {
  const _SwipeDemo();

  @override
  State<_SwipeDemo> createState() => _SwipeDemoState();
}

class _SwipeDemoState extends State<_SwipeDemo> {
  final SwipeActionsController _controller = SwipeActionsController();
  bool _removed = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 120, left: 40, right: 40),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200,
                child: Button(
                  onPressed: () => _controller.open(),
                  child: const Text('SWIPE OPEN'),
                ),
              ),
              const SizedBox(width: 24),
              SizedBox(
                width: 200,
                child: Button(
                  variant: ButtonVariant.destructive,
                  onPressed: () => _controller.dismiss(),
                  child: const Text('SWIPE COMMIT'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          if (_removed)
            Text(
              'REMOVED',
              style: theme.typography.textSmall.copyWith(
                color: theme.colors.foreground,
              ),
            )
          else
            SwipeActions(
              controller: _controller,
              motion: const MotionSpec(),
              actions: <SwipeAction>[
                SwipeAction(label: 'Archive', onPressed: () {}),
                SwipeAction(
                  label: 'Delete',
                  destructive: true,
                  onPressed: () {},
                ),
              ],
              onDismissed: () => setState(() => _removed = true),
              child: Card(
                child: SizedBox(
                  height: 72,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Swipe me',
                        style: theme.typography.textSmall.copyWith(
                          color: theme.colors.foreground,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
