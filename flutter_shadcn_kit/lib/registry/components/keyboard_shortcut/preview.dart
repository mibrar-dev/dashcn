// Named examples for the `keyboard_shortcut` component (P6-F3 preview
// contract).
//
// Centred, theme-driven chords: caps use the ambient muted surface, border,
// small radius and mono face, so they track the selected preset and the site
// light/dark toggle. `Ghost` renders the fill-free variant (P7-WC2).

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import '../card/card.dart';
import 'keyboard_shortcut.dart';

/// A chord the example can really fire.
class _KbdLive extends StatefulWidget {
  const _KbdLive();

  @override
  State<_KbdLive> createState() => _KbdLiveState();
}

class _KbdLiveState extends State<_KbdLive> {
  String _status = 'Press the chord';

  @override
  Widget build(BuildContext context) {
    final ShadcnThemeData theme = ShadcnTheme.of(context);
    return Shortcuts(
      shortcuts: const <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.keyK, meta: true):
            _OpenPaletteIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          _OpenPaletteIntent: CallbackAction<_OpenPaletteIntent>(
            onInvoke: (_) => setState(() => _status = 'Command palette opened'),
          ),
        },
        child: Focus(
          autofocus: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const KeyboardShortcut(
                keys: <LogicalKeyboardKey>[
                  LogicalKeyboardKey.meta,
                  LogicalKeyboardKey.keyK,
                ],
              ),
              Gap(theme.spacing.md),
              Text(
                _status,
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The intent the live example binds.
class _OpenPaletteIntent extends Intent {
  const _OpenPaletteIntent();
}

/// The command-palette chord, from an activator.
Widget _kbdDefault(BuildContext context) {
  return const Align(
    alignment: Alignment.center,
    child: KeyboardShortcut.fromActivator(
      activator: SingleActivator(LogicalKeyboardKey.keyK, meta: true),
    ),
  );
}

/// Modifiers first, in the order they are held.
Widget _kbdModifiers(BuildContext context) {
  return const Align(
    alignment: Alignment.center,
    child: KeyboardShortcut(
      keys: <LogicalKeyboardKey>[
        LogicalKeyboardKey.control,
        LogicalKeyboardKey.shift,
        LogicalKeyboardKey.keyP,
      ],
    ),
  );
}

/// G then H: a two-step sequence, not a chord.
Widget _kbdSequence(BuildContext context) {
  final ShadcnThemeData theme = ShadcnTheme.of(context);
  return Align(
    alignment: Alignment.center,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const KeyboardShortcut(
          keys: <LogicalKeyboardKey>[LogicalKeyboardKey.keyG],
        ),
        Gap(theme.spacing.sm),
        Text(
          'then',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
        Gap(theme.spacing.sm),
        const KeyboardShortcut(
          keys: <LogicalKeyboardKey>[LogicalKeyboardKey.keyH],
        ),
      ],
    ),
  );
}

/// Inside a menu item: the chord trails the label, as in `command` menus.
Widget _kbdInMenuItem(BuildContext context) {
  return Align(
    alignment: Alignment.center,
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: const Card(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: <Widget>[
            Expanded(child: Text('Open command palette')),
            Gap(16),
            KeyboardShortcut.fromActivator(
              activator: SingleActivator(LogicalKeyboardKey.keyK, meta: true),
            ),
          ],
        ),
      ),
    ),
  );
}

/// A chord under a custom display scope.
Widget _kbdScoped(BuildContext context) {
  return const Align(
    alignment: Alignment.center,
    child: KeyboardShortcutDisplayScope(
      builder: _kbdLabel,
      child: KeyboardShortcut(
        keys: <LogicalKeyboardKey>[
          LogicalKeyboardKey.alt,
          LogicalKeyboardKey.keyF,
        ],
      ),
    ),
  );
}

Widget _kbdLabel(BuildContext context, LogicalKeyboardKey key) =>
    Text(key.keyLabel.toUpperCase());

/// A chord that can really be pressed.
Widget _kbdLive(BuildContext context) =>
    const Align(alignment: Alignment.center, child: _KbdLive());

/// The same chord with no fill: a hint on a coloured surface (P7-WC2).
Widget _kbdGhost(BuildContext context) {
  return const Align(
    alignment: Alignment.center,
    child: KeyboardShortcut(
      variant: KbdVariant.ghost,
      keys: <LogicalKeyboardKey>[
        LogicalKeyboardKey.meta,
        LogicalKeyboardKey.keyK,
      ],
    ),
  );
}

/// Named docs examples for `keyboard_shortcut`; the first is the default.
const List<ComponentPreview> keyboardShortcutPreviews = <ComponentPreview>[
  ComponentPreview('Default', _kbdDefault),
  ComponentPreview('Modifiers', _kbdModifiers),
  ComponentPreview('Sequence', _kbdSequence),
  ComponentPreview('In menu item', _kbdInMenuItem),
  ComponentPreview('Scoped labels', _kbdScoped),
  ComponentPreview('Live chord', _kbdLive),
  ComponentPreview('Ghost', _kbdGhost),
];
