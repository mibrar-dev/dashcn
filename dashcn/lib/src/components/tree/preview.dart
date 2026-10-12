// Named examples for the `tree` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. Every example is a working file tree: folders use
// closed/open folder icons (never the file icon), files use the file icon,
// chevrons expand/collapse on click and with the arrow keys, selection
// highlights the row, and checkboxes appear only in the Multi-select example.

import 'package:flutter/widgets.dart';

import '../../components/icon/icon.dart';
import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/theme.dart';
import '../checkbox/checkbox.dart';
import 'tree.dart';

/// One file-tree entry: folders stay folders even when empty or collapsed.
class _FileEntry {
  const _FileEntry(
    this.name, {
    this.folder = false,
    this.lazy = false,
    this.children = const <_FileEntry>[],
  });

  final String name;
  final bool folder;
  final bool lazy;
  final List<_FileEntry> children;
}

List<TreeNode<_FileEntry>> _toNodes(
  List<_FileEntry> entries, {
  Set<String> expanded = const <String>{},
  Set<String> selected = const <String>{},
}) => <TreeNode<_FileEntry>>[
  for (final entry in entries)
    TreeItem<_FileEntry>(
      data: entry,
      expanded: expanded.contains(entry.name),
      selected: selected.contains(entry.name),
      children: _toNodes(
        entry.children,
        expanded: expanded,
        selected: selected,
      ),
    ),
];

List<_FileEntry> _files() => const <_FileEntry>[
  _FileEntry(
    'Documents',
    folder: true,
    children: <_FileEntry>[
      _FileEntry('report.pdf'),
      _FileEntry('notes.md'),
      _FileEntry(
        'archive',
        folder: true,
        children: <_FileEntry>[_FileEntry('2024.zip')],
      ),
    ],
  ),
  _FileEntry('Pictures', folder: true),
  _FileEntry('Downloads', folder: true),
];

/// Leading icon: open/closed folder for folders, file for files.
Widget _fileIcon(TreeItem<_FileEntry> item) {
  final bool folder = item.data.folder;
  final IconData glyph = folder
      ? (item.expanded ? LucideIcons.folderOpen : LucideIcons.folder)
      : LucideIcons.file;
  return Icon(glyph, size: 16).iconSmall();
}

/// Applies a selection report: reported rows take [selected], and a
/// single-select report clears every other row.
List<TreeNode<_FileEntry>> _applySelection(
  List<TreeNode<_FileEntry>> nodes,
  List<TreeNode<_FileEntry>> reported,
  bool multi,
  bool selected,
) => nodes.updateNodes((TreeNode<_FileEntry> node) {
  for (final TreeNode<_FileEntry> target in reported) {
    if (identical(node, target)) {
      return node.updateState(selected: selected);
    }
  }
  if (!multi) {
    return node.updateState(selected: false);
  }
  return null;
});

/// Last selected label, for the status line.
String _selectedLabel(List<TreeNode<_FileEntry>> nodes) {
  final List<String> names = <String>[];
  void visit(List<TreeNode<_FileEntry>> list) {
    for (final node in list) {
      if (node is TreeItem<_FileEntry> && node.selected) {
        names.add(node.data.name);
      }
      visit(node.children);
    }
  }

  visit(nodes);
  return names.isEmpty ? 'Nothing selected' : 'Selected: ${names.join(', ')}';
}

/// Shared file-tree shell: expand/collapse, selection and a status line.
class _FileTree extends StatefulWidget {
  const _FileTree({
    required this.entries,
    this.expanded = const <String>{},
    this.selected = const <String>{},
    this.allowMultiSelect = true,
    this.recursiveSelection = true,
    this.withCheckboxes = false,
    this.height,
    this.onExpand,
  });

  final List<_FileEntry> entries;
  final Set<String> expanded;
  final Set<String> selected;
  final bool allowMultiSelect;
  final bool recursiveSelection;
  final bool withCheckboxes;
  final double? height;
  final void Function(TreeNode<_FileEntry> node, bool expanded)? onExpand;

  @override
  State<_FileTree> createState() => _FileTreeState();
}

class _FileTreeState extends State<_FileTree> {
  late List<TreeNode<_FileEntry>> _nodes = _toNodes(
    widget.entries,
    expanded: widget.expanded,
    selected: widget.selected,
  );

  @override
  void didUpdateWidget(covariant _FileTree oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (identical(widget.entries, oldWidget.entries)) {
      return;
    }
    // Rebuild from the new entries (a lazy folder just loaded) while keeping
    // the user's expand/collapse and selection flags, matched by name.
    final Set<String> expanded = Set<String>.of(widget.expanded);
    final Set<String> selected = Set<String>.of(widget.selected);
    void collect(List<TreeNode<_FileEntry>> list) {
      for (final node in list) {
        if (node is TreeItem<_FileEntry>) {
          if (node.expanded) {
            expanded.add(node.data.name);
          }
          if (node.selected) {
            selected.add(node.data.name);
          }
        }
        collect(node.children);
      }
    }

    collect(_nodes);
    _nodes = _toNodes(widget.entries, expanded: expanded, selected: selected);
  }

  void _toggle(TreeNode<_FileEntry> node, bool expanded) {
    widget.onExpand?.call(node, expanded);
    setState(() {
      _nodes = expanded ? _nodes.expandNode(node) : _nodes.collapseNode(node);
    });
  }

