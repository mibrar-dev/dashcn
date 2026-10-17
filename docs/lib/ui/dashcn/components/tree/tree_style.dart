// Registry-owned theme data for the `tree` component: [TreeTheme], the token
// `treeDefaults`, the [TreeBranchLine] variant table, the [TreeRowContext] a
// row reads and the themed [TreeRow]. Overrides live in `tree_theme.dart`.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../components/icon/icon.dart';
import '../../foundation/data.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/clickable.dart';
import '../../primitives/motion/motion_chevron.dart';
import '../../theme/color_tokens.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';

/// How the guide between a row and its parent is drawn.
enum TreeBranchLine {
  /// No guide.
  none,

  /// A vertical line per level.
  line,

  /// A vertical line plus a tick towards the row.
  path,
}

/// Visual contract of a tree. Every field is nullable: an override leg sets
/// only what it changes and [merge] keeps the lower leg's remaining fields.
class TreeTheme extends ComponentThemeData implements Mergeable<TreeTheme> {
  /// Creates a tree theme.
  const TreeTheme({
    super.themeDensity,
    super.themeSpacing,
    super.themeShadows,
    this.branchLine,
    this.branchLineColor,
    this.padding,
    this.indentWidth,
    this.itemPadding,
    this.itemGap,
    this.selectedBackground,
    this.selectedFocusedBackground,
    this.selectedRadius,
  });

  /// Guide style. Default: [TreeBranchLine.path].
  final TreeBranchLine? branchLine;

  /// Guide colour. Default: the `border` token.
  final ThemedColor? branchLineColor;

  /// Padding around the whole tree. Default: 8 (scaled).
  final EdgeInsetsGeometry? padding;

  /// Horizontal space per level. Default: 16 (scaled).
  final double? indentWidth;

  /// Padding inside one row. Default: 8 horizontal, 4 vertical, resolved
  /// against density.
  final EdgeInsetsGeometry? itemPadding;

  /// Gap between the adornments and the row content. Default: 8 (scaled).
  final double? itemGap;

  /// Selected row fill. Default: `primary` at 5%.
  final ThemedColor? selectedBackground;

  /// Selected **and** focused fill. Default: `primary` at 10%.
  final ThemedColor? selectedFocusedBackground;

