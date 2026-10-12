// Playground builder for the `dialog` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/button/button.dart';
import 'package:docs/ui/dashcn/components/dialog/dialog.dart';
import 'package:flutter/widgets.dart';

/// Renders a dialog trigger from playground values.
///
/// `showDialog` runs on tap, so the trigger carries the dialog
/// configuration in its key: changing any control rebuilds the trigger.
Widget buildDialogPlayground(BuildContext context, PlaygroundValues values) {
  final bool useRootNavigator = values.getBoolOr('useRootNavigator', true);
  final bool barrierDismissible = values.getBoolOr('barrierDismissible', true);
  final String? barrierLabel = values.getString('barrierLabel');
  final bool useSafeArea = values.getBoolOr('useSafeArea', true);
  final bool fullScreen = values.getBoolOr('fullScreen', false);
  return Button(
    key: ValueKey<String>(
      'dialog-$useRootNavigator-$barrierDismissible-'
      '$barrierLabel-$useSafeArea-$fullScreen',
    ),
    onPressed: () => showDialog<void>(
      context: context,
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      fullScreen: fullScreen,
      builder: (BuildContext context) => const _DialogBody(),
    ),
    child: const Text('Open dialog'),
  );
}

/// The demo dialog body: a fixed title, message and close action.
class _DialogBody extends StatelessWidget {
  const _DialogBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Delete this project?'),
        const Text('This cannot be undone.'),
        Button(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
