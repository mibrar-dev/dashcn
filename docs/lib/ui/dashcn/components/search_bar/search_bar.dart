// The `search_bar` component: a search field with a ranked result list,
// built on the shared `primitives/search` ranker — the same files the
// `command` command palette ranks through, not a copy.
//
// Typing filters [items] (or [groups]) through the tiered matcher (exact,
// prefix, word-start, fuzzy, typo fallback) and highlights the matched
// characters; arrow keys move the highlight, Enter selects, Escape clears.

import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/input_features/adornment_features.dart';
import '../../primitives/input_features/input_features.dart';
import '../../primitives/localizations/localizations.dart';
import '../../primitives/search/search_index.dart';
import '../../primitives/surface.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import '../input/input.dart';
import 'search_bar_nav.dart';
import 'search_bar_results.dart';
import 'search_bar_style.dart';

export 'search_bar_nav.dart';
export 'search_bar_results.dart';
export 'search_bar_style.dart';

/// A search field with a ranked result list and keyboard navigation.
///
/// Items are filtered through the shared `primitives/search` ranker; the
/// `command` palette ranks through the same files.
class SearchBar<T> extends StatefulWidget {
  /// Creates a search bar over [items], or over [groups] when non-empty.
  const SearchBar({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.items = const [],
    this.groups = const [],
    this.itemLabel,
    this.itemBuilder,
    this.onChanged,
    this.onCleared,
    this.onSelected,
    this.onSubmitted,
    this.onCancelled,
    this.debounce = const Duration(milliseconds: 120),
    this.hintText,
    this.leading,
    this.enabled = true,
    this.readOnly = false,
    this.validator,
    this.showCancelButton = false,
    this.cancelLabel,
    this.emptyBuilder,
    this.autofocus = false,
    this.theme,
  }) : assert(
         controller == null || initialValue == null,
         'SearchBar cannot have both a controller and an initialValue.',
       );

  /// Field controller; one is created when null (and disposed with the bar).
  final TextEditingController? controller;

  /// Initial text; mutually exclusive with [controller].
  final String? initialValue;

  /// Field focus node; one is created when null (and disposed with the bar).
  final FocusNode? focusNode;

  /// Flat items, used when [groups] is empty.
  final List<T> items;

  /// Optional headed sections; non-empty wins over [items].
  final List<SearchBarGroup<T>> groups;

  /// Label an item is filtered and displayed by; null uses `'$item'`.
  final SearchBarLabel<T>? itemLabel;

  /// Custom row; null renders the label with highlighted matches.
  final SearchBarRowBuilder<T>? itemBuilder;

  /// Fires [debounce] after the last keystroke; clearing emits immediately.
  final ValueChanged<String>? onChanged;

  /// Fires when the text becomes empty.
  final VoidCallback? onCleared;

  /// Fires when a row is tapped or Enter accepts the highlighted row.
  final ValueChanged<T>? onSelected;

  /// Fires on Enter (or the search action) with no highlighted row.
  final ValueChanged<String>? onSubmitted;

  /// Fires when the cancel button is pressed, or Escape on an empty field.
  final VoidCallback? onCancelled;

  /// Debounce of [onChanged]; filtering itself is synchronous.
  final Duration debounce;

  /// Field hint; null uses the localized "Search".
  final String? hintText;

  /// Replaces the leading search icon; null shows the icon.
  final Widget? leading;

  /// Whether the field accepts input; false makes it read-only.
  final bool enabled;

  /// Whether the field is read-only (still focusable).
  final bool readOnly;

  /// Runs per change; a non-null result paints an error below the field.
  final String? Function(String? value)? validator;

  /// Whether a cancel button sits beside the field.
  final bool showCancelButton;

  /// Cancel label; null uses the localized "Cancel".
  final String? cancelLabel;

  /// Shown when the visible list is empty; null shows the default row.
  final WidgetBuilder? emptyBuilder;

  /// Whether the field takes focus when mounted.
  final bool autofocus;

  /// Widget-leg theme override, merged over the component/app/defaults.
  final SearchBarTheme? theme;

  @override
  State<SearchBar<T>> createState() => _SearchBarState<T>();
}

