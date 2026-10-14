// Playground builder for the `popup` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/button/button.dart';
import 'package:docs/ui/dashcn/components/menu/menu.dart';
import 'package:docs/ui/dashcn/components/popup/popup.dart';
import 'package:docs/ui/dashcn/primitives/overlay.dart';
import 'package:flutter/widgets.dart';

/// Renders a popup trigger from playground values.
///
/// `showPopup` runs on tap, so the trigger carries the popup configuration
/// in its key: changing any control rebuilds the trigger.
Widget buildPopupPlayground(BuildContext context, PlaygroundValues values) {
  final String? widthName = values.getEnum('widthConstraint');
  final String? heightName = values.getEnum('heightConstraint');
  final bool modal = values.getBoolOr('modal', true);
  final bool consumeOutsideTaps = values.getBoolOr('consumeOutsideTaps', true);
  final double? width = values.getDouble('width');
  final double? maxWidth = values.getDouble('maxWidth');
  final double? maxHeight = values.getDouble('maxHeight');
  return Button(
    key: ValueKey<String>(
      'popup-$widthName-$heightName-$modal-'
      '$consumeOutsideTaps-$width-$maxWidth-$maxHeight',
    ),
    variant: ButtonVariant.secondary,
    onPressed: () => showPopup(
      context: context,
      widthConstraint: widthName == null
          ? PopoverConstraint.flexible
          : PopoverConstraint.values.byName(widthName),
      heightConstraint: heightName == null
          ? PopoverConstraint.flexible
          : PopoverConstraint.values.byName(heightName),
      modal: modal,
      consumeOutsideTaps: consumeOutsideTaps,
      width: width,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      builder: (BuildContext context) => MenuPopup(
        children: <Widget>[
          MenuGroup(
            children: const <Widget>[
              MenuButton(child: Text('Profile')),
              MenuButton(child: Text('Settings')),
            ],
          ),
        ],
      ),
    ),
    child: const Text('Show popup'),
  );
}
