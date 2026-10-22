// Playground control groups (Figma-like properties panel).
//
// Editable controls are grouped so the right panel reads like Figma
// properties instead of one flat API-order list:
//
// * Appearance — `select` (variant, mode, type, …) and `colorToken`
// * Size — `size` selects, `fullWidth` and `slider` (numeric extents)
// * State — `toggle` and `enabled` (bools, nullable tri-state) plus the
//   `status` select (loading state machine)
// * Content — `text` (labels, strings, text-like Widget slots) plus the
//   synthetic `hasIcon`/`iconPosition` (icon content)
//
// Read-only (`ControlKind.readOnly`) entries never appear here; they stay
// visible only as documentation in the API Reference table. Group order is
// fixed (Appearance, Size, State, Content) and empty groups are omitted.
// Spacing comes from the theme (`spacing`), so density presets re-space the
// panel.

import 'package:flutter/widgets.dart';

import '../../generated/docs_controls.dart';
import '../../routing/docs_router.dart';
import '../../state/docs_strings.dart';
import '../../ui/dashcn/theme/theme.dart';
import '../values.dart';
import 'control_label.dart';
import 'controls.dart';

/// Group ids in display order.
const List<String> kPlaygroundGroupOrder = <String>[
  'appearance',
  'size',
  'state',
  'content',
];

/// Display title per group id.
String playgroundGroupTitle(String groupId) {
  return switch (groupId) {
    'appearance' => 'Appearance',
    'size' => 'Size',
    'state' => 'State',
    'content' => 'Content',
    _ => groupId,
  };
}

/// Locale-aware display title per group id (website chrome).
String playgroundGroupTitleFor(Locale locale, String groupId) {
  return switch (groupId) {
    'appearance' => docsChrome(locale, 'pgGroupAppearance'),
    'size' => docsChrome(locale, 'pgGroupSize'),
    'state' => docsChrome(locale, 'pgGroupState'),
    'content' => docsChrome(locale, 'pgGroupContent'),
    _ => groupId,
  };
}

/// Group id for [control], or null when the panel must hide it.
///
/// Only editable kinds are grouped; `readOnly` returns null (hidden from the
/// panel, kept only in the API Reference docs). Name takes precedence over
/// kind so `size` selects land in Size, `status` selects in State, and the
/// synthetic `hasIcon`/`iconPosition`/`fullWidth` land in Content/Size.
String? playgroundGroupFor(ControlSpec control) {
  if (control.kind == ControlKind.readOnly) {
    return null;
  }
  final String name = control.name;
  // Synthetic + name-driven overrides first.
  if (name == 'hasIcon' || name == 'iconPosition') {
    return 'content';
  }
  if (name == 'fullWidth' || name == 'size') {
    return 'size';
  }
  if (name == 'status') {
    return 'state';
  }
  if (name.contains('width') ||
      name.contains('height') ||
      name.contains('size')) {
    return 'size';
  }
  return switch (control.kind) {
    ControlKind.select => 'appearance',
    ControlKind.colorToken => 'appearance',
    ControlKind.slider => 'size',
    ControlKind.toggle => 'state',
    ControlKind.enabled => 'state',
    ControlKind.text => 'content',
    ControlKind.readOnly => null,
  };
}

/// Editable controls of [spec] grouped in display order.
///
/// Within a group the API order is preserved. Empty groups are omitted.
/// Read-only controls are excluded.
Map<String, List<ControlSpec>> groupEditableControls(ComponentControls spec) {
  final Map<String, List<ControlSpec>> grouped = <String, List<ControlSpec>>{};
  for (final ControlSpec control in spec.controls) {
    if (!control.isEditable) {
      continue;
    }
    final String? groupId = playgroundGroupFor(control);
    if (groupId == null) {
      continue;
    }
    grouped.putIfAbsent(groupId, () => <ControlSpec>[]).add(control);
  }
  final Map<String, List<ControlSpec>> ordered = <String, List<ControlSpec>>{};
  for (final String groupId in kPlaygroundGroupOrder) {
    final List<ControlSpec>? controls = grouped[groupId];
    if (controls != null && controls.isNotEmpty) {
      ordered[groupId] = controls;
    }
  }
  return ordered;
}

/// One grouped section: title plus its rows, spaced by density tokens.
class PlaygroundControlGroup extends StatelessWidget {
  /// Creates a group section.
  const PlaygroundControlGroup({
    super.key,
    required this.groupId,
    required this.title,
    required this.children,
  });

  /// Group id (`appearance`, `size`, `state`, `content`).
  final String groupId;

  /// Visible section title (`Appearance`, …).
  final String title;

  /// The control rows in this group.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_element — density bridge kept for the ~400-line rule.
    return _PlaygroundControlGroupBody(
      groupId: groupId,
      title: title,
      children: children,
    );
  }
}

class _PlaygroundControlGroupBody extends StatelessWidget {
  const _PlaygroundControlGroupBody({
    required this.groupId,
    required this.title,
    required this.children,
  });

  final String groupId;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          title,
          key: ValueKey<String>('playground-group-$groupId'),
          style: theme.typography.small.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colors.foreground,
          ),
        ),
        SizedBox(height: theme.spacing.xs),
        for (int i = 0; i < children.length; i++) ...<Widget>[
          if (i > 0) SizedBox(height: theme.spacing.sm),
          children[i],
        ],
      ],
    );
  }
}

/// Grouped control rows (replaces the flat list).
class PlaygroundGroupedControlsList extends StatelessWidget {
  /// Creates the grouped rows.
  const PlaygroundGroupedControlsList({
    super.key,
    required this.spec,
    required this.values,
    required this.version,
    required this.controllers,
    required this.onCommit,
    this.boundedBy,
  });

  /// The component's control spec.
  final ComponentControls spec;

  /// Live values (read at build time).
  final PlaygroundValues values;

  /// Bumped on every commit/reset (drives rows, incl. in sheets).
  final ValueNotifier<int> version;

  /// Panel-owned text controllers keyed by control name.
  final Map<String, TextEditingController> controllers;

  /// Called with the next value.
  final ControlCommitted onCommit;

  /// Dependent-range table (see `bounds.dart`).
  final Map<String, List<String>>? boundedBy;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    final Map<String, List<ControlSpec>> grouped = groupEditableControls(spec);
    return ListenableBuilder(
      listenable: version,
      builder: (BuildContext context, Widget? _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (int g = 0; g < grouped.entries.length; g++) ...<Widget>[
              if (g > 0) SizedBox(height: theme.spacing.md),
              PlaygroundControlGroup(
                groupId: grouped.entries.elementAt(g).key,
                title: playgroundGroupTitleFor(
                  locale,
                  grouped.entries.elementAt(g).key,
                ),
                children: <Widget>[
                  for (final ControlSpec control
                      in grouped.entries.elementAt(g).value)
                    ControlRow(
                      spec: spec,
                      control: control,
                      values: values,
                      onCommit: onCommit,
                      textController: controllers[control.name],
                      boundedBy: boundedBy,
                    ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
