// Collapsible Theme section for the live playground panel.
//
// Controls every theme token: radius (slider 0-24 + presets), density
// (compact/comfortable/touch segmented), spacing base, tracking, shadow
// (none/sm/md/lg), surface opacity, surface blur, font (sans/serif/mono),
// and light/dark mode.
//
// Styled consistently with existing playground controls and Figma properties.

import 'package:flutter/widgets.dart';

import '../../routing/docs_router.dart';
import '../../state/docs_strings.dart';
import '../../ui/dashcn/components/button/button.dart';
import '../../ui/dashcn/components/input/input.dart';
import '../../ui/dashcn/components/slider/slider.dart';
import '../../ui/dashcn/foundation/gap.dart';
import '../../ui/dashcn/theme/theme.dart';
import '../theme_values.dart';
import 'control_label.dart';

/// Collapsible Theme section in the playground panel.
class PlaygroundThemeSection extends StatefulWidget {
  /// Creates the theme section.
  const PlaygroundThemeSection({
    super.key,
    required this.themeValues,
    required this.onCommit,
  });

  /// The current theme values.
  final PlaygroundThemeValues themeValues;

  /// Called when any theme control changes.
  final ValueChanged<PlaygroundThemeValues> onCommit;

  @override
  State<PlaygroundThemeSection> createState() => _PlaygroundThemeSectionState();
}

class _PlaygroundThemeSectionState extends State<PlaygroundThemeSection> {
  bool _collapsed = false;

  late final TextEditingController _radiusCtrl;
  late final TextEditingController _spacingCtrl;
  late final TextEditingController _trackingCtrl;
  late final TextEditingController _opacityCtrl;
  late final TextEditingController _blurCtrl;

  @override
  void initState() {
    super.initState();
    _radiusCtrl = TextEditingController(text: _fmt(widget.themeValues.radius));
    _spacingCtrl = TextEditingController(
      text: _fmt(widget.themeValues.spacingBase),
    );
    _trackingCtrl = TextEditingController(
      text: widget.themeValues.tracking.toStringAsFixed(2),
    );
    _opacityCtrl = TextEditingController(
      text: widget.themeValues.surfaceOpacity.toStringAsFixed(2),
    );
    _blurCtrl = TextEditingController(
      text: _fmt(widget.themeValues.surfaceBlur),
    );
  }

