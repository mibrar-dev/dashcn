// The live props playground panel (P9-2b): preview, controls and code.
//
// `PlaygroundPanel(componentId:)` renders the P9-2a builder for [componentId]
// inside P9-1's [FramedPreview] (frames keep working here), a control row per
// editable `ControlSpec` ([ControlRow]), and the live `emitCode` snippet in
// the existing [DocsCodeFigure] (syntax-highlighted, selectable, copyable).
// Components without a builder render nothing — the integration step (P9-Z)
// shows "Playground coming soon" there.
//
// Layout follows the viewport width: controls beside the preview at
// [kPlaygroundSideBySideWidth] (1100 px) and up, below the preview under
// that, and inside a kit bottom sheet (`openSheet` from the `drawer`
// component) under [kPlaygroundSheetWidth] (600 px), opened by an
// `Edit controls` button. The code block always sits underneath.
//
// State: values seed from the spec defaults, then from [initialQuery] (or
// the live browser URL on web), so a configured playground is shareable and
// survives reload. Every commit and reset clamps dependent ranges
// (`bounds.dart`), syncs the text controllers, and reports the non-default
// query through [onQueryChanged] plus a best-effort engine URL update; P9-Z
// wires [onQueryChanged]/[initialQuery] into the docs router state
// (see `query.dart`).

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../builder.dart';
import '../builders.dart';
import '../../generated/docs_controls.dart';
import '../../ui/dashcn/components/button/button.dart';
import '../../ui/dashcn/components/drawer/drawer.dart';
import '../../ui/dashcn/foundation/gap.dart';
import '../../ui/dashcn/theme/theme.dart';
import '../values.dart';
import 'bounds.dart';
import 'numeric_controls.dart';
import 'panel_body.dart';
import 'query.dart';

/// Viewport width at/above which controls sit beside the preview.
const double kPlaygroundSideBySideWidth = 1100;

/// Viewport width below which controls move into a bottom sheet.
const double kPlaygroundSheetWidth = 600;

/// Width of the side-rail controls column.
const double kPlaygroundRailWidth = 320;

/// Live props playground: preview, controls and emitted code.
class PlaygroundPanel extends StatefulWidget {
  /// Creates the panel for [componentId].
  const PlaygroundPanel({
    super.key,
    required this.componentId,
    this.initialQuery,
    this.onQueryChanged,
    this.boundedBy,
    this.reportUrl = true,
  });

  /// Registry component id (must have a spec and a playground builder).
  final String componentId;

  /// Seed query (`p.<name>` entries); defaults to the browser URL on web.
  ///
  /// P9-Z passes the router's parsed query here so back/forward restores
  /// the panel.
  final Map<String, String>? initialQuery;

  /// Called with the non-default query after every change and reset.
  ///
  /// P9-Z merges this into the router state (browser URL + history).
  final ValueChanged<Map<String, String>>? onQueryChanged;

  /// Dependent-range table (see `bounds.dart`).
  final Map<String, List<String>>? boundedBy;

  /// Whether to also push the merged URI to the engine on web.
  final bool reportUrl;

  @override
  State<PlaygroundPanel> createState() => _PlaygroundPanelState();
}

class _PlaygroundPanelState extends State<PlaygroundPanel> {
  ComponentControls? _spec;
  PlaygroundBuilder? _builder;
  PlaygroundValues? _values;
  final Map<String, TextEditingController> _controllers =
      <String, TextEditingController>{};

