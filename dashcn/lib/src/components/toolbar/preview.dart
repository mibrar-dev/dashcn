// Named examples for the `toolbar` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/color_tokens.dart';
import 'toolbar.dart';

/// The default example: a horizontal row of actions.
Widget _toolbarDefault(BuildContext context) {
  return const Center(
    child: Toolbar(
      children: <Widget>[
        ToolbarItem(
          tooltip: 'Undo',
          semanticLabel: 'Undo',
          child: Icon(LucideIcons.rotateCw),
        ),
        ToolbarItem(
          tooltip: 'Redo',
          semanticLabel: 'Redo',
          child: Icon(LucideIcons.refreshCw),
        ),
        ToolbarSeparator(),
        ToolbarItem(
          tooltip: 'Share',
          semanticLabel: 'Share',
          child: Icon(LucideIcons.share),
        ),
        ToolbarItem(
          tooltip: 'Delete',
          semanticLabel: 'Delete',
          child: Icon(LucideIcons.trash),
        ),
      ],
    ),
  );
}

/// A vertical toolbar (a rail).
Widget _toolbarVertical(BuildContext context) {
  return const Center(
    child: Toolbar(
      axis: ToolbarAxis.vertical,
      children: <Widget>[
        ToolbarItem(
          tooltip: 'Home',
          semanticLabel: 'Home',
          child: Icon(LucideIcons.compass),
        ),
        ToolbarItem(
          tooltip: 'Files',
          semanticLabel: 'Files',
          child: Icon(LucideIcons.folder),
        ),
        ToolbarItem(
          tooltip: 'Search',
          semanticLabel: 'Search',
          child: Icon(LucideIcons.search),
        ),
        ToolbarSeparator(),
        ToolbarItem(
          tooltip: 'Settings',
          semanticLabel: 'Settings',
          child: Icon(LucideIcons.settings),
        ),
      ],
    ),
  );
}

/// Groups and separators.
Widget _toolbarGroups(BuildContext context) {
  return const Center(
    child: Toolbar(
      children: <Widget>[
        ToolbarGroup(
          children: <Widget>[
            ToolbarItem(
              tooltip: 'Bold',
              semanticLabel: 'Bold',
              child: Icon(LucideIcons.bold),
            ),
            ToolbarItem(
              tooltip: 'Italic',
              semanticLabel: 'Italic',
              child: Icon(LucideIcons.italic),
            ),
          ],
        ),
        ToolbarSeparator(),
        ToolbarGroup(
          children: <Widget>[
            ToolbarItem(
              tooltip: 'Align left',
              semanticLabel: 'Align left',
              child: Icon(LucideIcons.alignLeft),
            ),
            ToolbarItem(
              tooltip: 'Align centre',
              semanticLabel: 'Align centre',
              child: Icon(LucideIcons.alignCenter),
            ),
          ],
        ),
      ],
    ),
  );
}

/// Toggle items keep an on/off state.
class _ToolbarToggles extends StatefulWidget {
  const _ToolbarToggles();

  @override
  State<_ToolbarToggles> createState() => _ToolbarTogglesState();
}

class _ToolbarTogglesState extends State<_ToolbarToggles> {
  bool _bold = false;
  bool _italic = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Toolbar(
        children: <Widget>[
          ToolbarToggleItem(
            value: _bold,
            onChanged: (bool value) => setState(() => _bold = value),
            tooltip: 'Bold',
            semanticLabel: 'Bold',
            child: Icon(LucideIcons.bold),
          ),
          ToolbarToggleItem(
            value: _italic,
            onChanged: (bool value) => setState(() => _italic = value),
            tooltip: 'Italic',
            semanticLabel: 'Italic',
            child: Icon(LucideIcons.italic),
          ),
          const ToolbarSeparator(),
          const ToolbarItem(
            tooltip: 'Print',
            semanticLabel: 'Print',
            child: Icon(LucideIcons.printer),
          ),
        ],
      ),
    );
  }
}

Widget _toolbarToggles(BuildContext context) => const _ToolbarToggles();

/// The overflow menu: the toolbar is narrower than its items.
Widget _toolbarOverflow(BuildContext context) {
  return const Center(
    child: SizedBox(
      width: 200,
      child: Toolbar(
        children: <Widget>[
          ToolbarItem(
            tooltip: 'Undo',
            semanticLabel: 'Undo',
            child: Icon(LucideIcons.rotateCw),
          ),
          ToolbarItem(
            tooltip: 'Redo',
            semanticLabel: 'Redo',
            child: Icon(LucideIcons.refreshCw),
          ),
          ToolbarItem(
            tooltip: 'Copy',
            semanticLabel: 'Copy',
            child: Icon(LucideIcons.copy),
          ),
          ToolbarItem(
            tooltip: 'Share',
            semanticLabel: 'Share',
            child: Icon(LucideIcons.share),
          ),
          ToolbarItem(
            tooltip: 'Delete',
            semanticLabel: 'Delete',
            child: Icon(LucideIcons.trash),
          ),
        ],
      ),
    ),
  );
}

/// A customised toolbar: a filled container with an outlined item.
Widget _toolbarCustomized(BuildContext context) {
  return Center(
    child: Toolbar(
      style: ToolbarStyle(
        background: ThemedColor.ref(ColorRef.muted, alpha: 0.5),
        borderColor: ThemedColor.ref(ColorRef.border),
        borderWidth: 1,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        gap: 4,
        itemBackground: const StateValue(
          rest: ThemedColor.ref(ColorRef.background),
          hovered: ThemedColor.ref(ColorRef.background),
          pressed: ThemedColor.ref(ColorRef.background),
        ),
      ),
      children: <Widget>[
        ToolbarItem(
          tooltip: 'Save',
          semanticLabel: 'Save',
          child: const Icon(LucideIcons.save),
        ),
        ToolbarItem(
          tooltip: 'Upload',
          semanticLabel: 'Upload',
          child: const Icon(LucideIcons.upload),
        ),
        ToolbarItem(
          tooltip: 'Download',
          semanticLabel: 'Download',
          child: const Icon(LucideIcons.download),
        ),
      ],
    ),
  );
}

/// Named docs examples for `toolbar`; the first entry is the default.
const List<ComponentPreview> toolbarPreviews = <ComponentPreview>[
  ComponentPreview('Default', _toolbarDefault),
  ComponentPreview('Vertical', _toolbarVertical),
  ComponentPreview('Groups', _toolbarGroups),
  ComponentPreview('Toggles', _toolbarToggles),
  ComponentPreview('Overflow', _toolbarOverflow),
  ComponentPreview('Customized', _toolbarCustomized),
];
