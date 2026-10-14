// Playground builder for the `avatar` component.

import 'package:docs/playground/builder.dart';
import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/avatar/avatar.dart';
import 'package:flutter/widgets.dart';

/// Renders an [Avatar] from playground values.
///
/// The badge slot is builder-owned: it appears only while the `badgeGap`
/// control is set, so the gap change stays observable.
Widget buildAvatarPlayground(BuildContext context, PlaygroundValues values) {
  final double? badgeGap = values.getDouble('badgeGap');
  return Avatar(
    initials: values.textOr('initials'),
    size: values.getDouble('size'),
    backgroundColor: playgroundTokenColor(
      context,
      values.getToken('backgroundColor'),
    ),
    foregroundColor: playgroundTokenColor(
      context,
      values.getToken('foregroundColor'),
    ),
    badgeGap: badgeGap,
    badge: badgeGap == null
        ? null
        : Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: playgroundTokenColor(context, 'destructive'),
              shape: BoxShape.circle,
            ),
          ),
  );
}
