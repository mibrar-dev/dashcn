// The result list of the `search_bar` component: grouped rows with
// keyboard highlight, match highlighting and the default empty state.

import 'package:flutter/widgets.dart';

import '../../primitives/clickable.dart';
import '../../primitives/localizations/localizations.dart';
import '../../primitives/search/fuzzy_match.dart';
import '../../primitives/text/text_extension.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import 'search_bar_style.dart';

/// Extracts the searchable label of an item (defaults to `'$item'`).
typedef SearchBarLabel<T> = String Function(T item);

/// One headed section of a grouped [SearchBar].
class SearchBarGroup<T> {
  /// Creates a group; [items] may be empty (the group then never shows).
  const SearchBarGroup({required this.label, this.items = const []});

  /// Heading shown above the group's rows.
  final String label;

  /// Items in this group, in display order.
  final List<T> items;
}

/// Builds one result row; [highlight] holds the matched character indices
/// and [highlighted] whether the keyboard highlight is on this row.
typedef SearchBarRowBuilder<T> =
    Widget Function(
      BuildContext context,
      T item,
      List<int> highlight,
      bool highlighted,
    );

/// One visible row of a [SearchResults] list: the entry plus its match.
class SearchResultRow<T> {
  /// Creates a row; [match] is null for unfiltered (empty-query) rows.
  const SearchResultRow({
    this.group,
    required this.item,
    required this.label,
    this.match,
  });

  /// Heading of the group this row belongs to, if any.
  final String? group;

  /// The item.
  final T item;

  /// The label the item was filtered and is displayed by.
  final String label;

  /// The winning match, or null when the list is unfiltered.
  final FuzzyMatch? match;

  /// Returns a copy with [match] set.
  SearchResultRow<T> withMatch(FuzzyMatch? match) =>
      SearchResultRow<T>(group: group, item: item, label: label, match: match);
}

/// The ranked rows under the search field.
class SearchResults<T> extends StatelessWidget {
  /// Creates the result list.
  const SearchResults({
    super.key,
    required this.rows,
    required this.highlight,
    required this.listPadding,
    required this.maxHeight,
    required this.theme,
    this.itemBuilder,
    this.onSelect,
    this.emptyBuilder,
  });

  /// Ranked rows in display order.
  final List<SearchResultRow<T>> rows;

  /// Index of the keyboard-highlighted row, -1 for none.
  final int highlight;

  /// Padding around the list.
  final EdgeInsets listPadding;

  /// List height cap.
  final double maxHeight;

  /// Resolved theme.
  final SearchBarTheme theme;

  /// Custom row; null renders the label with highlighted matches.
  final SearchBarRowBuilder<T>? itemBuilder;

  /// Called when a row is tapped.
  final ValueChanged<T>? onSelect;

  /// Shown when [rows] is empty; null shows the default empty state.
  final WidgetBuilder? emptyBuilder;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return emptyBuilder?.call(context) ?? const _SearchBarEmpty();
    }
    String? group;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: ListView(
        shrinkWrap: true,
        padding: listPadding,
        children: <Widget>[
          for (int i = 0; i < rows.length; i++) ...<Widget>[
            if (rows[i].group != group)
              _groupHeader(context, group = rows[i].group),
            _SearchRow<T>(
              label: rows[i].label,
              item: rows[i].item,
              highlight: rows[i].match?.indices ?? const <int>[],
              highlighted: i == highlight,
              theme: theme,
              itemBuilder: itemBuilder,
              onSelect: onSelect,
            ),
          ],
        ],
      ),
    );
  }

  Widget _groupHeader(BuildContext context, String? label) {
    final ThemeData ambient = Theme.of(context);
    final Color muted =
        theme.mutedForeground?.resolve(ambient.colors) ??
        ambient.colors.mutedForeground;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Text(
        label ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: muted,
        ),
      ),
    );
  }
}

/// Default empty state shown when no rows match.
class _SearchBarEmpty extends StatelessWidget {
  const _SearchBarEmpty();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Text(
          ComponentLocalizations.of(context).commandEmpty,
        ).small.muted,
      ),
    );
  }
}

/// One result row with keyboard highlight and match highlighting.
class _SearchRow<T> extends StatelessWidget {
  const _SearchRow({
    required this.label,
    required this.item,
    required this.highlight,
    required this.highlighted,
    required this.theme,
    this.itemBuilder,
    this.onSelect,
  });

  final String label;
  final T item;
  final List<int> highlight;
  final bool highlighted;
  final SearchBarTheme theme;
  final SearchBarRowBuilder<T>? itemBuilder;
  final ValueChanged<T>? onSelect;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final Color foreground =
        theme.foreground?.resolve(ambient.colors) ?? ambient.colors.foreground;
    final Color highlightForeground =
        theme.itemHighlightForeground
            ?.resolve(<WidgetState>{if (highlighted) WidgetState.selected})
            ?.resolve(ambient.colors) ??
        ambient.colors.accentForeground;
    final Color rowColor = highlighted ? highlightForeground : foreground;
    final TextStyle base = (theme.textStyle ?? ambient.typography.small)
        .copyWith(fontFamily: ambient.fonts.fontSans, color: rowColor);
    final Widget content =
        itemBuilder?.call(context, item, highlight, highlighted) ??
        _HighlightText(
          label: label,
          highlight: highlight,
          base: base,
          highlightColor:
              theme.highlightColor?.resolve(ambient.colors) ??
              ambient.colors.primary,
        );
    final EdgeInsets padding = resolveEdgeInsets(
      theme.itemPadding ?? searchBarDefaultItemPadding,
      ambient.density.baseContentPadding * ambient.scaling,
    ).resolve(Directionality.of(context));
    // Like the command palette rows, the Clickable padding wraps a
    // ConstrainedBox so the border-box total meets the touch minimum.
    final double innerMin = ((theme.minRowHeight ?? 48) - padding.vertical)
        .clamp(0, double.infinity);
    return Clickable(
      focusOutline: false,
      onPressed: onSelect == null ? null : () => onSelect!(item),
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry?>(padding),
      decoration: WidgetStateProperty.resolveWith<Decoration?>((states) {
        final Color? fill = theme.itemHighlight
            ?.resolve(<WidgetState>{
              ...states,
              if (highlighted) WidgetState.selected,
            })
            ?.resolve(ambient.colors);
        if (fill == null) {
          return null;
        }
        return BoxDecoration(color: fill, borderRadius: theme.borderRadius);
      }),
      textStyle: WidgetStatePropertyAll<TextStyle?>(base),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: innerMin),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: SizedBox(width: double.infinity, child: content),
        ),
      ),
    );
  }
}

/// A label with the matched characters painted in the highlight colour.
class _HighlightText extends StatelessWidget {
  const _HighlightText({
    required this.label,
    required this.highlight,
    required this.base,
    required this.highlightColor,
  });

  final String label;
  final List<int> highlight;
  final TextStyle base;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    if (highlight.isEmpty) {
      return Text(
        label,
        style: base,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      );
    }
    final Set<int> hits = highlight.toSet();
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          for (int i = 0; i < label.length; i++)
            TextSpan(
              text: label[i],
              style: hits.contains(i)
                  ? TextStyle(
                      fontWeight: FontWeight.w600,
                      color: highlightColor,
                    )
                  : null,
            ),
        ],
      ),
      style: base,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
    );
  }
}