  @override
  void didUpdateWidget(covariant PlaygroundThemeSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.themeValues != widget.themeValues) {
      _syncCtrl(_radiusCtrl, _fmt(widget.themeValues.radius));
      _syncCtrl(_spacingCtrl, _fmt(widget.themeValues.spacingBase));
      _syncCtrl(_trackingCtrl, widget.themeValues.tracking.toStringAsFixed(2));
      _syncCtrl(
        _opacityCtrl,
        widget.themeValues.surfaceOpacity.toStringAsFixed(2),
      );
      _syncCtrl(_blurCtrl, _fmt(widget.themeValues.surfaceBlur));
    }
  }

  void _syncCtrl(TextEditingController ctrl, String val) {
    if (ctrl.text != val) {
      ctrl.text = val;
    }
  }

  @override
  void dispose() {
    _radiusCtrl.dispose();
    _spacingCtrl.dispose();
    _trackingCtrl.dispose();
    _opacityCtrl.dispose();
    _blurCtrl.dispose();
    super.dispose();
  }

  static String _fmt(double n) {
    return n == n.roundToDouble() ? n.round().toString() : n.toStringAsFixed(1);
  }

  Widget _buildSliderRow({
    required ThemeData theme,
    required String label,
    required double value,
    required double min,
    required double max,
    required String keyPrefix,
    required TextEditingController controller,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ControlLabel(text: label),
        Gap(theme.spacing.xs),
        Row(
          children: <Widget>[
            Expanded(
              child: Slider(
                key: ValueKey<String>('playground-theme-$keyPrefix-slider'),
                value: value.clamp(min, max),
                min: min,
                max: max,
                onChanged: onChanged,
                semanticLabel: label,
              ),
            ),
            Gap(theme.spacing.sm),
            SizedBox(
              width: 58,
              child: Input(
                key: ValueKey<String>('playground-theme-$keyPrefix-input'),
                controller: controller,
                keyboardType: TextInputType.number,
                onChanged: (String text) {
                  final double? parsed = double.tryParse(text);
                  if (parsed != null) {
                    onChanged(parsed.clamp(min, max));
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSegmentedRow({
    required ThemeData theme,
    required String label,
    required List<String> options,
    required String selected,
    required String keyPrefix,
    required ValueChanged<String> onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ControlLabel(text: label),
        Gap(theme.spacing.xs),
        Row(
          children: <Widget>[
            for (int i = 0; i < options.length; i++) ...<Widget>[
              if (i > 0) Gap(theme.spacing.xs),
              Expanded(
                child: Button(
                  key: ValueKey<String>(
                    'playground-theme-$keyPrefix-${options[i]}',
                  ),
                  variant: selected == options[i]
                      ? ButtonVariant.primary
                      : ButtonVariant.outline,
                  size: ButtonSize.sm,
                  onPressed: () => onSelect(options[i]),
                  child: Text(options[i]),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    final PlaygroundThemeValues values = widget.themeValues;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                docsChrome(locale, 'pgTheme'),
                key: const ValueKey<String>('playground-group-theme'),
                style: theme.typography.small.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colors.foreground,
                ),
              ),
            ),
            Button(
              key: const ValueKey<String>('playground-theme-collapse-toggle'),
              variant: ButtonVariant.ghost,
              size: ButtonSize.sm,
              onPressed: () => setState(() => _collapsed = !_collapsed),
              child: Text(
                _collapsed
                    ? docsChrome(locale, 'pgShow')
                    : docsChrome(locale, 'pgHide'),
              ),
            ),
          ],
        ),
        if (!_collapsed) ...<Widget>[
          Gap(theme.spacing.xs),
          // 1. Radius (presets + slider)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const ControlLabel(text: 'Radius'),
              Gap(theme.spacing.xs),
              Wrap(
                spacing: theme.spacing.xs,
                runSpacing: theme.spacing.xs,
                children: <Widget>[
                  for (final double p in kPlaygroundThemeRadiusPresets)
                    Button(
                      key: ValueKey<String>(
                        'playground-theme-radius-preset-${p.toInt()}',
                      ),
                      variant: (values.radius - p).abs() < 0.1
                          ? ButtonVariant.primary
                          : ButtonVariant.outline,
                      size: ButtonSize.sm,
                      onPressed: () {
                        widget.onCommit(values.copyWith(radius: p));
                      },
                      child: Text('${p.toInt()}'),
                    ),
                ],
              ),
              Gap(theme.spacing.xs),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Slider(
                      key: const ValueKey<String>(
                        'playground-theme-radius-slider',
                      ),
                      value: values.radius.clamp(0.0, 24.0),
                      min: 0.0,
                      max: 24.0,
                      onChanged: (double v) {
                        widget.onCommit(values.copyWith(radius: v));
                      },
                      semanticLabel: 'Radius',
                    ),
                  ),
                  Gap(theme.spacing.sm),
                  SizedBox(
                    width: 58,
                    child: Input(
                      key: const ValueKey<String>(
                        'playground-theme-radius-input',
                      ),
                      controller: _radiusCtrl,
                      keyboardType: TextInputType.number,
                      onChanged: (String text) {
                        final double? parsed = double.tryParse(text);
                        if (parsed != null) {
                          widget.onCommit(
                            values.copyWith(radius: parsed.clamp(0.0, 24.0)),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          Gap(theme.spacing.sm),

          // 2. Density (compact/comfortable/touch)
          _buildSegmentedRow(
            theme: theme,
            label: 'Density',
            options: kPlaygroundThemeDensities,
            selected: values.density,
            keyPrefix: 'density',
            onSelect: (String d) =>
                widget.onCommit(values.copyWith(density: d)),
          ),
          Gap(theme.spacing.sm),

          // 3. Spacing base
          _buildSliderRow(
            theme: theme,
            label: 'Spacing base',
            value: values.spacingBase,
            min: 1.0,
            max: 16.0,
            keyPrefix: 'spacing',
            controller: _spacingCtrl,
            onChanged: (double v) {
              widget.onCommit(values.copyWith(spacingBase: v));
            },
          ),
          Gap(theme.spacing.sm),

          // 4. Tracking
          _buildSliderRow(
            theme: theme,
            label: 'Tracking',
            value: values.tracking,
            min: -2.0,
            max: 4.0,
            keyPrefix: 'tracking',
            controller: _trackingCtrl,
            onChanged: (double v) {
              widget.onCommit(values.copyWith(tracking: v));
            },
          ),
          Gap(theme.spacing.sm),

          // 5. Shadow (none/sm/md/lg)
          _buildSegmentedRow(
            theme: theme,
            label: 'Shadow',
            options: kPlaygroundThemeShadows,
            selected: values.shadow,
            keyPrefix: 'shadow',
            onSelect: (String s) => widget.onCommit(values.copyWith(shadow: s)),
          ),
          Gap(theme.spacing.sm),

          // 6. Surface opacity
          _buildSliderRow(
            theme: theme,
            label: 'Surface opacity',
            value: values.surfaceOpacity,
            min: 0.0,
            max: 1.0,
            keyPrefix: 'surface-opacity',
            controller: _opacityCtrl,
            onChanged: (double v) {
              widget.onCommit(values.copyWith(surfaceOpacity: v));
            },
          ),
          Gap(theme.spacing.sm),

          // 7. Surface blur
          _buildSliderRow(
            theme: theme,
            label: 'Surface blur',
            value: values.surfaceBlur,
            min: 0.0,
            max: 30.0,
            keyPrefix: 'surface-blur',
            controller: _blurCtrl,
            onChanged: (double v) {
              widget.onCommit(values.copyWith(surfaceBlur: v));
            },
          ),
          Gap(theme.spacing.sm),

          // 8. Font (sans/serif/mono)
          _buildSegmentedRow(
            theme: theme,
            label: 'Font',
            options: kPlaygroundThemeFonts,
            selected: values.font,
            keyPrefix: 'font',
            onSelect: (String f) => widget.onCommit(values.copyWith(font: f)),
          ),
          Gap(theme.spacing.sm),

          // 9. Mode (light/dark)
          _buildSegmentedRow(
            theme: theme,
            label: 'Mode',
            options: kPlaygroundThemeModes,
            selected: values.mode,
            keyPrefix: 'mode',
            onSelect: (String m) => widget.onCommit(values.copyWith(mode: m)),
          ),
        ],
      ],
    );
  }
}
