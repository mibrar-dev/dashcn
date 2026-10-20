// The keyboard wiring of the `segmented_control` component.
//
// The arrow keys walk the segments and pick them, like a radio group. The
// horizontal map is mirrored in RTL.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../primitives/roving_group.dart';

/// The arrow-key shortcuts of a segmented control.
///
/// [rtl] mirrors the map: in RTL the left arrow moves to the next segment.
Map<LogicalKeySet, Intent> segmentedControlShortcuts(bool rtl) {
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

/// The actions behind the arrow-key shortcuts of a segmented control.
///
/// The actions move the [registry] one step forwards or backwards.
Map<Type, Action<Intent>> segmentedControlActions<T>(
  RovingGroupRegistry<T> registry,
) {
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
