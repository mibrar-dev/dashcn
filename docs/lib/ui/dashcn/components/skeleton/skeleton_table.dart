// Table placeholder for the `skeleton` component: [SkeletonTable].
//
// A header plus a row grid built from the shape primitives, so a loading
// table keeps the column geometry of the real grid. Sizes come from the
// density scale (compact default).

import 'package:flutter/widgets.dart';

import '../../theme/density_tokens.dart';
import '../../theme/theme.dart';
import 'skeleton_layout.dart';
import 'skeleton_shapes.dart';
import 'skeleton_style.dart';

/// A table-shaped loading placeholder: header plus a row grid.
class SkeletonTable extends StatelessWidget {
  /// Creates a table placeholder.
  const SkeletonTable({
    super.key,
    this.columns = 3,
    this.rows = 4,
    this.showHeader = true,
    this.theme,
    this.style,
    this.densityTokens,
    this.semanticsLabel,
    this.headerBuilder,
    this.cellBuilder,
  }) : assert(columns > 0, 'columns must be greater than zero'),
       assert(rows > 0, 'rows must be greater than zero');

  /// Number of columns.
  final int columns;

  /// Number of body rows.
  final int rows;

  /// Whether a header row shows.
  final bool showHeader;

  /// Widget-leg theme override.
  final SkeletonTheme? theme;

  /// Per-instance style override.
  final SkeletonStyle? style;

  /// Per-instance density tokens.
  final DensityTokens? densityTokens;

  /// Accessible label; null reads `Loading`.
  final String? semanticsLabel;

  /// Header cell builder slot.
  final Widget Function(BuildContext context, int column, Widget defaultCell)?
  headerBuilder;

  /// Body cell builder slot.
  final Widget Function(
    BuildContext context,
    int row,
    int column,
    Widget defaultCell,
  )?
  cellBuilder;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final SkeletonTheme resolved = resolveSkeletonTheme(
      context,
      widgetTheme: theme,
      style: style,
    );
    final DensityTokens tokens = resolveSkeletonTokens(
      context,
      override:
          densityTokens ??
          theme?.themeDensityTokens ??
          style?.themeDensityTokens,
      widgetTheme: theme,
    );
    final double gap = tokens.gap * ambient.scaling;
    Widget cell(int r, int c) {
      final Widget d = SkeletonLine(
        lines: 1,
        theme: resolved,
        densityTokens: tokens,
      );
      return cellBuilder?.call(context, r, c, d) ?? d;
    }

    Widget head(int c) {
      final Widget d = SkeletonBlock(
        height: tokens.subtitleTextSize * ambient.scaling,
        theme: resolved,
        densityTokens: tokens,
      );
      return headerBuilder?.call(context, c, d) ?? d;
    }

    return Semantics(
      label: semanticsLabel ?? 'Loading',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: gap,
        children: <Widget>[
          if (showHeader)
            Row(
              spacing: gap,
              children: <Widget>[
                for (int c = 0; c < columns; c++) Expanded(child: head(c)),
              ],
            ),
          for (int r = 0; r < rows; r++)
            Row(
              spacing: gap,
              children: <Widget>[
                for (int c = 0; c < columns; c++) Expanded(child: cell(r, c)),
              ],
            ),
        ],
      ),
    );
  }
}