class _SearchBarState<T> extends State<SearchBar<T>> {
  TextEditingController? _ownedController;
  FocusNode? _ownedFocusNode;
  Timer? _debounce;
  FuzzySearchIndex _index = FuzzySearchIndex(const <String>[]);
  List<SearchResultRow<T>> _entries = const [];
  List<SearchResultRow<T>> _rows = const [];
  int _highlight = -1;
  String _query = '';

  TextEditingController get _controller =>
      widget.controller ?? _ownedController!;
  FocusNode get _focusNode => widget.focusNode ?? _ownedFocusNode!;

  String _labelOf(T item) =>
      widget.itemLabel == null ? '$item' : widget.itemLabel!(item);

  void _rebuildIndex() {
    final List<SearchResultRow<T>> entries;
    if (widget.groups.isNotEmpty) {
      entries = <SearchResultRow<T>>[
        for (final SearchBarGroup<T> group in widget.groups)
          for (final T item in group.items)
            SearchResultRow<T>(
              group: group.label,
              item: item,
              label: _labelOf(item),
            ),
      ];
    } else {
      entries = <SearchResultRow<T>>[
        for (final T item in widget.items)
          SearchResultRow<T>(item: item, label: _labelOf(item)),
      ];
    }
    _entries = entries;
    _index = FuzzySearchIndex(entries.map((e) => e.label).toList());
    _refreshRows();
  }

  void _refreshRows() {
    final String query = _query;
    if (query.isEmpty) {
      _rows = List<SearchResultRow<T>>.of(_entries);
    } else {
      _rows = <SearchResultRow<T>>[
        for (final FuzzyRankedItem hit in _index.rank(query))
          _entries[hit.index].withMatch(hit.match),
      ];
    }
    _highlight = _rows.isEmpty ? -1 : 0;
  }

  @override
  void initState() {
    super.initState();
    _ownedController = widget.controller == null
        ? TextEditingController(text: widget.initialValue)
        : null;
    _ownedFocusNode = widget.focusNode == null ? FocusNode() : null;
    _query = _controller.text;
    _rebuildIndex();
    _controller.addListener(_onText);
  }