  /// Bumped on every commit/reset so sheet routes rebuild too (the panel's
  /// own `setState` cannot reach into an open overlay route).
  final ValueNotifier<int> _version = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _initForId(widget.componentId, widget.initialQuery);
  }

  @override
  void didUpdateWidget(covariant PlaygroundPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.componentId != widget.componentId) {
      _initForId(widget.componentId, widget.initialQuery);
    } else if (!mapEquals(oldWidget.initialQuery, widget.initialQuery)) {
      _applyQuery(widget.initialQuery);
    }
  }

  @override
  void dispose() {
    for (final TextEditingController controller in _controllers.values) {
      controller.dispose();
    }
    _version.dispose();
    super.dispose();
  }

  void _initForId(String componentId, Map<String, String>? query) {
    for (final TextEditingController controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
    _spec = kControlSpecs[componentId];
    _builder = kPlaygroundBuilders[componentId];
    final ComponentControls? spec = _spec;
    if (spec == null) {
      _values = null;
      return;
    }
    _values = PlaygroundValues.fromQuery(
      spec,
      query ?? browserPlaygroundQuery(),
    );
    clampBoundedValues(spec, _values!, boundedBy: widget.boundedBy);
    _seedControllers(spec, _values!);
  }

  void _applyQuery(Map<String, String>? query) {
    final ComponentControls? spec = _spec;
    final PlaygroundValues? values = _values;
    if (spec == null || values == null) {
      return;
    }
    final PlaygroundValues seeded = PlaygroundValues.fromQuery(
      spec,
      query ?? browserPlaygroundQuery(),
    );
    for (final ControlSpec control in spec.controls) {
      if (control.isEditable) {
        values.set(control.name, seeded.valueOf(control.name));
      }
    }
    clampBoundedValues(spec, values, boundedBy: widget.boundedBy);
    _syncControllers(spec, values);
    _version.value++;
    setState(() {});
  }

  void _seedControllers(ComponentControls spec, PlaygroundValues values) {
    for (final ControlSpec control in spec.controls) {
      if (control.kind == ControlKind.text ||
          control.kind == ControlKind.slider) {
        _controllers[control.name] = TextEditingController(
          text: _fieldString(spec, control, values),
        );
      }
    }
  }

  void _syncControllers(ComponentControls spec, PlaygroundValues values) {
    for (final ControlSpec control in spec.controls) {
      final TextEditingController? controller = _controllers[control.name];
      if (controller == null) {
        continue;
      }
      final String next = _fieldString(spec, control, values);
      if (controller.text != next) {
        controller.text = next;
      }
    }
  }

  String _fieldString(
    ComponentControls spec,
    ControlSpec control,
    PlaygroundValues values,
  ) {
    if (control.kind == ControlKind.slider) {
      final Object? raw = values.valueOf(control.name);
      final double value = raw is num ? raw.toDouble() : control.min ?? 0;
      return formatControlNumber(control, value);
    }
    return values.getString(control.name) ?? '';
  }

  void _commit(String name, Object? value) {
    final ComponentControls? spec = _spec;
    final PlaygroundValues? values = _values;
    if (spec == null || values == null) {
      return;
    }
    values.set(name, value);
    clampBoundedValues(
      spec,
      values,
      changed: name,
      boundedBy: widget.boundedBy,
    );
    _syncControllers(spec, values);
    _version.value++;
    setState(() {});
    _notifyQuery(spec, values);
  }

  void _reset() {
    final ComponentControls? spec = _spec;
    final PlaygroundValues? values = _values;
    if (spec == null || values == null) {
      return;
    }
    values.reset(spec);
    clampBoundedValues(spec, values, boundedBy: widget.boundedBy);
    _syncControllers(spec, values);
    _version.value++;
    setState(() {});
    _notifyQuery(spec, values);
  }

  void _notifyQuery(ComponentControls spec, PlaygroundValues values) {
    final Map<String, String> query = playgroundQuery(spec, values);
    widget.onQueryChanged?.call(query);
    if (widget.reportUrl) {
      try {
        unawaited(reportPlaygroundUri(playgroundUri(Uri.base, spec, values)));
      } catch (_) {
        // No browser URL (tests, non-web embedders): the callback above
        // is the testable seam.
      }
    }
  }

  Future<void> _openSheet() {
    final ComponentControls? spec = _spec;
    final PlaygroundValues? values = _values;
    if (spec == null || values == null) {
      return Future<void>.value();
    }
    return openSheet<void>(
      context: context,
      builder: (BuildContext sheetContext) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Expanded(child: PlaygroundControlsTitle()),
                Button(
                  key: const ValueKey<String>('playground-sheet-done'),
                  variant: ButtonVariant.primary,
                  size: ButtonSize.sm,
                  onPressed: () => closeSheet<void>(sheetContext),
                  child: const Text('Done'),
                ),
              ],
            ),
            PlaygroundControlsList(
              spec: spec,
              values: values,
              version: _version,
              controllers: _controllers,
              onCommit: _commit,
              boundedBy: widget.boundedBy,
            ),
          ],
        ),
      ),
    );
  }

  PlaygroundControlsCard _controlsCard(
    ComponentControls spec,
    PlaygroundValues values,
  ) {
    return PlaygroundControlsCard(
      spec: spec,
      values: values,
      version: _version,
      controllers: _controllers,
      onCommit: _commit,
      onReset: _reset,
      boundedBy: widget.boundedBy,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ComponentControls? spec = _spec;
    final PlaygroundBuilder? builder = _builder;
    final PlaygroundValues? values = _values;
    // Components without a builder render nothing (P9-Z shows
    // "Playground coming soon" there instead).
    if (spec == null || builder == null || values == null) {
      return const SizedBox.shrink();
    }
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth;
        final Widget preview = PlaygroundPreview(
          componentId: widget.componentId,
          builder: builder,
          values: values,
        );
        final Widget code = PlaygroundCodeBlock(spec: spec, values: values);
        final ThemeData theme = Theme.of(context);
        if (width.isFinite && width < kPlaygroundSheetWidth) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              preview,
              Gap(theme.spacing.sm),
              Button(
                key: const ValueKey<String>('playground-open-sheet'),
                variant: ButtonVariant.outline,
                size: ButtonSize.md,
                onPressed: _openSheet,
                child: const Text('Edit controls'),
              ),
              Gap(theme.spacing.sm),
              code,
            ],
          );
        }
        final Widget controls = _controlsCard(spec, values);
        if (width.isFinite && width >= kPlaygroundSideBySideWidth) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: preview),
                  Gap(theme.spacing.md),
                  SizedBox(width: kPlaygroundRailWidth, child: controls),
                ],
              ),
              Gap(theme.spacing.sm),
              code,
            ],
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            preview,
            Gap(theme.spacing.sm),
            controls,
            Gap(theme.spacing.sm),
            code,
          ],
        );
      },
    );
  }
}