  /// Selected row corner radius. Default: `theme.borderRadiusMd`.
  final BorderRadiusGeometry? selectedRadius;

  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  @override
  TreeTheme merge(TreeTheme? fallback) {
    if (fallback == null) {
      return this;
    }
    return TreeTheme(
      themeDensity: themeDensity ?? fallback.themeDensity,
      themeSpacing: themeSpacing ?? fallback.themeSpacing,
      themeShadows: themeShadows ?? fallback.themeShadows,
      branchLine: branchLine ?? fallback.branchLine,
      branchLineColor: branchLineColor ?? fallback.branchLineColor,
      padding: padding ?? fallback.padding,
      indentWidth: indentWidth ?? fallback.indentWidth,
      itemPadding: itemPadding ?? fallback.itemPadding,
      itemGap: itemGap ?? fallback.itemGap,
      selectedBackground: selectedBackground ?? fallback.selectedBackground,
      selectedFocusedBackground:
          selectedFocusedBackground ?? fallback.selectedFocusedBackground,
      selectedRadius: selectedRadius ?? fallback.selectedRadius,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TreeTheme &&
          other.themeDensity == themeDensity &&
          other.themeSpacing == themeSpacing &&
          other.themeShadows == themeShadows &&
          other.branchLine == branchLine &&
          other.branchLineColor == branchLineColor &&
          other.padding == padding &&
          other.indentWidth == indentWidth &&
          other.itemPadding == itemPadding &&
          other.itemGap == itemGap &&
          other.selectedBackground == selectedBackground &&
          other.selectedFocusedBackground == selectedFocusedBackground &&
          other.selectedRadius == selectedRadius;

  @override
  int get hashCode => Object.hashAll(<Object?>[
    themeDensity,
    themeSpacing,
    themeShadows,
    branchLine,
    branchLineColor,
    padding,
    indentWidth,
    itemPadding,
    itemGap,
    selectedBackground,
    selectedFocusedBackground,
    selectedRadius,
  ]);
}

/// Token-derived baseline; every unset override field falls through here.
const TreeTheme treeDefaults = TreeTheme(
  branchLine: TreeBranchLine.path,
  branchLineColor: ThemedColor.ref(ColorRef.border),
  indentWidth: 16,
  itemPadding: EdgeInsetsDensity.pxSymmetric(horizontal: 8, vertical: 4),
  itemGap: 8,
  selectedBackground: ThemedColor.ref(ColorRef.primary, alpha: 0.05),
  selectedFocusedBackground: ThemedColor.ref(ColorRef.primary, alpha: 0.1),
);

/// Position of a selected row inside a run of selected rows.
enum TreeSelectionPosition {
  /// First row of the run.
  start,

  /// Middle row of the run.
  middle,

  /// Last row of the run.
  end,

  /// The only selected row.
  single,
}

/// One level of the tree: a row's index among its siblings and the sibling
/// count. The pair drives the branch lines.
class TreeNodeDepth {
  /// Creates a depth entry.
  const TreeNodeDepth(this.index, this.count);

  /// Index of the row among its siblings.
  final int index;

  /// Number of siblings at this level.
  final int count;

  /// Whether this is the last sibling.
  bool get isLast => index >= count - 1;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TreeNodeDepth && other.index == index && other.count == count;

  @override
  int get hashCode => Object.hash(index, count);
}

/// Everything one visible row needs from its tree, published by `Tree` through
/// a `Data<TreeRowContext>` scope. [TreeRow] falls back to inert, unstyled
/// values outside a tree.
class TreeRowContext {
  /// Creates a row context.
  const TreeRowContext({
    required this.depth,
    this.branchLine,
    this.focusNode,
    this.theme,
    required this.expanded,
    required this.expandable,
    required this.selectionPosition,
    required this.onToggle,
    required this.onSelect,
  });

  /// Indent guides from the root to this row (one entry per level).
  final List<TreeNodeDepth> depth;

  /// Guide style chosen by the tree; null falls back to the theme.
  final TreeBranchLine? branchLine;

  /// Focus node of the row, so tab/arrow traversal reaches it.
  final FocusNode? focusNode;

  /// Widget-leg theme override of the owning tree.
  final TreeTheme? theme;

  /// Whether the row shows its children.
  final bool expanded;

  /// Whether the row has children.
  final bool expandable;

  /// Where the row sits in a run of selected rows; null when unselected.
  final TreeSelectionPosition? selectionPosition;

  /// Expands or collapses the row.
  final ValueChanged<bool>? onToggle;

  /// Selects the row.
  final VoidCallback? onSelect;
}

/// Collapses the focused row.
class TreeCollapseIntent extends Intent {
  /// Creates the intent.
  const TreeCollapseIntent();
}

/// Expands the focused row.
class TreeExpandIntent extends Intent {
  /// Creates the intent.
  const TreeExpandIntent();
}

/// The themed tree row: indent guides, the expand toggle and the selection
/// paint. Wrap the `builder` result of a `Tree` in one of these:
/// `builder: (context, item) => TreeRow(child: Text(item.data))`.
class TreeRow extends StatelessWidget {
  /// Creates a row.
  const TreeRow({
    super.key,
    required this.child,
    this.leading,
    this.trailing,
    this.onDoublePressed,
    this.semanticLabel,
    this.theme,
  });

  /// Row content.
  final Widget child;

  /// Widget before the content.
  final Widget? leading;

  /// Widget after the content.
  final Widget? trailing;

  /// Called on a double tap of the row.
  final VoidCallback? onDoublePressed;

  /// Accessible label for the row; null falls back to the content's text
  /// for expandable rows (whose toggle otherwise splits the merge).
  final String? semanticLabel;

  /// Widget-leg theme override, merged on top of the other legs.
  final TreeTheme? theme;

  /// Rounds the outer corners of a run of selected rows.
  static BorderRadius _radius(TreeSelectionPosition? position, double value) =>
      switch (position) {
        TreeSelectionPosition.start => BorderRadius.vertical(
          top: Radius.circular(value),
        ),
        TreeSelectionPosition.end => BorderRadius.vertical(
          bottom: Radius.circular(value),
        ),
        TreeSelectionPosition.middle || TreeSelectionPosition.single =>
          BorderRadius.all(Radius.circular(value)),
        null => BorderRadius.zero,
      };

  /// The guide of ancestor level [index].
  ///
  /// [indent] and [thickness] are already scaled. The hairline is a stretched
  /// row, not a `Positioned.fill` inside a `Stack`: `BoxConstraints` pin only a
  /// *minimum* width and a childless `ColoredBox` fills its box, so that stack
  /// painted the whole indent width as a grey block.
  static Widget _guide(
    TreeBranchLine kind,
    Color color,
    double indent,
    double thickness,
    List<TreeNodeDepth> depth,
    int index,
  ) {
    if (kind == TreeBranchLine.none) {
      return const SizedBox.shrink();
    }
    // The direct parent owns the last ancestor level — the box its own chevron
    // sits in — so that guide carries the tick towards this row.
    final bool tick = kind == TreeBranchLine.path && index == depth.length - 1;
    final double lead = (indent - thickness) / 2;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(width: lead),
        SizedBox(
          width: thickness,
          child: ColoredBox(color: color),
        ),
        Expanded(
          child: tick
              ? Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: SizedBox(
                    width: lead,
                    height: thickness,
                    child: ColoredBox(color: color),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  static CallbackAction<T> _toggle<T extends Intent>(
    TreeRowContext? row,
    bool expanded,
  ) => CallbackAction<T>(onInvoke: (T _) => row?.onToggle?.call(expanded));

  @override
  Widget build(BuildContext context) {
    final TreeRowContext? row = Data.maybeOf<TreeRowContext>(context);
    final TreeTheme style = resolveComponentStyle<TreeTheme, TreeTheme>(
      context,
      widget: theme ?? row?.theme,
      select: (t) => t,
      defaults: treeDefaults,
    );
    final ThemeData data = Theme.of(context);
    final double scaling = data.scaling;
    final double indent = (style.indentWidth ?? 16) * scaling;
    final double gap = (style.itemGap ?? 8) * scaling;
    // A border token is a hairline: 1px at the default scaling.
    final double thickness = scaling;
    final Color guide = (style.branchLineColor ?? treeDefaults.branchLineColor!)
        .resolve(data.colors);
    final List<TreeNodeDepth> depth = row?.depth ?? const <TreeNodeDepth>[];
    final TreeSelectionPosition? position = row?.selectionPosition;
    final TreeBranchLine branchLine =
        row?.branchLine ?? style.branchLine ?? TreeBranchLine.path;

    final Widget toggle = row != null && row.expandable
        ? GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => row.onToggle?.call(!row.expanded),
            child: Semantics(
              button: true,
              expanded: row.expanded,
              label: row.expanded ? 'Collapse' : 'Expand',
              // The chevron rotates 90 degrees on expand instead of snapping.
              child: MotionChevron(
                expanded: row.expanded,
                turns: 0.25,
                child: const Icon(LucideIcons.chevronRight).iconSmall(),
              ),
            ),
          )
        : const SizedBox.shrink();

    // Expandable rows carry their own toggle node, which splits the row's
    // semantics merge (the content text would otherwise stay unlabeled next
    // to the toggle): label the tap node explicitly. Plain rows merge their
    // text on their own and are left untouched.
    final String? rowLabel =
        semanticLabel ??
        (row != null && row.expandable && child is Text
            ? (child as Text).data
            : null);
    Widget tappable = Clickable(
      onPressed: row?.onSelect,
      onDoubleTap: onDoublePressed,
      focusNode: row?.focusNode,
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.arrowLeft): const TreeCollapseIntent(),
        LogicalKeySet(LogicalKeyboardKey.arrowRight): const TreeExpandIntent(),
      },
      actions: <Type, Action<Intent>>{
        TreeCollapseIntent: _toggle<TreeCollapseIntent>(row, false),
        TreeExpandIntent: _toggle<TreeExpandIntent>(row, true),
      },
      decoration: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (position == null) {
          return const BoxDecoration();
        }
        final ThemedColor fill = states.contains(WidgetState.focused)
            ? (style.selectedFocusedBackground ??
                  treeDefaults.selectedFocusedBackground!)
            : (style.selectedBackground ?? treeDefaults.selectedBackground!);
        return BoxDecoration(
          color: fill.resolve(data.colors),
          borderRadius:
              style.selectedRadius ?? _radius(position, data.radiusMd),
        );
      }),
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
        resolveEdgeInsets(
          style.itemPadding ?? treeDefaults.itemPadding!,
          data.density.baseContentPadding * data.scaling,
        ),
      ),
      // IntrinsicHeight bounds the guides: a list row has no height of its own.
      // The min height is the upstream tree row (~32px at default density).
      child: IntrinsicHeight(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 32 * scaling),
          child: Row(
            children: <Widget>[
              for (int i = 1; i < depth.length; i++)
                SizedBox(
                  width: indent,
                  child: _guide(branchLine, guide, indent, thickness, depth, i),
                ),
              SizedBox(
                width: indent,
                child: Center(child: toggle),
              ),
              SizedBox(width: gap),
              if (leading != null) ...<Widget>[leading!, SizedBox(width: gap)],
              Expanded(child: child),
              if (trailing != null) ...<Widget>[
                SizedBox(width: gap),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
    if (rowLabel == null) {
      return tappable;
    }
    return Semantics(label: rowLabel, child: tappable);
  }
}
