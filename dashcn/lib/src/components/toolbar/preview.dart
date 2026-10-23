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
  return Center(
    child: Toolbar(
      children: <Widget>[
        ToolbarItem(
          tooltip: docsSample(context, 'Undo'),
          semanticLabel: docsSample(context, 'Undo'),
          child: Icon(LucideIcons.rotateCw),
        ),
        ToolbarItem(
          tooltip: docsSample(context, 'Redo'),
          semanticLabel: docsSample(context, 'Redo'),
          child: Icon(LucideIcons.refreshCw),
        ),
        ToolbarSeparator(),
        ToolbarItem(
          tooltip: docsSample(context, 'Share'),
          semanticLabel: docsSample(context, 'Share'),
          child: Icon(LucideIcons.share),
        ),
        ToolbarItem(
          tooltip: docsSample(context, 'Delete'),
          semanticLabel: docsSample(context, 'Delete'),
          child: Icon(LucideIcons.trash),
        ),
      ],
    ),
  );
}

/// A vertical toolbar (a rail).
Widget _toolbarVertical(BuildContext context) {
  return Center(
    child: Toolbar(
      axis: ToolbarAxis.vertical,
      children: <Widget>[
        ToolbarItem(
          tooltip: docsSample(context, 'Home'),
          semanticLabel: docsSample(context, 'Home'),
          child: Icon(LucideIcons.compass),
        ),
        ToolbarItem(
          tooltip: docsSample(context, 'Files'),
          semanticLabel: docsSample(context, 'Files'),
          child: Icon(LucideIcons.folder),
        ),
        ToolbarItem(
          tooltip: docsSample(context, 'Search'),
          semanticLabel: docsSample(context, 'Search'),
          child: Icon(LucideIcons.search),
        ),
        ToolbarSeparator(),
        ToolbarItem(
          tooltip: docsSample(context, 'Settings'),
          semanticLabel: docsSample(context, 'Settings'),
          child: Icon(LucideIcons.settings),
        ),
      ],
    ),
  );
}

/// Groups and separators.
Widget _toolbarGroups(BuildContext context) {
  return Center(
    child: Toolbar(
      children: <Widget>[
        ToolbarGroup(
          children: <Widget>[
            ToolbarItem(
              tooltip: docsSample(context, 'Bold'),
              semanticLabel: docsSample(context, 'Bold'),
              child: Icon(LucideIcons.bold),
            ),
            ToolbarItem(
              tooltip: docsSample(context, 'Italic'),
              semanticLabel: docsSample(context, 'Italic'),
              child: Icon(LucideIcons.italic),
            ),
          ],
        ),
        ToolbarSeparator(),
        ToolbarGroup(
          children: <Widget>[
            ToolbarItem(
              tooltip: docsSample(context, 'Align left'),
              semanticLabel: docsSample(context, 'Align left'),
              child: Icon(LucideIcons.alignLeft),
            ),
            ToolbarItem(
              tooltip: docsSample(context, 'Align centre'),
              semanticLabel: docsSample(context, 'Align centre'),
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
            tooltip: docsSample(context, 'Bold'),
            semanticLabel: docsSample(context, 'Bold'),
            child: Icon(LucideIcons.bold),
          ),
          ToolbarToggleItem(
            value: _italic,
            onChanged: (bool value) => setState(() => _italic = value),
            tooltip: docsSample(context, 'Italic'),
            semanticLabel: docsSample(context, 'Italic'),
            child: Icon(LucideIcons.italic),
          ),
          const ToolbarSeparator(),
          ToolbarItem(
            tooltip: docsSample(context, 'Print'),
            semanticLabel: docsSample(context, 'Print'),
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
  return Center(
    child: SizedBox(
      width: 200,
      child: Toolbar(
        children: <Widget>[
          ToolbarItem(
            tooltip: docsSample(context, 'Undo'),
            semanticLabel: docsSample(context, 'Undo'),
            child: Icon(LucideIcons.rotateCw),
          ),
          ToolbarItem(
            tooltip: docsSample(context, 'Redo'),
            semanticLabel: docsSample(context, 'Redo'),
            child: Icon(LucideIcons.refreshCw),
          ),
          ToolbarItem(
            tooltip: docsSample(context, 'Copy'),
            semanticLabel: docsSample(context, 'Copy'),
            child: Icon(LucideIcons.copy),
          ),
          ToolbarItem(
            tooltip: docsSample(context, 'Share'),
            semanticLabel: docsSample(context, 'Share'),
            child: Icon(LucideIcons.share),
          ),
          ToolbarItem(
            tooltip: docsSample(context, 'Delete'),
            semanticLabel: docsSample(context, 'Delete'),
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
          tooltip: docsSample(context, 'Save'),
          semanticLabel: docsSample(context, 'Save'),
          child: const Icon(LucideIcons.save),
        ),
        ToolbarItem(
          tooltip: docsSample(context, 'Upload'),
          semanticLabel: docsSample(context, 'Upload'),
          child: const Icon(LucideIcons.upload),
        ),
        ToolbarItem(
          tooltip: docsSample(context, 'Download'),
          semanticLabel: docsSample(context, 'Download'),
          child: const Icon(LucideIcons.download),
        ),
      ],
    ),
  );
}

/// Named docs examples for `toolbar`; the first entry is the default.
List<ComponentPreview> get toolbarPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _toolbarDefault),
  ComponentPreview(docsSample(null, 'Vertical'), _toolbarVertical),
  ComponentPreview(docsSample(null, 'Groups'), _toolbarGroups),
  ComponentPreview(docsSample(null, 'Toggles'), _toolbarToggles),
  ComponentPreview(docsSample(null, 'Overflow'), _toolbarOverflow),
  ComponentPreview(docsSample(null, 'Customized'), _toolbarCustomized),
];
