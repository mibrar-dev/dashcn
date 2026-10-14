// The landing announcement badge (spec §2.1): secondary badge,
// text-sm/500, arrow icon, links to the docs. It hugs its label + arrow
// (upstream hero badge: inline-flex, px-3, h-7, text-sm) and caps at 320 px so
// narrow screens ellipsize instead of overflowing.
//
// P7-TH1: the radius comes from the registry `Badge` (radiusMd), so the pill
// follows the Theme Studio radius instead of forcing `circular(999)`.

import 'package:flutter/widgets.dart';

import '../ui/dashcn/components/badge/badge.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/theme/theme.dart';

/// A pill badge with a trailing arrow, used at the top of the landing page.
class Announcement extends StatelessWidget {
  /// Creates the announcement.
  const Announcement({super.key, required this.label, required this.onPressed});

  /// Badge text.
  final String label;

  /// Tap target (navigates to the docs).
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // Hug the label + arrow, but never exceed the hero width: on a 375 px
    // phone the hero leaves 327 px, while the label alone can exceed 320 px
    // in wide test fonts. The cap is the available width minus the badge
    // chrome (px-3 + icon + gap), so narrow screens ellipsize (the old fixed
    // 260 px box did the same) and wide screens hug.
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double maxWidth = constraints.maxWidth.isFinite
            ? (constraints.maxWidth - 56).clamp(120.0, 320.0)
            : 320;
        return Badge(
          variant: BadgeVariant.secondary,
          onPressed: onPressed,
          theme: BadgeStyle(
            // Upstream hero badge: px-3 (12) with py-1 (4) under text-sm
            // (14/20) for the h-7 (28) box — type from the theme's
            // textSmall (14/500), P7-TH1.
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            textStyle: Theme.of(
              context,
            ).typography.textSmall.copyWith(height: 20 / 14),
          ),
          trailing: const Icon(LucideIcons.arrowRight, size: 14),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        );
      },
    );
  }
}
