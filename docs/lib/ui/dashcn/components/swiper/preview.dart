// Named examples for the `swiper` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. Each example bounds the swipe surface because the
// panel extent is measured from the laid-out child.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'swiper.dart';

/// Drag towards the panel edge to reveal a drawer.
Widget _drawer(BuildContext context) {
  return SizedBox(
    width: 320,
    height: 200,
    child: Swiper(
      position: OverlayPosition.left,
      builder: (BuildContext context) => _Panel(
        title: 'Drawer',
        hint: docsSample(context, 'Swipe it away to dismiss'),
      ),
      child: _SwipeSurface(docsSample(context, 'Swipe right for a drawer')),
    ),
  );
}

/// Drag up to reveal a sheet.
Widget _sheet(BuildContext context) {
  return SizedBox(
    width: 320,
    height: 200,
    child: Swiper(
      position: OverlayPosition.bottom,
      variant: SwiperVariant.sheet,
      builder: (BuildContext context) => _Panel(
        title: 'Sheet',
        hint: docsSample(context, 'Drag down to dismiss'),
      ),
      child: _SwipeSurface(docsSample(context, 'Swipe up for a sheet')),
    ),
  );
}

/// A tappable-looking surface that carries the swipe hint.
class _SwipeSurface extends StatelessWidget {
  const _SwipeSurface(this.hint);

  final String hint;

  @override
  Widget build(BuildContext context) {
    final ThemeColors colors = Theme.of(context).colors;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.muted,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(hint, style: TextStyle(color: colors.mutedForeground)),
    );
  }
}

/// The overlay body used by both variants.
class _Panel extends StatelessWidget {
  const _Panel({required this.title, required this.hint});

  final String title;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final ThemeColors colors = Theme.of(context).colors;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Gap(Theme.of(context).spacing.sm),
          Text(hint, style: TextStyle(color: colors.mutedForeground)),
        ],
      ),
    );
  }
}

/// Named docs examples for `swiper`; the first entry is the default.
List<ComponentPreview> get swiperPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _drawer),
  ComponentPreview('Sheet', _sheet),
];
