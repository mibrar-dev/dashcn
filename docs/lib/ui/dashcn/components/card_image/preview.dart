// Named examples for the `card_image` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// P7-C2: every card example is live — tapping a card selects it and the
// selection is echoed under the row, so the demo shows what `onPressed` does.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/theme.dart';
import 'card_image.dart';

/// A palette-derived thumbnail, so the demo follows the selected theme.
Widget _cardImageThumb(BuildContext context, double height) {
  final theme = Theme.of(context);
  return SizedBox(
    height: height,
    child: ColoredBox(
      color: theme.colors.muted,
      child: Center(
        child: Icon(
          LucideIcons.image,
          size: 28,
          color: theme.colors.mutedForeground,
        ),
      ),
    ),
  );
}

/// One card row plus the status line the example writes to.
class _CardImageRow extends StatelessWidget {
  const _CardImageRow({
    required this.width,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onPressed,
    this.image,
    this.direction = Axis.vertical,
    this.enabled = true,
  });

  final double width;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onPressed;
  final Widget? image;
  final Axis direction;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: width,
          child: CardImage(
            theme: CardImageTheme(direction: direction, gap: 12),
            image: image ?? _cardImageThumb(context, 120),
            title: Text(
              title,
              style: TextStyle(
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            subtitle: Text(subtitle),
            enabled: enabled,
            onPressed: onPressed,
          ),
        ),
        Gap(theme.spacing.sm),
        Text(
          selected ? 'Opened "$title"' : 'Tap the card to open it',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

/// Vertical composition: media above the text block.
class _CardImageVertical extends StatefulWidget {
  const _CardImageVertical();

  @override
  State<_CardImageVertical> createState() => _CardImageVerticalState();
}

class _CardImageVerticalState extends State<_CardImageVertical> {
  bool _opened = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _CardImageRow(
          width: 220,
          title: 'Sunset',
          subtitle: '18:42 - Lisbon',
          selected: _opened,
          onPressed: () => setState(() => _opened = !_opened),
        ),
      ],
    );
  }
}

/// Horizontal composition: media beside the text block.
class _CardImageHorizontal extends StatefulWidget {
  const _CardImageHorizontal();

  @override
  State<_CardImageHorizontal> createState() => _CardImageHorizontalState();
}

class _CardImageHorizontalState extends State<_CardImageHorizontal> {
  bool _opened = false;

  @override
  Widget build(BuildContext context) {
    return _CardImageRow(
      width: 320,
      direction: Axis.horizontal,
      image: SizedBox(width: 96, child: _cardImageThumb(context, 120)),
      title: 'Ambient loops',
      subtitle: '3:21 - focus mix',
      selected: _opened,
      onPressed: () => setState(() => _opened = !_opened),
    );
  }
}

/// The disabled card next to a live one, so the pair reads as one row.
class _CardImageDisabledPair extends StatefulWidget {
  const _CardImageDisabledPair();

  @override
  State<_CardImageDisabledPair> createState() => _CardImageDisabledPairState();
}

class _CardImageDisabledPairState extends State<_CardImageDisabledPair> {
  bool _opened = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Theme.of(context).spacing.lg,
      runSpacing: Theme.of(context).spacing.lg,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: <Widget>[
        _CardImageRow(
          width: 220,
          title: 'Archived',
          subtitle: 'read-only',
          selected: false,
          enabled: false,
          onPressed: () {},
        ),
        _CardImageRow(
          width: 220,
          title: 'In progress',
          subtitle: 'tap to open',
          selected: _opened,
          onPressed: () => setState(() => _opened = !_opened),
        ),
      ],
    );
  }
}

Widget _cardImageVertical(BuildContext context) => const _CardImageVertical();

Widget _cardImageHorizontal(BuildContext context) =>
    const _CardImageHorizontal();

Widget _cardImageDisabled(BuildContext context) =>
    const _CardImageDisabledPair();

/// Named docs examples for `card_image`; the first entry is the default.
const List<ComponentPreview> cardImagePreviews = <ComponentPreview>[
  ComponentPreview('Vertical', _cardImageVertical),
  ComponentPreview('Horizontal', _cardImageHorizontal),
  ComponentPreview('Disabled', _cardImageDisabled),
];
