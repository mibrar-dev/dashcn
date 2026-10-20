// The keyboard wiring of the `toolbar` component.
//
// The arrow keys walk the toolbar's items through the roving group. A
// vertical toolbar walks on the up/down arrows; a horizontal one walks on the
// left/right arrows, mirrored in RTL.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../primitives/roving_group.dart';

/// The arrow-key shortcuts of a toolbar.
///
/// [axis] is the toolbar's axis and [rtl] mirrors the horizontal map.
Map<LogicalKeySet, Intent> toolbarShortcuts(Axis axis, bool rtl) {
  if (axis == Axis.vertical) {
    return <LogicalKeySet, Intent>{
      LogicalKeySet(LogicalKeyboardKey.arrowDown): const NextRovingItemIntent(),
      LogicalKeySet(LogicalKeyboardKey.arrowUp):
          const PreviousRovingItemIntent(),
    };
  }
  return rtl
      ? <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.arrowLeft):
              const NextRovingItemIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowRight):
              const PreviousRovingItemIntent(),
        }
      : <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.arrowRight):
              const NextRovingItemIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowLeft):
              const PreviousRovingItemIntent(),
        };
}

/// The actions behind the arrow-key shortcuts of a toolbar.
///
/// The actions move the [registry] one step forwards or backwards.
Map<Type, Action<Intent>> toolbarActions(RovingGroupRegistry<int> registry) {
  return <Type, Action<Intent>>{
    NextRovingItemIntent: CallbackAction<NextRovingItemIntent>(
      onInvoke: (NextRovingItemIntent intent) {
        registry.move(1);
        return null;
      },
    ),
    PreviousRovingItemIntent: CallbackAction<PreviousRovingItemIntent>(
      onInvoke: (PreviousRovingItemIntent intent) {
        registry.move(-1);
        return null;
      },
    ),
  };
}
