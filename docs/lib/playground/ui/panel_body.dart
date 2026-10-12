// Playground panel sections: the framed preview, the live code block and
// the controls column/sheet list.
//
// Split from `playground_panel.dart` for the ~400-line rule. These widgets
// are presentational: they read [PlaygroundValues] at build time and report
// through callbacks. The list rebuilds off [version] (a `ValueNotifier` the
// panel bumps on every commit) so controls inside an open bottom-sheet route
// stay live — the panel's own `setState` cannot reach into the overlay.

import 'package:flutter/widgets.dart';

import '../../generated/docs_controls.dart';
import '../../ui/dashcn/components/button/button.dart';
import '../../ui/dashcn/foundation/gap.dart';
import '../../ui/dashcn/theme/theme.dart';
import '../../widgets/code_figure.dart';
import '../../widgets/device_frame/framed_preview.dart';
import '../../widgets/preview_stage.dart';
import '../builder.dart';
import '../code.dart';
import '../values.dart';
import 'control_label.dart';
import 'controls.dart';
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
      'Controls',
      style: theme.typography.base.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

/// Controls header (title + reset) plus the rows.
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
              child: const Text('Reset'),
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

/// One row per editable control.
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
    final List<ControlSpec> editable = <ControlSpec>[
      for (final ControlSpec control in spec.controls)
        if (control.isEditable) control,
    ];
    return ListenableBuilder(
      listenable: version,
      builder: (BuildContext context, Widget? _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (int i = 0; i < editable.length; i++) ...<Widget>[
              if (i > 0) Gap(theme.spacing.sm),
              ControlRow(
                spec: spec,
                control: editable[i],
                values: values,
                onCommit: onCommit,
                textController: controllers[editable[i].name],
                boundedBy: boundedBy,
              ),
            ],
          ],
        );
      },
    );
  }
}
