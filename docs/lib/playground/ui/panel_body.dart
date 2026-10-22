// Playground panel sections: the framed preview, the live code block and
// the controls column/sheet list.
//
// Split from `playground_panel.dart` for the ~400-line rule. These widgets
// are presentational: they read [PlaygroundValues] at build time and report
// through callbacks. The list rebuilds off [version] (a `ValueNotifier` the
// panel bumps on every commit) so controls inside an open bottom-sheet route
// stay live — the panel's own `setState` cannot reach into the overlay.
//
// Controls are grouped Figma-style (Appearance, Size, State, Content); only
// editable kinds appear here. Read-only entries stay in the API Reference
// docs and never render as rows.

import 'package:flutter/widgets.dart';

import '../../routing/docs_router.dart';
import '../../state/docs_strings.dart';

import '../../generated/docs_controls.dart';
import '../../ui/dashcn/components/button/button.dart';
import '../../ui/dashcn/foundation/gap.dart';
import '../../ui/dashcn/theme/theme.dart';
import '../../widgets/code_figure.dart';
import '../../widgets/copy_button.dart';
import '../../widgets/device_frame/framed_preview.dart';
import '../../widgets/preview_stage.dart';
import '../builder.dart';
import '../code.dart';
import '../values.dart';
import 'control_label.dart';
import 'controls.dart';
import 'groups.dart';
import 'query.dart';

/// The framed live preview (P9-1 frames keep working inside the playground).
class PlaygroundPreview extends StatelessWidget {
  /// Creates the preview for [componentId].
  const PlaygroundPreview({
    super.key,
    required this.componentId,
    required this.builder,
    required this.values,
  });

  /// Registry component id (namespaces the frame state).
  final String componentId;

  /// The P9-2a builder for the component.
  final PlaygroundBuilder builder;

  /// Live values (read at build time).
  final PlaygroundValues values;

  @override
  Widget build(BuildContext context) {
    return FramedPreview(
      id: 'playground-$componentId',
      child: PreviewStage(
        minHeight: 200,
        child: Builder(
          builder: (BuildContext context) => builder(context, values),
        ),
      ),
    );
  }
}

/// The live code block (rebuilds with the values on every change).
class PlaygroundCodeBlock extends StatelessWidget {
  /// Creates the code block for [spec] and [values].
  const PlaygroundCodeBlock({
    super.key,
    required this.spec,
    required this.values,
  });

  /// The component's control spec.
  final ComponentControls spec;

  /// Live values (read at build time).
  final PlaygroundValues values;

  @override
  Widget build(BuildContext context) {
    return DocsCodeFigure(
      key: const ValueKey<String>('playground-code'),
      code: emitCode(spec, values),
      language: 'dart',
    );
  }
}

/// The controls section title.
class PlaygroundControlsTitle extends StatelessWidget {
  /// Creates the title.
  const PlaygroundControlsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Text(
      docsChrome(
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en'),
        'pgControls',
      ),
      style: theme.typography.base.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

/// Controls header (title + reset + copy) plus the grouped rows.
class PlaygroundControlsCard extends StatelessWidget {
  /// Creates the controls column.
  const PlaygroundControlsCard({
    super.key,
    required this.spec,
    required this.values,
    required this.version,
    required this.controllers,
    required this.onCommit,
    required this.onReset,
    this.boundedBy,
  });

  /// The component's control spec.
  final ComponentControls spec;

  /// Live values (read at build time).
  final PlaygroundValues values;

  /// Bumped on every commit/reset (drives the rows, incl. in sheets).
  final ValueNotifier<int> version;

  /// Panel-owned text controllers keyed by control name.
  final Map<String, TextEditingController> controllers;

  /// Called with the next value.
  final ControlCommitted onCommit;

  /// Restores the spec defaults.
  final VoidCallback onReset;

  /// Dependent-range table (see `bounds.dart`).
  final Map<String, List<String>>? boundedBy;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool pristine = playgroundQuery(spec, values).isEmpty;
    final String code = emitCode(spec, values);
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    final String copyLabel = docsChrome(locale, 'pgCopyCode');
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Expanded(child: PlaygroundControlsTitle()),
            Button(
              key: const ValueKey<String>('playground-reset'),
              variant: ButtonVariant.outline,
              size: ButtonSize.sm,
              onPressed: pristine ? null : onReset,
              child: Text(
                docsChrome(
                  DocsRouterScope.maybeOf(context)?.state.locale ??
                      const Locale('en'),
                  'pgReset',
                ),
              ),
            ),
            Gap(theme.spacing.xs),
            CopyButton(
              key: const ValueKey<String>('playground-copy'),
              text: code,
              label: copyLabel,
              showLabel: true,
              variant: ButtonVariant.secondary,
              size: ButtonSize.sm,
              tooltip: copyLabel,
            ),
          ],
        ),
        Gap(theme.spacing.sm),
        PlaygroundControlsList(
          spec: spec,
          values: values,
          version: version,
          controllers: controllers,
          onCommit: onCommit,
          boundedBy: boundedBy,
        ),
      ],
    );
  }
}

/// One row per editable control, grouped Figma-style.
///
/// Groups (Appearance, Size, State, Content) come from `groups.dart`; only
/// editable kinds render. Read-only entries are hidden here and stay in the
/// API Reference docs.
class PlaygroundControlsList extends StatelessWidget {
  /// Creates the rows.
  const PlaygroundControlsList({
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

  /// Bumped on every commit/reset (drives the rows, incl. in sheets).
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
              if (g > 0) Gap(theme.spacing.md),
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