  @override
  void didUpdateWidget(covariant SearchBar<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.controller, widget.controller)) {
      _controller.removeListener(_onText);
      _ownedController?.dispose();
      _ownedController = widget.controller == null
          ? TextEditingController(text: widget.initialValue)
          : null;
      _query = _controller.text;
      _controller.addListener(_onText);
    }
    if (!identical(oldWidget.focusNode, widget.focusNode)) {
      _ownedFocusNode?.dispose();
      _ownedFocusNode = widget.focusNode == null ? FocusNode() : null;
    }
    if (!identical(oldWidget.items, widget.items) ||
        !identical(oldWidget.groups, widget.groups) ||
        oldWidget.itemLabel != widget.itemLabel) {
      _rebuildIndex();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.removeListener(_onText);
    _ownedController?.dispose();
    _ownedFocusNode?.dispose();
    super.dispose();
  }

  void _emit(String next) {
    widget.onChanged?.call(next);
    if (next.isEmpty) {
      widget.onCleared?.call();
    }
  }

  void _onText() {
    final String next = _controller.text;
    if (next == _query) {
      return;
    }
    // Cancel first: a pending timer must not resurrect cleared text, and
    // clearing emits immediately even with a pending debounce.
    _debounce?.cancel();
    final bool cleared = next.isEmpty;
    setState(() {
      _query = next;
      _refreshRows();
    });
    if (cleared || widget.debounce == Duration.zero) {
      _emit(next);
    } else {
      _debounce = Timer(widget.debounce, () {
        if (mounted) {
          _emit(_controller.text);
        }
      });
    }
  }

  void _move(int direction) {
    if (_rows.isEmpty) {
      return;
    }
    setState(() {
      if (_highlight < 0) {
        _highlight = direction > 0 ? 0 : _rows.length - 1;
      } else {
        _highlight = (_highlight + direction) % _rows.length;
        if (_highlight < 0) {
          _highlight += _rows.length;
        }
      }
    });
  }

  void _accept() {
    if (_highlight >= 0 && _highlight < _rows.length) {
      widget.onSelected?.call(_rows[_highlight].item);
    } else {
      widget.onSubmitted?.call(_query);
    }
  }

  void _dismiss() {
    if (_controller.text.isNotEmpty) {
      _controller.clear();
      _focusNode.requestFocus();
    } else {
      widget.onCancelled?.call();
      _focusNode.unfocus();
    }
  }

  void _cancel() {
    _debounce?.cancel();
    if (_controller.text.isNotEmpty) {
      _controller.clear();
    }
    widget.onCancelled?.call();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SearchBarTheme resolved =
        resolveComponentStyle<SearchBarTheme, SearchBarTheme>(
          context,
          widget: widget.theme,
          select: (t) => t,
          defaults: searchBarDefaults,
        );
    final ComponentLocalizations localizations = ComponentLocalizations.of(
      context,
    );
    final Color background =
        resolved.background?.resolve(theme.colors) ?? theme.colors.popover;
    final Color border =
        resolved.borderColor?.resolve(theme.colors) ?? theme.colors.border;
    final double borderWidth = resolved.borderWidth ?? 1;
    final BorderRadiusGeometry radius =
        resolved.borderRadius ?? theme.borderRadiusLg;
    final double scale = theme.scaling;
    final EdgeInsets listPadding = resolveEdgeInsets(
      resolved.padding ?? EdgeInsetsDensity.pxAll(4),
      theme.density.baseContentPadding * scale,
    ).resolve(Directionality.of(context));
    final String hint = widget.hintText ?? localizations.filterSearch;

    final Widget field = Input(
      controller: _controller,
      focusNode: _focusNode,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      validator: widget.validator,
      showFocusRing: false,
      hintText: hint,
      onSubmitted: (_) => _accept(),
      decoration: const BoxDecoration(color: Color(0x00000000)),
      border: _rows.isEmpty
          ? null
          : borderWidth > 0
          ? Border(
              bottom: BorderSide(color: border, width: borderWidth),
            )
          : null,
      borderRadius: BorderRadius.zero,
      padding: EdgeInsets.symmetric(horizontal: theme.spacing.md),
      features: <InputFeature>[
        if (resolved.showLeading ?? true)
          InputLeadingFeature(
            widget.leading ??
                DensityContentPadding(
                  padding: EdgeInsetsDensity.only(right: 8 / Density.pxBase),
                  child: Opacity(
                    opacity: 0.5,
                    child: Icon(
                      LucideIcons.search,
                      size: resolved.iconSize ?? searchBarDefaultIconSize,
                    ),
                  ),
                ),
          ),
        if (resolved.showClear ?? true) const InputClearFeature(),
        SearchBarNavFeature(
          onMove: _move,
          onAccept: _accept,
          onDismiss: _dismiss,
        ),
      ],
    );

    final Widget list = SearchResults<T>(
      rows: _rows,
      highlight: _highlight,
      listPadding: listPadding,
      maxHeight: (resolved.maxHeight ?? 300) * scale,
      itemBuilder: widget.itemBuilder,
      onSelect: (item) => widget.onSelected?.call(item),
      emptyBuilder: widget.emptyBuilder,
      theme: resolved,
    );

    // Frosted glass: the popover fill carries the ambient surfaceOpacity
    // and the blur wraps the painted surface (no extra layer at default).
    final Color paint = surfaceColor(background, theme.surfaceOpacity);
    final Widget surface = GlassSurface(
      surfaceBlur: theme.surfaceBlur,
      borderRadius: radius,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: paint,
          border: borderWidth > 0
              ? Border.all(color: border, width: borderWidth)
              : null,
          borderRadius: radius,
          boxShadow: resolved.shadows ?? theme.tokens.shadows.shadowLg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Semantics(label: hint, child: field),
            Flexible(child: list),
          ],
        ),
      ),
    );

    if (!widget.showCancelButton) {
      return surface;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: surface),
        SizedBox(width: theme.spacing.sm),
        Button(
          variant: ButtonVariant.text,
          onPressed: _cancel,
          child: Text(widget.cancelLabel ?? localizations.buttonCancel),
        ),
      ],
    );
  }
}
