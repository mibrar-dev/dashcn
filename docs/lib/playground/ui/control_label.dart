// Shared bits of the playground control rows: the commit signature and the
// visible row label (theme small type, muted token).

import 'package:flutter/widgets.dart';

import '../../ui/dashcn/theme/theme.dart';

/// Commits one control's next value (`null` unsets).
typedef ControlCommitted = void Function(String name, Object? value);

/// Visible row label (every control is labelled, on screen and in semantics).
class ControlLabel extends StatelessWidget {
  /// Creates the label for [text].
  const ControlLabel({super.key, required this.text});

  /// The label text.
  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Text(
      text,
      style: theme.typography.small.copyWith(
        color: theme.colors.mutedForeground,
      ),
    );
  }
}
