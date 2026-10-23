// Gallery preview for the `icon` component.
//
// Widgets-only, like the component itself. Shows every surviving modifier,
// the icon container, a scoped theme leg and dark tokens.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'icon.dart';

/// Preview entry point used by the docs gallery.
class IconPreview extends StatelessWidget {
  /// Creates the preview.
  const IconPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Directionality.maybeOf(context) ?? TextDirection.ltr,
      child: _IconPreviewBody(),
    );
  }
}

class _IconPreviewBody extends StatelessWidget {
  const _IconPreviewBody();

  @override
  Widget build(BuildContext context) {
    final ThemeColors colors = Theme.of(context).colors;
    final double gap = Theme.of(context).spacing.xl;
    return ColoredBox(
      color: colors.background,
      child: Center(
        // Wrap, not Row: the icon sizes sit in one centred row on wide
        // screens and reflow instead of overflowing narrow phones (the
        // framed sweep gives centre content ~328 px on a 360 px phone).
        child: Wrap(
          spacing: gap,
          runSpacing: Theme.of(context).spacing.md,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            const Icon(LucideIcons.star).iconX3Small(),
            const Icon(LucideIcons.star).iconXSmall(),
            const Icon(LucideIcons.star).iconSmall(),
            const Icon(LucideIcons.star).iconMedium(),
            const Icon(LucideIcons.star).iconLarge(),
            const Icon(LucideIcons.star).iconSmall().iconMutedForeground(),
            const IconContainer(icon: Icon(LucideIcons.check)),
            ComponentTheme<IconContainerTheme>(
              data: const IconContainerTheme(
                backgroundColor: ThemedColor.ref(ColorRef.secondary),
                iconColor: ThemedColor.ref(ColorRef.secondaryForeground),
              ),
              child: const IconContainer(icon: Icon(LucideIcons.check)),
            ),
          ],
        ),
      ),
    );
  }
}
