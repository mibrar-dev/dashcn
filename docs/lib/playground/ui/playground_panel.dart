// The live props playground panel: preview, controls and code.
//
// `PlaygroundPanel(componentId:)` renders the builder for [componentId]
// inside [FramedPreview], controls for theme tokens and component props,
// and the live `emitCode` snippet. Components without a props builder
// still render the Theme section.
//
// Layout follows viewport width: controls beside preview at
// [kPlaygroundSideBySideWidth] (1100 px), below preview under that,
// or in bottom sheet under [kPlaygroundSheetWidth] (600 px).

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../builder.dart';
import '../builders.dart';
import '../../generated/docs_controls.dart';
import '../../ui/dashcn/components/button/button.dart';
import '../../routing/docs_router.dart';
import '../../state/docs_strings.dart';
import '../../ui/dashcn/components/drawer/drawer.dart';
import '../../ui/dashcn/foundation/gap.dart';
import '../../ui/dashcn/theme/theme.dart';
import '../theme_values.dart';
import '../values.dart';
import 'bounds.dart';
import 'numeric_controls.dart';
import 'panel_body.dart';
import 'query.dart';
import 'theme_section.dart';

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
    this.inlineControls = false,
  });

  /// Registry component id.
  final String componentId;

  /// Seed query (`p.<name>` and `t.<name>` entries).
  final Map<String, String>? initialQuery;

  /// Called with the non-default query after every change and reset.
  final ValueChanged<Map<String, String>>? onQueryChanged;

  /// Dependent-range table (see `bounds.dart`).
  final Map<String, List<String>>? boundedBy;

  /// Whether to also push the merged URI to the engine on web.
  final bool reportUrl;

  /// When true the controls render inline even below [kPlaygroundSheetWidth].
  final bool inlineControls;

  @override
  State<PlaygroundPanel> createState() => _PlaygroundPanelState();
}

class _PlaygroundPanelState extends State<PlaygroundPanel> {
  ComponentControls? _spec;
  PlaygroundBuilder? _builder;
  PlaygroundValues? _values;
  PlaygroundThemeValues? _themeValues;
  final Map<String, TextEditingController> _controllers =
      <String, TextEditingController>{};

  final ValueNotifier<int> _version = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _initForId(widget.componentId, widget.initialQuery);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeValues ??= PlaygroundThemeValues.fromQuery(
      Theme.of(context),
      widget.initialQuery ?? browserPlaygroundQuery(),
    );
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
    if (spec != null) {
      _values = PlaygroundValues.fromQuery(
        spec,
        query ?? browserPlaygroundQuery(),
      );
      clampBoundedValues(spec, _values!, boundedBy: widget.boundedBy);
      _seedControllers(spec, _values!);
    } else {
      _values = null;
    }
  }

  void _applyQuery(Map<String, String>? query) {
    final ThemeData siteTheme = Theme.of(context);
    _themeValues = PlaygroundThemeValues.fromQuery(
      siteTheme,
      query ?? browserPlaygroundQuery(),
    );
    final ComponentControls? spec = _spec;
    final PlaygroundValues? values = _values;
    if (spec != null && values != null) {
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
    }
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
      if (controller == null) continue;
      final String next = _fieldString(spec, control, values);
      if (controller.text != next) controller.text = next;
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
    if (spec == null || values == null) return;
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
    _notifyQuery();
  }

  void _commitTheme(PlaygroundThemeValues next) {
    _themeValues = next;
    _version.value++;
    setState(() {});
    _notifyQuery();
  }

  void _reset() {
    final ThemeData siteTheme = Theme.of(context);
    final ComponentControls? spec = _spec;
    final PlaygroundValues? values = _values;
    if (spec != null && values != null) {
      values.reset(spec);
      clampBoundedValues(spec, values, boundedBy: widget.boundedBy);
      _syncControllers(spec, values);
    }
    _themeValues = PlaygroundThemeValues.defaults(siteTheme);
    _version.value++;
    setState(() {});
    _notifyQuery();
  }

  void _notifyQuery() {
    final ThemeData siteTheme = Theme.of(context);
    final ComponentControls? spec = _spec;
    final PlaygroundValues? values = _values;
    final Map<String, String> query = <String, String>{};
    if (spec != null && values != null) {
      query.addAll(playgroundQuery(spec, values));
    }
    if (_themeValues != null) {
      query.addAll(_themeValues!.toQuery(siteTheme));
    }
    widget.onQueryChanged?.call(query);
    if (widget.reportUrl) {
      try {
        unawaited(reportPlaygroundUri(mergedPlaygroundUri(Uri.base, query)));
      } catch (_) {}
    }
  }

  Future<void> _openSheet() {
    final ThemeData theme = Theme.of(context);
    final PlaygroundThemeValues tv =
        _themeValues ?? PlaygroundThemeValues.defaults(theme);
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
                  child: Text(
                    docsChrome(
                      DocsRouterScope.maybeOf(context)?.state.locale ??
                          const Locale('en'),
                      'pgDone',
                    ),
                  ),
                ),
              ],
            ),
            Gap(theme.spacing.sm),
            PlaygroundThemeSection(themeValues: tv, onCommit: _commitTheme),
            if (_spec != null && _values != null) ...<Widget>[
              Gap(theme.spacing.md),
              PlaygroundControlsList(
                spec: _spec!,
                values: _values!,
                version: _version,
                controllers: _controllers,
                onCommit: _commit,
                boundedBy: widget.boundedBy,
              ),
            ],
          ],
        ),
      ),
    );
  }

  PlaygroundControlsCard _controlsCard(
    ComponentControls? spec,
    PlaygroundValues? values,
  ) {
    final ThemeData theme = Theme.of(context);
    return PlaygroundControlsCard(
      spec: spec,
      values: values,
      themeValues: _themeValues ?? PlaygroundThemeValues.defaults(theme),
      version: _version,
      controllers: _controllers,
      onCommit: _commit,
      onThemeCommit: _commitTheme,
      onReset: _reset,
      boundedBy: widget.boundedBy,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    _themeValues ??= PlaygroundThemeValues.fromQuery(
      theme,
      widget.initialQuery ?? browserPlaygroundQuery(),
    );
    final ComponentControls? spec = _spec;
    final PlaygroundBuilder? builder = _builder;
    final PlaygroundValues? values = _values;

    if (builder == null || spec == null || values == null) {
      return _controlsCard(spec, values);
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
        if (!widget.inlineControls &&
            width.isFinite &&
            width < kPlaygroundSheetWidth) {
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
                child: Text(
                  docsChrome(
                    DocsRouterScope.maybeOf(context)?.state.locale ??
                        const Locale('en'),
                    'pgEdit',
                  ),
                ),
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
