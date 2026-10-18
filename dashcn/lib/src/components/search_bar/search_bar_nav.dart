// Keyboard map that drives a search result list from its field.
//
// Contributed through the `input` feature contract so the arrows reach the
// list instead of moving the caret (a shortcut map above the field is not in
// the key-event path of an `EditableText`).

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../primitives/input_features/input_features.dart';

class _SearchNextItemIntent extends Intent {
  const _SearchNextItemIntent(this.direction);

  final int direction;
}

class _SearchAcceptIntent extends Intent {
  const _SearchAcceptIntent();
}

class _SearchDismissIntent extends Intent {
  const _SearchDismissIntent();
}

/// Keyboard map of the search field: arrows move the highlight, Enter
/// accepts, Escape dismisses.
class SearchBarNavFeature extends InputFeature {
  /// Creates the feature; all callbacks drive the owning [SearchBar].
  const SearchBarNavFeature({
    required this.onMove,
    required this.onAccept,
    required this.onDismiss,
  });

  /// Moves the highlight by [direction] rows (wrapping).
  final ValueChanged<int> onMove;

  /// Accepts the highlighted row, or submits the query when none is.
  final VoidCallback onAccept;

  /// Clears the field, or cancels when it is already empty.
  final VoidCallback onDismiss;

  @override
  Iterable<MapEntry<ShortcutActivator, Intent>> buildShortcuts(
    InputFeatureState state,
  ) sync* {
    yield const MapEntry<ShortcutActivator, Intent>(
      SingleActivator(LogicalKeyboardKey.arrowDown),
      _SearchNextItemIntent(1),
    );
    yield const MapEntry<ShortcutActivator, Intent>(
      SingleActivator(LogicalKeyboardKey.arrowUp),
      _SearchNextItemIntent(-1),
    );
    yield const MapEntry<ShortcutActivator, Intent>(
      SingleActivator(LogicalKeyboardKey.enter),
      _SearchAcceptIntent(),
    );
    yield const MapEntry<ShortcutActivator, Intent>(
      SingleActivator(LogicalKeyboardKey.escape),
      _SearchDismissIntent(),
    );
  }

  @override
  Iterable<MapEntry<Type, Action<Intent>>> buildActions(
    InputFeatureState state,
  ) sync* {
    yield MapEntry<Type, Action<Intent>>(
      _SearchNextItemIntent,
      CallbackAction<_SearchNextItemIntent>(
        onInvoke: (intent) {
          onMove(intent.direction);
          return null;
        },
      ),
    );
    yield MapEntry<Type, Action<Intent>>(
      _SearchAcceptIntent,
      CallbackAction<_SearchAcceptIntent>(
        onInvoke: (_) {
          onAccept();
          return null;
        },
      ),
    );
    yield MapEntry<Type, Action<Intent>>(
      _SearchDismissIntent,
      CallbackAction<_SearchDismissIntent>(
        onInvoke: (_) {
          onDismiss();
          return null;
        },
      ),
    );
  }
}
