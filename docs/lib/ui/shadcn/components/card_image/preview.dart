// Named examples for the `card_image` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. Image thumbs are theme-token fills (`chartColors`)
// with a `card`-coloured glyph, so the grid stays vivid in light and dark.
//
// P7-WB: `Vertical` is a grid of cards — the component's home is a media tile
// in a grid. Every card is live: tapping one selects it and the selection is
// echoed under the grid.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/theme.dart';
import 'card_image.dart';

/// One grid tile's content.
class _Tile {
  const _Tile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.chart,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  /// Index into `ShadcnColors.chartColors`.
  final int chart;
}

const List<_Tile> _tiles = <_Tile>[
  _Tile(
    title: 'Sunset',
    subtitle: '18:42 · Lisbon',
    icon: LucideIcons.mountain,
    chart: 0,
  ),
  _Tile(
    title: 'Harbor nights',
    subtitle: '3:21 · focus mix',
    icon: LucideIcons.music,
    chart: 1,
  ),
];

/// A theme-token poster thumb: a chart fill with a card-coloured glyph. It
/// carries no size of its own — the card's aspect-ratio surface sizes it —
/// so this is also the shape a user `Image` takes.
Widget _thumb(BuildContext context, _Tile tile) {
  final theme = ShadcnTheme.of(context);
  final List<Color> charts = theme.colors.chartColors;
  return ColoredBox(
    color: charts[tile.chart % charts.length],
    child: Center(child: Icon(tile.icon, size: 36, color: theme.colors.card)),
  );
}

/// One pressable card for [tile], selected when [selected].
Widget _tileCard(
  BuildContext context,
  _Tile tile,
  bool selected,
  VoidCallback onPressed,
) {
  return CardImage(
    image: _thumb(context, tile),
    title: Text(
      tile.title,
      style: TextStyle(
        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
      ),
    ),
    subtitle: Text(tile.subtitle),
    trailing: const Icon(LucideIcons.chevronRight, size: 16),
    onPressed: onPressed,
  );
}

/// A grid of vertical cards sharing one selection echo.
class _CardImageGrid extends StatefulWidget {
  const _CardImageGrid();

  @override
  State<_CardImageGrid> createState() => _CardImageGridState();
}

class _CardImageGridState extends State<_CardImageGrid> {
  int? _opened;

  @override
  Widget build(BuildContext context) {
    final theme = ShadcnTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ConstrainedBox(
          // Two cards per row at 200px: the grid stays inside the 720x420
          // preview stage (three across wraps to a 3+1 layout and overflows).
          constraints: const BoxConstraints(maxWidth: 424),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: theme.spacing.lg,
            runSpacing: theme.spacing.lg,
            children: <Widget>[
              for (int i = 0; i < _tiles.length; i++)
                SizedBox(
                  width: 200,
                  child: _tileCard(
                    context,
                    _tiles[i],
                    _opened == i,
                    () => setState(() => _opened = _opened == i ? null : i),
                  ),
                ),
            ],
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          _opened == null
              ? 'Tap the card to open it'
              : 'Opened "${_tiles[_opened!].title}"',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
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
    final theme = ShadcnTheme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 320,
          child: CardImage(
            theme: const CardImageTheme(direction: Axis.horizontal),
            image: SizedBox(
              width: 96,
              height: 96,
              child: _thumb(context, _tiles[1]),
            ),
            title: Text(
              _tiles[1].title,
              style: TextStyle(
                fontWeight: _opened ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            subtitle: Text(_tiles[1].subtitle),
            trailing: const Icon(LucideIcons.chevronRight, size: 16),
            onPressed: () => setState(() => _opened = !_opened),
          ),
        ),
        Gap(theme.spacing.sm),
        Text(
          _opened ? 'Opened "${_tiles[1].title}"' : 'Tap the card to open it',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
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
      alignment: WrapAlignment.center,
      spacing: ShadcnTheme.of(context).spacing.lg,
      runSpacing: ShadcnTheme.of(context).spacing.lg,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 200,
          child: CardImage(
            image: _thumb(context, _tiles[1]),
            title: const Text('Archived'),
            subtitle: const Text('read-only'),
            enabled: false,
            onPressed: () {},
          ),
        ),
        SizedBox(
          width: 200,
          child: CardImage(
            image: _thumb(context, _tiles[0]),
            title: Text(
              'In progress',
              style: TextStyle(
                fontWeight: _opened ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            subtitle: const Text('tap to open'),
            trailing: const Icon(LucideIcons.chevronRight, size: 16),
            onPressed: () => setState(() => _opened = !_opened),
          ),
        ),
      ],
    );
  }
}

Widget _cardImageVertical(BuildContext context) => const _CardImageGrid();

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