  /// Checkbox value of [item]: checked when its whole subtree is selected,
  /// indeterminate when only part of it is.
  CheckboxValue _boxValue(TreeItem<_FileEntry> item) {
    bool any = false;
    bool all = true;
    void visit(TreeNode<_FileEntry> node) {
      if (!node.selected) {
        all = false;
      } else {
        any = true;
      }
      for (final child in node.children) {
        visit(child);
      }
    }

    visit(item);
    if (all) {
      return CheckboxValue.checked;
    }
    if (any) {
      return CheckboxValue.indeterminate;
    }
    return CheckboxValue.unchecked;
  }

  /// Selects or clears [item] plus its whole subtree.
  void _toggleSubtree(TreeItem<_FileEntry> item) {
    final bool select = _boxValue(item) != CheckboxValue.checked;
    final Set<TreeNode<_FileEntry>> subtree =
        Set<TreeNode<_FileEntry>>.identity();
    void collect(TreeNode<_FileEntry> node) {
      subtree.add(node);
      for (final child in node.children) {
        collect(child);
      }
    }

    collect(item);
    setState(() {
      _nodes = _nodes.updateNodes((TreeNode<_FileEntry> node) {
        for (final target in subtree) {
          if (identical(node, target)) {
            return node.updateState(selected: select);
          }
        }
        return null;
      });
    });
  }

  Widget _row(BuildContext context, TreeItem<_FileEntry> item) {
    Widget leading = _fileIcon(item);
    if (widget.withCheckboxes) {
      leading = Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Checkbox(
            value: _boxValue(item),
            tristate: true,
            onChanged: (_) => _toggleSubtree(item),
          ),
          Gap(ShadcnTheme.of(context).spacing.xs),
          leading,
        ],
      );
    }
    return TreeRow(leading: leading, child: Text(item.data.name));
  }

  @override
  Widget build(BuildContext context) {
    final spacing = ShadcnTheme.of(context).spacing;
    final Widget tree = Tree<_FileEntry>(
      nodes: _nodes,
      shrinkWrap: widget.height == null,
      allowMultiSelect: widget.allowMultiSelect,
      recursiveSelection: widget.recursiveSelection,
      onSelectionChanged:
          (List<TreeNode<_FileEntry>> reported, bool multi, bool selected) =>
              setState(() {
                _nodes = _applySelection(_nodes, reported, multi, selected);
              }),
      onExpandedChanged: _toggle,
      builder: _row,
    );
    return SizedBox(
      width: 320,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (widget.height == null)
            tree
          else
            SizedBox(height: widget.height, child: tree),
          Gap(spacing.sm),
          Text(
            _selectedLabel(_nodes),
            style: TextStyle(
              color: ShadcnTheme.of(context).colors.mutedForeground,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

/// Default file tree with indent guides and an expanded folder.
Widget _treeDefault(BuildContext context) =>
    _FileTree(entries: _files(), expanded: const <String>{'Documents'});

/// Single-select tree with a preselected file.
Widget _treeSelection(BuildContext context) => _FileTree(
  entries: _files(),
  expanded: const <String>{'Documents'},
  selected: const <String>{'report.pdf'},
  allowMultiSelect: false,
  recursiveSelection: false,
);

/// Multi-select tree: checkboxes with tri-state parents.
Widget _treeMulti(BuildContext context) => _FileTree(
  entries: _files(),
  expanded: const <String>{'Documents', 'archive'},
  selected: const <String>{'report.pdf'},
  withCheckboxes: true,
);

/// Large tree: generated folders plus a lazily loaded one.
class _LargeTree extends StatefulWidget {
  const _LargeTree();

  @override
  State<_LargeTree> createState() => _LargeTreeState();
}

class _LargeTreeState extends State<_LargeTree> {
  static List<_FileEntry> _buildEntries() => <_FileEntry>[
    _FileEntry(
      'src',
      folder: true,
      children: <_FileEntry>[
        for (int i = 1; i <= 30; i++) _FileEntry('widget_$i.dart'),
      ],
    ),
    _FileEntry(
      'assets',
      folder: true,
      children: <_FileEntry>[
        for (int i = 1; i <= 20; i++) _FileEntry('icon_$i.svg'),
      ],
    ),
    const _FileEntry('Shared', folder: true, lazy: true),
    for (int i = 1; i <= 40; i++) _FileEntry('note_$i.md'),
  ];

  List<_FileEntry> _entries = _buildEntries();
  final Set<String> _loaded = <String>{};

  void _maybeLoad(TreeNode<_FileEntry> node, bool expanded) {
    if (!expanded ||
        node is! TreeItem<_FileEntry> ||
        !node.data.lazy ||
        _loaded.contains(node.data.name)) {
      return;
    }
    _loaded.add(node.data.name);
    Future<void>.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) {
        return;
      }
      setState(() {
        _entries = <_FileEntry>[
          for (final entry in _entries)
            entry.name == node.data.name
                ? _FileEntry(
                    entry.name,
                    folder: true,
                    lazy: true,
                    children: <_FileEntry>[
                      for (int i = 1; i <= 12; i++)
                        _FileEntry('shared_$i.dart'),
                    ],
                  )
                : entry,
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _FileTree(
      entries: _entries,
      expanded: const <String>{'src'},
      height: 300,
      onExpand: _maybeLoad,
    );
  }
}

Widget _treeLarge(BuildContext context) => const _LargeTree();

/// Named docs examples for `tree`; the first entry is the default.
const List<ComponentPreview> treePreviews = <ComponentPreview>[
  ComponentPreview('Default', _treeDefault),
  ComponentPreview('With selection', _treeSelection),
  ComponentPreview('Multi-select', _treeMulti),
  ComponentPreview('Large', _treeLarge),
];
