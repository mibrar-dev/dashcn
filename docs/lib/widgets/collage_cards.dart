// The landing collage card shell (spec §2.1).
//
// Split in P6-P1: this file keeps [CollageCard] + [collageNoop] only; the
// concrete cards live in `collage_cards_forms.dart` and
// `collage_cards_info.dart` to keep every file under the ~400-line rule.

import 'package:flutter/widgets.dart';

import '../ui/dashcn/components/card/card.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/theme/color_tokens.dart';
import '../ui/dashcn/theme/theme.dart';
import 'docs_tokens.dart';

/// Base card: card fill, `shadow-sm` + 5 % foreground ring.
/// The shared collage card shell (radiusXl, card fill, soft ring).
///
/// P7-TH1: radius, padding, gaps and shadows all come from the active theme,
/// so the home collage follows the Theme Studio radius/spacing/density.
class CollageCard extends StatelessWidget {
  const CollageCard({
    super.key,
    this.title,
    this.subtitle,
    this.trailing,
    required this.children,
  });

  final String? title;
  final String? subtitle;

  /// Optional widget at the end of the header row (actions, icons, counts).
  final Widget? trailing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ThemeColors colors = theme.colors;
    return Card(
      padding: EdgeInsets.all(theme.spacing.xl),
      background: ThemedColor.ref(ColorRef.card),
      borderColor: ThemedColor.value(colors.foreground.withValues(alpha: 0.05)),
      borderWidth: 1,
      borderRadius: theme.borderRadiusXl,
      shadows: theme.tokens.shadows.shadowSm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (title != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    title!,
                    style: docsText(
                      context,
                      size: 16,
                      weight: FontWeight.w600,
                      color: colors.cardForeground,
                    ),
                  ),
                ),
                if (trailing != null) ...<Widget>[
                  Gap(theme.spacing.sm),
                  trailing!,
                ],
              ],
            ),
          if (subtitle != null) ...<Widget>[
            Gap(theme.spacing.xs),
            Text(
              subtitle!,
              style: docsText(
                context,
                size: 14,
                height: 1.4,
                color: colors.mutedForeground,
              ),
            ),
          ],
          if (title != null || subtitle != null) Gap(theme.spacing.md),
          ...children,
        ],
      ),
    );
  }
}

/// No-op callback for showcase buttons that must render enabled.
void collageNoop() {}
