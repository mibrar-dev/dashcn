// GENERATED CODE - DO NOT MODIFY BY HAND.
//
// Sources:
//   * dashcn/lib/src/components/<id>/preview.dart
//
// Regenerate: dart run tool/gen_docs_data.dart
//
// One display-code entry per ComponentPreview element: the imports
// for the component plus the example builder and the private
// helpers it uses (read with package:analyzer, see
// tool/src/example_sources.dart). `kExampleSources` drives the
// per-example Code tabs (first entry of each list is the default).

/// One named example plus its display code.
class DocsExampleSource {
  /// Creates the source.
  const DocsExampleSource({
    required this.name,
    this.description,
    required this.builder,
    required this.code,
  });

  /// Label shown on the card (`Default`, `With groups`).
  final String name;

  /// Optional one-line explanation under the card heading.
  final String? description;

  /// Builder expression (`_buttonDefault`).
  final String builder;

  /// Display code: imports plus the example body, verbatim.
  final String code;
}

/// Example sources keyed by component id, in declaration order.
const Map<String, List<DocsExampleSource>>
kExampleSources = <String, List<DocsExampleSource>>{
  'border_loading': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Sweep',
      builder: '_borderLoadingSweep',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/border_loading/border_loading.dart';

/// A labelled card carrying the loading border.
Widget _borderLoadingCard(BuildContext context, String label, Widget child) {
  final theme = Theme.of(context);
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      child,
      Gap(theme.spacing.sm),
      Text(
        label,
        style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
      ),
    ],
  );
}

/// The default rotating sweep.
Widget _borderLoadingSweep(BuildContext context) {
  return Center(
    child: _borderLoadingCard(
      context,
      'Indeterminate sweep',
      const BorderLoading(child: SizedBox(width: 120, height: 48)),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Progress',
      builder: '_borderLoadingProgressExample',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/border_loading/border_loading.dart';

/// A labelled card carrying the loading border.
Widget _borderLoadingCard(BuildContext context, String label, Widget child) {
  final theme = Theme.of(context);
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      child,
      Gap(theme.spacing.sm),
      Text(
        label,
        style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
      ),
    ],
  );
}

/// Determinate progress around the outline, driven by the example.
class _BorderLoadingProgress extends StatefulWidget {
  const _BorderLoadingProgress();

  @override
  State<_BorderLoadingProgress> createState() => _BorderLoadingProgressState();
}

class _BorderLoadingProgressState extends State<_BorderLoadingProgress> {
  double _progress = 0.6;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _borderLoadingCard(
            context,
            'Determinate - ${(_progress * 100).round()}%',
            BorderLoading(
              mode: BorderLoadingMode.progress,
              progress: _progress,
              child: const SizedBox(width: 120, height: 48),
            ),
          ),
          Gap(spacing.md),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.outline,
                onPressed: () => setState(
                  () => _progress = (_progress - 0.2).clamp(0.0, 1.0),
                ),
                child: const Text('-20%'),
              ),
              Gap(spacing.sm),
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.outline,
                onPressed: () => setState(
                  () => _progress = (_progress + 0.2).clamp(0.0, 1.0),
                ),
                child: const Text('+20%'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A live progress example; the `const` bridge keeps the preview list const.
Widget _borderLoadingProgressExample(BuildContext context) =>
    const _BorderLoadingProgress();
''',
    ),
    DocsExampleSource(
      name: 'Outline',
      builder: '_borderLoadingOutline',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/border_loading/border_loading.dart';

/// A labelled card carrying the loading border.
Widget _borderLoadingCard(BuildContext context, String label, Widget child) {
  final theme = Theme.of(context);
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      child,
      Gap(theme.spacing.sm),
      Text(
        label,
        style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
      ),
    ],
  );
}

/// A static outline, no animation.
Widget _borderLoadingOutline(BuildContext context) {
  return Center(
    child: _borderLoadingCard(
      context,
      'Static outline',
      const BorderLoading(
        mode: BorderLoadingMode.staticBorder,
        child: SizedBox(width: 120, height: 48),
      ),
    ),
  );
}
''',
    ),
  ],
  'dot_indicator': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_dotIndicatorDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/dot_indicator/dot_indicator.dart';

/// Horizontal dots the example taps through.
class _DotIndicatorHorizontalDots extends StatefulWidget {
  const _DotIndicatorHorizontalDots();

  @override
  State<_DotIndicatorHorizontalDots> createState() =>
      _DotIndicatorHorizontalDotsState();
}

class _DotIndicatorHorizontalDotsState
    extends State<_DotIndicatorHorizontalDots> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DotIndicator(
          index: _index,
          length: 5,
          onChanged: (int value) => setState(() => _index = value),
        ),
        Gap(theme.spacing.md),
        Text(
          'index $_index',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
        Gap(theme.spacing.md),
        DotIndicator(index: 1, length: 5),
        Gap(theme.spacing.sm),
        Text(
          'read-only (no click cursor, no tap target)',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _dotIndicatorDefault(BuildContext context) =>
    const _DotIndicatorHorizontalDots();
''',
    ),
    DocsExampleSource(
      name: 'Vertical',
      builder: '_dotIndicatorVertical',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/dot_indicator/dot_indicator.dart';

/// Vertical dots beside the horizontal ones.
class _DotIndicatorVerticalDots extends StatefulWidget {
  const _DotIndicatorVerticalDots();

  @override
  State<_DotIndicatorVerticalDots> createState() =>
      _DotIndicatorVerticalDotsState();
}

class _DotIndicatorVerticalDotsState extends State<_DotIndicatorVerticalDots> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        DotIndicator(
          index: _index,
          length: 3,
          direction: Axis.vertical,
          onChanged: (int value) => setState(() => _index = value),
        ),
        Gap(theme.spacing.xl),
        DotIndicator(
          index: 1,
          length: 3,
          direction: Axis.vertical,
          onChanged: (int value) => setState(() => _index = value),
        ),
      ],
    );
  }
}

Widget _dotIndicatorVertical(BuildContext context) =>
    const _DotIndicatorVerticalDots();
''',
    ),
    DocsExampleSource(
      name: 'Themed dots',
      builder: '_dotIndicatorThemed',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/dot_indicator/dot_indicator.dart';

/// A scoped theme leg: bigger accent dots.
class _DotIndicatorThemed extends StatefulWidget {
  const _DotIndicatorThemed();

  @override
  State<_DotIndicatorThemed> createState() => _DotIndicatorThemedState();
}

class _DotIndicatorThemedState extends State<_DotIndicatorThemed> {
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ComponentTheme<DotIndicatorTheme>(
          data: const DotIndicatorTheme(
            active: DotStyle(
              background: StateValue(rest: ThemedColor.ref(ColorRef.accent)),
              size: 18,
            ),
            spacing: 14,
          ),
          child: DotIndicator(
            index: _index,
            length: 5,
            onChanged: (int value) => setState(() => _index = value),
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          'index $_index',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _dotIndicatorThemed(BuildContext context) => const _DotIndicatorThemed();
''',
    ),
  ],
  'text_animate': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/text_animate/text_animate.dart';

String _sample = 'Ship a new build to production.';

/// Opacity-only entrance.
Widget _default(BuildContext context) {
  return TextAnimate(text: _sample, effect: TextAnimateEffect.fade());
}
''',
    ),
    DocsExampleSource(
      name: 'Slide',
      builder: '_slide',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/text_animate/text_animate.dart';

String _sample = 'Ship a new build to production.';

/// Vertical slide entrance.
Widget _slide(BuildContext context) {
  return TextAnimate(text: _sample, effect: TextAnimateEffect.slide());
}
''',
    ),
    DocsExampleSource(
      name: 'Blur',
      builder: '_blur',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/text_animate/text_animate.dart';

String _sample = 'Ship a new build to production.';

/// Blur-to-sharp entrance.
Widget _blur(BuildContext context) {
  return TextAnimate(text: _sample, effect: TextAnimateEffect.blur());
}
''',
    ),
    DocsExampleSource(
      name: 'Scramble',
      builder: '_scramble',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/text_animate/text_animate.dart';

String _sample = 'Ship a new build to production.';

/// Scramble-then-resolve entrance.
Widget _scramble(BuildContext context) {
  return TextAnimate(text: _sample, effect: TextAnimateEffect.scramble());
}
''',
    ),
    DocsExampleSource(
      name: 'Words',
      builder: '_words',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/text_animate/text_animate.dart';

String _sample = 'Ship a new build to production.';

/// Word-by-word slide with a blinking cursor.
Widget _words(BuildContext context) {
  return TextAnimate(
    text: _sample,
    animateByWord: true,
    effect: TextAnimateEffect.slide(),
    cursor: TextAnimateCursor.blink(),
  );
}
''',
    ),
  ],
  'button': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_buttonDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/button/preview_status.dart';

/// One button whose label counts the presses the example owns.
class _PressableButton extends StatefulWidget {
  const _PressableButton({
    required this.label,
    this.variant = ButtonVariant.primary,
  });

  final String label;
  final ButtonVariant variant;

  @override
  State<_PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<_PressableButton> {
  int _presses = 0;

  @override
  Widget build(BuildContext context) {
    final String localizedLabel = widget.label;
    return Align(
      alignment: Alignment.center,
      child: Button(
        variant: widget.variant,
        onPressed: () => setState(() => _presses++),
        child: Text(
          _presses == 0 ? localizedLabel : '$localizedLabel · $_presses',
        ),
      ),
    );
  }
}

/// One variant demo, centred with its press count in the label.
Widget _buttonExample(
  BuildContext context,
  ButtonVariant variant,
  String label,
) {
  return _PressableButton(variant: variant, label: label);
}

Widget _buttonDefault(BuildContext context) =>
    _buttonExample(context, ButtonVariant.primary, 'Button');
''',
    ),
    DocsExampleSource(
      name: 'Secondary',
      builder: '_buttonSecondary',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/button/preview_status.dart';

/// One button whose label counts the presses the example owns.
class _PressableButton extends StatefulWidget {
  const _PressableButton({
    required this.label,
    this.variant = ButtonVariant.primary,
  });

  final String label;
  final ButtonVariant variant;

  @override
  State<_PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<_PressableButton> {
  int _presses = 0;

  @override
  Widget build(BuildContext context) {
    final String localizedLabel = widget.label;
    return Align(
      alignment: Alignment.center,
      child: Button(
        variant: widget.variant,
        onPressed: () => setState(() => _presses++),
        child: Text(
          _presses == 0 ? localizedLabel : '$localizedLabel · $_presses',
        ),
      ),
    );
  }
}

/// One variant demo, centred with its press count in the label.
Widget _buttonExample(
  BuildContext context,
  ButtonVariant variant,
  String label,
) {
  return _PressableButton(variant: variant, label: label);
}

Widget _buttonSecondary(BuildContext context) => _buttonExample(
  context,
  ButtonVariant.secondary,
  'Secondary',
);
''',
    ),
    DocsExampleSource(
      name: 'Outline',
      builder: '_buttonOutline',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/button/preview_status.dart';

/// One button whose label counts the presses the example owns.
class _PressableButton extends StatefulWidget {
  const _PressableButton({
    required this.label,
    this.variant = ButtonVariant.primary,
  });

  final String label;
  final ButtonVariant variant;

  @override
  State<_PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<_PressableButton> {
  int _presses = 0;

  @override
  Widget build(BuildContext context) {
    final String localizedLabel = widget.label;
    return Align(
      alignment: Alignment.center,
      child: Button(
        variant: widget.variant,
        onPressed: () => setState(() => _presses++),
        child: Text(
          _presses == 0 ? localizedLabel : '$localizedLabel · $_presses',
        ),
      ),
    );
  }
}

/// One variant demo, centred with its press count in the label.
Widget _buttonExample(
  BuildContext context,
  ButtonVariant variant,
  String label,
) {
  return _PressableButton(variant: variant, label: label);
}

Widget _buttonOutline(BuildContext context) => _buttonExample(
  context,
  ButtonVariant.outline,
  'Outline',
);
''',
    ),
    DocsExampleSource(
      name: 'Ghost',
      builder: '_buttonGhost',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/button/preview_status.dart';

/// One button whose label counts the presses the example owns.
class _PressableButton extends StatefulWidget {
  const _PressableButton({
    required this.label,
    this.variant = ButtonVariant.primary,
  });

  final String label;
  final ButtonVariant variant;

  @override
  State<_PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<_PressableButton> {
  int _presses = 0;

  @override
  Widget build(BuildContext context) {
    final String localizedLabel = widget.label;
    return Align(
      alignment: Alignment.center,
      child: Button(
        variant: widget.variant,
        onPressed: () => setState(() => _presses++),
        child: Text(
          _presses == 0 ? localizedLabel : '$localizedLabel · $_presses',
        ),
      ),
    );
  }
}

/// One variant demo, centred with its press count in the label.
Widget _buttonExample(
  BuildContext context,
  ButtonVariant variant,
  String label,
) {
  return _PressableButton(variant: variant, label: label);
}

Widget _buttonGhost(BuildContext context) =>
    _buttonExample(context, ButtonVariant.ghost, 'Ghost');
''',
    ),
    DocsExampleSource(
      name: 'Link',
      builder: '_buttonLink',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/button/preview_status.dart';

/// One button whose label counts the presses the example owns.
class _PressableButton extends StatefulWidget {
  const _PressableButton({
    required this.label,
    this.variant = ButtonVariant.primary,
  });

  final String label;
  final ButtonVariant variant;

  @override
  State<_PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<_PressableButton> {
  int _presses = 0;

  @override
  Widget build(BuildContext context) {
    final String localizedLabel = widget.label;
    return Align(
      alignment: Alignment.center,
      child: Button(
        variant: widget.variant,
        onPressed: () => setState(() => _presses++),
        child: Text(
          _presses == 0 ? localizedLabel : '$localizedLabel · $_presses',
        ),
      ),
    );
  }
}

/// One variant demo, centred with its press count in the label.
Widget _buttonExample(
  BuildContext context,
  ButtonVariant variant,
  String label,
) {
  return _PressableButton(variant: variant, label: label);
}

Widget _buttonLink(BuildContext context) =>
    _buttonExample(context, ButtonVariant.link, 'Link');
''',
    ),
    DocsExampleSource(
      name: 'Destructive',
      builder: '_buttonDestructive',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/button/preview_status.dart';

/// One button whose label counts the presses the example owns.
class _PressableButton extends StatefulWidget {
  const _PressableButton({
    required this.label,
    this.variant = ButtonVariant.primary,
  });

  final String label;
  final ButtonVariant variant;

  @override
  State<_PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<_PressableButton> {
  int _presses = 0;

  @override
  Widget build(BuildContext context) {
    final String localizedLabel = widget.label;
    return Align(
      alignment: Alignment.center,
      child: Button(
        variant: widget.variant,
        onPressed: () => setState(() => _presses++),
        child: Text(
          _presses == 0 ? localizedLabel : '$localizedLabel · $_presses',
        ),
      ),
    );
  }
}

/// One variant demo, centred with its press count in the label.
Widget _buttonExample(
  BuildContext context,
  ButtonVariant variant,
  String label,
) {
  return _PressableButton(variant: variant, label: label);
}

Widget _buttonDestructive(BuildContext context) => _buttonExample(
  context,
  ButtonVariant.destructive,
  'Delete',
);
''',
    ),
    DocsExampleSource(
      name: 'Icon',
      builder: '_buttonIcon',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/button/preview_status.dart';

/// Icon-only button (upstream `size="icon"`) with the press count beside it.
class _ButtonIcon extends StatefulWidget {
  const _ButtonIcon();

  @override
  State<_ButtonIcon> createState() => _ButtonIconState();
}

class _ButtonIconState extends State<_ButtonIcon> {
  int _presses = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Button(
          size: ButtonSize.icon,
          variant: ButtonVariant.outline,
          onPressed: () => setState(() => _presses++),
          child: const Icon(LucideIcons.settings, size: 16),
        ),
        Gap(theme.spacing.md),
        // Truncate on narrow touch viewports instead of overflowing the row.
        Flexible(
          child: Text(
            _presses == 0
                ? 'not pressed yet'
                : 'pressed $_presses time(s)',
            style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

Widget _buttonIcon(BuildContext context) => const _ButtonIcon();
''',
    ),
    DocsExampleSource(
      name: 'With icon',
      builder: '_buttonWithIcon',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/button/preview_status.dart';

/// Leading and trailing icon buttons; both report the press below the row.
class _ButtonWithIcon extends StatefulWidget {
  const _ButtonWithIcon();

  @override
  State<_ButtonWithIcon> createState() => _ButtonWithIconState();
}

class _ButtonWithIconState extends State<_ButtonWithIcon> {
  String _last = 'not pressed yet';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Wrap(
          spacing: theme.spacing.md,
          runSpacing: theme.spacing.sm,
          children: <Widget>[
            Button(
              leading: const Icon(LucideIcons.plus, size: 16),
              onPressed: () => setState(
                () => _last = 'Add item pressed',
              ),
              child: Text('Add item'),
            ),
            Button(
              variant: ButtonVariant.outline,
              trailing: const Icon(LucideIcons.chevronRight, size: 16),
              onPressed: () =>
                  setState(() => _last = 'Next pressed'),
              child: Text('Next'),
            ),
          ],
        ),
        Gap(theme.spacing.sm),
        Text(
          _last,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _buttonWithIcon(BuildContext context) => const _ButtonWithIcon();
''',
    ),
    DocsExampleSource(
      name: 'Sizes',
      builder: '_buttonSizes',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/button/preview_status.dart';

/// The size scale in one row (upstream shows the sizes together).
class _ButtonSizes extends StatefulWidget {
  const _ButtonSizes();

  @override
  State<_ButtonSizes> createState() => _ButtonSizesState();
}

class _ButtonSizesState extends State<_ButtonSizes> {
  String _last = 'not pressed yet';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            for (final ButtonSize size in ButtonSize.values)
              if (size != ButtonSize.icon)
                Button(
                  size: size,
                  onPressed: () =>
                      setState(() => _last = '${size.name} button pressed'),
                  child: Text(size.name),
                ),
          ],
        ),
        Gap(theme.spacing.sm),
        Text(
          _last,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _buttonSizes(BuildContext context) => const _ButtonSizes();
''',
    ),
    DocsExampleSource(
      name: 'Loading',
      builder: '_buttonLoading',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/button/preview_status.dart';

Widget _buttonLoading(BuildContext context) => const ButtonLoadingPreview();
''',
    ),
    DocsExampleSource(
      name: 'Async (success)',
      builder: '_buttonAsyncSuccess',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/button/preview_status.dart';

Widget _buttonAsyncSuccess(BuildContext context) =>
    const ButtonAsyncSuccessPreview();
''',
    ),
    DocsExampleSource(
      name: 'Async (failure)',
      builder: '_buttonAsyncFailure',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/button/preview_status.dart';

Widget _buttonAsyncFailure(BuildContext context) =>
    const ButtonAsyncFailurePreview();
''',
    ),
    DocsExampleSource(
      name: 'Controlled status',
      builder: '_buttonControlledStatus',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/button/preview_status.dart';

Widget _buttonControlledStatus(BuildContext context) =>
    const ButtonControlledStatusPreview();
''',
    ),
    DocsExampleSource(
      name: 'Disabled',
      builder: '_buttonDisabled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/button/preview_status.dart';

/// A disabled button.
Widget _buttonDisabled(BuildContext context) {
  return Align(
    alignment: Alignment.center,
    child: Button(enabled: false, child: Text('Disabled')),
  );
}
''',
    ),
  ],
  'fab': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_fabDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/fab/fab.dart';

/// The default example: one round floating action button.
///
/// md standard: 56 px box, 20 px icon, shadowLg from the theme tokens.
Widget _fabDefault(BuildContext context) {
  return Center(
    child: Fab(
      icon: Icon(LucideIcons.plus),
      onPressed: _noop,
      semanticLabel: 'Add item',
      tooltip: 'Add item',
    ),
  );
}

void _noop() {}
''',
    ),
    DocsExampleSource(
      name: 'Sizes',
      builder: '_fabSizes',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/fab/fab.dart';

void _noop() {}

/// The three fixed sizes, side by side (standard 40/56/64, icons 16/20/24).
Widget _fabSizes(BuildContext context) {
  final double spacing = Theme.of(context).spacing.md;
  return Center(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Fab(
          icon: Icon(LucideIcons.plus),
          size: FabSize.sm,
          onPressed: _noop,
          semanticLabel: 'Add item (small)',
        ),
        Gap(spacing),
        Fab(
          icon: Icon(LucideIcons.plus),
          size: FabSize.md,
          onPressed: _noop,
          semanticLabel: 'Add item (regular)',
        ),
        Gap(spacing),
        Fab(
          icon: Icon(LucideIcons.plus),
          size: FabSize.lg,
          onPressed: _noop,
          semanticLabel: 'Add item (large)',
        ),
      ],
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Extended',
      builder: '_fabExtended',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/fab/fab.dart';

void _noop() {}

/// The extended (pill) shape with a label.
///
/// Label: 14 px semibold from the tokens; icon-label gap 8 px from the
/// tokens; pill radius follows the box.
Widget _fabExtended(BuildContext context) {
  return Center(
    child: Fab(
      icon: Icon(LucideIcons.pencil),
      label: Text('Compose'),
      onPressed: _noop,
      semanticLabel: 'Compose',
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Mini sizes',
      builder: '_fabMiniSizes',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/fab/fab.dart';

void _noop() {}

/// The mini sizes used by the speed dial, with token captions.
Widget _fabMiniSizes(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  final double spacing = theme.spacing.md;
  return Center(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Fab(
          icon: Icon(LucideIcons.plus),
          shape: FabShape.mini,
          size: FabSize.sm,
          onPressed: _noop,
          semanticLabel: 'Mini (32)',
        ),
        Gap(spacing),
        Fab(
          icon: Icon(LucideIcons.plus),
          shape: FabShape.mini,
          size: FabSize.md,
          onPressed: _noop,
          semanticLabel: 'Mini (40)',
        ),
        Gap(spacing),
        Fab(
          icon: Icon(LucideIcons.plus),
          shape: FabShape.mini,
          size: FabSize.lg,
          onPressed: _noop,
          semanticLabel: 'Mini (48)',
        ),
      ],
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Speed dial',
      builder: '_fabSpeedDial',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/fab/fab.dart';

void _noop() {}

/// The speed dial: a main button that unfolds three mini actions.
class _FabSpeedDialExample extends StatefulWidget {
  const _FabSpeedDialExample();

  @override
  State<_FabSpeedDialExample> createState() => _FabSpeedDialExampleState();
}

class _FabSpeedDialExampleState extends State<_FabSpeedDialExample> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FabSpeedDial(
        icon: const Icon(LucideIcons.plus),
        expanded: _expanded,
        onExpandedChanged: (bool value) => setState(() => _expanded = value),
        semanticLabel: 'Create',
        tooltip: 'Create',
        actions: <FabSpeedDialAction>[
          FabSpeedDialAction(
            icon: const Icon(LucideIcons.fileText),
            onPressed: _noop,
            tooltip: 'New document',
            semanticLabel: 'New document',
          ),
          FabSpeedDialAction(
            icon: const Icon(LucideIcons.image),
            onPressed: _noop,
            tooltip: 'New image',
            semanticLabel: 'New image',
          ),
          FabSpeedDialAction(
            icon: const Icon(LucideIcons.camera),
            onPressed: _noop,
            tooltip: 'Take a photo',
            semanticLabel: 'Take a photo',
          ),
        ],
      ),
    );
  }
}

Widget _fabSpeedDial(BuildContext context) => const _FabSpeedDialExample();
''',
    ),
    DocsExampleSource(
      name: 'Positions',
      builder: '_fabPositions',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/fab/fab.dart';

void _noop() {}

/// The positions helper: the same button in four anchor positions.
Widget _fabPositions(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  return Center(
    child: SizedBox(
      width: 260,
      height: 200,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colors.muted.withValues(alpha: 0.4),
          borderRadius: theme.borderRadiusLg,
        ),
        child: Stack(
          children: <Widget>[
            FabPositioner(
              position: FabPosition.topStart,
              child: Fab(
                icon: Icon(LucideIcons.heart),
                size: FabSize.sm,
                onPressed: _noop,
                semanticLabel: 'Favourite',
              ),
            ),
            FabPositioner(
              position: FabPosition.topEnd,
              child: Fab(
                icon: Icon(LucideIcons.share),
                size: FabSize.sm,
                onPressed: _noop,
                semanticLabel: 'Share',
              ),
            ),
            FabPositioner(
              position: FabPosition.bottomStart,
              child: Fab(
                icon: Icon(LucideIcons.trash),
                size: FabSize.sm,
                onPressed: _noop,
                semanticLabel: 'Delete',
              ),
            ),
            FabPositioner(
              position: FabPosition.bottomEnd,
              child: Fab(
                icon: Icon(LucideIcons.settings),
                size: FabSize.sm,
                onPressed: _noop,
                semanticLabel: 'Settings',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Hide on scroll',
      builder: '_fabHideOnScroll',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/fab/fab.dart';

void _noop() {}

/// Hide on scroll: the button slides away while the list scrolls down.
class _FabHideOnScrollExample extends StatefulWidget {
  const _FabHideOnScrollExample();

  @override
  State<_FabHideOnScrollExample> createState() =>
      _FabHideOnScrollExampleState();
}

class _FabHideOnScrollExampleState extends State<_FabHideOnScrollExample> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: SizedBox(
        width: 280,
        height: 220,
        child: Stack(
          children: <Widget>[
            ListView.builder(
              controller: _controller,
              padding: EdgeInsets.all(theme.spacing.md),
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: theme.spacing.sm),
                  child: Text('Row ${index + 1}'),
                );
              },
            ),
            Positioned(
              right: theme.spacing.md,
              bottom: theme.spacing.md,
              child: FabHideOnScroll(
                controller: _controller,
                child: Fab(
                  icon: Icon(LucideIcons.plus),
                  size: FabSize.sm,
                  onPressed: _noop,
                  semanticLabel: 'Add item',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _fabHideOnScroll(BuildContext context) =>
    const _FabHideOnScrollExample();
''',
    ),
    DocsExampleSource(
      name: 'Customized',
      builder: '_fabCustomized',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/fab/fab.dart';

void _noop() {}

/// A customised button: secondary fill, custom radius and token shadow.
///
/// Extended 56 px pill with a 16 px icon plus label; elevation 3 paints the
/// theme shadowLg so the button lifts off the stage instead of looking flat.
Widget _fabCustomized(BuildContext context) {
  return Center(
    child: Fab(
      icon: Icon(LucideIcons.zap),
      label: Text('Launch'),
      onPressed: _noop,
      semanticLabel: 'Launch',
      style: FabStyle(
        background: StateValue(rest: ThemedColor.ref(ColorRef.secondary)),
        foreground: StateValue(
          rest: ThemedColor.ref(ColorRef.secondaryForeground),
        ),
        borderRadius: BorderRadius.all(Radius.circular(16)),
        elevation: 3,
        gap: 8,
      ),
    ),
  );
}
''',
    ),
  ],
  'toggle': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_toggleDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/toggle/toggle.dart';

/// Controlled toggle: the example owns the value.
class _ToggleControlledToggle extends StatelessWidget {
  const _ToggleControlledToggle();

  @override
  Widget build(BuildContext context) {
    // P7-TH1: centred so the docs stage (and the centred-example audit)
    // sees the toggle in the middle of the stage, not pinned left.
    return const Align(
      alignment: Alignment.center,
      child: _ToggleControlledInner(),
    );
  }
}

class _ToggleControlledInner extends StatefulWidget {
  const _ToggleControlledInner();

  @override
  State<_ToggleControlledInner> createState() => _ToggleControlledInnerState();
}

class _ToggleControlledInnerState extends State<_ToggleControlledInner> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Toggle(
      value: _value,
      onChanged: (bool value) => setState(() => _value = value),
      child: Text(_value ? 'On' : 'Off'),
    );
  }
}

Widget _toggleDefault(BuildContext context) => const _ToggleControlledToggle();
''',
    ),
    DocsExampleSource(
      name: 'Group',
      builder: '_toggleGroup',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/toggle/toggle.dart';

/// A toggle group: one control per member, `gap-3` between the members.
class _ToggleGroup extends StatefulWidget {
  const _ToggleGroup();

  @override
  State<_ToggleGroup> createState() => _ToggleGroupState();
}

class _ToggleGroupState extends State<_ToggleGroup> {
  final Set<String> _active = <String>{'bold'};

  static const List<(String, IconData)> _members = <(String, IconData)>[
    ('bold', LucideIcons.bold),
    ('italic', LucideIcons.italic),
    ('underline', LucideIcons.underline),
  ];

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: spacing.md,
      children: <Widget>[
        for (final (String name, IconData icon) in _members)
          Toggle(
            value: _active.contains(name),
            onChanged: (bool value) => setState(() {
              if (value) {
                _active.add(name);
              } else {
                _active.remove(name);
              }
            }),
            child: Icon(icon, size: 16),
          ),
      ],
    );
  }
}

Widget _toggleGroup(BuildContext context) => const _ToggleGroup();
''',
    ),
    DocsExampleSource(
      name: 'Controller',
      builder: '_toggleController',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/toggle/toggle.dart';

/// Controller-driven toggles: the [ToggleController] is created inside this
/// state, so two examples can never attach one controller twice.
class _ToggleControllerToggle extends StatefulWidget {
  const _ToggleControllerToggle();

  @override
  State<_ToggleControllerToggle> createState() =>
      _ToggleControllerToggleState();
}

class _ToggleControllerToggleState extends State<_ToggleControllerToggle> {
  final ToggleController _toggleController = ToggleController();

  @override
  void dispose() {
    _toggleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Toggle(
          controller: _toggleController,
          child: Text('Controller'),
        ),
        Gap(spacing.md),
        Toggle(
          controller: _toggleController,
          child: const Icon(LucideIcons.bell, size: 16),
        ),
      ],
    );
  }
}

Widget _toggleController(BuildContext context) =>
    const _ToggleControllerToggle();
''',
    ),
    DocsExampleSource(
      name: 'Disabled',
      builder: '_toggleDisabled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/toggle/toggle.dart';

/// Disabled toggles in both states.
Widget _toggleDisabled(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Toggle(value: true, child: Text('On')),
      Gap(spacing.md),
      Toggle(value: false, onChanged: null, child: Text('Off')),
    ],
  );
}
''',
    ),
  ],
  'toolbar': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_toolbarDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/toolbar/toolbar.dart';

/// The default example: a horizontal row of actions.
Widget _toolbarDefault(BuildContext context) {
  return Center(
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
''',
    ),
    DocsExampleSource(
      name: 'Vertical',
      builder: '_toolbarVertical',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/toolbar/toolbar.dart';

/// A vertical toolbar (a rail).
Widget _toolbarVertical(BuildContext context) {
  return Center(
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
''',
    ),
    DocsExampleSource(
      name: 'Groups',
      builder: '_toolbarGroups',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/toolbar/toolbar.dart';

/// Groups and separators.
Widget _toolbarGroups(BuildContext context) {
  return Center(
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
''',
    ),
    DocsExampleSource(
      name: 'Toggles',
      builder: '_toolbarToggles',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/toolbar/toolbar.dart';

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
          ToolbarItem(
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
''',
    ),
    DocsExampleSource(
      name: 'Overflow',
      builder: '_toolbarOverflow',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/toolbar/toolbar.dart';

/// The overflow menu: the toolbar is narrower than its items.
Widget _toolbarOverflow(BuildContext context) {
  return Center(
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
''',
    ),
    DocsExampleSource(
      name: 'Customized',
      builder: '_toolbarCustomized',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/toolbar/toolbar.dart';

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
''',
    ),
  ],
  'color_picker': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_colorPickerDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/color/color.dart';
import 'package:<your_app>/ui/dashcn/components/eye_dropper/eye_dropper.dart';
import 'package:<your_app>/ui/dashcn/components/history/history.dart';
import 'package:<your_app>/ui/dashcn/components/color_picker/color_picker.dart';

/// The colour every example starts from.
const Color _colorPickerInitial = Color(0xFF2563EB);

/// Recent colours the history button replays.
const List<Color> _colorPickerRecent = <Color>[
  Color(0xFF2563EB),
  Color(0xFF22C55E),
  Color(0xFFE11D48),
];

/// One picker; owns the value it edits.
class _ColorPickerPicker extends StatefulWidget {
  const _ColorPickerPicker({
    this.showAlpha = false,
    this.showHistoryButton = false,
    this.initialMode = ColorPickerMode.rgb,
  });

  final bool showAlpha;
  final bool showHistoryButton;
  final ColorPickerMode initialMode;

  @override
  State<_ColorPickerPicker> createState() => _ColorPickerPickerState();
}

class _ColorPickerPickerState extends State<_ColorPickerPicker> {
  ColorDerivative _value = ColorDerivative.fromColor(_colorPickerInitial);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 280,
        child: EyeDropperLayer(
          child: RecentColorsScope(
            initialRecentColors: _colorPickerRecent,
            child: ColorPicker(
              value: _value,
              showAlpha: widget.showAlpha,
              showHistoryButton: widget.showHistoryButton,
              initialMode: widget.initialMode,
              onChanging: (ColorDerivative value) =>
                  setState(() => _value = value),
              onChanged: (ColorDerivative value) =>
                  setState(() => _value = value),
            ),
          ),
        ),
      ),
    );
  }
}

/// The default vertical picker in RGB mode.
Widget _colorPickerDefault(BuildContext context) => const _ColorPickerPicker();
''',
    ),
    DocsExampleSource(
      name: 'With alpha',
      builder: '_colorPickerAlpha',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/color/color.dart';
import 'package:<your_app>/ui/dashcn/components/eye_dropper/eye_dropper.dart';
import 'package:<your_app>/ui/dashcn/components/history/history.dart';
import 'package:<your_app>/ui/dashcn/components/color_picker/color_picker.dart';

/// The colour every example starts from.
const Color _colorPickerInitial = Color(0xFF2563EB);

/// Recent colours the history button replays.
const List<Color> _colorPickerRecent = <Color>[
  Color(0xFF2563EB),
  Color(0xFF22C55E),
  Color(0xFFE11D48),
];

/// One picker; owns the value it edits.
class _ColorPickerPicker extends StatefulWidget {
  const _ColorPickerPicker({
    this.showAlpha = false,
    this.showHistoryButton = false,
    this.initialMode = ColorPickerMode.rgb,
  });

  final bool showAlpha;
  final bool showHistoryButton;
  final ColorPickerMode initialMode;

  @override
  State<_ColorPickerPicker> createState() => _ColorPickerPickerState();
}

class _ColorPickerPickerState extends State<_ColorPickerPicker> {
  ColorDerivative _value = ColorDerivative.fromColor(_colorPickerInitial);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 280,
        child: EyeDropperLayer(
          child: RecentColorsScope(
            initialRecentColors: _colorPickerRecent,
            child: ColorPicker(
              value: _value,
              showAlpha: widget.showAlpha,
              showHistoryButton: widget.showHistoryButton,
              initialMode: widget.initialMode,
              onChanging: (ColorDerivative value) =>
                  setState(() => _value = value),
              onChanged: (ColorDerivative value) =>
                  setState(() => _value = value),
            ),
          ),
        ),
      ),
    );
  }
}

/// The picker with the alpha row shown.
Widget _colorPickerAlpha(BuildContext context) =>
    const _ColorPickerPicker(showAlpha: true);
''',
    ),
    DocsExampleSource(
      name: 'HSL',
      builder: '_colorPickerHsl',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/color/color.dart';
import 'package:<your_app>/ui/dashcn/components/eye_dropper/eye_dropper.dart';
import 'package:<your_app>/ui/dashcn/components/history/history.dart';
import 'package:<your_app>/ui/dashcn/components/color_picker/color_picker.dart';

/// The colour every example starts from.
const Color _colorPickerInitial = Color(0xFF2563EB);

/// Recent colours the history button replays.
const List<Color> _colorPickerRecent = <Color>[
  Color(0xFF2563EB),
  Color(0xFF22C55E),
  Color(0xFFE11D48),
];

/// One picker; owns the value it edits.
class _ColorPickerPicker extends StatefulWidget {
  const _ColorPickerPicker({
    this.showAlpha = false,
    this.showHistoryButton = false,
    this.initialMode = ColorPickerMode.rgb,
  });

  final bool showAlpha;
  final bool showHistoryButton;
  final ColorPickerMode initialMode;

  @override
  State<_ColorPickerPicker> createState() => _ColorPickerPickerState();
}

class _ColorPickerPickerState extends State<_ColorPickerPicker> {
  ColorDerivative _value = ColorDerivative.fromColor(_colorPickerInitial);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 280,
        child: EyeDropperLayer(
          child: RecentColorsScope(
            initialRecentColors: _colorPickerRecent,
            child: ColorPicker(
              value: _value,
              showAlpha: widget.showAlpha,
              showHistoryButton: widget.showHistoryButton,
              initialMode: widget.initialMode,
              onChanging: (ColorDerivative value) =>
                  setState(() => _value = value),
              onChanged: (ColorDerivative value) =>
                  setState(() => _value = value),
            ),
          ),
        ),
      ),
    );
  }
}

/// HSL mode with the recent-colour history.
Widget _colorPickerHsl(BuildContext context) => const _ColorPickerPicker(
  initialMode: ColorPickerMode.hsl,
  showHistoryButton: true,
);
''',
    ),
    DocsExampleSource(
      name: 'HSV',
      builder: '_colorPickerHsv',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/color/color.dart';
import 'package:<your_app>/ui/dashcn/components/eye_dropper/eye_dropper.dart';
import 'package:<your_app>/ui/dashcn/components/history/history.dart';
import 'package:<your_app>/ui/dashcn/components/color_picker/color_picker.dart';

/// The colour every example starts from.
const Color _colorPickerInitial = Color(0xFF2563EB);

/// Recent colours the history button replays.
const List<Color> _colorPickerRecent = <Color>[
  Color(0xFF2563EB),
  Color(0xFF22C55E),
  Color(0xFFE11D48),
];

/// One picker; owns the value it edits.
class _ColorPickerPicker extends StatefulWidget {
  const _ColorPickerPicker({
    this.showAlpha = false,
    this.showHistoryButton = false,
    this.initialMode = ColorPickerMode.rgb,
  });

  final bool showAlpha;
  final bool showHistoryButton;
  final ColorPickerMode initialMode;

  @override
  State<_ColorPickerPicker> createState() => _ColorPickerPickerState();
}

class _ColorPickerPickerState extends State<_ColorPickerPicker> {
  ColorDerivative _value = ColorDerivative.fromColor(_colorPickerInitial);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 280,
        child: EyeDropperLayer(
          child: RecentColorsScope(
            initialRecentColors: _colorPickerRecent,
            child: ColorPicker(
              value: _value,
              showAlpha: widget.showAlpha,
              showHistoryButton: widget.showHistoryButton,
              initialMode: widget.initialMode,
              onChanging: (ColorDerivative value) =>
                  setState(() => _value = value),
              onChanged: (ColorDerivative value) =>
                  setState(() => _value = value),
            ),
          ),
        ),
      ),
    );
  }
}

/// HSV mode.
Widget _colorPickerHsv(BuildContext context) =>
    const _ColorPickerPicker(initialMode: ColorPickerMode.hsv);
''',
    ),
    DocsExampleSource(
      name: 'HEX',
      builder: '_colorPickerHex',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/color/color.dart';
import 'package:<your_app>/ui/dashcn/components/eye_dropper/eye_dropper.dart';
import 'package:<your_app>/ui/dashcn/components/history/history.dart';
import 'package:<your_app>/ui/dashcn/components/color_picker/color_picker.dart';

/// The colour every example starts from.
const Color _colorPickerInitial = Color(0xFF2563EB);

/// Recent colours the history button replays.
const List<Color> _colorPickerRecent = <Color>[
  Color(0xFF2563EB),
  Color(0xFF22C55E),
  Color(0xFFE11D48),
];

/// One picker; owns the value it edits.
class _ColorPickerPicker extends StatefulWidget {
  const _ColorPickerPicker({
    this.showAlpha = false,
    this.showHistoryButton = false,
    this.initialMode = ColorPickerMode.rgb,
  });

  final bool showAlpha;
  final bool showHistoryButton;
  final ColorPickerMode initialMode;

  @override
  State<_ColorPickerPicker> createState() => _ColorPickerPickerState();
}

class _ColorPickerPickerState extends State<_ColorPickerPicker> {
  ColorDerivative _value = ColorDerivative.fromColor(_colorPickerInitial);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 280,
        child: EyeDropperLayer(
          child: RecentColorsScope(
            initialRecentColors: _colorPickerRecent,
            child: ColorPicker(
              value: _value,
              showAlpha: widget.showAlpha,
              showHistoryButton: widget.showHistoryButton,
              initialMode: widget.initialMode,
              onChanging: (ColorDerivative value) =>
                  setState(() => _value = value),
              onChanged: (ColorDerivative value) =>
                  setState(() => _value = value),
            ),
          ),
        ),
      ),
    );
  }
}

/// HEX mode.
Widget _colorPickerHex(BuildContext context) =>
    const _ColorPickerPicker(initialMode: ColorPickerMode.hex);
''',
    ),
    DocsExampleSource(
      name: 'Eye dropper',
      builder: '_colorPickerEyeDropper',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/color/color.dart';
import 'package:<your_app>/ui/dashcn/components/eye_dropper/eye_dropper.dart';
import 'package:<your_app>/ui/dashcn/components/history/history.dart';
import 'package:<your_app>/ui/dashcn/components/color_picker/color_picker.dart';

/// The colour every example starts from.
const Color _colorPickerInitial = Color(0xFF2563EB);

/// Recent colours the history button replays.
const List<Color> _colorPickerRecent = <Color>[
  Color(0xFF2563EB),
  Color(0xFF22C55E),
  Color(0xFFE11D48),
];

/// Eye-dropper sampling: a known painted scene (primary / success / danger
/// swatches) above the picker. Inside the docs app the session delegates to
/// the app-root layer, so the loupe follows the pointer across the whole
/// window and the pad, hue/alpha bars and hex field update live while moving.
// Click commits, Escape or right-click cancels and restores the colour.
class _ColorPickerEyeDropper extends StatefulWidget {
  const _ColorPickerEyeDropper();

  @override
  State<_ColorPickerEyeDropper> createState() => _ColorPickerEyeDropperState();
}

class _ColorPickerEyeDropperState extends State<_ColorPickerEyeDropper> {
  ColorDerivative _value = ColorDerivative.fromColor(_colorPickerInitial);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 280,
        child: EyeDropperLayer(
          child: RecentColorsScope(
            initialRecentColors: _colorPickerRecent,
            child: Builder(
              builder: (BuildContext context) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: const <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ColoredBox(color: Color(0xFFE11D48)),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ColoredBox(color: Color(0xFF22C55E)),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ColoredBox(color: Color(0xFF2563EB)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ColorPicker(
                    value: _value,
                    showAlpha: true,
                    onChanging: (ColorDerivative value) =>
                        setState(() => _value = value),
                    onChanged: (ColorDerivative value) =>
                        setState(() => _value = value),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The eye-dropper sampling demo.
Widget _colorPickerEyeDropper(BuildContext context) =>
    const _ColorPickerEyeDropper();
''',
    ),
  ],
  'avatar': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Image',
      builder: '_avatarImage',
      code: r'''import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/avatar/avatar.dart';

/// A 48x48 PNG decoded from memory: the preview never hits the network, so it
/// renders identically offline and inside a widget test.
const String _avatarPhotoBase64 =
    'iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAIAAADYYG7QAAAAWElEQVR42u3OoRGAMBBFwdPURBHoFIajKTS9hBL+ROTUzjz/ts7xxZ73js1x5eqIFRAQEBAQ0CKoczarYkBAQEBAQKugzhkQEBAQENAWUOMMCAgIC'
    'AhoQz/vbpR28UARAAAAAABJRU5ErkJggg==';

/// Local photo provider shared by the avatar examples.
final ImageProvider _avatarPhoto = MemoryImage(
  base64Decode(_avatarPhotoBase64),
);

/// A photo avatar, with the initials fallback next to it.
Widget _avatarImage(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Avatar(initials: 'IB', image: _avatarPhoto, size: 56),
      Gap(spacing.md),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Avatar(initials: 'AC', image: _avatarPhoto),
          Gap(spacing.sm),
          Avatar(initials: 'MK', image: _avatarPhoto, size: 40),
        ],
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Initials',
      builder: '_avatarInitials',
      code: r'''import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/avatar/avatar.dart';

/// Initials-only avatars at three sizes.
Widget _avatarInitials(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      const Avatar(initials: 'IB'),
      Gap(spacing.md),
      const Avatar(initials: 'AC', size: 40),
      Gap(spacing.md),
      const Avatar(initials: 'MK', size: 56),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Badge',
      builder: '_avatarBadge',
      code: r'''import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/avatar/avatar.dart';

/// An avatar carrying a status badge.
Widget _avatarBadge(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Avatar(
        initials: 'AC',
        badge: AvatarBadge(child: Icon(LucideIcons.check, size: 8)),
      ),
      Gap(spacing.md),
      const Avatar(
        initials: 'AC',
        badge: AvatarBadge(),
        badgeAlignment: AlignmentDirectional.topEnd,
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Group',
      builder: '_avatarGroup',
      code: r'''import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/avatar/avatar.dart';

/// A stack of avatars.
Widget _avatarGroup(BuildContext context) {
  return const AvatarGroup(
    children: <Widget>[
      Avatar(initials: 'IB'),
      Avatar(initials: 'AC'),
      Avatar(initials: 'MK'),
      Avatar(initials: '+4'),
    ],
  );
}
''',
    ),
  ],
  'badge': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_badgeDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/badge/badge.dart';

Widget _badgeExample(BuildContext context, BadgeVariant variant, String label) {
  final String localized = label;
  final String localizedWithIcon = '$label with icon';
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Badge(variant: variant, child: Text(localized)),
      Gap(Theme.of(context).spacing.md),
      Badge(
        variant: variant,
        leading: const Icon(LucideIcons.star, size: 12),
        child: Text(localizedWithIcon),
      ),
    ],
  );
}

Widget _badgeDefault(BuildContext context) => _badgeExample(
  context,
  BadgeVariant.primary,
  'Default',
);
''',
    ),
    DocsExampleSource(
      name: 'Secondary',
      builder: '_badgeSecondary',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/badge/badge.dart';

Widget _badgeExample(BuildContext context, BadgeVariant variant, String label) {
  final String localized = label;
  final String localizedWithIcon = '$label with icon';
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Badge(variant: variant, child: Text(localized)),
      Gap(Theme.of(context).spacing.md),
      Badge(
        variant: variant,
        leading: const Icon(LucideIcons.star, size: 12),
        child: Text(localizedWithIcon),
      ),
    ],
  );
}

Widget _badgeSecondary(BuildContext context) => _badgeExample(
  context,
  BadgeVariant.secondary,
  'Secondary',
);
''',
    ),
    DocsExampleSource(
      name: 'Outline',
      builder: '_badgeOutline',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/badge/badge.dart';

Widget _badgeExample(BuildContext context, BadgeVariant variant, String label) {
  final String localized = label;
  final String localizedWithIcon = '$label with icon';
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Badge(variant: variant, child: Text(localized)),
      Gap(Theme.of(context).spacing.md),
      Badge(
        variant: variant,
        leading: const Icon(LucideIcons.star, size: 12),
        child: Text(localizedWithIcon),
      ),
    ],
  );
}

Widget _badgeOutline(BuildContext context) => _badgeExample(
  context,
  BadgeVariant.outline,
  'Outline',
);
''',
    ),
    DocsExampleSource(
      name: 'Destructive',
      builder: '_badgeDestructive',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/badge/badge.dart';

Widget _badgeExample(BuildContext context, BadgeVariant variant, String label) {
  final String localized = label;
  final String localizedWithIcon = '$label with icon';
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Badge(variant: variant, child: Text(localized)),
      Gap(Theme.of(context).spacing.md),
      Badge(
        variant: variant,
        leading: const Icon(LucideIcons.star, size: 12),
        child: Text(localizedWithIcon),
      ),
    ],
  );
}

Widget _badgeDestructive(BuildContext context) => _badgeExample(
  context,
  BadgeVariant.destructive,
  'Destructive',
);
''',
    ),
  ],
  'carousel': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_carouselDefault',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/constants.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/dot_indicator/dot_indicator.dart';
import 'package:<your_app>/ui/dashcn/components/carousel/carousel.dart';

/// One numbered card slide.
Widget _slideCard(BuildContext context, int index) {
  final theme = Theme.of(context);
  return Container(
    decoration: BoxDecoration(
      color: theme.colors.card,
      border: Border.all(color: theme.colors.border),
      borderRadius: theme.borderRadiusLg,
    ),
    alignment: Alignment.center,
    child: Text(
      '${index + 1}',
      style: TextStyle(
        color: theme.colors.cardForeground,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// Shared working shell: viewport + prev/next + dots (+ optional counter).
class _CarouselShell extends StatefulWidget {
  const _CarouselShell({
    this.viewportFraction,
    this.gap,
    this.direction = Axis.horizontal,
    this.autoplay = false,
    this.showCounter = false,
  });

  final double? viewportFraction;
  final double? gap;
  final Axis direction;
  final bool autoplay;
  final bool showCounter;

  @override
  State<_CarouselShell> createState() => _CarouselShellState();
}

/// Slides per example.
const int _slideCount = 5;

class _CarouselShellState extends State<_CarouselShell> {
  final CarouselController _controller = CarouselController();
  final FocusNode _keys = FocusNode(debugLabel: 'CarouselShell');
  int _index = 0;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _playing = widget.autoplay;
  }

  @override
  void dispose() {
    _controller.dispose();
    _keys.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final int next = (_index + delta) % _slideCount < 0
        ? _slideCount - 1
        : (_index + delta) % _slideCount;
    _controller.animateTo(next.toDouble(), kDefaultDuration);
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.logicalKey == LogicalKeyboardKey.arrowDown) {
      _go(1);
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
        event.logicalKey == LogicalKeyboardKey.arrowUp) {
      _go(-1);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    final bool horizontal = widget.direction == Axis.horizontal;
    // The tap only moves keyboard focus into the viewport: excluded from
    // semantics so it never reports as an unlabeled action.
    final Widget viewport = ExcludeSemantics(
      child: GestureDetector(
        onTap: _keys.requestFocus,
        child: Focus(
          focusNode: _keys,
          onKeyEvent: _onKey,
          child: SizedBox(
            height: horizontal ? 160 : 280,
            child: Carousel(
              itemCount: _slideCount,
              controller: _controller,
              viewportFraction: widget.viewportFraction,
              gap: widget.gap,
              direction: widget.direction,
              autoplayInterval: _playing ? const Duration(seconds: 2) : null,
              onIndexChanged: (int index) => setState(() => _index = index),
              itemBuilder: _slideCard,
            ),
          ),
        ),
      ),
    );
    final Widget prev = Button(
      size: ButtonSize.icon,
      variant: ButtonVariant.outline,
      onPressed: () => _go(-1),
      child: Semantics(
        label: 'Previous',
        child: Icon(
          horizontal ? LucideIcons.chevronLeft : LucideIcons.chevronUp,
          size: 16,
        ),
      ),
    );
    final Widget next = Button(
      size: ButtonSize.icon,
      variant: ButtonVariant.outline,
      onPressed: () => _go(1),
      child: Semantics(
        label: 'Next',
        child: Icon(
          horizontal ? LucideIcons.chevronRight : LucideIcons.chevronDown,
          size: 16,
        ),
      ),
    );
    final Widget dots = DotIndicator(
      index: _index,
      length: _slideCount,
      direction: widget.direction,
      onChanged: (int page) =>
          _controller.animateTo(page.toDouble(), kDefaultDuration),
    );

    // P7-TH1: the pager fills the 480px box (no `min`): with an `Expanded`
    // viewport a min-sized row sizes unpredictably and strands 8px, which
    // reads as off-centre. The outer Column stays min-sized and centred.
    final Widget pager = horizontal
        ? Row(
            children: <Widget>[
              prev,
              Gap(spacing.sm),
              Expanded(child: viewport),
              Gap(spacing.sm),
              next,
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[prev, Gap(spacing.sm), next],
              ),
              Gap(spacing.sm),
              Expanded(child: viewport),
              Gap(spacing.sm),
              dots,
            ],
          );
    return Align(
      // P7-TH1: centred on both axes so the stage (and the centred-example
      // audit) sees the demo in the middle, not pinned to the top.
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            pager,
            if (horizontal) ...<Widget>[Gap(spacing.sm), dots],
            if (widget.autoplay) ...<Widget>[
              Gap(spacing.sm),
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.outline,
                onPressed: () => setState(() => _playing = !_playing),
                leading: Icon(
                  _playing ? LucideIcons.pause : LucideIcons.play,
                  size: 16,
                ),
                child: Text(
                  _playing
                        ? 'Pause'
                        : 'Play',
                ),
              ),
            ],
            if (widget.showCounter) ...<Widget>[
              Gap(spacing.sm),
              Text(
                '${'Slide'} ${_index + 1} '
                '${'of'} $_slideCount',
              ),
              Gap(spacing.xs),
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.secondary,
                onPressed: () => _controller.animateTo(
                  (_slideCount - 1).toDouble(),
                  kDefaultDuration,
                ),
                child: Text('Jump to last'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Default: full-width slides with prev/next and dots.
Widget _carouselDefault(BuildContext context) => const _CarouselShell();
''',
    ),
    DocsExampleSource(
      name: 'Sizes',
      builder: '_carouselSizes',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/constants.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/dot_indicator/dot_indicator.dart';
import 'package:<your_app>/ui/dashcn/components/carousel/carousel.dart';

/// One numbered card slide.
Widget _slideCard(BuildContext context, int index) {
  final theme = Theme.of(context);
  return Container(
    decoration: BoxDecoration(
      color: theme.colors.card,
      border: Border.all(color: theme.colors.border),
      borderRadius: theme.borderRadiusLg,
    ),
    alignment: Alignment.center,
    child: Text(
      '${index + 1}',
      style: TextStyle(
        color: theme.colors.cardForeground,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// Shared working shell: viewport + prev/next + dots (+ optional counter).
class _CarouselShell extends StatefulWidget {
  const _CarouselShell({
    this.viewportFraction,
    this.gap,
    this.direction = Axis.horizontal,
    this.autoplay = false,
    this.showCounter = false,
  });

  final double? viewportFraction;
  final double? gap;
  final Axis direction;
  final bool autoplay;
  final bool showCounter;

  @override
  State<_CarouselShell> createState() => _CarouselShellState();
}

/// Slides per example.
const int _slideCount = 5;

class _CarouselShellState extends State<_CarouselShell> {
  final CarouselController _controller = CarouselController();
  final FocusNode _keys = FocusNode(debugLabel: 'CarouselShell');
  int _index = 0;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _playing = widget.autoplay;
  }

  @override
  void dispose() {
    _controller.dispose();
    _keys.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final int next = (_index + delta) % _slideCount < 0
        ? _slideCount - 1
        : (_index + delta) % _slideCount;
    _controller.animateTo(next.toDouble(), kDefaultDuration);
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.logicalKey == LogicalKeyboardKey.arrowDown) {
      _go(1);
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
        event.logicalKey == LogicalKeyboardKey.arrowUp) {
      _go(-1);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    final bool horizontal = widget.direction == Axis.horizontal;
    // The tap only moves keyboard focus into the viewport: excluded from
    // semantics so it never reports as an unlabeled action.
    final Widget viewport = ExcludeSemantics(
      child: GestureDetector(
        onTap: _keys.requestFocus,
        child: Focus(
          focusNode: _keys,
          onKeyEvent: _onKey,
          child: SizedBox(
            height: horizontal ? 160 : 280,
            child: Carousel(
              itemCount: _slideCount,
              controller: _controller,
              viewportFraction: widget.viewportFraction,
              gap: widget.gap,
              direction: widget.direction,
              autoplayInterval: _playing ? const Duration(seconds: 2) : null,
              onIndexChanged: (int index) => setState(() => _index = index),
              itemBuilder: _slideCard,
            ),
          ),
        ),
      ),
    );
    final Widget prev = Button(
      size: ButtonSize.icon,
      variant: ButtonVariant.outline,
      onPressed: () => _go(-1),
      child: Semantics(
        label: 'Previous',
        child: Icon(
          horizontal ? LucideIcons.chevronLeft : LucideIcons.chevronUp,
          size: 16,
        ),
      ),
    );
    final Widget next = Button(
      size: ButtonSize.icon,
      variant: ButtonVariant.outline,
      onPressed: () => _go(1),
      child: Semantics(
        label: 'Next',
        child: Icon(
          horizontal ? LucideIcons.chevronRight : LucideIcons.chevronDown,
          size: 16,
        ),
      ),
    );
    final Widget dots = DotIndicator(
      index: _index,
      length: _slideCount,
      direction: widget.direction,
      onChanged: (int page) =>
          _controller.animateTo(page.toDouble(), kDefaultDuration),
    );

    // P7-TH1: the pager fills the 480px box (no `min`): with an `Expanded`
    // viewport a min-sized row sizes unpredictably and strands 8px, which
    // reads as off-centre. The outer Column stays min-sized and centred.
    final Widget pager = horizontal
        ? Row(
            children: <Widget>[
              prev,
              Gap(spacing.sm),
              Expanded(child: viewport),
              Gap(spacing.sm),
              next,
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[prev, Gap(spacing.sm), next],
              ),
              Gap(spacing.sm),
              Expanded(child: viewport),
              Gap(spacing.sm),
              dots,
            ],
          );
    return Align(
      // P7-TH1: centred on both axes so the stage (and the centred-example
      // audit) sees the demo in the middle, not pinned to the top.
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            pager,
            if (horizontal) ...<Widget>[Gap(spacing.sm), dots],
            if (widget.autoplay) ...<Widget>[
              Gap(spacing.sm),
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.outline,
                onPressed: () => setState(() => _playing = !_playing),
                leading: Icon(
                  _playing ? LucideIcons.pause : LucideIcons.play,
                  size: 16,
                ),
                child: Text(
                  _playing
                        ? 'Pause'
                        : 'Play',
                ),
              ),
            ],
            if (widget.showCounter) ...<Widget>[
              Gap(spacing.sm),
              Text(
                '${'Slide'} ${_index + 1} '
                '${'of'} $_slideCount',
              ),
              Gap(spacing.xs),
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.secondary,
                onPressed: () => _controller.animateTo(
                  (_slideCount - 1).toDouble(),
                  kDefaultDuration,
                ),
                child: Text('Jump to last'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Three-up slides (`basis-1/3`) with spacing.
Widget _carouselSizes(BuildContext context) =>
    const _CarouselShell(viewportFraction: 1 / 3, gap: 8);
''',
    ),
    DocsExampleSource(
      name: 'Vertical',
      builder: '_carouselVertical',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/constants.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/dot_indicator/dot_indicator.dart';
import 'package:<your_app>/ui/dashcn/components/carousel/carousel.dart';

/// One numbered card slide.
Widget _slideCard(BuildContext context, int index) {
  final theme = Theme.of(context);
  return Container(
    decoration: BoxDecoration(
      color: theme.colors.card,
      border: Border.all(color: theme.colors.border),
      borderRadius: theme.borderRadiusLg,
    ),
    alignment: Alignment.center,
    child: Text(
      '${index + 1}',
      style: TextStyle(
        color: theme.colors.cardForeground,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// Shared working shell: viewport + prev/next + dots (+ optional counter).
class _CarouselShell extends StatefulWidget {
  const _CarouselShell({
    this.viewportFraction,
    this.gap,
    this.direction = Axis.horizontal,
    this.autoplay = false,
    this.showCounter = false,
  });

  final double? viewportFraction;
  final double? gap;
  final Axis direction;
  final bool autoplay;
  final bool showCounter;

  @override
  State<_CarouselShell> createState() => _CarouselShellState();
}

/// Slides per example.
const int _slideCount = 5;

class _CarouselShellState extends State<_CarouselShell> {
  final CarouselController _controller = CarouselController();
  final FocusNode _keys = FocusNode(debugLabel: 'CarouselShell');
  int _index = 0;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _playing = widget.autoplay;
  }

  @override
  void dispose() {
    _controller.dispose();
    _keys.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final int next = (_index + delta) % _slideCount < 0
        ? _slideCount - 1
        : (_index + delta) % _slideCount;
    _controller.animateTo(next.toDouble(), kDefaultDuration);
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.logicalKey == LogicalKeyboardKey.arrowDown) {
      _go(1);
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
        event.logicalKey == LogicalKeyboardKey.arrowUp) {
      _go(-1);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    final bool horizontal = widget.direction == Axis.horizontal;
    // The tap only moves keyboard focus into the viewport: excluded from
    // semantics so it never reports as an unlabeled action.
    final Widget viewport = ExcludeSemantics(
      child: GestureDetector(
        onTap: _keys.requestFocus,
        child: Focus(
          focusNode: _keys,
          onKeyEvent: _onKey,
          child: SizedBox(
            height: horizontal ? 160 : 280,
            child: Carousel(
              itemCount: _slideCount,
              controller: _controller,
              viewportFraction: widget.viewportFraction,
              gap: widget.gap,
              direction: widget.direction,
              autoplayInterval: _playing ? const Duration(seconds: 2) : null,
              onIndexChanged: (int index) => setState(() => _index = index),
              itemBuilder: _slideCard,
            ),
          ),
        ),
      ),
    );
    final Widget prev = Button(
      size: ButtonSize.icon,
      variant: ButtonVariant.outline,
      onPressed: () => _go(-1),
      child: Semantics(
        label: 'Previous',
        child: Icon(
          horizontal ? LucideIcons.chevronLeft : LucideIcons.chevronUp,
          size: 16,
        ),
      ),
    );
    final Widget next = Button(
      size: ButtonSize.icon,
      variant: ButtonVariant.outline,
      onPressed: () => _go(1),
      child: Semantics(
        label: 'Next',
        child: Icon(
          horizontal ? LucideIcons.chevronRight : LucideIcons.chevronDown,
          size: 16,
        ),
      ),
    );
    final Widget dots = DotIndicator(
      index: _index,
      length: _slideCount,
      direction: widget.direction,
      onChanged: (int page) =>
          _controller.animateTo(page.toDouble(), kDefaultDuration),
    );

    // P7-TH1: the pager fills the 480px box (no `min`): with an `Expanded`
    // viewport a min-sized row sizes unpredictably and strands 8px, which
    // reads as off-centre. The outer Column stays min-sized and centred.
    final Widget pager = horizontal
        ? Row(
            children: <Widget>[
              prev,
              Gap(spacing.sm),
              Expanded(child: viewport),
              Gap(spacing.sm),
              next,
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[prev, Gap(spacing.sm), next],
              ),
              Gap(spacing.sm),
              Expanded(child: viewport),
              Gap(spacing.sm),
              dots,
            ],
          );
    return Align(
      // P7-TH1: centred on both axes so the stage (and the centred-example
      // audit) sees the demo in the middle, not pinned to the top.
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            pager,
            if (horizontal) ...<Widget>[Gap(spacing.sm), dots],
            if (widget.autoplay) ...<Widget>[
              Gap(spacing.sm),
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.outline,
                onPressed: () => setState(() => _playing = !_playing),
                leading: Icon(
                  _playing ? LucideIcons.pause : LucideIcons.play,
                  size: 16,
                ),
                child: Text(
                  _playing
                        ? 'Pause'
                        : 'Play',
                ),
              ),
            ],
            if (widget.showCounter) ...<Widget>[
              Gap(spacing.sm),
              Text(
                '${'Slide'} ${_index + 1} '
                '${'of'} $_slideCount',
              ),
              Gap(spacing.xs),
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.secondary,
                onPressed: () => _controller.animateTo(
                  (_slideCount - 1).toDouble(),
                  kDefaultDuration,
                ),
                child: Text('Jump to last'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Vertical orientation with up/down buttons and a vertical dot run.
Widget _carouselVertical(BuildContext context) =>
    const _CarouselShell(direction: Axis.vertical);
''',
    ),
    DocsExampleSource(
      name: 'Autoplay',
      builder: '_carouselAutoplay',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/constants.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/dot_indicator/dot_indicator.dart';
import 'package:<your_app>/ui/dashcn/components/carousel/carousel.dart';

/// One numbered card slide.
Widget _slideCard(BuildContext context, int index) {
  final theme = Theme.of(context);
  return Container(
    decoration: BoxDecoration(
      color: theme.colors.card,
      border: Border.all(color: theme.colors.border),
      borderRadius: theme.borderRadiusLg,
    ),
    alignment: Alignment.center,
    child: Text(
      '${index + 1}',
      style: TextStyle(
        color: theme.colors.cardForeground,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// Shared working shell: viewport + prev/next + dots (+ optional counter).
class _CarouselShell extends StatefulWidget {
  const _CarouselShell({
    this.viewportFraction,
    this.gap,
    this.direction = Axis.horizontal,
    this.autoplay = false,
    this.showCounter = false,
  });

  final double? viewportFraction;
  final double? gap;
  final Axis direction;
  final bool autoplay;
  final bool showCounter;

  @override
  State<_CarouselShell> createState() => _CarouselShellState();
}

/// Slides per example.
const int _slideCount = 5;

class _CarouselShellState extends State<_CarouselShell> {
  final CarouselController _controller = CarouselController();
  final FocusNode _keys = FocusNode(debugLabel: 'CarouselShell');
  int _index = 0;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _playing = widget.autoplay;
  }

  @override
  void dispose() {
    _controller.dispose();
    _keys.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final int next = (_index + delta) % _slideCount < 0
        ? _slideCount - 1
        : (_index + delta) % _slideCount;
    _controller.animateTo(next.toDouble(), kDefaultDuration);
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.logicalKey == LogicalKeyboardKey.arrowDown) {
      _go(1);
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
        event.logicalKey == LogicalKeyboardKey.arrowUp) {
      _go(-1);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    final bool horizontal = widget.direction == Axis.horizontal;
    // The tap only moves keyboard focus into the viewport: excluded from
    // semantics so it never reports as an unlabeled action.
    final Widget viewport = ExcludeSemantics(
      child: GestureDetector(
        onTap: _keys.requestFocus,
        child: Focus(
          focusNode: _keys,
          onKeyEvent: _onKey,
          child: SizedBox(
            height: horizontal ? 160 : 280,
            child: Carousel(
              itemCount: _slideCount,
              controller: _controller,
              viewportFraction: widget.viewportFraction,
              gap: widget.gap,
              direction: widget.direction,
              autoplayInterval: _playing ? const Duration(seconds: 2) : null,
              onIndexChanged: (int index) => setState(() => _index = index),
              itemBuilder: _slideCard,
            ),
          ),
        ),
      ),
    );
    final Widget prev = Button(
      size: ButtonSize.icon,
      variant: ButtonVariant.outline,
      onPressed: () => _go(-1),
      child: Semantics(
        label: 'Previous',
        child: Icon(
          horizontal ? LucideIcons.chevronLeft : LucideIcons.chevronUp,
          size: 16,
        ),
      ),
    );
    final Widget next = Button(
      size: ButtonSize.icon,
      variant: ButtonVariant.outline,
      onPressed: () => _go(1),
      child: Semantics(
        label: 'Next',
        child: Icon(
          horizontal ? LucideIcons.chevronRight : LucideIcons.chevronDown,
          size: 16,
        ),
      ),
    );
    final Widget dots = DotIndicator(
      index: _index,
      length: _slideCount,
      direction: widget.direction,
      onChanged: (int page) =>
          _controller.animateTo(page.toDouble(), kDefaultDuration),
    );

    // P7-TH1: the pager fills the 480px box (no `min`): with an `Expanded`
    // viewport a min-sized row sizes unpredictably and strands 8px, which
    // reads as off-centre. The outer Column stays min-sized and centred.
    final Widget pager = horizontal
        ? Row(
            children: <Widget>[
              prev,
              Gap(spacing.sm),
              Expanded(child: viewport),
              Gap(spacing.sm),
              next,
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[prev, Gap(spacing.sm), next],
              ),
              Gap(spacing.sm),
              Expanded(child: viewport),
              Gap(spacing.sm),
              dots,
            ],
          );
    return Align(
      // P7-TH1: centred on both axes so the stage (and the centred-example
      // audit) sees the demo in the middle, not pinned to the top.
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            pager,
            if (horizontal) ...<Widget>[Gap(spacing.sm), dots],
            if (widget.autoplay) ...<Widget>[
              Gap(spacing.sm),
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.outline,
                onPressed: () => setState(() => _playing = !_playing),
                leading: Icon(
                  _playing ? LucideIcons.pause : LucideIcons.play,
                  size: 16,
                ),
                child: Text(
                  _playing
                        ? 'Pause'
                        : 'Play',
                ),
              ),
            ],
            if (widget.showCounter) ...<Widget>[
              Gap(spacing.sm),
              Text(
                '${'Slide'} ${_index + 1} '
                '${'of'} $_slideCount',
              ),
              Gap(spacing.xs),
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.secondary,
                onPressed: () => _controller.animateTo(
                  (_slideCount - 1).toDouble(),
                  kDefaultDuration,
                ),
                child: Text('Jump to last'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Autoplaying slides with a play/pause toggle.
Widget _carouselAutoplay(BuildContext context) =>
    const _CarouselShell(autoplay: true);
''',
    ),
    DocsExampleSource(
      name: 'With API',
      builder: '_carouselApi',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/constants.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/dot_indicator/dot_indicator.dart';
import 'package:<your_app>/ui/dashcn/components/carousel/carousel.dart';

/// One numbered card slide.
Widget _slideCard(BuildContext context, int index) {
  final theme = Theme.of(context);
  return Container(
    decoration: BoxDecoration(
      color: theme.colors.card,
      border: Border.all(color: theme.colors.border),
      borderRadius: theme.borderRadiusLg,
    ),
    alignment: Alignment.center,
    child: Text(
      '${index + 1}',
      style: TextStyle(
        color: theme.colors.cardForeground,
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// Shared working shell: viewport + prev/next + dots (+ optional counter).
class _CarouselShell extends StatefulWidget {
  const _CarouselShell({
    this.viewportFraction,
    this.gap,
    this.direction = Axis.horizontal,
    this.autoplay = false,
    this.showCounter = false,
  });

  final double? viewportFraction;
  final double? gap;
  final Axis direction;
  final bool autoplay;
  final bool showCounter;

  @override
  State<_CarouselShell> createState() => _CarouselShellState();
}

/// Slides per example.
const int _slideCount = 5;

class _CarouselShellState extends State<_CarouselShell> {
  final CarouselController _controller = CarouselController();
  final FocusNode _keys = FocusNode(debugLabel: 'CarouselShell');
  int _index = 0;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _playing = widget.autoplay;
  }

  @override
  void dispose() {
    _controller.dispose();
    _keys.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final int next = (_index + delta) % _slideCount < 0
        ? _slideCount - 1
        : (_index + delta) % _slideCount;
    _controller.animateTo(next.toDouble(), kDefaultDuration);
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.logicalKey == LogicalKeyboardKey.arrowDown) {
      _go(1);
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
        event.logicalKey == LogicalKeyboardKey.arrowUp) {
      _go(-1);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    final bool horizontal = widget.direction == Axis.horizontal;
    // The tap only moves keyboard focus into the viewport: excluded from
    // semantics so it never reports as an unlabeled action.
    final Widget viewport = ExcludeSemantics(
      child: GestureDetector(
        onTap: _keys.requestFocus,
        child: Focus(
          focusNode: _keys,
          onKeyEvent: _onKey,
          child: SizedBox(
            height: horizontal ? 160 : 280,
            child: Carousel(
              itemCount: _slideCount,
              controller: _controller,
              viewportFraction: widget.viewportFraction,
              gap: widget.gap,
              direction: widget.direction,
              autoplayInterval: _playing ? const Duration(seconds: 2) : null,
              onIndexChanged: (int index) => setState(() => _index = index),
              itemBuilder: _slideCard,
            ),
          ),
        ),
      ),
    );
    final Widget prev = Button(
      size: ButtonSize.icon,
      variant: ButtonVariant.outline,
      onPressed: () => _go(-1),
      child: Semantics(
        label: 'Previous',
        child: Icon(
          horizontal ? LucideIcons.chevronLeft : LucideIcons.chevronUp,
          size: 16,
        ),
      ),
    );
    final Widget next = Button(
      size: ButtonSize.icon,
      variant: ButtonVariant.outline,
      onPressed: () => _go(1),
      child: Semantics(
        label: 'Next',
        child: Icon(
          horizontal ? LucideIcons.chevronRight : LucideIcons.chevronDown,
          size: 16,
        ),
      ),
    );
    final Widget dots = DotIndicator(
      index: _index,
      length: _slideCount,
      direction: widget.direction,
      onChanged: (int page) =>
          _controller.animateTo(page.toDouble(), kDefaultDuration),
    );

    // P7-TH1: the pager fills the 480px box (no `min`): with an `Expanded`
    // viewport a min-sized row sizes unpredictably and strands 8px, which
    // reads as off-centre. The outer Column stays min-sized and centred.
    final Widget pager = horizontal
        ? Row(
            children: <Widget>[
              prev,
              Gap(spacing.sm),
              Expanded(child: viewport),
              Gap(spacing.sm),
              next,
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[prev, Gap(spacing.sm), next],
              ),
              Gap(spacing.sm),
              Expanded(child: viewport),
              Gap(spacing.sm),
              dots,
            ],
          );
    return Align(
      // P7-TH1: centred on both axes so the stage (and the centred-example
      // audit) sees the demo in the middle, not pinned to the top.
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            pager,
            if (horizontal) ...<Widget>[Gap(spacing.sm), dots],
            if (widget.autoplay) ...<Widget>[
              Gap(spacing.sm),
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.outline,
                onPressed: () => setState(() => _playing = !_playing),
                leading: Icon(
                  _playing ? LucideIcons.pause : LucideIcons.play,
                  size: 16,
                ),
                child: Text(
                  _playing
                        ? 'Pause'
                        : 'Play',
                ),
              ),
            ],
            if (widget.showCounter) ...<Widget>[
              Gap(spacing.sm),
              Text(
                '${'Slide'} ${_index + 1} '
                '${'of'} $_slideCount',
              ),
              Gap(spacing.xs),
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.secondary,
                onPressed: () => _controller.animateTo(
                  (_slideCount - 1).toDouble(),
                  kDefaultDuration,
                ),
                child: Text('Jump to last'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Controller API: live current/total counter plus a jump button.
Widget _carouselApi(BuildContext context) =>
    const _CarouselShell(showCounter: true);
''',
    ),
  ],
  'chart': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Line Chart - Interactive',
      builder: '_chartLineInteractive',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

/// Interactive line chart with a 90d/30d/7d range filter.
class _LineInteractive extends StatefulWidget {
  const _LineInteractive();

  @override
  State<_LineInteractive> createState() => _LineInteractiveState();
}

class _LineInteractiveState extends State<_LineInteractive> {
  String _range = '90d';

  int get _count => _range == '7d'
      ? 7
      : _range == '30d'
      ? 30
      : 90;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _RangeButtons(
          options: const <String>['90d', '30d', '7d'],
          selected: _range,
          onSelect: (String value) => setState(() => _range = value),
        ),
        const SizedBox(height: 8),
        Chart(
          labels: _AreaInteractiveState.dayLabels.sublist(90 - _count),
          series: <ChartSeries>[
            ChartSeries(
              label: 'Desktop',
              values: _AreaInteractiveState.desktopData.sublist(90 - _count),
            ),
            ChartSeries(
              label: 'Mobile',
              values: _AreaInteractiveState.mobileData.sublist(90 - _count),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _chartLineInteractive(BuildContext context) => const _LineInteractive();

/// 90 days of deterministic sample data (Apr 1 - Jun 29) for the
/// interactive range-filter examples.
List<double> _trend(int seed) {
  return <double>[
    for (var i = 0; i < 90; i++) (150 + ((i * 53 + seed) % 260)).toDouble(),
  ];
}

String _trendDay(int i) {
  const List<int> lens = <int>[30, 31, 30];
  const List<String> names = <String>['Apr', 'May', 'Jun'];
  var d = i;
  var m = 0;
  while (m < 2 && d >= lens[m]) {
    d -= lens[m];
    m++;
  }
  return '${names[m]} ${d + 1}';
}

/// Range-filter buttons for the interactive examples.
class _RangeButtons extends StatelessWidget {
  const _RangeButtons({
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colors;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        for (final String option in options)
          GestureDetector(
            onTap: () => onSelect(option),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: option == selected ? colors.foreground : colors.border,
                ),
              ),
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 12,
                  color: option == selected
                      ? colors.foreground
                      : colors.mutedForeground,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Interactive area chart with a 90d/30d/7d range filter.
class _AreaInteractive extends StatefulWidget {
  const _AreaInteractive();

  @override
  State<_AreaInteractive> createState() => _AreaInteractiveState();
}

class _AreaInteractiveState extends State<_AreaInteractive> {
  static final List<double> desktopData = _trend(11);
  static final List<double> mobileData = _trend(101);
  static final List<String> dayLabels = <String>[
    for (var i = 0; i < 90; i++) _trendDay(i),
  ];

  String _range = '90d';

  int get _count => _range == '7d'
      ? 7
      : _range == '30d'
      ? 30
      : 90;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _RangeButtons(
          options: const <String>['90d', '30d', '7d'],
          selected: _range,
          onSelect: (String value) => setState(() => _range = value),
        ),
        const SizedBox(height: 8),
        Chart(
          type: ChartType.area,
          areaMode: ChartAreaMode.stacked,
          labels: dayLabels.sublist(90 - _count),
          series: <ChartSeries>[
            ChartSeries(
              label: 'Mobile',
              values: mobileData.sublist(90 - _count),
            ),
            ChartSeries(
              label: 'Desktop',
              values: desktopData.sublist(90 - _count),
            ),
          ],
        ),
      ],
    );
  }
}
''',
    ),
    DocsExampleSource(
      name: 'Line Chart',
      builder: '_chartLineDefault',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

Widget _chartLineDefault(BuildContext context) {
  return Chart(
    labels: _areaMonths,
    tooltip: ChartTooltipConfig(showLabel: false),
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _barDesktop),
    ],
  );
}

const List<double> _barDesktop = <double>[186, 305, 237, 73, 209, 214];

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];
''',
    ),
    DocsExampleSource(
      name: 'Line Chart - Linear',
      builder: '_chartLineLinear',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

Widget _chartLineLinear(BuildContext context) {
  return Chart(
    lineStyle: ChartLineStyle.linear,
    labels: _areaMonths,
    tooltip: ChartTooltipConfig(showLabel: false),
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _barDesktop),
    ],
  );
}

const List<double> _barDesktop = <double>[186, 305, 237, 73, 209, 214];

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];
''',
    ),
    DocsExampleSource(
      name: 'Line Chart - Step',
      builder: '_chartLineStep',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

Widget _chartLineStep(BuildContext context) {
  return Chart(
    lineStyle: ChartLineStyle.step,
    labels: _areaMonths,
    tooltip: ChartTooltipConfig(showLabel: false),
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _barDesktop),
    ],
  );
}

const List<double> _barDesktop = <double>[186, 305, 237, 73, 209, 214];

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];
''',
    ),
    DocsExampleSource(
      name: 'Line Chart - Multiple',
      builder: '_chartLineMultiple',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

Widget _chartLineMultiple(BuildContext context) {
  return Chart(
    labels: _areaMonths,
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _barDesktop),
      ChartSeries(label: 'Mobile', values: _barMobile),
    ],
  );
}

const List<double> _barDesktop = <double>[186, 305, 237, 73, 209, 214];

const List<double> _barMobile = <double>[80, 200, 120, 190, 130, 140];

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];
''',
    ),
    DocsExampleSource(
      name: 'Line Chart - Dots',
      builder: '_chartLineDots',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

Widget _chartLineDots(BuildContext context) {
  return Chart(
    labels: _areaMonths,
    showMarkers: true,
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _barDesktop),
      ChartSeries(label: 'Mobile', values: _barMobile),
    ],
  );
}

const List<double> _barDesktop = <double>[186, 305, 237, 73, 209, 214];

const List<double> _barMobile = <double>[80, 200, 120, 190, 130, 140];

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];
''',
    ),
    DocsExampleSource(
      name: 'Line Chart - Custom Dots',
      builder: '_chartLineDotsCustom',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

Widget _chartLineDotsCustom(BuildContext context) {
  return Chart(
    labels: _areaMonths,
    showMarkers: true,
    tooltip: ChartTooltipConfig(showLabel: false),
    series: <ChartSeries>[
      ChartSeries(
        label: 'Desktop',
        values: _barDesktop,
        markerShape: ChartMarkerShape.commit,
      ),
    ],
  );
}

const List<double> _barDesktop = <double>[186, 305, 237, 73, 209, 214];

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];
''',
    ),
    DocsExampleSource(
      name: 'Line Chart - Dots Colors',
      builder: '_chartLineDotsColors',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

Widget _chartLineDotsColors(BuildContext context) {
  return Chart(
    labels: _browserNames,
    showMarkers: true,
    tooltip: const ChartTooltipConfig(
      indicator: ChartTooltipIndicator.line,
      showLabel: false,
    ),
    series: <ChartSeries>[
      ChartSeries(
        label: 'Visitors',
        values: _browserVisitors,
        pointColors: _browserColors(context),
      ),
    ],
  );
}

List<String> _browserNames = <String>[
  'Chrome',
  'Safari',
  'Firefox',
  'Edge',
  'Other',
];

const List<double> _browserVisitors = <double>[275, 200, 187, 173, 90];

List<Color> _browserColors(BuildContext context) {
  final List<Color> palette = Theme.of(context).colors.chartColors;
  return <Color>[
    for (var i = 0; i < _browserVisitors.length; i++)
      palette[i % palette.length],
  ];
}
''',
    ),
    DocsExampleSource(
      name: 'Line Chart - Label',
      builder: '_chartLineLabel',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

Widget _chartLineLabel(BuildContext context) {
  return Chart(
    labels: _areaMonths,
    showMarkers: true,
    showPointLabels: true,
    tooltip: ChartTooltipConfig(indicator: ChartTooltipIndicator.line),
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _barDesktop),
    ],
  );
}

const List<double> _barDesktop = <double>[186, 305, 237, 73, 209, 214];

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];
''',
    ),
    DocsExampleSource(
      name: 'Line Chart - Custom Label',
      builder: '_chartLineLabelCustom',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

Widget _chartLineLabelCustom(BuildContext context) {
  return Chart(
    labels: _browserNames,
    showMarkers: true,
    showPointLabels: true,
    pointLabels: _browserNames,
    tooltip: const ChartTooltipConfig(
      indicator: ChartTooltipIndicator.line,
      showLabel: false,
    ),
    series: <ChartSeries>[
      ChartSeries(
        label: 'Visitors',
        values: _browserVisitors,
      ),
    ],
  );
}

List<String> _browserNames = <String>[
  'Chrome',
  'Safari',
  'Firefox',
  'Edge',
  'Other',
];

const List<double> _browserVisitors = <double>[275, 200, 187, 173, 90];
''',
    ),
    DocsExampleSource(
      name: 'Area Chart - Interactive',
      builder: '_chartAreaInteractive',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

/// 90 days of deterministic sample data (Apr 1 - Jun 29) for the
/// interactive range-filter examples.
List<double> _trend(int seed) {
  return <double>[
    for (var i = 0; i < 90; i++) (150 + ((i * 53 + seed) % 260)).toDouble(),
  ];
}

String _trendDay(int i) {
  const List<int> lens = <int>[30, 31, 30];
  const List<String> names = <String>['Apr', 'May', 'Jun'];
  var d = i;
  var m = 0;
  while (m < 2 && d >= lens[m]) {
    d -= lens[m];
    m++;
  }
  return '${names[m]} ${d + 1}';
}

/// Range-filter buttons for the interactive examples.
class _RangeButtons extends StatelessWidget {
  const _RangeButtons({
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colors;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        for (final String option in options)
          GestureDetector(
            onTap: () => onSelect(option),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: option == selected ? colors.foreground : colors.border,
                ),
              ),
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 12,
                  color: option == selected
                      ? colors.foreground
                      : colors.mutedForeground,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Interactive area chart with a 90d/30d/7d range filter.
class _AreaInteractive extends StatefulWidget {
  const _AreaInteractive();

  @override
  State<_AreaInteractive> createState() => _AreaInteractiveState();
}

class _AreaInteractiveState extends State<_AreaInteractive> {
  static final List<double> desktopData = _trend(11);
  static final List<double> mobileData = _trend(101);
  static final List<String> dayLabels = <String>[
    for (var i = 0; i < 90; i++) _trendDay(i),
  ];

  String _range = '90d';

  int get _count => _range == '7d'
      ? 7
      : _range == '30d'
      ? 30
      : 90;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _RangeButtons(
          options: const <String>['90d', '30d', '7d'],
          selected: _range,
          onSelect: (String value) => setState(() => _range = value),
        ),
        const SizedBox(height: 8),
        Chart(
          type: ChartType.area,
          areaMode: ChartAreaMode.stacked,
          labels: dayLabels.sublist(90 - _count),
          series: <ChartSeries>[
            ChartSeries(
              label: 'Mobile',
              values: mobileData.sublist(90 - _count),
            ),
            ChartSeries(
              label: 'Desktop',
              values: desktopData.sublist(90 - _count),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _chartAreaInteractive(BuildContext context) => const _AreaInteractive();
''',
    ),
    DocsExampleSource(
      name: 'Area Chart',
      builder: '_chartAreaDefault',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];

const List<double> _areaDesktop = <double>[186, 305, 237, 73, 209, 214];

Widget _chartAreaDefault(BuildContext context) {
  return Chart(
    type: ChartType.area,
    labels: _areaMonths,
    fillOpacity: 0.4,
    tooltip: ChartTooltipConfig(indicator: ChartTooltipIndicator.line),
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _areaDesktop),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Area Chart - Linear',
      builder: '_chartAreaLinear',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];

const List<double> _areaDesktop = <double>[186, 305, 237, 73, 209, 214];

Widget _chartAreaLinear(BuildContext context) {
  return Chart(
    type: ChartType.area,
    lineStyle: ChartLineStyle.linear,
    labels: _areaMonths,
    fillOpacity: 0.4,
    tooltip: ChartTooltipConfig(indicator: ChartTooltipIndicator.line),
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _areaDesktop),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Area Chart - Step',
      builder: '_chartAreaStep',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];

const List<double> _areaDesktop = <double>[186, 305, 237, 73, 209, 214];

Widget _chartAreaStep(BuildContext context) {
  return Chart(
    type: ChartType.area,
    lineStyle: ChartLineStyle.step,
    labels: _areaMonths,
    fillOpacity: 0.4,
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _areaDesktop),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Area Chart - Legend',
      builder: '_chartAreaLegend',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];

const List<double> _areaDesktop = <double>[186, 305, 237, 73, 209, 214];

const List<double> _areaMobile = <double>[80, 200, 120, 190, 130, 140];

Widget _chartAreaLegend(BuildContext context) {
  return Chart(
    type: ChartType.area,
    areaMode: ChartAreaMode.stacked,
    labels: _areaMonths,
    series: <ChartSeries>[
      ChartSeries(label: 'Mobile', values: _areaMobile),
      ChartSeries(label: 'Desktop', values: _areaDesktop),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Area Chart - Stacked',
      builder: '_chartAreaStacked',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];

const List<double> _areaDesktop = <double>[186, 305, 237, 73, 209, 214];

const List<double> _areaMobile = <double>[80, 200, 120, 190, 130, 140];

Widget _chartAreaStacked(BuildContext context) {
  return const Chart(
    type: ChartType.area,
    areaMode: ChartAreaMode.stacked,
    labels: _areaMonths,
    showLegend: false,
    series: <ChartSeries>[
      ChartSeries(values: _areaMobile),
      ChartSeries(values: _areaDesktop),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Area Chart - Stacked Expanded',
      builder: '_chartAreaStackedExpanded',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];

const List<double> _areaDesktop = <double>[186, 305, 237, 73, 209, 214];

const List<double> _areaMobile = <double>[80, 200, 120, 190, 130, 140];

Widget _chartAreaStackedExpanded(BuildContext context) {
  return const Chart(
    type: ChartType.area,
    areaMode: ChartAreaMode.expanded,
    labels: _areaMonths,
    showLegend: false,
    series: <ChartSeries>[
      ChartSeries(values: _areaMobile),
      ChartSeries(values: _areaDesktop),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Area Chart - Icons',
      builder: '_chartAreaIcons',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];

const List<double> _areaDesktop = <double>[186, 305, 237, 73, 209, 214];

const List<double> _areaMobile = <double>[80, 200, 120, 190, 130, 140];

Widget _chartAreaIcons(BuildContext context) {
  return Chart(
    type: ChartType.area,
    areaMode: ChartAreaMode.stacked,
    labels: _areaMonths,
    series: <ChartSeries>[
      ChartSeries(
        label: 'Mobile',
        values: _areaMobile,
        icon: Icon(LucideIcons.trendingUp),
      ),
      ChartSeries(
        label: 'Desktop',
        values: _areaDesktop,
        icon: Icon(LucideIcons.trendingDown),
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Area Chart - Gradient',
      builder: '_chartAreaGradient',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];

const List<double> _areaDesktop = <double>[186, 305, 237, 73, 209, 214];

const List<double> _areaMobile = <double>[80, 200, 120, 190, 130, 140];

Widget _chartAreaGradient(BuildContext context) {
  final palette = Theme.of(context).colors.chartColors;
  LinearGradient fill(Color color) => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[color.withValues(alpha: 0.8), color.withValues(alpha: 0.1)],
  );
  return Chart(
    type: ChartType.area,
    areaMode: ChartAreaMode.stacked,
    labels: _areaMonths,
    series: <ChartSeries>[
      ChartSeries(
        label: 'Mobile',
        values: _areaMobile,
        gradient: fill(palette[1]),
      ),
      ChartSeries(
        label: 'Desktop',
        values: _areaDesktop,
        gradient: fill(palette[0]),
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Area Chart - Axes',
      builder: '_chartAreaAxes',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];

const List<double> _areaDesktop = <double>[186, 305, 237, 73, 209, 214];

const List<double> _areaMobile = <double>[80, 200, 120, 190, 130, 140];

Widget _chartAreaAxes(BuildContext context) {
  return const Chart(
    type: ChartType.area,
    areaMode: ChartAreaMode.stacked,
    labels: _areaMonths,
    showAxes: false,
    showLegend: false,
    yAxis: ChartAxis(tickCount: 3),
    series: <ChartSeries>[
      ChartSeries(values: _areaMobile),
      ChartSeries(values: _areaDesktop),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Bar Chart - Interactive',
      builder: '_chartBarInteractive',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

/// Interactive bar chart with a 90d/30d/7d range filter.
class _BarInteractive extends StatefulWidget {
  const _BarInteractive();

  @override
  State<_BarInteractive> createState() => _BarInteractiveState();
}

class _BarInteractiveState extends State<_BarInteractive> {
  String _range = '90d';

  int get _count => _range == '7d'
      ? 7
      : _range == '30d'
      ? 30
      : 90;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _RangeButtons(
          options: const <String>['90d', '30d', '7d'],
          selected: _range,
          onSelect: (String value) => setState(() => _range = value),
        ),
        const SizedBox(height: 8),
        Chart(
          type: ChartType.bar,
          labels: _AreaInteractiveState.dayLabels.sublist(90 - _count),
          series: <ChartSeries>[
            ChartSeries(
              label: 'Desktop',
              values: _AreaInteractiveState.desktopData.sublist(90 - _count),
            ),
            ChartSeries(
              label: 'Mobile',
              values: _AreaInteractiveState.mobileData.sublist(90 - _count),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _chartBarInteractive(BuildContext context) => const _BarInteractive();

/// 90 days of deterministic sample data (Apr 1 - Jun 29) for the
/// interactive range-filter examples.
List<double> _trend(int seed) {
  return <double>[
    for (var i = 0; i < 90; i++) (150 + ((i * 53 + seed) % 260)).toDouble(),
  ];
}

String _trendDay(int i) {
  const List<int> lens = <int>[30, 31, 30];
  const List<String> names = <String>['Apr', 'May', 'Jun'];
  var d = i;
  var m = 0;
  while (m < 2 && d >= lens[m]) {
    d -= lens[m];
    m++;
  }
  return '${names[m]} ${d + 1}';
}

/// Range-filter buttons for the interactive examples.
class _RangeButtons extends StatelessWidget {
  const _RangeButtons({
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colors;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        for (final String option in options)
          GestureDetector(
            onTap: () => onSelect(option),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: option == selected ? colors.foreground : colors.border,
                ),
              ),
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 12,
                  color: option == selected
                      ? colors.foreground
                      : colors.mutedForeground,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Interactive area chart with a 90d/30d/7d range filter.
class _AreaInteractive extends StatefulWidget {
  const _AreaInteractive();

  @override
  State<_AreaInteractive> createState() => _AreaInteractiveState();
}

class _AreaInteractiveState extends State<_AreaInteractive> {
  static final List<double> desktopData = _trend(11);
  static final List<double> mobileData = _trend(101);
  static final List<String> dayLabels = <String>[
    for (var i = 0; i < 90; i++) _trendDay(i),
  ];

  String _range = '90d';

  int get _count => _range == '7d'
      ? 7
      : _range == '30d'
      ? 30
      : 90;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _RangeButtons(
          options: const <String>['90d', '30d', '7d'],
          selected: _range,
          onSelect: (String value) => setState(() => _range = value),
        ),
        const SizedBox(height: 8),
        Chart(
          type: ChartType.area,
          areaMode: ChartAreaMode.stacked,
          labels: dayLabels.sublist(90 - _count),
          series: <ChartSeries>[
            ChartSeries(
              label: 'Mobile',
              values: mobileData.sublist(90 - _count),
            ),
            ChartSeries(
              label: 'Desktop',
              values: desktopData.sublist(90 - _count),
            ),
          ],
        ),
      ],
    );
  }
}
''',
    ),
    DocsExampleSource(
      name: 'Bar Chart',
      builder: '_chartBarDefault',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<double> _barDesktop = <double>[186, 305, 237, 73, 209, 214];

Widget _chartBarDefault(BuildContext context) {
  return Chart(
    type: ChartType.bar,
    labels: _areaMonths,
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _barDesktop),
    ],
  );
}

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];
''',
    ),
    DocsExampleSource(
      name: 'Bar Chart - Horizontal',
      builder: '_chartBarHorizontal',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<double> _barDesktop = <double>[186, 305, 237, 73, 209, 214];

Widget _chartBarHorizontal(BuildContext context) {
  return Chart(
    type: ChartType.bar,
    barLayout: ChartBarLayout.horizontal,
    labels: _areaMonths,
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _barDesktop),
    ],
  );
}

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];
''',
    ),
    DocsExampleSource(
      name: 'Bar Chart - Multiple',
      builder: '_chartBarMultiple',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<double> _barDesktop = <double>[186, 305, 237, 73, 209, 214];

const List<double> _barMobile = <double>[80, 200, 120, 190, 130, 140];

Widget _chartBarMultiple(BuildContext context) {
  return Chart(
    type: ChartType.bar,
    labels: _areaMonths,
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _barDesktop),
      ChartSeries(label: 'Mobile', values: _barMobile),
    ],
  );
}

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];
''',
    ),
    DocsExampleSource(
      name: 'Bar Chart - Stacked + Legend',
      builder: '_chartBarStacked',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<double> _barDesktop = <double>[186, 305, 237, 73, 209, 214];

const List<double> _barMobile = <double>[80, 200, 120, 190, 130, 140];

Widget _chartBarStacked(BuildContext context) {
  return Chart(
    type: ChartType.bar,
    barMode: ChartBarMode.stacked,
    labels: _areaMonths,
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _barDesktop),
      ChartSeries(label: 'Mobile', values: _barMobile),
    ],
  );
}

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];
''',
    ),
    DocsExampleSource(
      name: 'Bar Chart - Label',
      builder: '_chartBarLabel',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<double> _barDesktop = <double>[186, 305, 237, 73, 209, 214];

Widget _chartBarLabel(BuildContext context) {
  return Chart(
    type: ChartType.bar,
    labels: _areaMonths,
    showBarLabels: true,
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _barDesktop),
    ],
  );
}

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];
''',
    ),
    DocsExampleSource(
      name: 'Bar Chart - Custom Label',
      builder: '_chartBarLabelCustom',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<double> _barDesktop = <double>[186, 305, 237, 73, 209, 214];

Widget _chartBarLabelCustom(BuildContext context) {
  return Chart(
    type: ChartType.bar,
    barLayout: ChartBarLayout.horizontal,
    labels: _areaMonths,
    showLabels: false,
    showBarLabels: true,
    showBarCategories: true,
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _barDesktop),
    ],
  );
}

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];
''',
    ),
    DocsExampleSource(
      name: 'Bar Chart - Mixed',
      builder: '_chartBarMixed',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _browserNames = <String>[
  'Chrome',
  'Safari',
  'Firefox',
  'Edge',
  'Other',
];

const List<double> _browserVisitors = <double>[275, 200, 187, 173, 90];

List<Color> _browserColors(BuildContext context) {
  final List<Color> palette = Theme.of(context).colors.chartColors;
  return <Color>[
    for (var i = 0; i < _browserVisitors.length; i++)
      palette[i % palette.length],
  ];
}

Widget _chartBarMixed(BuildContext context) {
  return Chart(
    type: ChartType.bar,
    barLayout: ChartBarLayout.horizontal,
    labels: _browserNames,
    showLegend: false,
    series: <ChartSeries>[
      ChartSeries(
        values: _browserVisitors,
        pointColors: _browserColors(context),
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Bar Chart - Active',
      builder: '_chartBarActive',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _browserNames = <String>[
  'Chrome',
  'Safari',
  'Firefox',
  'Edge',
  'Other',
];

const List<double> _browserVisitors = <double>[275, 200, 187, 173, 90];

List<Color> _browserColors(BuildContext context) {
  final List<Color> palette = Theme.of(context).colors.chartColors;
  return <Color>[
    for (var i = 0; i < _browserVisitors.length; i++)
      palette[i % palette.length],
  ];
}

Widget _chartBarActive(BuildContext context) {
  return Chart(
    type: ChartType.bar,
    labels: _browserNames,
    showLegend: false,
    barRadius: 8,
    initialSelectedIndex: 2,
    tooltip: const ChartTooltipConfig(showLabel: false),
    series: <ChartSeries>[
      ChartSeries(
        // Same order as the reference: firefox (275) is the active index.
        values: const <double>[187, 200, 275, 173, 90],
        pointColors: _browserColors(context),
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Bar Chart - Negative',
      builder: '_chartBarNegative',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

Widget _chartBarNegative(BuildContext context) {
  return Chart(
    type: ChartType.bar,
    labels: _areaMonths,
    series: <ChartSeries>[
      ChartSeries(
        label: 'Desktop',
        values: <double>[186, 305, -120, 73, -90, 214],
      ),
    ],
  );
}

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];
''',
    ),
    DocsExampleSource(
      name: 'Pie Chart',
      builder: '_chartPieSimple',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _browserNames = <String>[
  'Chrome',
  'Safari',
  'Firefox',
  'Edge',
  'Other',
];

const List<double> _browserVisitors = <double>[275, 200, 187, 173, 90];

Widget _chartPieSimple(BuildContext context) {
  return Chart(
    type: ChartType.pie,
    height: 250,
    labels: _browserNames,
    series: <ChartSeries>[ChartSeries(values: _browserVisitors)],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Pie Chart - Separator None',
      builder: '_chartPieSeparatorNone',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _browserNames = <String>[
  'Chrome',
  'Safari',
  'Firefox',
  'Edge',
  'Other',
];

const List<double> _browserVisitors = <double>[275, 200, 187, 173, 90];

Widget _chartPieSeparatorNone(BuildContext context) {
  return Chart(
    type: ChartType.pie,
    height: 250,
    labels: _browserNames,
    pie: ChartPieConfig(showDividers: false),
    series: <ChartSeries>[ChartSeries(values: _browserVisitors)],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Pie Chart - Label',
      builder: '_chartPieLabel',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _browserNames = <String>[
  'Chrome',
  'Safari',
  'Firefox',
  'Edge',
  'Other',
];

const List<double> _browserVisitors = <double>[275, 200, 187, 173, 90];

Widget _chartPieLabel(BuildContext context) {
  return Chart(
    type: ChartType.pie,
    height: 250,
    labels: _browserNames,
    pie: ChartPieConfig(labels: ChartPieLabels.outside),
    series: <ChartSeries>[ChartSeries(values: _browserVisitors)],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Pie Chart - Custom Label',
      builder: '_chartPieLabelCustom',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _browserNames = <String>[
  'Chrome',
  'Safari',
  'Firefox',
  'Edge',
  'Other',
];

const List<double> _browserVisitors = <double>[275, 200, 187, 173, 90];

Widget _chartPieLabelCustom(BuildContext context) {
  return Chart(
    type: ChartType.pie,
    height: 250,
    labels: _browserNames,
    pie: ChartPieConfig(labels: ChartPieLabels.outside, labelValues: true),
    series: <ChartSeries>[ChartSeries(values: _browserVisitors)],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Pie Chart - Label List',
      builder: '_chartPieLabelList',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _browserNames = <String>[
  'Chrome',
  'Safari',
  'Firefox',
  'Edge',
  'Other',
];

const List<double> _browserVisitors = <double>[275, 200, 187, 173, 90];

Widget _chartPieLabelList(BuildContext context) {
  return Chart(
    type: ChartType.pie,
    height: 250,
    labels: _browserNames,
    pie: ChartPieConfig(labels: ChartPieLabels.inside),
    series: <ChartSeries>[ChartSeries(values: _browserVisitors)],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Pie Chart - Legend',
      builder: '_chartPieLegend',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _browserNames = <String>[
  'Chrome',
  'Safari',
  'Firefox',
  'Edge',
  'Other',
];

const List<double> _browserVisitors = <double>[275, 200, 187, 173, 90];

Widget _chartPieLegend(BuildContext context) {
  return Chart(
    type: ChartType.pie,
    height: 250,
    labels: _browserNames,
    series: <ChartSeries>[
      ChartSeries(
        label: 'Browsers',
        values: _browserVisitors,
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Pie Chart - Donut',
      builder: '_chartPieDonut',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _browserNames = <String>[
  'Chrome',
  'Safari',
  'Firefox',
  'Edge',
  'Other',
];

const List<double> _browserVisitors = <double>[275, 200, 187, 173, 90];

Widget _chartPieDonut(BuildContext context) {
  return Chart(
    type: ChartType.donut,
    height: 250,
    labels: _browserNames,
    series: <ChartSeries>[ChartSeries(values: _browserVisitors)],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Pie Chart - Donut Active',
      builder: '_chartPieDonutActive',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _browserNames = <String>[
  'Chrome',
  'Safari',
  'Firefox',
  'Edge',
  'Other',
];

const List<double> _browserVisitors = <double>[275, 200, 187, 173, 90];

Widget _chartPieDonutActive(BuildContext context) {
  return Chart(
    type: ChartType.donut,
    height: 250,
    labels: _browserNames,
    initialSelectedIndex: 1,
    series: <ChartSeries>[ChartSeries(values: _browserVisitors)],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Pie Chart - Donut with Text',
      builder: '_chartPieDonutText',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _browserNames = <String>[
  'Chrome',
  'Safari',
  'Firefox',
  'Edge',
  'Other',
];

const List<double> _browserVisitors = <double>[275, 200, 187, 173, 90];

Widget _chartPieDonutText(BuildContext context) {
  return Chart(
    type: ChartType.donut,
    height: 250,
    labels: _browserNames,
    centerLabel: '925',
    centerSublabel: 'Visitors',
    series: <ChartSeries>[ChartSeries(values: _browserVisitors)],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Pie Chart - Stacked',
      builder: '_chartPieStacked',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

Widget _chartPieStacked(BuildContext context) {
  return Chart(
    type: ChartType.donut,
    height: 250,
    labels: <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
    ],
    showLegend: false,
    pie: ChartPieConfig(stacked: true),
    tooltip: ChartTooltipConfig(indicator: ChartTooltipIndicator.line),
    series: <ChartSeries>[
      ChartSeries(
        label: 'Desktop',
        values: <double>[186, 305, 237, 173, 209],
      ),
      ChartSeries(
        label: 'Mobile',
        values: <double>[80, 200, 120, 190, 130],
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Pie Chart - Interactive',
      builder: '_chartPieInteractive',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<double> _browserVisitors = <double>[275, 200, 187, 173, 90];

List<Color> _browserColors(BuildContext context) {
  final List<Color> palette = Theme.of(context).colors.chartColors;
  return <Color>[
    for (var i = 0; i < _browserVisitors.length; i++)
      palette[i % palette.length],
  ];
}

/// Interactive donut chart with a dropdown driving the active slice.
class _PieInteractive extends StatefulWidget {
  const _PieInteractive();

  @override
  State<_PieInteractive> createState() => _PieInteractiveState();
}

class _PieInteractiveState extends State<_PieInteractive> {
  static List<String> months = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
  ];
  static const List<double> visitors = <double>[186, 305, 237, 173, 209];

  int _active = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: _PieDropdown(
            options: months,
            selected: months[_active],
            dots: _browserColors(context),
            onSelect: (String value) =>
                setState(() => _active = months.indexOf(value)),
          ),
        ),
        const SizedBox(height: 8),
        Chart(
          type: ChartType.donut,
          height: 250,
          labels: months,
          initialSelectedIndex: _active,
          onSelected: (int? index) {
            if (index != null && index != _active) {
              setState(() => _active = index);
            }
          },
          centerLabel: '${visitors[_active].toInt()}',
          centerSublabel: 'Visitors',
          pie: const ChartPieConfig(activeRing: true),
          tooltip: const ChartTooltipConfig(showLabel: false),
          series: <ChartSeries>[
            ChartSeries(values: visitors, pointColors: _browserColors(context)),
          ],
        ),
      ],
    );
  }
}

/// Minimal dropdown trigger with an expanding option list (widgets only).
class _PieDropdown extends StatefulWidget {
  const _PieDropdown({
    required this.options,
    required this.selected,
    required this.dots,
    required this.onSelect,
  });

  final List<String> options;
  final String selected;

  /// Swatch per option, in option order.
  final List<Color> dots;

  final ValueChanged<String> onSelect;

  @override
  State<_PieDropdown> createState() => _PieDropdownState();
}

class _PieDropdownState extends State<_PieDropdown> {
  bool _open = false;

  Color _dot(int index) {
    if (widget.dots.isEmpty) {
      return const Color(0x00000000);
    }
    return widget.dots[index % widget.dots.length];
  }

  Widget _swatch(int index) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: _dot(index),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colors;
    final TextStyle itemStyle = TextStyle(
      fontSize: 12,
      color: colors.foreground,
    );
    final int selectedIndex = widget.options
        .indexOf(widget.selected)
        .clamp(0, widget.options.length - 1);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: () => setState(() => _open = !_open),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colors.border),
              color: colors.background,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _swatch(selectedIndex),
                const SizedBox(width: 6),
                Text(widget.selected, style: itemStyle),
                const SizedBox(width: 6),
                Icon(
                  LucideIcons.chevronDown,
                  size: 14,
                  color: colors.mutedForeground,
                ),
              ],
            ),
          ),
        ),
        if (_open)
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colors.border),
              color: colors.popover,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for (var i = 0; i < widget.options.length; i++)
                  GestureDetector(
                    onTap: () {
                      widget.onSelect(widget.options[i]);
                      setState(() => _open = false);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      color: widget.options[i] == widget.selected
                          ? colors.accent
                          : const Color(0x00000000),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _swatch(i),
                          const SizedBox(width: 6),
                          Text(
                            widget.options[i],
                            style: TextStyle(
                              fontSize: 12,
                              color: widget.options[i] == widget.selected
                                  ? colors.accentForeground
                                  : colors.foreground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

Widget _chartPieInteractive(BuildContext context) => const _PieInteractive();
''',
    ),
    DocsExampleSource(
      name: 'Scatter',
      builder: '_chartScatter',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

Widget _chartScatter(BuildContext context) {
  return Chart(
    type: ChartType.scatter,
    series: <ChartSeries>[
      ChartSeries(
        label: 'Latency',
        values: <double>[2, 5, 3, 8, 6, 9, 4],
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Sparkline',
      builder: '_chartSparkline',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

Widget _chartSparkline(BuildContext context) {
  return const SizedBox(
    width: 160,
    child: Chart(
      type: ChartType.sparkline,
      data: <double>[1, 3, 2, 5, 4, 6],
      height: 48,
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Streaming',
      builder: '_chartStreaming',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

/// Live streaming demo: appends a point every 800 ms into a 40-point window.
class _ChartStreaming extends StatefulWidget {
  const _ChartStreaming();

  @override
  State<_ChartStreaming> createState() => _ChartStreamingState();
}

class _ChartStreamingState extends State<_ChartStreaming> {
  late final ChartController _controller;
  Timer? _timer;
  double _t = 6;

  @override
  void initState() {
    super.initState();
    _controller = ChartController(
      maxPoints: 40,
      initial: <ChartSeries>[
        ChartSeries(
          label: 'Live',
          values: <double>[3, 5, 2, 6, 4, 7],
        ),
      ],
    );
    _timer = Timer.periodic(const Duration(milliseconds: 800), (_) {
      _t += 1;
      final double next = 5 + (_t % 7) - 3 + ((_t * 37) % 5) / 5;
      _controller.append(next);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chart(
      controller: _controller,
      semanticsLabel: 'Streaming line chart, last 40 points',
    );
  }
}

Widget _chartStreaming(BuildContext context) => const _ChartStreaming();
''',
    ),
    DocsExampleSource(
      name: 'Radar Chart',
      builder: '_chartRadarDefault',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _radarMonths = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
];

const List<double> _radarDesktop = <double>[186, 305, 237, 73, 209, 214];

Widget _chartRadarDefault(BuildContext context) {
  return Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _radarDesktop),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Radar Chart - Dots',
      builder: '_chartRadarDots',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _radarMonths = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
];

const List<double> _radarDesktop = <double>[186, 305, 237, 73, 209, 214];

Widget _chartRadarDots(BuildContext context) {
  return Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    showMarkers: true,
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _radarDesktop),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Radar Chart - Lines Only',
      builder: '_chartRadarLinesOnly',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _radarMonths = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
];

const List<double> _radarDesktop = <double>[186, 305, 237, 73, 209, 214];

Widget _chartRadarLinesOnly(BuildContext context) {
  return Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    series: <ChartSeries>[
      ChartSeries(
        label: 'Desktop',
        values: _radarDesktop,
        fillOpacity: 0,
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Radar Chart - Custom Label',
      builder: '_chartRadarLabelCustom',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _radarMonths = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
];

const List<double> _radarDesktop = <double>[186, 305, 237, 73, 209, 214];

const List<double> _radarMobile = <double>[80, 200, 120, 190, 130, 140];

Widget _chartRadarLabelCustom(BuildContext context) {
  return Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    radar: ChartRadarConfig(showValues: true),
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _radarDesktop),
      ChartSeries(label: 'Mobile', values: _radarMobile),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Radar Chart - Grid Custom',
      builder: '_chartRadarGridCustom',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _radarMonths = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
];

const List<double> _radarDesktop = <double>[186, 305, 237, 73, 209, 214];

Widget _chartRadarGridCustom(BuildContext context) {
  return Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    radar: ChartRadarConfig(rings: 1, showSpokes: false),
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _radarDesktop),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Radar Chart - Grid None',
      builder: '_chartRadarGridNone',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _radarMonths = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
];

const List<double> _radarDesktop = <double>[186, 305, 237, 73, 209, 214];

Widget _chartRadarGridNone(BuildContext context) {
  return Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    radar: ChartRadarConfig(grid: ChartRadarGrid.none),
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _radarDesktop),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Radar Chart - Grid Circle',
      builder: '_chartRadarGridCircle',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _radarMonths = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
];

const List<double> _radarDesktop = <double>[186, 305, 237, 73, 209, 214];

Widget _chartRadarGridCircle(BuildContext context) {
  return Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    radar: ChartRadarConfig(grid: ChartRadarGrid.circle),
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _radarDesktop),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Radar Chart - Grid Circle - No lines',
      builder: '_chartRadarGridCircleNoLines',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _radarMonths = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
];

const List<double> _radarDesktop = <double>[186, 305, 237, 73, 209, 214];

Widget _chartRadarGridCircleNoLines(BuildContext context) {
  return Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    radar: ChartRadarConfig(grid: ChartRadarGrid.circle, showSpokes: false),
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _radarDesktop),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Radar Chart - Grid Circle Filled',
      builder: '_chartRadarGridCircleFilled',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _radarMonths = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
];

const List<double> _radarDesktop = <double>[186, 305, 237, 73, 209, 214];

Widget _chartRadarGridCircleFilled(BuildContext context) {
  return Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    radar: ChartRadarConfig(grid: ChartRadarGrid.circle, filled: true),
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _radarDesktop),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Radar Chart - Grid Filled',
      builder: '_chartRadarGridFilled',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _radarMonths = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
];

const List<double> _radarDesktop = <double>[186, 305, 237, 73, 209, 214];

Widget _chartRadarGridFilled(BuildContext context) {
  return Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    radar: ChartRadarConfig(filled: true),
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _radarDesktop),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Radar Chart - Multiple',
      builder: '_chartRadarMultiple',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _radarMonths = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
];

const List<double> _radarDesktop = <double>[186, 305, 237, 73, 209, 214];

const List<double> _radarMobile = <double>[80, 200, 120, 190, 130, 140];

Widget _chartRadarMultiple(BuildContext context) {
  return Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _radarDesktop),
      ChartSeries(label: 'Mobile', values: _radarMobile),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Radar Chart - Legend',
      builder: '_chartRadarLegend',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

List<String> _radarMonths = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
];

const List<double> _radarDesktop = <double>[186, 305, 237, 73, 209, 214];

const List<double> _radarMobile = <double>[80, 200, 120, 190, 130, 140];

Widget _chartRadarLegend(BuildContext context) {
  return Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _radarDesktop),
      ChartSeries(label: 'Mobile', values: _radarMobile),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Radial Chart',
      builder: '_chartRadialSimple',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<double> _radialBrowserValues = <double>[275, 200, 187, 173, 90];

List<String> _radialBrowserLabels = <String>[
  'Chrome',
  'Safari',
  'Firefox',
  'Edge',
  'Other',
];

List<ChartSeries> _radialBrowsers({bool labeled = true}) {
  return <ChartSeries>[
    for (var i = 0; i < _radialBrowserValues.length; i++)
      ChartSeries(
        label: labeled ? _radialBrowserLabels[i] : null,
        values: <double>[_radialBrowserValues[i]],
      ),
  ];
}

Widget _chartRadialSimple(BuildContext context) {
  return Chart(
    type: ChartType.radial,
    height: 260,
    showLegend: false,
    series: _radialBrowsers(),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Radial Chart - Label',
      builder: '_chartRadialLabel',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

Widget _chartRadialLabel(BuildContext context) {
  return Chart(
    type: ChartType.radial,
    height: 260,
    showLegend: false,
    radial: ChartRadialConfig(showRingLabels: true),
    series: <ChartSeries>[
      ChartSeries(label: 'Chrome', values: <double>[275]),
      ChartSeries(label: 'Safari', values: <double>[200]),
      ChartSeries(label: 'Firefox', values: <double>[187]),
      ChartSeries(label: 'Edge', values: <double>[173]),
      ChartSeries(label: 'Other', values: <double>[90]),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Radial Chart - Grid',
      builder: '_chartRadialGrid',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<double> _radialBrowserValues = <double>[275, 200, 187, 173, 90];

List<String> _radialBrowserLabels = <String>[
  'Chrome',
  'Safari',
  'Firefox',
  'Edge',
  'Other',
];

List<ChartSeries> _radialBrowsers({bool labeled = true}) {
  return <ChartSeries>[
    for (var i = 0; i < _radialBrowserValues.length; i++)
      ChartSeries(
        label: labeled ? _radialBrowserLabels[i] : null,
        values: <double>[_radialBrowserValues[i]],
      ),
  ];
}

Widget _chartRadialGrid(BuildContext context) {
  return Chart(
    type: ChartType.radial,
    height: 260,
    showLegend: false,
    radial: const ChartRadialConfig(showGrid: true),
    series: _radialBrowsers(),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Radial Chart - Text',
      builder: '_chartRadialText',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

Widget _chartRadialText(BuildContext context) {
  return Chart(
    type: ChartType.radial,
    height: 260,
    showLegend: false,
    centerLabel: '200',
    centerSublabel: 'Visitors',
    radial: ChartRadialConfig(sweep: 250 / 360, rounded: true),
    series: <ChartSeries>[
      ChartSeries(values: <double>[200]),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Radial Chart - Shape',
      builder: '_chartRadialShape',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

Widget _chartRadialShape(BuildContext context) {
  return Chart(
    type: ChartType.radial,
    height: 260,
    showLegend: false,
    centerLabel: '1,260',
    centerSublabel: 'Visitors',
    radial: ChartRadialConfig(sweep: 100 / 360, thickness: 0.35),
    series: <ChartSeries>[
      ChartSeries(values: <double>[1260]),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Radial Chart - Stacked',
      builder: '_chartRadialStacked',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

Widget _chartRadialStacked(BuildContext context) {
  return Chart(
    type: ChartType.radial,
    height: 260,
    showLegend: false,
    centerLabel: '1,830',
    centerSublabel: 'Visitors',
    radial: ChartRadialConfig(sweep: 0.5, stacked: true, rounded: true),
    series: <ChartSeries>[
      ChartSeries(label: 'Mobile', values: <double>[570]),
      ChartSeries(
        label: 'Desktop',
        values: <double>[1260],
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Tooltip - Default',
      builder: '_chartTooltipDefault',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<String> _tooltipDays = <String>[
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
];

const List<double> _tooltipRunning = <double>[450, 380, 520, 140, 600, 480];

const List<double> _tooltipSwimming = <double>[300, 420, 120, 550, 350, 400];

Chart _tooltipBase({
  ChartTooltipConfig tooltip = const ChartTooltipConfig(),
  List<ChartSeries>? series,
}) {
  return Chart(
    type: ChartType.bar,
    barMode: ChartBarMode.stacked,
    labels: _tooltipDays,
    height: 220,
    initialSelectedIndex: 1,
    tooltip: tooltip,
    series:
        series ??
        <ChartSeries>[
          ChartSeries(
            label: 'Running',
            values: _tooltipRunning,
          ),
          ChartSeries(
            label: 'Swimming',
            values: _tooltipSwimming,
          ),
        ],
  );
}

Widget _chartTooltipDefault(BuildContext context) => _tooltipBase();
''',
    ),
    DocsExampleSource(
      name: 'Tooltip - Line Indicator',
      builder: '_chartTooltipLineIndicator',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<String> _tooltipDays = <String>[
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
];

const List<double> _tooltipRunning = <double>[450, 380, 520, 140, 600, 480];

const List<double> _tooltipSwimming = <double>[300, 420, 120, 550, 350, 400];

Chart _tooltipBase({
  ChartTooltipConfig tooltip = const ChartTooltipConfig(),
  List<ChartSeries>? series,
}) {
  return Chart(
    type: ChartType.bar,
    barMode: ChartBarMode.stacked,
    labels: _tooltipDays,
    height: 220,
    initialSelectedIndex: 1,
    tooltip: tooltip,
    series:
        series ??
        <ChartSeries>[
          ChartSeries(
            label: 'Running',
            values: _tooltipRunning,
          ),
          ChartSeries(
            label: 'Swimming',
            values: _tooltipSwimming,
          ),
        ],
  );
}

Widget _chartTooltipLineIndicator(BuildContext context) => _tooltipBase(
  tooltip: const ChartTooltipConfig(indicator: ChartTooltipIndicator.line),
);
''',
    ),
    DocsExampleSource(
      name: 'Tooltip - No Indicator',
      builder: '_chartTooltipNoIndicator',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<String> _tooltipDays = <String>[
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
];

const List<double> _tooltipRunning = <double>[450, 380, 520, 140, 600, 480];

const List<double> _tooltipSwimming = <double>[300, 420, 120, 550, 350, 400];

Chart _tooltipBase({
  ChartTooltipConfig tooltip = const ChartTooltipConfig(),
  List<ChartSeries>? series,
}) {
  return Chart(
    type: ChartType.bar,
    barMode: ChartBarMode.stacked,
    labels: _tooltipDays,
    height: 220,
    initialSelectedIndex: 1,
    tooltip: tooltip,
    series:
        series ??
        <ChartSeries>[
          ChartSeries(
            label: 'Running',
            values: _tooltipRunning,
          ),
          ChartSeries(
            label: 'Swimming',
            values: _tooltipSwimming,
          ),
        ],
  );
}

Widget _chartTooltipNoIndicator(BuildContext context) => _tooltipBase(
  tooltip: const ChartTooltipConfig(indicator: ChartTooltipIndicator.none),
);
''',
    ),
    DocsExampleSource(
      name: 'Tooltip - Custom label',
      builder: '_chartTooltipCustomLabel',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<String> _tooltipDays = <String>[
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
];

const List<double> _tooltipRunning = <double>[450, 380, 520, 140, 600, 480];

const List<double> _tooltipSwimming = <double>[300, 420, 120, 550, 350, 400];

Chart _tooltipBase({
  ChartTooltipConfig tooltip = const ChartTooltipConfig(),
  List<ChartSeries>? series,
}) {
  return Chart(
    type: ChartType.bar,
    barMode: ChartBarMode.stacked,
    labels: _tooltipDays,
    height: 220,
    initialSelectedIndex: 1,
    tooltip: tooltip,
    series:
        series ??
        <ChartSeries>[
          ChartSeries(
            label: 'Running',
            values: _tooltipRunning,
          ),
          ChartSeries(
            label: 'Swimming',
            values: _tooltipSwimming,
          ),
        ],
  );
}

String _tooltipCustomLabel(int index) => 'Activities';

Widget _chartTooltipCustomLabel(BuildContext context) => _tooltipBase(
  tooltip: const ChartTooltipConfig(
    indicator: ChartTooltipIndicator.line,
    labelFormatter: _tooltipCustomLabel,
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Tooltip - Label Formatter',
      builder: '_chartTooltipLabelFormatter',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<String> _tooltipDays = <String>[
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
];

const List<double> _tooltipRunning = <double>[450, 380, 520, 140, 600, 480];

const List<double> _tooltipSwimming = <double>[300, 420, 120, 550, 350, 400];

Chart _tooltipBase({
  ChartTooltipConfig tooltip = const ChartTooltipConfig(),
  List<ChartSeries>? series,
}) {
  return Chart(
    type: ChartType.bar,
    barMode: ChartBarMode.stacked,
    labels: _tooltipDays,
    height: 220,
    initialSelectedIndex: 1,
    tooltip: tooltip,
    series:
        series ??
        <ChartSeries>[
          ChartSeries(
            label: 'Running',
            values: _tooltipRunning,
          ),
          ChartSeries(
            label: 'Swimming',
            values: _tooltipSwimming,
          ),
        ],
  );
}

String _tooltipWeekday(int index) => _tooltipDays[index];

Widget _chartTooltipLabelFormatter(BuildContext context) => _tooltipBase(
  tooltip: const ChartTooltipConfig(labelFormatter: _tooltipWeekday),
);
''',
    ),
    DocsExampleSource(
      name: 'Tooltip - No Label',
      builder: '_chartTooltipNoLabel',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<String> _tooltipDays = <String>[
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
];

const List<double> _tooltipRunning = <double>[450, 380, 520, 140, 600, 480];

const List<double> _tooltipSwimming = <double>[300, 420, 120, 550, 350, 400];

Chart _tooltipBase({
  ChartTooltipConfig tooltip = const ChartTooltipConfig(),
  List<ChartSeries>? series,
}) {
  return Chart(
    type: ChartType.bar,
    barMode: ChartBarMode.stacked,
    labels: _tooltipDays,
    height: 220,
    initialSelectedIndex: 1,
    tooltip: tooltip,
    series:
        series ??
        <ChartSeries>[
          ChartSeries(
            label: 'Running',
            values: _tooltipRunning,
          ),
          ChartSeries(
            label: 'Swimming',
            values: _tooltipSwimming,
          ),
        ],
  );
}

Widget _chartTooltipNoLabel(BuildContext context) =>
    _tooltipBase(tooltip: const ChartTooltipConfig(showLabel: false));
''',
    ),
    DocsExampleSource(
      name: 'Tooltip - Formatter',
      builder: '_chartTooltipFormatter',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<String> _tooltipDays = <String>[
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
];

const List<double> _tooltipRunning = <double>[450, 380, 520, 140, 600, 480];

const List<double> _tooltipSwimming = <double>[300, 420, 120, 550, 350, 400];

Chart _tooltipBase({
  ChartTooltipConfig tooltip = const ChartTooltipConfig(),
  List<ChartSeries>? series,
}) {
  return Chart(
    type: ChartType.bar,
    barMode: ChartBarMode.stacked,
    labels: _tooltipDays,
    height: 220,
    initialSelectedIndex: 1,
    tooltip: tooltip,
    series:
        series ??
        <ChartSeries>[
          ChartSeries(
            label: 'Running',
            values: _tooltipRunning,
          ),
          ChartSeries(
            label: 'Swimming',
            values: _tooltipSwimming,
          ),
        ],
  );
}

Widget _chartTooltipFormatter(BuildContext context) => _tooltipBase(
  tooltip: ChartTooltipConfig(showLabel: false, valueSuffix: ' kcal'),
);
''',
    ),
    DocsExampleSource(
      name: 'Tooltip - Icons',
      builder: '_chartTooltipIcons',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<String> _tooltipDays = <String>[
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
];

const List<double> _tooltipRunning = <double>[450, 380, 520, 140, 600, 480];

const List<double> _tooltipSwimming = <double>[300, 420, 120, 550, 350, 400];

Chart _tooltipBase({
  ChartTooltipConfig tooltip = const ChartTooltipConfig(),
  List<ChartSeries>? series,
}) {
  return Chart(
    type: ChartType.bar,
    barMode: ChartBarMode.stacked,
    labels: _tooltipDays,
    height: 220,
    initialSelectedIndex: 1,
    tooltip: tooltip,
    series:
        series ??
        <ChartSeries>[
          ChartSeries(
            label: 'Running',
            values: _tooltipRunning,
          ),
          ChartSeries(
            label: 'Swimming',
            values: _tooltipSwimming,
          ),
        ],
  );
}

Widget _chartTooltipIcons(BuildContext context) => _tooltipBase(
  tooltip: const ChartTooltipConfig(showLabel: false),
  series: <ChartSeries>[
    ChartSeries(
      label: 'Running',
      values: _tooltipRunning,
      icon: Icon(LucideIcons.footprints),
    ),
    ChartSeries(
      label: 'Swimming',
      values: _tooltipSwimming,
      icon: Icon(LucideIcons.waves),
    ),
  ],
);
''',
    ),
    DocsExampleSource(
      name: 'Tooltip - Advanced',
      builder: '_chartTooltipAdvanced',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';

const List<String> _tooltipDays = <String>[
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
];

const List<double> _tooltipRunning = <double>[450, 380, 520, 140, 600, 480];

const List<double> _tooltipSwimming = <double>[300, 420, 120, 550, 350, 400];

Chart _tooltipBase({
  ChartTooltipConfig tooltip = const ChartTooltipConfig(),
  List<ChartSeries>? series,
}) {
  return Chart(
    type: ChartType.bar,
    barMode: ChartBarMode.stacked,
    labels: _tooltipDays,
    height: 220,
    initialSelectedIndex: 1,
    tooltip: tooltip,
    series:
        series ??
        <ChartSeries>[
          ChartSeries(
            label: 'Running',
            values: _tooltipRunning,
          ),
          ChartSeries(
            label: 'Swimming',
            values: _tooltipSwimming,
          ),
        ],
  );
}

Widget _chartTooltipAdvanced(BuildContext context) => _tooltipBase(
  tooltip: ChartTooltipConfig(
    showLabel: false,
    valueSuffix: ' kcal',
    showTotal: true,
  ),
);
''',
    ),
  ],
  'chat': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_chatDefault',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/text_area/text_area.dart';
import 'package:<your_app>/ui/dashcn/components/chat/chat.dart';

/// A round initials avatar drawn with theme tokens.
class _ChatAvatar extends StatelessWidget {
  const _ChatAvatar(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colors.muted,
        shape: BoxShape.circle,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          // Initials sit on the muted circle: the raw token fails AA on it.
          color: theme.colors.onMuted,
        ),
      ),
    );
  }
}

/// The conversation column, bounded so the stage never overflows.
class _ChatConversation extends StatelessWidget {
  const _ChatConversation();

  static const Widget _start = _ChatAvatar('JO');
  static const Widget _end = _ChatAvatar('AI');

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ChatGroup(
              avatarSuffix: _end,
              children: <Widget>[
                ChatBubble(
                  child: Text(
                    'Did you remember the meeting time?',
                  ),
                ),
                ChatBubble(
                  child: Text('Please reply ASAP.'),
                ),
              ],
            ),
            Gap(spacing.lg),
            ChatGroup(
              avatarPrefix: _start,
              children: <Widget>[
                ChatBubble(child: Text('Around 6 or 7?')),
                ChatBubble(
                  child: Text('New phone who dis?'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _chatDefault(BuildContext context) => const _ChatConversation();
''',
    ),
    DocsExampleSource(
      name: 'Incoming',
      builder: '_chatIncoming',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/text_area/text_area.dart';
import 'package:<your_app>/ui/dashcn/components/chat/chat.dart';

/// A round initials avatar drawn with theme tokens.
class _ChatAvatar extends StatelessWidget {
  const _ChatAvatar(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colors.muted,
        shape: BoxShape.circle,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          // Initials sit on the muted circle: the raw token fails AA on it.
          color: theme.colors.onMuted,
        ),
      ),
    );
  }
}

/// The conversation column, bounded so the stage never overflows.
class _ChatConversation extends StatelessWidget {
  const _ChatConversation();

  static const Widget _start = _ChatAvatar('JO');
  static const Widget _end = _ChatAvatar('AI');

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ChatGroup(
              avatarSuffix: _end,
              children: <Widget>[
                ChatBubble(
                  child: Text(
                    'Did you remember the meeting time?',
                  ),
                ),
                ChatBubble(
                  child: Text('Please reply ASAP.'),
                ),
              ],
            ),
            Gap(spacing.lg),
            ChatGroup(
              avatarPrefix: _start,
              children: <Widget>[
                ChatBubble(child: Text('Around 6 or 7?')),
                ChatBubble(
                  child: Text('New phone who dis?'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Incoming bubbles only.
Widget _chatIncoming(BuildContext context) {
  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ChatGroup(
            avatarPrefix: _ChatConversation._start,
            children: <Widget>[
              ChatBubble(
                child: Text('Is the build green yet?'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Outgoing',
      builder: '_chatOutgoing',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/text_area/text_area.dart';
import 'package:<your_app>/ui/dashcn/components/chat/chat.dart';

/// A round initials avatar drawn with theme tokens.
class _ChatAvatar extends StatelessWidget {
  const _ChatAvatar(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colors.muted,
        shape: BoxShape.circle,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          // Initials sit on the muted circle: the raw token fails AA on it.
          color: theme.colors.onMuted,
        ),
      ),
    );
  }
}

/// The conversation column, bounded so the stage never overflows.
class _ChatConversation extends StatelessWidget {
  const _ChatConversation();

  static const Widget _start = _ChatAvatar('JO');
  static const Widget _end = _ChatAvatar('AI');

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ChatGroup(
              avatarSuffix: _end,
              children: <Widget>[
                ChatBubble(
                  child: Text(
                    'Did you remember the meeting time?',
                  ),
                ),
                ChatBubble(
                  child: Text('Please reply ASAP.'),
                ),
              ],
            ),
            Gap(spacing.lg),
            ChatGroup(
              avatarPrefix: _start,
              children: <Widget>[
                ChatBubble(child: Text('Around 6 or 7?')),
                ChatBubble(
                  child: Text('New phone who dis?'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Outgoing bubbles only.
Widget _chatOutgoing(BuildContext context) {
  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ChatGroup(
            avatarSuffix: _ChatConversation._end,
            children: <Widget>[
              ChatBubble(
                child: Text(
                  'Deploying now - two minutes.',
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Grouped',
      builder: '_chatGrouped',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/text_area/text_area.dart';
import 'package:<your_app>/ui/dashcn/components/chat/chat.dart';

/// A round initials avatar drawn with theme tokens.
class _ChatAvatar extends StatelessWidget {
  const _ChatAvatar(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colors.muted,
        shape: BoxShape.circle,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          // Initials sit on the muted circle: the raw token fails AA on it.
          color: theme.colors.onMuted,
        ),
      ),
    );
  }
}

/// The conversation column, bounded so the stage never overflows.
class _ChatConversation extends StatelessWidget {
  const _ChatConversation();

  static const Widget _start = _ChatAvatar('JO');
  static const Widget _end = _ChatAvatar('AI');

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ChatGroup(
              avatarSuffix: _end,
              children: <Widget>[
                ChatBubble(
                  child: Text(
                    'Did you remember the meeting time?',
                  ),
                ),
                ChatBubble(
                  child: Text('Please reply ASAP.'),
                ),
              ],
            ),
            Gap(spacing.lg),
            ChatGroup(
              avatarPrefix: _start,
              children: <Widget>[
                ChatBubble(child: Text('Around 6 or 7?')),
                ChatBubble(
                  child: Text('New phone who dis?'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A grouped run with a tailed shape and a live reaction row.
class _ChatGrouped extends StatefulWidget {
  const _ChatGrouped();

  @override
  State<_ChatGrouped> createState() => _ChatGroupedState();
}

class _ChatGroupedState extends State<_ChatGrouped> {
  bool _thumbsUp = true;
  bool _party = false;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ChatGroup(
              avatarPrefix: _ChatConversation._start,
              children: <Widget>[
                ChatBubble(child: Text('First message')),
                ChatBubble(child: Text('Second message')),
                ChatBubble(child: Text('Third message')),
              ],
            ),
            Gap(spacing.sm),
            ChatReaction(
              chips: <Widget>[
                ChatReactionContainer(
                  onTap: () => setState(() => _thumbsUp = !_thumbsUp),
                  selected: _thumbsUp,
                  child: Text('\u{1F44D} ${_thumbsUp ? 4 : 3}'),
                ),
                ChatReactionContainer(
                  onTap: () => setState(() => _party = !_party),
                  selected: _party,
                  child: Text('\u{1F389} ${_party ? 2 : 1}'),
                ),
              ],
              child: ChatBubble(child: Text('Nice work!')),
            ),
            Gap(spacing.lg),
            ComponentTheme<ChatTheme>(
              data: const ChatTheme(
                widthFactor: 0.8,
                background: ThemedColor.ref(ColorRef.accent),
                foreground: ThemedColor.ref(ColorRef.accentForeground),
              ),
              child: ChatGroup(
                children: <Widget>[
                  ChatBubble(
                    child: Text('Accented group bubble.'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _chatGrouped(BuildContext context) => const _ChatGrouped();
''',
    ),
    DocsExampleSource(
      name: 'Live',
      builder: '_chatLive',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/text_area/text_area.dart';
import 'package:<your_app>/ui/dashcn/components/chat/chat.dart';

Widget _chatLive(BuildContext context) => const _ChatLive();

/// One message of the live demo thread.
class _LiveMessage {
  const _LiveMessage(this.text, this.mine);

  final String text;
  final bool mine;
}

/// Canned agent replies, cycled in order.
List<String> _liveReplies = <String>[
  'Got it — pulling up your payout history now.',
  'That month was prorated after the reissue; I can send the breakdown.',
  'All set — refresh the report to see the corrected split.',
];

/// A working support thread: typing + Enter/Send appends the user's bubble,
/// a typing indicator shows after ~800 ms, then a canned agent reply lands.
/// The list auto-scrolls and Send stays disabled while the field is empty.
class _ChatLive extends StatefulWidget {
  const _ChatLive();

  @override
  State<_ChatLive> createState() => _ChatLiveState();
}

class _ChatLiveState extends State<_ChatLive> {
  final List<_LiveMessage> _messages = <_LiveMessage>[
    _LiveMessage(
      'Can you re-check the 2026-01 payout?',
      true,
    ),
    _LiveMessage(
      'I see it — that month was prorated.',
      false,
    ),
  ];
  final TextEditingController _reply = TextEditingController();
  final ScrollController _scroll = ScrollController();
  bool _canSend = false;
  bool _typing = false;
  int _nextReply = 0;
  int _sendCount = 0;

  @override
  void initState() {
    super.initState();
    _reply.addListener(_syncSend);
  }

  @override
  void dispose() {
    _reply.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _syncSend() {
    final bool next = _reply.text.trim().isNotEmpty;
    if (next != _canSend) {
      setState(() => _canSend = next);
    }
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scroll.hasClients) {
        return;
      }
      _scroll.jumpTo(_scroll.position.maxScrollExtent);
    });
  }

  Future<void> _send() async {
    final String text = _reply.text.trim();
    if (text.isEmpty || _typing) {
      return;
    }
    final int ticket = ++_sendCount;
    setState(() {
      _messages.add(_LiveMessage(text, true));
      _reply.clear();
    });
    _scrollToEnd();
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted || ticket != _sendCount) {
      return;
    }
    setState(() => _typing = true);
    _scrollToEnd();
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted || ticket != _sendCount) {
      return;
    }
    setState(() {
      _typing = false;
      _messages.add(
        _LiveMessage(_liveReplies[_nextReply % _liveReplies.length], false),
      );
      _nextReply++;
    });
    _scrollToEnd();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 220),
              child: SingleChildScrollView(
                controller: _scroll,
                child: ChatGroup(
                  children: <Widget>[
                    for (final _LiveMessage message in _messages)
                      ChatBubble(
                        theme: message.mine ? null : _incomingBubble,
                        variant: message.mine
                            ? ChatBubbleVariant.tail
                            : ChatBubbleVariant.plain,
                        child: Text(message.text),
                      ),
                    if (_typing)
                      const ChatBubble(
                        theme: _incomingBubble,
                        child: _TypingDots(),
                      ),
                  ],
                ),
              ),
            ),
            Gap(spacing.md),
            TextArea(
              controller: _reply,
              minLines: 1,
              maxLines: 4,
              hintText: 'Write a reply...',
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _send(),
            ),
            Gap(spacing.md),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Button(
                variant: ButtonVariant.primary,
                size: ButtonSize.sm,
                leading: const Icon(LucideIcons.send, size: 14),
                enabled: _canSend,
                onPressed: _send,
                child: Text('Send'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Three static dots shown while the agent "types" (static: no ticker, so
/// the ticker-off static collage and the 720x420 preview stage stay still).
class _TypingDots extends StatelessWidget {
  const _TypingDots();

  @override
  Widget build(BuildContext context) {
    final Color dot = Theme.of(context).colors.mutedForeground;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (int i = 0; i < 3; i++)
          Container(
            width: 6,
            height: 6,
            margin: EdgeInsets.only(left: i == 0 ? 0 : 4),
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
      ],
    );
  }
}

/// Incoming (other side) bubbles: start-aligned on the muted surface.
const ChatTheme _incomingBubble = ChatTheme(
  background: ThemedColor.ref(ColorRef.muted),
  foreground: ThemedColor.ref(ColorRef.foreground),
  alignment: AlignmentDirectional.centerStart,
  avatarAlignment: AlignmentDirectional.topStart,
);
''',
    ),
  ],
  'chip': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Removable',
      builder: '_chipsRemovable',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/chip/chip.dart';

/// Hint line under the interactive rows.
Widget _hint(BuildContext context, String text) {
  final theme = Theme.of(context);
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(color: theme.colors.mutedForeground, fontSize: 12),
  );
}

/// Removable tokens: the x removes the chip, Reset restores the list.
class _RemovableChips extends StatefulWidget {
  const _RemovableChips();

  @override
  State<_RemovableChips> createState() => _RemovableChipsState();
}

class _RemovableChipsState extends State<_RemovableChips> {
  static final List<String> _all = <String>[
    'Design system',
    'Flutter',
    'Accessibility',
    'Dark mode',
  ];
  final List<String> _tags = List<String>.of(_all);

  void _remove(String tag) => setState(() => _tags.remove(tag));

  void _reset() => setState(() {
    _tags
      ..clear()
      ..addAll(_all);
  });

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          children: <Widget>[
            for (final tag in _tags)
              Chip(
                key: ValueKey<String>('chip-$tag'),
                onDeleted: () => _remove(tag),
                trailing: ChipButton(
                  onPressed: () => _remove(tag),
                  semanticLabel: 'Remove $tag',
                  child: const Icon(LucideIcons.x, size: 12),
                ),
                child: Text(tag),
              ),
            if (_tags.isEmpty)
              Chip(child: Text('No tags')),
          ],
        ),
        Gap(spacing.sm),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('${_tags.length} of ${_all.length} shown'),
            if (_tags.length != _all.length) ...<Widget>[
              Gap(spacing.sm),
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.outline,
                onPressed: _reset,
                child: Text('Reset'),
              ),
            ],
          ],
        ),
        Gap(spacing.xs),
        _hint(
          context,
          'Tip: focus a chip and press Backspace to remove it.',
        ),
      ],
    );
  }
}

Widget _chipsRemovable(BuildContext context) => const _RemovableChips();
''',
    ),
    DocsExampleSource(
      name: 'Selectable',
      builder: '_chipsSelectable',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/chip/chip.dart';

/// Filter chips: tap toggles each interest on and off.
class _FilterChips extends StatefulWidget {
  const _FilterChips();

  @override
  State<_FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<_FilterChips> {
  static final List<String> _options = <String>[
    'Music',
    'Sports',
    'Travel',
    'Cooking',
    'Reading',
  ];
  final Set<String> _selected = <String>{'Music', 'Travel'};

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          children: <Widget>[
            for (final option in _options)
              Chip(
                key: ValueKey<String>('filter-$option'),
                onPressed: () => setState(() {
                  if (!_selected.remove(option)) {
                    _selected.add(option);
                  }
                }),
                variant: _selected.contains(option)
                    ? ButtonVariant.primary
                    : ButtonVariant.outline,
                leading: _selected.contains(option)
                    ? const Icon(LucideIcons.check, size: 12)
                    : null,
                child: Text(option),
              ),
          ],
        ),
        Gap(spacing.sm),
        Text('${_selected.length} selected'),
      ],
    );
  }
}

Widget _chipsSelectable(BuildContext context) => const _FilterChips();
''',
    ),
    DocsExampleSource(
      name: 'With icon',
      builder: '_chipsWithIcon',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/chip/chip.dart';

/// Chips with icons: realistic status tokens, static (non-pressable).
Widget _chipsWithIcon(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Align(
    alignment: Alignment.center,
    child: Wrap(
      spacing: spacing.sm,
      runSpacing: spacing.sm,
      children: <Widget>[
        Chip(
          leading: const Icon(LucideIcons.star, size: 12),
          child: Text('Featured'),
        ),
        Chip(
          leading: const Icon(LucideIcons.check, size: 12),
          child: Text('Verified'),
        ),
        Chip(
          leading: const Icon(LucideIcons.folder, size: 12),
          child: Text('Archived'),
        ),
        Chip(
          trailing: const Icon(LucideIcons.chevronRight, size: 12),
          child: Text('See all'),
        ),
      ],
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Variants',
      builder: '_chipsVariants',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/chip/chip.dart';

/// One chip per button variant plus a larger density.
Widget _chipsVariants(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Wrap(
        spacing: spacing.sm,
        runSpacing: spacing.sm,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Chip(child: Text('Active')),
          Chip(
            variant: ButtonVariant.outline,
            child: Text('On hold'),
          ),
          Chip(
            variant: ButtonVariant.destructive,
            child: Text('Overdue'),
          ),
          Chip(
            variant: ButtonVariant.ghost,
            child: Text('Draft'),
          ),
        ],
      ),
      Gap(spacing.sm),
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Chip(
            theme: const ChipTheme(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
            child: Text('Large'),
          ),
        ],
      ),
    ],
  );
}
''',
    ),
  ],
  'country_flag': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_countryFlagDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/country_flag/country_flag.dart';

/// A row of flags looked up from different keys.
Widget _countryFlagDefault(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Wrap(
    spacing: spacing.md,
    runSpacing: spacing.sm,
    crossAxisAlignment: WrapCrossAlignment.center,
    children: <Widget>[
      CountryFlag.fromCountryCode('US'),
      CountryFlag.fromCountryCode('JP'),
      CountryFlag.fromCountryCode('DE'),
      CountryFlag.fromCountryCode('BR'),
      CountryFlag.fromCurrencyCode('JPY'),
      CountryFlag.fromPhonePrefix('+49'),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Sizes',
      builder: '_countryFlagSizes',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/country_flag/country_flag.dart';

/// The size scale and the rounded shape.
Widget _countryFlagSizes(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Wrap(
    spacing: spacing.md,
    runSpacing: spacing.sm,
    crossAxisAlignment: WrapCrossAlignment.center,
    children: <Widget>[
      CountryFlag.fromCountryCode('FR'),
      CountryFlag.fromCountryCode('FR', width: 36, height: 27),
      CountryFlag.fromCountryCode('IT', width: 48, height: 36),
      CountryFlag.fromCountryCode(
        'ES',
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    ],
  );
}
''',
    ),
  ],
  'divider': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_dividerDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/divider/divider.dart';

/// A plain horizontal rule.
Widget _dividerDefault(BuildContext context) => const Divider();
''',
    ),
    DocsExampleSource(
      name: 'Labelled',
      builder: '_dividerLabelled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/divider/divider.dart';

/// The labelled form, with the three label alignments.
Widget _dividerLabelled(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Divider(label: Text('or continue with')),
      Gap(spacing.sm),
      Divider(
        labelAlignment: DividerLabelAlignment.start,
        label: Text('New this week'),
      ),
      Gap(spacing.sm),
      Divider(
        labelAlignment: DividerLabelAlignment.end,
        label: Text('Archived'),
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Vertical',
      builder: '_dividerVertical',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/divider/divider.dart';

/// Vertical rule between two lines of text.
Widget _dividerVertical(BuildContext context) {
  return SizedBox(
    height: 72,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('Inbox'),
        Divider(axis: Axis.vertical),
        Text('Archive'),
      ],
    ),
  );
}
''',
    ),
  ],
  'empty_state': <DocsExampleSource>[
    DocsExampleSource(
      name: 'No results',
      builder: '_emptyStateNoResults',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/empty_state/empty_state.dart';

/// The status line every interactive example writes to.
class _StatusLine extends StatelessWidget {
  const _StatusLine(this.status);

  final String status;

  @override
  Widget build(BuildContext context) {
    return Text(
      status,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12,
        color: Theme.of(context).colors.mutedForeground,
      ),
    );
  }
}

/// The no-results variant, whose action clears the filters.
class _EmptyStateNoResults extends StatefulWidget {
  const _EmptyStateNoResults();

  @override
  State<_EmptyStateNoResults> createState() => _EmptyStateNoResultsState();
}

class _EmptyStateNoResultsState extends State<_EmptyStateNoResults> {
  String _status = 'No results for "rocket".';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        EmptyState(
          variant: EmptyStateVariant.noResults,
          primaryAction: EmptyStateAction(
            label: 'Clear filters',
            onPressed: () => setState(
              () => _status = 'Filters cleared.',
            ),
          ),
        ),
        Gap(Theme.of(context).spacing.md),
        _StatusLine(_status),
      ],
    );
  }
}

Widget _emptyStateNoResults(BuildContext context) =>
    const _EmptyStateNoResults();
''',
    ),
    DocsExampleSource(
      name: 'Empty',
      builder: '_emptyStateEmpty',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/empty_state/empty_state.dart';

/// The status line every interactive example writes to.
class _StatusLine extends StatelessWidget {
  const _StatusLine(this.status);

  final String status;

  @override
  Widget build(BuildContext context) {
    return Text(
      status,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12,
        color: Theme.of(context).colors.mutedForeground,
      ),
    );
  }
}

/// The full-page empty state, both actions live.
class _EmptyStateEmpty extends StatefulWidget {
  const _EmptyStateEmpty();

  @override
  State<_EmptyStateEmpty> createState() => _EmptyStateEmptyState();
}

class _EmptyStateEmptyState extends State<_EmptyStateEmpty> {
  String _status = 'Nothing here yet.';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        EmptyState(
          variant: EmptyStateVariant.empty,
          primaryAction: EmptyStateAction(
            label: 'Create project',
            onPressed: () => setState(
              () => _status = 'Created a project.',
            ),
          ),
          secondaryAction: EmptyStateAction(
            label: 'Import',
            variant: ButtonVariant.outline,
            onPressed: () => setState(
              () => _status = 'Importing a project.',
            ),
          ),
        ),
        Gap(Theme.of(context).spacing.md),
        _StatusLine(_status),
      ],
    );
  }
}

Widget _emptyStateEmpty(BuildContext context) => const _EmptyStateEmpty();
''',
    ),
    DocsExampleSource(
      name: 'Error fallback',
      builder: '_emptyStateError',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/empty_state/empty_state.dart';

/// The status line every interactive example writes to.
class _StatusLine extends StatelessWidget {
  const _StatusLine(this.status);

  final String status;

  @override
  Widget build(BuildContext context) {
    return Text(
      status,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12,
        color: Theme.of(context).colors.mutedForeground,
      ),
    );
  }
}

/// The error-fallback variant with a footer link.
class _EmptyStateError extends StatefulWidget {
  const _EmptyStateError();

  @override
  State<_EmptyStateError> createState() => _EmptyStateErrorState();
}

class _EmptyStateErrorState extends State<_EmptyStateError> {
  String _status = 'Something went wrong.';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        EmptyState(
          variant: EmptyStateVariant.errorFallback,
          primaryAction: EmptyStateAction(
            label: 'Try again',
            onPressed: () =>
                setState(() => _status = 'Retrying...'),
          ),
          footerAction: EmptyStateAction(
            label: 'Report this',
            variant: ButtonVariant.link,
            onPressed: () =>
                setState(() => _status = 'Report sent.'),
          ),
        ),
        Gap(Theme.of(context).spacing.md),
        _StatusLine(_status),
      ],
    );
  }
}

Widget _emptyStateError(BuildContext context) => const _EmptyStateError();
''',
    ),
    DocsExampleSource(
      name: 'Compact',
      builder: '_emptyStateCompact',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/empty_state/empty_state.dart';

/// The compact scale, with and without the icon container.
Widget _emptyStateCompact(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      EmptyState(
        size: EmptyStateSize.compact,
        variant: EmptyStateVariant.empty,
        title: Text('Nothing here yet'),
        primaryAction: EmptyStateAction(label: 'Create'),
      ),
      Gap(spacing.xl),
      EmptyState(
        size: EmptyStateSize.compact,
        variant: EmptyStateVariant.noResults,
        showIconContainer: false,
        title: Text('No matches'),
        description: Text('Try a different term.'),
      ),
    ],
  );
}
''',
    ),
  ],
  'feature_carousel': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_featureCarouselDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/feature_carousel/feature_carousel.dart';

/// The full carousel with its default chrome, scrollable when the cards are
/// taller than the stage.
class _FeatureCarouselDefaultFeatureCarousel extends StatefulWidget {
  const _FeatureCarouselDefaultFeatureCarousel();

  @override
  State<_FeatureCarouselDefaultFeatureCarousel> createState() =>
      _FeatureCarouselDefaultFeatureCarouselState();
}

class _FeatureCarouselDefaultFeatureCarouselState
    extends State<_FeatureCarouselDefaultFeatureCarousel> {
  late final FeatureCarouselController _controller = FeatureCarouselController(
    autoPlay: false,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: 420,
        child: FeatureCarousel(
          controller: _controller,
          items: <FeatureCarouselItem>[
            FeatureCarouselItem(
              title: 'Fast',
              description: 'Ship a build in seconds.',
              icon: LucideIcons.zap,
            ),
            FeatureCarouselItem(
              title: 'Safe',
              description: 'Every deploy is immutable.',
              icon: LucideIcons.shield,
            ),
            FeatureCarouselItem(
              title: 'Insightful',
              description: 'Metrics for every release.',
              icon: LucideIcons.chartLine,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _featureCarouselDefault(BuildContext context) =>
    const _FeatureCarouselDefaultFeatureCarousel();
''',
    ),
    DocsExampleSource(
      name: 'Themed',
      builder: '_featureCarouselThemed',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/feature_carousel/feature_carousel.dart';

/// A carousel whose theme leg re-colours the accent and card fill.
Widget _featureCarouselThemed(BuildContext context) {
  return SingleChildScrollView(
    child: SizedBox(
      width: 420,
      child: ComponentTheme<FeatureCarouselTheme>(
        data: const FeatureCarouselTheme(
          accentColor: ThemedColor.ref(ColorRef.chart2),
          cardFill: ThemedColor.ref(ColorRef.popover),
          radius: 20,
        ),
        child: FeatureCarousel(
          items: <FeatureCarouselItem>[
            FeatureCarouselItem(
              title: 'Themed',
              icon: LucideIcons.sparkles,
            ),
            FeatureCarouselItem(
              title: 'Accent',
              icon: LucideIcons.star,
            ),
          ],
        ),
      ),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Cards only',
      builder: '_featureCarouselCardsOnly',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/feature_carousel/feature_carousel.dart';

/// The cards without the CTA and the navigation arrows.
Widget _featureCarouselCardsOnly(BuildContext context) {
  return SingleChildScrollView(
    child: SizedBox(width: 420, child: _FeatureCarouselCardsOnlyCarousel()),
  );
}

class _FeatureCarouselCardsOnlyCarousel extends StatefulWidget {
  const _FeatureCarouselCardsOnlyCarousel();

  @override
  State<_FeatureCarouselCardsOnlyCarousel> createState() =>
      _FeatureCarouselCardsOnlyCarouselState();
}

class _FeatureCarouselCardsOnlyCarouselState
    extends State<_FeatureCarouselCardsOnlyCarousel> {
  late final FeatureCarouselController _controller = FeatureCarouselController(
    autoPlay: false,
    showCta: false,
    showNavArrows: false,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FeatureCarousel(
      controller: _controller,
      items: <FeatureCarouselItem>[
        FeatureCarouselItem(
          title: 'Cards only',
          icon: LucideIcons.image,
        ),
        FeatureCarouselItem(
          title: 'No chrome',
          icon: LucideIcons.circle,
        ),
      ],
    );
  }
}
''',
    ),
    DocsExampleSource(
      name: 'Labelled',
      builder: '_featureCarouselLabelled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/feature_carousel/feature_carousel.dart';

/// A single slide, so the CTA sits under one card.
Widget _featureCarouselLabelled(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 420,
          child: FeatureCarousel(
            items: <FeatureCarouselItem>[
              FeatureCarouselItem(
                title: 'Analytics',
                description: 'Every release measured.',
                icon: LucideIcons.chartLine,
              ),
            ],
          ),
        ),
        Gap(spacing.md),
        Text(
          'A single slide, so the CTA sits under one card.',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colors.mutedForeground,
          ),
        ),
      ],
    ),
  );
}
''',
    ),
  ],
  'file_diff_viewer': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Unified',
      builder: '_unified',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/file_diff_viewer/file_diff_viewer.dart';

/// A two-hunk patch; the second hunk starts collapsed.
const FileDiff _patch = FileDiff(
  path: 'lib/src/widget.dart',
  hunks: <FileDiffHunk>[
    FileDiffHunk(
      header: '@@ -10,7 +10,8 @@',
      lines: <FileDiffLine>[
        FileDiffLine(
          type: FileDiffLineType.context,
          content: 'Widget build(BuildContext context) {',
          oldLineNumber: 10,
          newLineNumber: 10,
        ),
        FileDiffLine(
          type: FileDiffLineType.deletion,
          content: '  return Text(label);',
          oldLineNumber: 11,
        ),
        FileDiffLine(
          type: FileDiffLineType.addition,
          content: '  return Text(label, maxLines: 1);',
          newLineNumber: 11,
        ),
        FileDiffLine(
          type: FileDiffLineType.context,
          content: '}',
          oldLineNumber: 12,
          newLineNumber: 12,
        ),
      ],
    ),
    FileDiffHunk(
      header: '@@ -40,6 +41,9 @@',
      collapsed: true,
      lines: <FileDiffLine>[
        FileDiffLine(
          type: FileDiffLineType.context,
          content: 'void unusedHelper() {}',
          oldLineNumber: 40,
          newLineNumber: 41,
        ),
      ],
    ),
  ],
);

/// Compact single-column patch (the upstream default).
Widget _unified(BuildContext context) {
  return const FileDiffViewer(maxHeight: 260, files: <FileDiff>[_patch]);
}
''',
    ),
    DocsExampleSource(
      name: 'Split',
      builder: '_split',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/file_diff_viewer/file_diff_viewer.dart';

/// A two-hunk patch; the second hunk starts collapsed.
const FileDiff _patch = FileDiff(
  path: 'lib/src/widget.dart',
  hunks: <FileDiffHunk>[
    FileDiffHunk(
      header: '@@ -10,7 +10,8 @@',
      lines: <FileDiffLine>[
        FileDiffLine(
          type: FileDiffLineType.context,
          content: 'Widget build(BuildContext context) {',
          oldLineNumber: 10,
          newLineNumber: 10,
        ),
        FileDiffLine(
          type: FileDiffLineType.deletion,
          content: '  return Text(label);',
          oldLineNumber: 11,
        ),
        FileDiffLine(
          type: FileDiffLineType.addition,
          content: '  return Text(label, maxLines: 1);',
          newLineNumber: 11,
        ),
        FileDiffLine(
          type: FileDiffLineType.context,
          content: '}',
          oldLineNumber: 12,
          newLineNumber: 12,
        ),
      ],
    ),
    FileDiffHunk(
      header: '@@ -40,6 +41,9 @@',
      collapsed: true,
      lines: <FileDiffLine>[
        FileDiffLine(
          type: FileDiffLineType.context,
          content: 'void unusedHelper() {}',
          oldLineNumber: 40,
          newLineNumber: 41,
        ),
      ],
    ),
  ],
);

/// Old and new sides beside each other.
Widget _split(BuildContext context) {
  return const FileDiffViewer(
    layout: FileDiffLayout.split,
    showCopyAction: false,
    files: <FileDiff>[_patch],
  );
}
''',
    ),
  ],
  'keyboard_shortcut': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_kbdDefault',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/card/card.dart';
import 'package:<your_app>/ui/dashcn/components/keyboard_shortcut/keyboard_shortcut.dart';

/// The command-palette chord, from an activator.
Widget _kbdDefault(BuildContext context) {
  return const Align(
    alignment: Alignment.center,
    child: KeyboardShortcut.fromActivator(
      activator: SingleActivator(LogicalKeyboardKey.keyK, meta: true),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Modifiers',
      builder: '_kbdModifiers',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/card/card.dart';
import 'package:<your_app>/ui/dashcn/components/keyboard_shortcut/keyboard_shortcut.dart';

/// Modifiers first, in the order they are held.
Widget _kbdModifiers(BuildContext context) {
  return const Align(
    alignment: Alignment.center,
    child: KeyboardShortcut(
      keys: <LogicalKeyboardKey>[
        LogicalKeyboardKey.control,
        LogicalKeyboardKey.shift,
        LogicalKeyboardKey.keyP,
      ],
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Sequence',
      builder: '_kbdSequence',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/card/card.dart';
import 'package:<your_app>/ui/dashcn/components/keyboard_shortcut/keyboard_shortcut.dart';

/// G then H: a two-step sequence, not a chord.
Widget _kbdSequence(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  return Align(
    alignment: Alignment.center,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const KeyboardShortcut(
          keys: <LogicalKeyboardKey>[LogicalKeyboardKey.keyG],
        ),
        Gap(theme.spacing.sm),
        Text(
          'then',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
        Gap(theme.spacing.sm),
        const KeyboardShortcut(
          keys: <LogicalKeyboardKey>[LogicalKeyboardKey.keyH],
        ),
      ],
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'In menu item',
      builder: '_kbdInMenuItem',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/card/card.dart';
import 'package:<your_app>/ui/dashcn/components/keyboard_shortcut/keyboard_shortcut.dart';

/// Inside a menu item: the chord trails the label, as in `command` menus.
Widget _kbdInMenuItem(BuildContext context) {
  return Align(
    alignment: Alignment.center,
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Card(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: <Widget>[
            Expanded(child: Text('Open command palette')),
            Gap(16),
            KeyboardShortcut.fromActivator(
              activator: SingleActivator(LogicalKeyboardKey.keyK, meta: true),
            ),
          ],
        ),
      ),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Scoped labels',
      builder: '_kbdScoped',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/card/card.dart';
import 'package:<your_app>/ui/dashcn/components/keyboard_shortcut/keyboard_shortcut.dart';

/// A chord under a custom display scope.
Widget _kbdScoped(BuildContext context) {
  return const Align(
    alignment: Alignment.center,
    child: KeyboardShortcutDisplayScope(
      builder: _kbdLabel,
      child: KeyboardShortcut(
        keys: <LogicalKeyboardKey>[
          LogicalKeyboardKey.alt,
          LogicalKeyboardKey.keyF,
        ],
      ),
    ),
  );
}

Widget _kbdLabel(BuildContext context, LogicalKeyboardKey key) =>
    Text(key.keyLabel.toUpperCase());
''',
    ),
    DocsExampleSource(
      name: 'Live chord',
      builder: '_kbdLive',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/card/card.dart';
import 'package:<your_app>/ui/dashcn/components/keyboard_shortcut/keyboard_shortcut.dart';

/// A chord the example can really fire.
class _KbdLive extends StatefulWidget {
  const _KbdLive();

  @override
  State<_KbdLive> createState() => _KbdLiveState();
}

class _KbdLiveState extends State<_KbdLive> {
  String _status = 'Press the chord';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Shortcuts(
      shortcuts: const <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.keyK, meta: true):
            _OpenPaletteIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          _OpenPaletteIntent: CallbackAction<_OpenPaletteIntent>(
            onInvoke: (_) => setState(
              () => _status = 'Command palette opened',
            ),
          ),
        },
        child: Focus(
          autofocus: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const KeyboardShortcut(
                keys: <LogicalKeyboardKey>[
                  LogicalKeyboardKey.meta,
                  LogicalKeyboardKey.keyK,
                ],
              ),
              Gap(theme.spacing.md),
              Text(
                _status,
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The intent the live example binds.
class _OpenPaletteIntent extends Intent {
  const _OpenPaletteIntent();
}

/// A chord that can really be pressed.
Widget _kbdLive(BuildContext context) =>
    const Align(alignment: Alignment.center, child: _KbdLive());
''',
    ),
    DocsExampleSource(
      name: 'Ghost',
      builder: '_kbdGhost',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/card/card.dart';
import 'package:<your_app>/ui/dashcn/components/keyboard_shortcut/keyboard_shortcut.dart';

/// The same chord with no fill: a hint on a coloured surface (P7-WC2).
Widget _kbdGhost(BuildContext context) {
  return const Align(
    alignment: Alignment.center,
    child: KeyboardShortcut(
      variant: KbdVariant.ghost,
      keys: <LogicalKeyboardKey>[
        LogicalKeyboardKey.meta,
        LogicalKeyboardKey.keyK,
      ],
    ),
  );
}
''',
    ),
  ],
  'list_tile': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/avatar/avatar.dart';
import 'package:<your_app>/ui/dashcn/components/list_tile/list_tile.dart';

Widget _wrap(Widget child) => SizedBox(width: 360, child: child);

Widget _default(BuildContext context) => _wrap(
  ListTile(
    leading: Icon(LucideIcons.user),
    title: Text('Title'),
    subtitle: Text('Subtitle'),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Compact',
      builder: '_compact',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/avatar/avatar.dart';
import 'package:<your_app>/ui/dashcn/components/list_tile/list_tile.dart';

Widget _wrap(Widget child) => SizedBox(width: 360, child: child);

Widget _compact(BuildContext context) => _wrap(
  ListTile(
    densityTokens: DensityTokens.compact,
    leading: Icon(LucideIcons.user),
    title: Text('Compact (default)'),
    subtitle: Text('Row 32-36, icon 16'),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Comfortable',
      builder: '_comfortable',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/avatar/avatar.dart';
import 'package:<your_app>/ui/dashcn/components/list_tile/list_tile.dart';

Widget _wrap(Widget child) => SizedBox(width: 360, child: child);

Widget _comfortable(BuildContext context) => _wrap(
  ListTile(
    densityTokens: DensityTokens.comfortable,
    leading: Icon(LucideIcons.user),
    title: Text('Comfortable'),
    subtitle: Text('Row 40-44, icon 20'),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Avatar',
      builder: '_avatar',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/avatar/avatar.dart';
import 'package:<your_app>/ui/dashcn/components/list_tile/list_tile.dart';

Widget _wrap(Widget child) => SizedBox(width: 360, child: child);

Widget _avatar(BuildContext context) => _wrap(
  ListTile(
    leading: Avatar(initials: 'IB', size: 32),
    title: Text('Avatar 32 (compact)'),
    subtitle: Text('Avatar sizes follow density'),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Avatar comfortable',
      builder: '_avatarComfortable',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/avatar/avatar.dart';
import 'package:<your_app>/ui/dashcn/components/list_tile/list_tile.dart';

Widget _wrap(Widget child) => SizedBox(width: 360, child: child);

Widget _avatarComfortable(BuildContext context) => _wrap(
  ListTile(
    densityTokens: DensityTokens.comfortable,
    leading: Avatar(initials: 'IB', size: 40),
    title: Text('Avatar 40 (comfortable)'),
    subtitle: Text('Row 40-44, icon 20'),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Dense',
      builder: '_dense',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/avatar/avatar.dart';
import 'package:<your_app>/ui/dashcn/components/list_tile/list_tile.dart';

Widget _wrap(Widget child) => SizedBox(width: 360, child: child);

Widget _dense(BuildContext context) => _wrap(
  ListTile(
    dense: true,
    leading: Icon(LucideIcons.user),
    title: Text('Dense tile'),
    subtitle: Text('Subtitle'),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Three line',
      builder: '_threeLine',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/avatar/avatar.dart';
import 'package:<your_app>/ui/dashcn/components/list_tile/list_tile.dart';

Widget _wrap(Widget child) => SizedBox(width: 360, child: child);

Widget _threeLine(BuildContext context) => _wrap(
  ListTile(
    isThreeLine: true,
    leading: Icon(LucideIcons.user),
    title: Text('Three-line title'),
    subtitle: Text(
      'A longer subtitle that spans multiple lines in the tile.',
    ),
    trailing: Icon(LucideIcons.chevronRight),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Selected',
      builder: '_selected',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/avatar/avatar.dart';
import 'package:<your_app>/ui/dashcn/components/list_tile/list_tile.dart';

Widget _wrap(Widget child) => SizedBox(width: 360, child: child);

Widget _selected(BuildContext context) => _wrap(
  ListTile(
    selected: true,
    leading: Icon(LucideIcons.check),
    title: Text('Selected'),
    subtitle: Text('Selected state'),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Disabled',
      builder: '_disabled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/avatar/avatar.dart';
import 'package:<your_app>/ui/dashcn/components/list_tile/list_tile.dart';

Widget _wrap(Widget child) => SizedBox(width: 360, child: child);

Widget _disabled(BuildContext context) => _wrap(
  ListTile(
    enabled: false,
    leading: Icon(LucideIcons.user),
    title: Text('Disabled'),
    subtitle: Text('Disabled state'),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Customized',
      builder: '_customized',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/avatar/avatar.dart';
import 'package:<your_app>/ui/dashcn/components/list_tile/list_tile.dart';

Widget _wrap(Widget child) => SizedBox(width: 360, child: child);

Widget _customized(BuildContext context) => _wrap(
  ListTile(
    style: const ListTileTheme(
      tileColor: null,
      titleStyle: TextStyle(fontWeight: FontWeight.w700),
    ),
    leading: const Icon(LucideIcons.star),
    title: Text('Customized'),
    subtitle: Text('With style override'),
    trailing: const Icon(LucideIcons.heart),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Grouped',
      builder: '_grouped',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/avatar/avatar.dart';
import 'package:<your_app>/ui/dashcn/components/list_tile/list_tile.dart';

Widget _wrap(Widget child) => SizedBox(width: 360, child: child);

Widget _grouped(BuildContext context) => _wrap(
  ListTileGroup(
    children: <Widget>[
      ListTile(
        title: Text('First'),
        leading: Icon(LucideIcons.user),
      ),
      ListTile(
        title: Text('Second'),
        leading: Icon(LucideIcons.user),
      ),
      ListTile(
        title: Text('Third'),
        leading: Icon(LucideIcons.user),
      ),
    ],
  ),
);
''',
    ),
  ],
  'number_ticker': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_numberTickerDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/number_ticker/number_ticker.dart';

/// A rolling ticker whose value the example changes on tap.
class _NumberTickerTicker extends StatefulWidget {
  const _NumberTickerTicker();

  @override
  State<_NumberTickerTicker> createState() => _NumberTickerTickerState();
}

class _NumberTickerTickerState extends State<_NumberTickerTicker> {
  double _value = 1234;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        NumberTicker(
          number: _value,
          formatter: (num value) => value.toStringAsFixed(0),
        ),
        Gap(theme.spacing.lg),
        Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          children: <Widget>[
            for (final double next in const <double>[0, 1234, 987654])
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.outline,
                onPressed: () => setState(() => _value = next),
                child: Text('${next.toInt()}'),
              ),
          ],
        ),
      ],
    );
  }
}

Widget _numberTickerDefault(BuildContext context) =>
    const _NumberTickerTicker();
''',
    ),
    DocsExampleSource(
      name: 'Flip clock',
      builder: '_numberTickerFlip',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/number_ticker/number_ticker.dart';

/// The flip-clock form of the same value.
class _NumberTickerFlipClock extends StatefulWidget {
  const _NumberTickerFlipClock();

  @override
  State<_NumberTickerFlipClock> createState() => _NumberTickerFlipClockState();
}

class _NumberTickerFlipClockState extends State<_NumberTickerFlipClock> {
  double _value = 1234;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextFlipper(
          charset: FlipperCharset.numbers,
          text: _value.toInt().toString(),
        ),
        Gap(theme.spacing.md),
        Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          children: <Widget>[
            for (final double next in const <double>[7, 1234, 987654])
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.outline,
                onPressed: () => setState(() => _value = next),
                child: Text('${next.toInt()}'),
              ),
          ],
        ),
      ],
    );
  }
}

Widget _numberTickerFlip(BuildContext context) =>
    const _NumberTickerFlipClock();
''',
    ),
  ],
  'pinned_sheet': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Bottom sheet',
      builder: '_sheetBottom',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/drawer_container/drawer_container.dart';
import 'package:<your_app>/ui/dashcn/components/pinned_sheet/pinned_sheet.dart';

/// Sheet body with a title and a Close button wired to [controller].
class _SheetBody extends StatelessWidget {
  const _SheetBody({required this.title, required this.controller});

  final String title;
  final SheetController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Gap(theme.spacing.sm),
          Text(
            'Drag the handle to move between snap stages.',
            style: TextStyle(color: theme.colors.mutedForeground),
          ),
          Gap(theme.spacing.md),
          Button(
            size: ButtonSize.sm,
            variant: ButtonVariant.outline,
            onPressed: controller.close,
            child: Text('Done'),
          ),
        ],
      ),
    );
  }
}

/// One working sheet inside its own bounded stage.
class _SheetDemo extends StatefulWidget {
  const _SheetDemo({
    required this.position,
    required this.title,
    this.stages = const <SheetStage>[
      SheetStage.closed(),
      SheetStage.expanded(),
    ],
    this.initialStage,
    this.showFraction = false,
  });

  final OverlayPosition position;
  final String title;
  final List<SheetStage> stages;
  final SheetStage? initialStage;
  final bool showFraction;

  @override
  State<_SheetDemo> createState() => _SheetDemoState();
}

class _SheetDemoState extends State<_SheetDemo> {
  final SheetController _controller = SheetController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool vertical =
        widget.position == OverlayPosition.top ||
        widget.position == OverlayPosition.bottom;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Button(
              size: ButtonSize.sm,
              onPressed: _controller.open,
              child: Text('Open sheet'),
            ),
            if (widget.stages.length > 2) ...<Widget>[
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.secondary,
                onPressed: () => _controller.animateTo(widget.stages[1]),
                child: Text('Half'),
              ),
            ],
            Button(
              size: ButtonSize.sm,
              variant: ButtonVariant.outline,
              onPressed: _controller.close,
              child: Text('Close'),
            ),
            if (widget.showFraction)
              ListenableBuilder(
                listenable: _controller,
                builder: (BuildContext context, Widget? child) => Text(
                  '${(_controller.fraction * 100).round()}% open',
                  style: TextStyle(color: theme.colors.mutedForeground),
                ),
              ),
          ],
        ),
        Gap(theme.spacing.sm),
        SizedBox(
          width: 320,
          height: vertical ? 240 : 220,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colors.muted,
              border: Border.all(color: theme.colors.border),
              borderRadius: theme.borderRadiusLg,
            ),
            clipBehavior: Clip.hardEdge,
            child: PinnedSheet(
              controller: _controller,
              position: widget.position,
              stages: widget.stages,
              initialStage:
                  widget.initialStage ??
                  (widget.stages.isNotEmpty
                      ? widget.stages.first
                      : const SheetStage.closed()),
              child: DrawerContainer(
                child: _SheetBody(title: widget.title, controller: _controller),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Bottom sheet, starting open so the chrome is visible.
Widget _sheetBottom(BuildContext context) => _SheetDemo(
  position: OverlayPosition.bottom,
  title: 'Bottom sheet',
  initialStage: SheetStage.expanded(),
);
''',
    ),
    DocsExampleSource(
      name: 'Right side',
      builder: '_sheetRight',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/drawer_container/drawer_container.dart';
import 'package:<your_app>/ui/dashcn/components/pinned_sheet/pinned_sheet.dart';

/// Sheet body with a title and a Close button wired to [controller].
class _SheetBody extends StatelessWidget {
  const _SheetBody({required this.title, required this.controller});

  final String title;
  final SheetController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Gap(theme.spacing.sm),
          Text(
            'Drag the handle to move between snap stages.',
            style: TextStyle(color: theme.colors.mutedForeground),
          ),
          Gap(theme.spacing.md),
          Button(
            size: ButtonSize.sm,
            variant: ButtonVariant.outline,
            onPressed: controller.close,
            child: Text('Done'),
          ),
        ],
      ),
    );
  }
}

/// One working sheet inside its own bounded stage.
class _SheetDemo extends StatefulWidget {
  const _SheetDemo({
    required this.position,
    required this.title,
    this.stages = const <SheetStage>[
      SheetStage.closed(),
      SheetStage.expanded(),
    ],
    this.initialStage,
    this.showFraction = false,
  });

  final OverlayPosition position;
  final String title;
  final List<SheetStage> stages;
  final SheetStage? initialStage;
  final bool showFraction;

  @override
  State<_SheetDemo> createState() => _SheetDemoState();
}

class _SheetDemoState extends State<_SheetDemo> {
  final SheetController _controller = SheetController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool vertical =
        widget.position == OverlayPosition.top ||
        widget.position == OverlayPosition.bottom;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Button(
              size: ButtonSize.sm,
              onPressed: _controller.open,
              child: Text('Open sheet'),
            ),
            if (widget.stages.length > 2) ...<Widget>[
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.secondary,
                onPressed: () => _controller.animateTo(widget.stages[1]),
                child: Text('Half'),
              ),
            ],
            Button(
              size: ButtonSize.sm,
              variant: ButtonVariant.outline,
              onPressed: _controller.close,
              child: Text('Close'),
            ),
            if (widget.showFraction)
              ListenableBuilder(
                listenable: _controller,
                builder: (BuildContext context, Widget? child) => Text(
                  '${(_controller.fraction * 100).round()}% open',
                  style: TextStyle(color: theme.colors.mutedForeground),
                ),
              ),
          ],
        ),
        Gap(theme.spacing.sm),
        SizedBox(
          width: 320,
          height: vertical ? 240 : 220,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colors.muted,
              border: Border.all(color: theme.colors.border),
              borderRadius: theme.borderRadiusLg,
            ),
            clipBehavior: Clip.hardEdge,
            child: PinnedSheet(
              controller: _controller,
              position: widget.position,
              stages: widget.stages,
              initialStage:
                  widget.initialStage ??
                  (widget.stages.isNotEmpty
                      ? widget.stages.first
                      : const SheetStage.closed()),
              child: DrawerContainer(
                child: _SheetBody(title: widget.title, controller: _controller),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Right-side sheet.
Widget _sheetRight(BuildContext context) => _SheetDemo(
  position: OverlayPosition.right,
  title: 'Right sheet',
);
''',
    ),
    DocsExampleSource(
      name: 'Left side',
      builder: '_sheetLeft',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/drawer_container/drawer_container.dart';
import 'package:<your_app>/ui/dashcn/components/pinned_sheet/pinned_sheet.dart';

/// Sheet body with a title and a Close button wired to [controller].
class _SheetBody extends StatelessWidget {
  const _SheetBody({required this.title, required this.controller});

  final String title;
  final SheetController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Gap(theme.spacing.sm),
          Text(
            'Drag the handle to move between snap stages.',
            style: TextStyle(color: theme.colors.mutedForeground),
          ),
          Gap(theme.spacing.md),
          Button(
            size: ButtonSize.sm,
            variant: ButtonVariant.outline,
            onPressed: controller.close,
            child: Text('Done'),
          ),
        ],
      ),
    );
  }
}

/// One working sheet inside its own bounded stage.
class _SheetDemo extends StatefulWidget {
  const _SheetDemo({
    required this.position,
    required this.title,
    this.stages = const <SheetStage>[
      SheetStage.closed(),
      SheetStage.expanded(),
    ],
    this.initialStage,
    this.showFraction = false,
  });

  final OverlayPosition position;
  final String title;
  final List<SheetStage> stages;
  final SheetStage? initialStage;
  final bool showFraction;

  @override
  State<_SheetDemo> createState() => _SheetDemoState();
}

class _SheetDemoState extends State<_SheetDemo> {
  final SheetController _controller = SheetController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool vertical =
        widget.position == OverlayPosition.top ||
        widget.position == OverlayPosition.bottom;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Button(
              size: ButtonSize.sm,
              onPressed: _controller.open,
              child: Text('Open sheet'),
            ),
            if (widget.stages.length > 2) ...<Widget>[
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.secondary,
                onPressed: () => _controller.animateTo(widget.stages[1]),
                child: Text('Half'),
              ),
            ],
            Button(
              size: ButtonSize.sm,
              variant: ButtonVariant.outline,
              onPressed: _controller.close,
              child: Text('Close'),
            ),
            if (widget.showFraction)
              ListenableBuilder(
                listenable: _controller,
                builder: (BuildContext context, Widget? child) => Text(
                  '${(_controller.fraction * 100).round()}% open',
                  style: TextStyle(color: theme.colors.mutedForeground),
                ),
              ),
          ],
        ),
        Gap(theme.spacing.sm),
        SizedBox(
          width: 320,
          height: vertical ? 240 : 220,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colors.muted,
              border: Border.all(color: theme.colors.border),
              borderRadius: theme.borderRadiusLg,
            ),
            clipBehavior: Clip.hardEdge,
            child: PinnedSheet(
              controller: _controller,
              position: widget.position,
              stages: widget.stages,
              initialStage:
                  widget.initialStage ??
                  (widget.stages.isNotEmpty
                      ? widget.stages.first
                      : const SheetStage.closed()),
              child: DrawerContainer(
                child: _SheetBody(title: widget.title, controller: _controller),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Left-side sheet.
Widget _sheetLeft(BuildContext context) => _SheetDemo(
  position: OverlayPosition.left,
  title: 'Left sheet',
);
''',
    ),
    DocsExampleSource(
      name: 'Top sheet',
      builder: '_sheetTop',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/drawer_container/drawer_container.dart';
import 'package:<your_app>/ui/dashcn/components/pinned_sheet/pinned_sheet.dart';

/// Sheet body with a title and a Close button wired to [controller].
class _SheetBody extends StatelessWidget {
  const _SheetBody({required this.title, required this.controller});

  final String title;
  final SheetController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Gap(theme.spacing.sm),
          Text(
            'Drag the handle to move between snap stages.',
            style: TextStyle(color: theme.colors.mutedForeground),
          ),
          Gap(theme.spacing.md),
          Button(
            size: ButtonSize.sm,
            variant: ButtonVariant.outline,
            onPressed: controller.close,
            child: Text('Done'),
          ),
        ],
      ),
    );
  }
}

/// One working sheet inside its own bounded stage.
class _SheetDemo extends StatefulWidget {
  const _SheetDemo({
    required this.position,
    required this.title,
    this.stages = const <SheetStage>[
      SheetStage.closed(),
      SheetStage.expanded(),
    ],
    this.initialStage,
    this.showFraction = false,
  });

  final OverlayPosition position;
  final String title;
  final List<SheetStage> stages;
  final SheetStage? initialStage;
  final bool showFraction;

  @override
  State<_SheetDemo> createState() => _SheetDemoState();
}

class _SheetDemoState extends State<_SheetDemo> {
  final SheetController _controller = SheetController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool vertical =
        widget.position == OverlayPosition.top ||
        widget.position == OverlayPosition.bottom;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Button(
              size: ButtonSize.sm,
              onPressed: _controller.open,
              child: Text('Open sheet'),
            ),
            if (widget.stages.length > 2) ...<Widget>[
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.secondary,
                onPressed: () => _controller.animateTo(widget.stages[1]),
                child: Text('Half'),
              ),
            ],
            Button(
              size: ButtonSize.sm,
              variant: ButtonVariant.outline,
              onPressed: _controller.close,
              child: Text('Close'),
            ),
            if (widget.showFraction)
              ListenableBuilder(
                listenable: _controller,
                builder: (BuildContext context, Widget? child) => Text(
                  '${(_controller.fraction * 100).round()}% open',
                  style: TextStyle(color: theme.colors.mutedForeground),
                ),
              ),
          ],
        ),
        Gap(theme.spacing.sm),
        SizedBox(
          width: 320,
          height: vertical ? 240 : 220,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colors.muted,
              border: Border.all(color: theme.colors.border),
              borderRadius: theme.borderRadiusLg,
            ),
            clipBehavior: Clip.hardEdge,
            child: PinnedSheet(
              controller: _controller,
              position: widget.position,
              stages: widget.stages,
              initialStage:
                  widget.initialStage ??
                  (widget.stages.isNotEmpty
                      ? widget.stages.first
                      : const SheetStage.closed()),
              child: DrawerContainer(
                child: _SheetBody(title: widget.title, controller: _controller),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Top sheet.
Widget _sheetTop(BuildContext context) => _SheetDemo(
  position: OverlayPosition.top,
  title: 'Top sheet',
);
''',
    ),
    DocsExampleSource(
      name: 'Snap points',
      builder: '_sheetSnapping',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/drawer_container/drawer_container.dart';
import 'package:<your_app>/ui/dashcn/components/pinned_sheet/pinned_sheet.dart';

/// Sheet body with a title and a Close button wired to [controller].
class _SheetBody extends StatelessWidget {
  const _SheetBody({required this.title, required this.controller});

  final String title;
  final SheetController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Gap(theme.spacing.sm),
          Text(
            'Drag the handle to move between snap stages.',
            style: TextStyle(color: theme.colors.mutedForeground),
          ),
          Gap(theme.spacing.md),
          Button(
            size: ButtonSize.sm,
            variant: ButtonVariant.outline,
            onPressed: controller.close,
            child: Text('Done'),
          ),
        ],
      ),
    );
  }
}

/// One working sheet inside its own bounded stage.
class _SheetDemo extends StatefulWidget {
  const _SheetDemo({
    required this.position,
    required this.title,
    this.stages = const <SheetStage>[
      SheetStage.closed(),
      SheetStage.expanded(),
    ],
    this.initialStage,
    this.showFraction = false,
  });

  final OverlayPosition position;
  final String title;
  final List<SheetStage> stages;
  final SheetStage? initialStage;
  final bool showFraction;

  @override
  State<_SheetDemo> createState() => _SheetDemoState();
}

class _SheetDemoState extends State<_SheetDemo> {
  final SheetController _controller = SheetController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool vertical =
        widget.position == OverlayPosition.top ||
        widget.position == OverlayPosition.bottom;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: theme.spacing.sm,
          runSpacing: theme.spacing.sm,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Button(
              size: ButtonSize.sm,
              onPressed: _controller.open,
              child: Text('Open sheet'),
            ),
            if (widget.stages.length > 2) ...<Widget>[
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.secondary,
                onPressed: () => _controller.animateTo(widget.stages[1]),
                child: Text('Half'),
              ),
            ],
            Button(
              size: ButtonSize.sm,
              variant: ButtonVariant.outline,
              onPressed: _controller.close,
              child: Text('Close'),
            ),
            if (widget.showFraction)
              ListenableBuilder(
                listenable: _controller,
                builder: (BuildContext context, Widget? child) => Text(
                  '${(_controller.fraction * 100).round()}% open',
                  style: TextStyle(color: theme.colors.mutedForeground),
                ),
              ),
          ],
        ),
        Gap(theme.spacing.sm),
        SizedBox(
          width: 320,
          height: vertical ? 240 : 220,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colors.muted,
              border: Border.all(color: theme.colors.border),
              borderRadius: theme.borderRadiusLg,
            ),
            clipBehavior: Clip.hardEdge,
            child: PinnedSheet(
              controller: _controller,
              position: widget.position,
              stages: widget.stages,
              initialStage:
                  widget.initialStage ??
                  (widget.stages.isNotEmpty
                      ? widget.stages.first
                      : const SheetStage.closed()),
              child: DrawerContainer(
                child: _SheetBody(title: widget.title, controller: _controller),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Snap points: closed, half and expanded with a live fraction readout.
Widget _sheetSnapping(BuildContext context) => _SheetDemo(
  position: OverlayPosition.bottom,
  title: 'Snap points',
  stages: <SheetStage>[
    SheetStage.closed(),
    SheetStage.fraction(0.4),
    SheetStage.expanded(),
  ],
  initialStage: SheetStage.fraction(0.4),
  showFraction: true,
);
''',
    ),
  ],
  'table': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Data table',
      builder: '_dataTable',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/primitives/clickable.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/badge/badge.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/checkbox/checkbox.dart';
import 'package:<your_app>/ui/dashcn/components/table/table.dart';

/// One member row of the data-table example.
class _Member {
  const _Member(this.name, this.role, this.status);

  final String name;
  final String role;
  final String status;
}

/// Six rows so pagination has two pages of four.
List<_Member> _members = <_Member>[
  _Member(
    'Avery',
    'Designer',
    'Active',
  ),
  _Member(
    'Jordan',
    'Engineer',
    'Active',
  ),
  _Member(
    'Casey',
    'Manager',
    'Away',
  ),
  _Member(
    'Riley',
    'Writer',
    'Offline',
  ),
  _Member(
    'Quinn',
    'Engineer',
    'Active',
  ),
  _Member(
    'Skyler',
    'Designer',
    'Away',
  ),
];

/// Badge variant for a member status.
BadgeVariant _statusVariant(String status) {
  switch (status) {
    case 'Active':
      return BadgeVariant.primary;
    case 'Away':
      return BadgeVariant.secondary;
    default:
      return BadgeVariant.outline;
  }
}

/// A sortable column header: label plus direction arrow.
class _SortHeader extends StatelessWidget {
  const _SortHeader({
    required this.label,
    required this.sorted,
    required this.ascending,
    required this.onTap,
  });

  final String label;
  final bool sorted;
  final bool ascending;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeColors colors = Theme.of(context).colors;
    return Clickable(
      behavior: HitTestBehavior.opaque,
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(label),
          const Gap(4),
          Icon(
            sorted
                ? (ascending ? LucideIcons.arrowUp : LucideIcons.arrowDown)
                : LucideIcons.chevronsUpDown,
            size: 12,
            color: colors.mutedForeground,
          ),
        ],
      ),
    );
  }
}

/// A live data table: sorting, selection, badges, pagination and column
/// resizing with min/max bounds.
class _DataTable extends StatefulWidget {
  const _DataTable();

  @override
  State<_DataTable> createState() => _DataTableState();
}

class _DataTableState extends State<_DataTable> {
  static const int _pageSize = 4;
  static const int _nameColumn = 1;
  static const int _roleColumn = 2;

  final ResizableTableController _resize = ResizableTableController(
    defaultColumnWidth: 120,
    // Compact density row height (32-40 band; header uses 36): the grid
    // scrolls inside its frame via the controllers below, and every header
    // divider drags to resize its column while row dividers resize rows.
    defaultRowHeight: 36,
    columnWidths: <int, double>{0: 40},
    widthConstraints: <int, ConstrainedTableSize>{
      0: ConstrainedTableSize(min: 32, max: 64),
      1: ConstrainedTableSize(min: 80, max: 220),
      2: ConstrainedTableSize(min: 80, max: 220),
      3: ConstrainedTableSize(min: 80, max: 200),
    },
  );
  final ScrollController _horizontal = ScrollController();
  final ScrollController _vertical = ScrollController();

  int _sortColumn = _nameColumn;
  bool _ascending = true;
  int _page = 0;
  final Set<String> _selected = <String>{};

  @override
  void dispose() {
    _resize.dispose();
    _horizontal.dispose();
    _vertical.dispose();
    super.dispose();
  }

  List<_Member> get _sorted {
    final List<_Member> rows = List<_Member>.of(_members);
    int compare(_Member a, _Member b) => _sortColumn == _roleColumn
        ? a.role.compareTo(b.role)
        : a.name.compareTo(b.name);
    rows.sort(
      (_Member a, _Member b) => _ascending ? compare(a, b) : compare(b, a),
    );
    return rows;
  }

  void _sort(int column) {
    setState(() {
      if (_sortColumn == column) {
        _ascending = !_ascending;
      } else {
        _sortColumn = column;
        _ascending = true;
      }
      _page = 0;
    });
  }

  void _toggle(String name) {
    setState(() {
      if (!_selected.remove(name)) {
        _selected.add(name);
      }
    });
  }

  void _togglePage(List<_Member> visible) {
    final Iterable<String> names = visible.map((_Member m) => m.name);
    setState(() {
      if (names.every(_selected.contains)) {
        _selected.removeAll(names);
      } else {
        _selected.addAll(names);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final List<_Member> sorted = _sorted;
    final int totalPages = (sorted.length + _pageSize - 1) ~/ _pageSize;
    final int page = _page.clamp(0, totalPages - 1);
    final List<_Member> visible = sorted.sublist(
      page * _pageSize,
      ((page + 1) * _pageSize).clamp(0, sorted.length),
    );
    final bool allChecked =
        visible.isNotEmpty &&
        visible.map((_Member m) => m.name).every(_selected.contains);
    final bool someChecked =
        !allChecked &&
        visible.map((_Member m) => m.name).any(_selected.contains);
    return Center(
      // Fixed widths sum to 400 (40 + 3 x 120), so the box hugs the grid
      // exactly and the stage centres it; narrower viewports scroll.
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Fixed rows (header + page) fill this box exactly: every row is
            // the controller's 36 px compact height, so narrower viewports
            // scroll instead of overflowing and the stage centres the box.
            // Drag any header divider to resize that column; drag a row
            // divider to resize the row.
            SizedBox(
              height: (_pageSize + 1) * 36,
              child: TableView(
                resizeController: _resize,
                horizontalController: _horizontal,
                verticalController: _vertical,
                rows: <TableViewRow>[
                  TableViewHeader(
                    cells: <TableViewCell>[
                      TableViewCell(
                        child: Checkbox(
                          tristate: true,
                          // Labels the tappable node for assistive tech.
                          semanticLabel: 'Select all rows',
                          value: allChecked
                              ? CheckboxValue.checked
                              : (someChecked
                                    ? CheckboxValue.indeterminate
                                    : CheckboxValue.unchecked),
                          onChanged: (_) => _togglePage(visible),
                        ),
                      ),
                      TableViewCell(
                        child: _SortHeader(
                          label: 'Name',
                          sorted: _sortColumn == _nameColumn,
                          ascending: _ascending,
                          onTap: () => _sort(_nameColumn),
                        ),
                      ),
                      TableViewCell(
                        child: _SortHeader(
                          label: 'Role',
                          sorted: _sortColumn == _roleColumn,
                          ascending: _ascending,
                          onTap: () => _sort(_roleColumn),
                        ),
                      ),
                      TableViewCell(child: Text('Status')),
                    ],
                  ),
                  for (final _Member member in visible)
                    TableViewRow(
                      selected: _selected.contains(member.name),
                      cells: <TableViewCell>[
                        TableViewCell(
                          child: Checkbox(
                            // Labels the tappable node for assistive tech.
                            semanticLabel: 'Select row',
                            value: _selected.contains(member.name)
                                ? CheckboxValue.checked
                                : CheckboxValue.unchecked,
                            onChanged: (_) => _toggle(member.name),
                          ),
                        ),
                        TableViewCell(child: Text(member.name)),
                        TableViewCell(
                          child: Text(member.role),
                        ),
                        TableViewCell(
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Badge(
                              variant: _statusVariant(member.status),
                              child: Text(member.status),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            // Narrow frames cut the last column: say the grid scrolls sideways.
            if (MediaQuery.widthOf(context) < 600) ...<Widget>[
              Gap(theme.spacing.sm),
              Text(
                'Scroll sideways for more columns',
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colors.mutedForeground,
                ),
              ),
            ],
            Gap(theme.spacing.md),
            Builder(
              builder: (context) {
                // Narrow touch viewports hide the selection count and use
                // icon-only pagination so the touch-sized controls fit.
                final bool narrow = MediaQuery.widthOf(context) < 600;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    if (!narrow)
                      Flexible(
                        child: Text(
                          '${_selected.length} of ${_members.length} selected',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colors.mutedForeground,
                          ),
                        ),
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Button(
                          variant: ButtonVariant.outline,
                          size: narrow ? ButtonSize.icon : ButtonSize.sm,
                          onPressed: page > 0
                              ? () => setState(() => _page = page - 1)
                              : null,
                          leading: narrow
                              ? null
                              : const Icon(LucideIcons.chevronLeft, size: 14),
                          child: narrow
                              ? const Icon(LucideIcons.chevronLeft, size: 14)
                              : Text('Prev'),
                        ),
                        Gap(theme.spacing.sm),
                        Text(
                          '${page + 1} / $totalPages',
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colors.mutedForeground,
                          ),
                        ),
                        Gap(theme.spacing.sm),
                        Button(
                          variant: ButtonVariant.outline,
                          size: narrow ? ButtonSize.icon : ButtonSize.sm,
                          onPressed: page + 1 < totalPages
                              ? () => setState(() => _page = page + 1)
                              : null,
                          trailing: narrow
                              ? null
                              : const Icon(LucideIcons.chevronRight, size: 14),
                          child: narrow
                              ? const Icon(LucideIcons.chevronRight, size: 14)
                              : Text('Next'),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _dataTable(BuildContext context) => const _DataTable();
''',
    ),
    DocsExampleSource(
      name: 'Invoices',
      builder: '_invoices',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/primitives/clickable.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/badge/badge.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/checkbox/checkbox.dart';
import 'package:<your_app>/ui/dashcn/components/table/table.dart';

/// A small static invoice grid with a total footer.
///
/// Scrolls inside its frame and supports column/row resize via header and
/// row divider drags, like the data table above.
class _InvoicesTable extends StatefulWidget {
  const _InvoicesTable();

  @override
  State<_InvoicesTable> createState() => _InvoicesTableState();
}

class _InvoicesTableState extends State<_InvoicesTable> {
  final ResizableTableController _resize = ResizableTableController(
    defaultColumnWidth: 90,
    defaultRowHeight: 36,
  );
  final ScrollController _horizontal = ScrollController();
  final ScrollController _vertical = ScrollController();

  @override
  void dispose() {
    _resize.dispose();
    _horizontal.dispose();
    _vertical.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SizedBox(
          // Header + 4 body rows + footer at the 36 px compact row height.
          height: 6 * 36,
          child: TableView(
            resizeController: _resize,
            horizontalController: _horizontal,
            verticalController: _vertical,
            columnWidths: <int, TableSize>{
              1: FixedTableSize(80),
              2: FixedTableSize(80),
              3: FixedTableSize(90),
            },
            rows: <TableViewRow>[
              TableViewHeader(
                cells: <TableViewCell>[
                  TableViewCell(child: Text('Invoice')),
                  TableViewCell(child: Text('Status')),
                  TableViewCell(child: Text('Method')),
                  TableViewCell(child: Text('Amount')),
                ],
              ),
              TableViewRow(
                cells: <TableViewCell>[
                  TableViewCell(child: Text('INV-001')),
                  TableViewCell(child: Text('Paid')),
                  TableViewCell(child: Text('Card')),
                  TableViewCell(child: Text('\$250.00')),
                ],
              ),
              TableViewRow(
                cells: <TableViewCell>[
                  TableViewCell(child: Text('INV-002')),
                  TableViewCell(child: Text('Pending')),
                  TableViewCell(child: Text('PayPal')),
                  TableViewCell(child: Text('\$150.00')),
                ],
              ),
              TableViewRow(
                cells: <TableViewCell>[
                  TableViewCell(child: Text('INV-003')),
                  TableViewCell(child: Text('Overdue')),
                  TableViewCell(child: Text('Transfer')),
                  TableViewCell(child: Text('\$350.00')),
                ],
              ),
              TableViewFooter(
                cells: <TableViewCell>[
                  TableViewCell(
                    columnSpan: 3,
                    child: Text('Total'),
                  ),
                  TableViewCell(child: Text('\$750.00')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _invoices(BuildContext context) => const _InvoicesTable();
''',
    ),
  ],
  'timeline': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/timeline/timeline.dart';

/// Three entries with times, titles and content.
Widget _default(BuildContext context) {
  return ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 400),
    child: Timeline(
      data: <TimelineData>[
        TimelineData(
          time: Text('09:00'),
          title: Text('Kickoff'),
          content: Text('Project kickoff meeting.'),
        ),
        TimelineData(
          time: Text('11:00'),
          title: Text('Design review'),
          content: Text('Review the first concept batch.'),
        ),
        TimelineData(
          time: Text('14:30'),
          title: Text('Delivery'),
          content: Text('Share the final assets.'),
        ),
      ],
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Compact',
      builder: '_compact',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/timeline/timeline.dart';

/// Smaller dots and a narrower time column through a scoped theme.
Widget _compact(BuildContext context) {
  return ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 400),
    child: ComponentTheme<TimelineTheme>(
      data: TimelineTheme(
        dotSize: 8,
        connectorThickness: 1,
        rowGap: 8,
        color: ThemedColor.ref(ColorRef.accent),
      ),
      child: Timeline(
        timeConstraints: BoxConstraints(minWidth: 72, maxWidth: 72),
        data: <TimelineData>[
          TimelineData(
            time: Text('Mon'),
            title: Text('Compact'),
          ),
          TimelineData(
            time: Text('Tue'),
            title: Text('scoped leg'),
          ),
        ],
      ),
    ),
  );
}
''',
    ),
  ],
  'tracker': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/tracker/tracker.dart';

/// All four levels.
Widget _default(BuildContext context) {
  return SizedBox(
    width: 320,
    child: Tracker(
      semanticLabel: 'Activity tracker',
      data: <TrackerData>[
        TrackerData(
          tooltip: Text('Healthy'),
          level: TrackerLevel.fine,
        ),
        TrackerData(
          tooltip: Text('Degraded'),
          level: TrackerLevel.warning,
        ),
        TrackerData(
          tooltip: Text('Down'),
          level: TrackerLevel.critical,
        ),
        TrackerData(
          tooltip: Text('No data'),
          level: TrackerLevel.unknown,
        ),
        TrackerData(
          tooltip: Text('Healthy'),
          level: TrackerLevel.fine,
        ),
        TrackerData(
          tooltip: Text('Healthy'),
          level: TrackerLevel.fine,
        ),
      ],
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Custom size',
      builder: '_customSize',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/tracker/tracker.dart';

/// Taller segments with a wider gap through the widget leg.
Widget _customSize(BuildContext context) {
  return SizedBox(
    width: 320,
    child: Tracker(
      theme: TrackerTheme(itemHeight: 24, gap: 4, radius: 4),
      data: <TrackerData>[
        TrackerData(tooltip: Text('One'), level: TrackerLevel.fine),
        TrackerData(tooltip: Text('Two'), level: TrackerLevel.critical),
        TrackerData(
          tooltip: Text('Three'),
          level: TrackerLevel.warning,
        ),
      ],
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Themed',
      builder: '_themed',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/tracker/tracker.dart';

/// Fine segments tinted with the primary token through a scoped theme.
Widget _themed(BuildContext context) {
  return SizedBox(
    width: 320,
    child: ComponentTheme<TrackerTheme>(
      data: TrackerTheme(
        fine: ThemedColor.ref(ColorRef.primary),
        itemHeight: 16,
      ),
      child: Tracker(
        data: <TrackerData>[
          TrackerData(tooltip: Text('One'), level: TrackerLevel.fine),
          TrackerData(tooltip: Text('Two'), level: TrackerLevel.fine),
          TrackerData(
            tooltip: Text('Three'),
            level: TrackerLevel.fine,
          ),
        ],
      ),
    ),
  );
}
''',
    ),
  ],
  'tree': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_treeDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/icon/icon.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/checkbox/checkbox.dart';
import 'package:<your_app>/ui/dashcn/components/tree/tree.dart';

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

List<_FileEntry> _files() => <_FileEntry>[
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
  return names.isEmpty
      ? 'Nothing selected'
      : 'Selected: ${names.join(', ')}';
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
          Gap(Theme.of(context).spacing.xs),
          leading,
        ],
      );
    }
    return TreeRow(leading: leading, child: Text(item.data.name));
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
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
              color: Theme.of(context).colors.mutedForeground,
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
''',
    ),
    DocsExampleSource(
      name: 'With selection',
      builder: '_treeSelection',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/icon/icon.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/checkbox/checkbox.dart';
import 'package:<your_app>/ui/dashcn/components/tree/tree.dart';

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

List<_FileEntry> _files() => <_FileEntry>[
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
  return names.isEmpty
      ? 'Nothing selected'
      : 'Selected: ${names.join(', ')}';
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
          Gap(Theme.of(context).spacing.xs),
          leading,
        ],
      );
    }
    return TreeRow(leading: leading, child: Text(item.data.name));
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
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
              color: Theme.of(context).colors.mutedForeground,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

/// Single-select tree with a preselected file.
Widget _treeSelection(BuildContext context) => _FileTree(
  entries: _files(),
  expanded: const <String>{'Documents'},
  selected: const <String>{'report.pdf'},
  allowMultiSelect: false,
  recursiveSelection: false,
);
''',
    ),
    DocsExampleSource(
      name: 'Multi-select',
      builder: '_treeMulti',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/icon/icon.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/checkbox/checkbox.dart';
import 'package:<your_app>/ui/dashcn/components/tree/tree.dart';

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

List<_FileEntry> _files() => <_FileEntry>[
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
  return names.isEmpty
      ? 'Nothing selected'
      : 'Selected: ${names.join(', ')}';
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
          Gap(Theme.of(context).spacing.xs),
          leading,
        ],
      );
    }
    return TreeRow(leading: leading, child: Text(item.data.name));
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
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
              color: Theme.of(context).colors.mutedForeground,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

/// Multi-select tree: checkboxes with tri-state parents.
Widget _treeMulti(BuildContext context) => _FileTree(
  entries: _files(),
  expanded: const <String>{'Documents', 'archive'},
  selected: const <String>{'report.pdf'},
  withCheckboxes: true,
);
''',
    ),
    DocsExampleSource(
      name: 'Large',
      builder: '_treeLarge',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/icon/icon.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/checkbox/checkbox.dart';
import 'package:<your_app>/ui/dashcn/components/tree/tree.dart';

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
  return names.isEmpty
      ? 'Nothing selected'
      : 'Selected: ${names.join(', ')}';
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
          Gap(Theme.of(context).spacing.xs),
          leading,
        ],
      );
    }
    return TreeRow(leading: leading, child: Text(item.data.name));
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
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
              color: Theme.of(context).colors.mutedForeground,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

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
    _FileEntry('Shared', folder: true, lazy: true),
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
''',
    ),
  ],
  'calendar': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Read-only',
      builder: '_calendarReadOnly',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/date_math.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/calendar/calendar.dart';

/// The month the examples show.
final DateTime _calendarToday = DateTime(2024, 3, 14);

/// The default month view, March 2024.
final CalendarView _calendarMarch = CalendarView(2024, 3);

/// Read-only: Sundays are disabled and the value does not change.
Widget _calendarReadOnly(BuildContext context) {
  return Calendar(
    view: _calendarMarch,
    now: _calendarToday,
    value: SingleCalendarValue(_calendarToday),
    stateBuilder: (DateTime date) => date.weekday == DateTime.sunday
        ? DateState.disabled
        : DateState.enabled,
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Single',
      builder: '_calendarSingle',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/date_math.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/calendar/calendar.dart';

/// The month the examples show.
final DateTime _calendarToday = DateTime(2024, 3, 14);

/// One interactive calendar in [selectionMode], with a month header:
/// `Calendar` owns no navigation, so the caller drives the view.
class _CalendarCalendarPanel extends StatefulWidget {
  const _CalendarCalendarPanel({required this.selectionMode});

  final CalendarSelectionMode selectionMode;

  @override
  State<_CalendarCalendarPanel> createState() => _CalendarCalendarPanelState();
}

class _CalendarCalendarPanelState extends State<_CalendarCalendarPanel> {
  CalendarView _view = CalendarView(2024, 3);
  CalendarValue? _value;

  /// A 24x24 stepper, the tap target the upstream calendar header uses.
  Widget _calendarStep(String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colors.border),
          borderRadius: Theme.of(context).borderRadiusSm,
        ),
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _calendarStep('<', () => setState(() => _view = _view.previous)),
            SizedBox(width: spacing.sm),
            Text('${_view.year}-${_view.month}'),
            SizedBox(width: spacing.sm),
            _calendarStep('>', () => setState(() => _view = _view.next)),
          ],
        ),
        Gap(spacing.sm),
        Calendar(
          view: _view,
          now: _calendarToday,
          value: _value,
          selectionMode: widget.selectionMode,
          onChanged: (CalendarValue? value) => setState(() => _value = value),
        ),
      ],
    );
  }
}

Widget _calendarSingle(BuildContext context) =>
    const _CalendarCalendarPanel(selectionMode: CalendarSelectionMode.single);
''',
    ),
    DocsExampleSource(
      name: 'Range',
      builder: '_calendarRange',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/date_math.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/calendar/calendar.dart';

/// The month the examples show.
final DateTime _calendarToday = DateTime(2024, 3, 14);

/// One interactive calendar in [selectionMode], with a month header:
/// `Calendar` owns no navigation, so the caller drives the view.
class _CalendarCalendarPanel extends StatefulWidget {
  const _CalendarCalendarPanel({required this.selectionMode});

  final CalendarSelectionMode selectionMode;

  @override
  State<_CalendarCalendarPanel> createState() => _CalendarCalendarPanelState();
}

class _CalendarCalendarPanelState extends State<_CalendarCalendarPanel> {
  CalendarView _view = CalendarView(2024, 3);
  CalendarValue? _value;

  /// A 24x24 stepper, the tap target the upstream calendar header uses.
  Widget _calendarStep(String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colors.border),
          borderRadius: Theme.of(context).borderRadiusSm,
        ),
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _calendarStep('<', () => setState(() => _view = _view.previous)),
            SizedBox(width: spacing.sm),
            Text('${_view.year}-${_view.month}'),
            SizedBox(width: spacing.sm),
            _calendarStep('>', () => setState(() => _view = _view.next)),
          ],
        ),
        Gap(spacing.sm),
        Calendar(
          view: _view,
          now: _calendarToday,
          value: _value,
          selectionMode: widget.selectionMode,
          onChanged: (CalendarValue? value) => setState(() => _value = value),
        ),
      ],
    );
  }
}

Widget _calendarRange(BuildContext context) =>
    const _CalendarCalendarPanel(selectionMode: CalendarSelectionMode.range);
''',
    ),
    DocsExampleSource(
      name: 'Multi',
      builder: '_calendarMulti',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/date_math.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/calendar/calendar.dart';

/// The month the examples show.
final DateTime _calendarToday = DateTime(2024, 3, 14);

/// One interactive calendar in [selectionMode], with a month header:
/// `Calendar` owns no navigation, so the caller drives the view.
class _CalendarCalendarPanel extends StatefulWidget {
  const _CalendarCalendarPanel({required this.selectionMode});

  final CalendarSelectionMode selectionMode;

  @override
  State<_CalendarCalendarPanel> createState() => _CalendarCalendarPanelState();
}

class _CalendarCalendarPanelState extends State<_CalendarCalendarPanel> {
  CalendarView _view = CalendarView(2024, 3);
  CalendarValue? _value;

  /// A 24x24 stepper, the tap target the upstream calendar header uses.
  Widget _calendarStep(String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colors.border),
          borderRadius: Theme.of(context).borderRadiusSm,
        ),
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _calendarStep('<', () => setState(() => _view = _view.previous)),
            SizedBox(width: spacing.sm),
            Text('${_view.year}-${_view.month}'),
            SizedBox(width: spacing.sm),
            _calendarStep('>', () => setState(() => _view = _view.next)),
          ],
        ),
        Gap(spacing.sm),
        Calendar(
          view: _view,
          now: _calendarToday,
          value: _value,
          selectionMode: widget.selectionMode,
          onChanged: (CalendarValue? value) => setState(() => _value = value),
        ),
      ],
    );
  }
}

Widget _calendarMulti(BuildContext context) =>
    const _CalendarCalendarPanel(selectionMode: CalendarSelectionMode.multi);
''',
    ),
    DocsExampleSource(
      name: 'Month grid',
      builder: '_calendarMonthGrid',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/date_math.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/calendar/calendar.dart';

/// The month the examples show.
final DateTime _calendarToday = DateTime(2024, 3, 14);

/// The default month view, March 2024.
final CalendarView _calendarMarch = CalendarView(2024, 3);

/// A month grid that also serves as the month picker.
class _CalendarMonthGridPanel extends StatefulWidget {
  const _CalendarMonthGridPanel();

  @override
  State<_CalendarMonthGridPanel> createState() =>
      _CalendarMonthGridPanelState();
}

class _CalendarMonthGridPanelState extends State<_CalendarMonthGridPanel> {
  CalendarValue? _value;

  @override
  Widget build(BuildContext context) {
    return Calendar(
      view: _calendarMarch,
      viewType: CalendarViewType.month,
      now: _calendarToday,
      selectionMode: CalendarSelectionMode.single,
      value: _value,
      onChanged: (CalendarValue? value) => setState(() => _value = value),
    );
  }
}

Widget _calendarMonthGrid(BuildContext context) =>
    const _CalendarMonthGridPanel();
''',
    ),
    DocsExampleSource(
      name: 'Year grid',
      builder: '_calendarYearGrid',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/date_math.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/calendar/calendar.dart';

/// The month the examples show.
final DateTime _calendarToday = DateTime(2024, 3, 14);

/// The default month view, March 2024.
final CalendarView _calendarMarch = CalendarView(2024, 3);

/// A year grid.
class _CalendarYearGridPanel extends StatefulWidget {
  const _CalendarYearGridPanel();

  @override
  State<_CalendarYearGridPanel> createState() => _CalendarYearGridPanelState();
}

class _CalendarYearGridPanelState extends State<_CalendarYearGridPanel> {
  CalendarValue? _value;

  @override
  Widget build(BuildContext context) {
    return Calendar(
      view: _calendarMarch,
      viewType: CalendarViewType.year,
      now: _calendarToday,
      selectionMode: CalendarSelectionMode.single,
      value: _value,
      onChanged: (CalendarValue? value) => setState(() => _value = value),
    );
  }
}

Widget _calendarYearGrid(BuildContext context) =>
    const _CalendarYearGridPanel();
''',
    ),
  ],
  'date_picker': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Single',
      builder: '_datePickerSingle',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/form_core/object_form_field.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/calendar/calendar.dart';
import 'package:<your_app>/ui/dashcn/components/date_picker/date_picker.dart';

/// A label above a trigger.
class _DatePickerLabel extends StatelessWidget {
  const _DatePickerLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
    );
  }
}

/// The moment the examples show.
final DateTime _datePickerToday = DateTime(2024, 3, 14);

/// The single-date picker, empty and pre-filled.
Widget _datePickerSingle(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      _DatePickerLabel('Empty trigger'),
      Gap(spacing.sm),
      DatePicker(value: null, onChanged: (DateTime? value) {}),
      Gap(spacing.lg),
      _DatePickerLabel('Filled trigger'),
      Gap(spacing.sm),
      DatePicker(value: _datePickerToday, onChanged: (DateTime? value) {}),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Range',
      builder: '_datePickerRange',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/form_core/object_form_field.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/calendar/calendar.dart';
import 'package:<your_app>/ui/dashcn/components/date_picker/date_picker.dart';

/// A label above a trigger.
class _DatePickerLabel extends StatelessWidget {
  const _DatePickerLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
    );
  }
}

/// The moment the examples show.
final DateTime _datePickerToday = DateTime(2024, 3, 14);

/// The range picker, empty and pre-filled.
Widget _datePickerRange(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      _DatePickerLabel('Empty range trigger'),
      Gap(spacing.sm),
      DateRangePicker(value: null, onChanged: (DateTimeRange? value) {}),
      Gap(spacing.lg),
      _DatePickerLabel('Filled range trigger'),
      Gap(spacing.sm),
      DateRangePicker(
        value: DateTimeRange(
          _datePickerToday,
          _datePickerToday.add(const Duration(days: 6)),
        ),
        onChanged: (DateTimeRange? value) {},
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Dialog',
      builder: '_datePickerDialog',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/form_core/object_form_field.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/calendar/calendar.dart';
import 'package:<your_app>/ui/dashcn/components/date_picker/date_picker.dart';

/// The dialog prompt with a title.
Widget _datePickerDialog(BuildContext context) {
  return DatePicker(
    value: null,
    mode: PromptMode.dialog,
    dialogTitle: Text('Pick a date'),
    onChanged: null,
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Disabled',
      builder: '_datePickerDisabled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/form_core/object_form_field.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/calendar/calendar.dart';
import 'package:<your_app>/ui/dashcn/components/date_picker/date_picker.dart';

/// The disabled trigger.
Widget _datePickerDisabled(BuildContext context) {
  return const DatePicker(value: null, enabled: false, onChanged: null);
}
''',
    ),
    DocsExampleSource(
      name: 'Inline',
      builder: '_datePickerInline',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/form_core/object_form_field.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/calendar/calendar.dart';
import 'package:<your_app>/ui/dashcn/components/date_picker/date_picker.dart';

/// The inline calendar sheet, without a popover.
Widget _datePickerInline(BuildContext context) {
  return const SizedBox(
    width: 280,
    child: DatePickerDialog(selectionMode: CalendarSelectionMode.single),
  );
}
''',
    ),
  ],
  'time_picker': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Clock',
      builder: '_clock',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/time_of_day.dart';
import 'package:<your_app>/ui/dashcn/components/time_picker/time_picker.dart';

/// Clock trigger; owns its value.
class _ClockTrigger extends StatefulWidget {
  const _ClockTrigger();

  @override
  State<_ClockTrigger> createState() => _ClockTriggerState();
}

class _ClockTriggerState extends State<_ClockTrigger> {
  TimeOfDay? _value = const TimeOfDay(hour: 14, minute: 30);

  @override
  Widget build(BuildContext context) {
    return TimePicker(
      value: _value,
      onChanged: (TimeOfDay? value) => setState(() => _value = value),
      use24HourFormat: true,
    );
  }
}

Widget _clock(BuildContext context) => const _ClockTrigger();
''',
    ),
    DocsExampleSource(
      name: 'Duration',
      builder: '_duration',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/time_of_day.dart';
import 'package:<your_app>/ui/dashcn/components/time_picker/time_picker.dart';

/// Duration trigger; owns its value.
class _DurationTrigger extends StatefulWidget {
  const _DurationTrigger();

  @override
  State<_DurationTrigger> createState() => _DurationTriggerState();
}

class _DurationTriggerState extends State<_DurationTrigger> {
  Duration? _value = const Duration(hours: 1, minutes: 30);

  @override
  Widget build(BuildContext context) {
    return DurationPicker(
      value: _value,
      onChanged: (Duration? value) => setState(() => _value = value),
    );
  }
}

Widget _duration(BuildContext context) => const _DurationTrigger();
''',
    ),
    DocsExampleSource(
      name: 'Clock dialog',
      builder: '_clockDialog',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/time_of_day.dart';
import 'package:<your_app>/ui/dashcn/components/time_picker/time_picker.dart';

/// The inline clock sheet.
Widget _clockDialog(BuildContext context) {
  return const TimePickerDialog(use24HourFormat: true);
}
''',
    ),
    DocsExampleSource(
      name: 'Duration dialog',
      builder: '_durationDialog',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/time_of_day.dart';
import 'package:<your_app>/ui/dashcn/components/time_picker/time_picker.dart';

/// The inline duration sheet.
Widget _durationDialog(BuildContext context) {
  return const DurationPickerDialog();
}
''',
    ),
  ],
  'alert': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_alertDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/alert/alert.dart';

/// One alert, stretched to the stage width.
Widget _alert(
  BuildContext context,
  AlertVariant variant,
  String title,
  String content,
) {
  return ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 512),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Alert(
          variant: variant,
          leading: const Icon(LucideIcons.info, size: 16),
          title: Text(title),
          content: Text(content),
        ),
      ],
    ),
  );
}

/// Default variant.
Widget _alertDefault(BuildContext context) => _alert(
  context,
  AlertVariant.base,
  'Heads up',
  'You can install components from the CLI.',
);
''',
    ),
    DocsExampleSource(
      name: 'Destructive',
      builder: '_alertDestructive',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/alert/alert.dart';

/// One alert, stretched to the stage width.
Widget _alert(
  BuildContext context,
  AlertVariant variant,
  String title,
  String content,
) {
  return ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 512),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Alert(
          variant: variant,
          leading: const Icon(LucideIcons.info, size: 16),
          title: Text(title),
          content: Text(content),
        ),
      ],
    ),
  );
}

/// Destructive variant.
Widget _alertDestructive(BuildContext context) => _alert(
  context,
  AlertVariant.destructive,
  'Session expired',
  'Please log in again to continue.',
);
''',
    ),
    DocsExampleSource(
      name: 'Compact',
      builder: '_alertCompact',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/alert/alert.dart';

/// A compact alert whose trailing button dismisses it.
class _AlertCompact extends StatefulWidget {
  const _AlertCompact();

  @override
  State<_AlertCompact> createState() => _AlertCompactState();
}

class _AlertCompactState extends State<_AlertCompact> {
  bool _dismissed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 512),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (!_dismissed)
            Alert(
              title: Text('Notification'),
              content: Text('You have a new message.'),
              trailing: Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.ghost,
                onPressed: () => setState(() => _dismissed = true),
                child: const Icon(LucideIcons.x, size: 14),
              ),
            )
          else
            Text(
              'Notification dismissed.',
              style: TextStyle(color: theme.colors.mutedForeground),
            ),
          Gap(theme.spacing.md),
          Button(
            size: ButtonSize.sm,
            variant: ButtonVariant.outline,
            onPressed: () => setState(() => _dismissed = false),
            child: Text('Show again'),
          ),
        ],
      ),
    );
  }
}

Widget _alertCompact(BuildContext context) => const _AlertCompact();
''',
    ),
  ],
  'progress': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Determinate',
      builder: '_progressDeterminate',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/progress/progress.dart';

/// Determinate values at a few fill levels and heights.
Widget _progressDeterminate(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  final bar = <Widget>[
    Progress(value: 0.25, semanticsLabel: 'Quarter'),
    Gap(spacing.lg),
    Progress(value: 0.6, semanticsLabel: 'Sixty percent'),
    Gap(spacing.lg),
    Progress(
      value: 0.85,
      showSparks: true,
      semanticsLabel: 'Eighty five percent',
    ),
  ];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      ...bar,
      Gap(spacing.lg),
      SizedBox(
        width: 320,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Progress(value: 0.4, height: 4),
            Gap(spacing.lg),
            const Progress(value: 0.5, height: 14),
          ],
        ),
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Live',
      builder: '_progressLive',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/progress/progress.dart';

/// A bar the example drives between 0 and 100%.
class _ProgressLive extends StatefulWidget {
  const _ProgressLive();

  @override
  State<_ProgressLive> createState() => _ProgressLiveState();
}

class _ProgressLiveState extends State<_ProgressLive> {
  double _value = 0.35;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Progress(
          value: _value,
          showSparks: true,
          semanticsLabel: 'Upload progress',
        ),
        Gap(theme.spacing.md),
        Text(
          '${(_value * 100).round()}% uploaded',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
        Gap(theme.spacing.md),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Button(
              size: ButtonSize.sm,
              variant: ButtonVariant.outline,
              onPressed: () =>
                  setState(() => _value = _value >= 0.15 ? _value - 0.15 : 0),
              child: const Text('-15%'),
            ),
            Gap(theme.spacing.sm),
            Button(
              size: ButtonSize.sm,
              variant: ButtonVariant.outline,
              onPressed: () =>
                  setState(() => _value = _value <= 0.85 ? _value + 0.15 : 1),
              child: const Text('+15%'),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _progressLive(BuildContext context) => const _ProgressLive();
''',
    ),
    DocsExampleSource(
      name: 'Indeterminate',
      builder: '_progressIndeterminate',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/progress/progress.dart';

/// Indeterminate mode.
Widget _progressIndeterminate(BuildContext context) {
  return Progress(semanticsLabel: 'Loading');
}
''',
    ),
  ],
  'skeleton': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_skeletonDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/skeleton/skeleton.dart';

/// Tap target that flips the loading state of the example.
class _SkeletonSkeletonToggle extends StatelessWidget {
  const _SkeletonSkeletonToggle({
    required this.loading,
    required this.onPressed,
  });

  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // A real Button (keyboard, hover, focus ring, semantics) instead of a
    // hand-rolled GestureDetector pill.
    return Button(
      size: ButtonSize.sm,
      variant: ButtonVariant.outline,
      onPressed: onPressed,
      child: Text(
        loading
            ? 'Show content'
            : 'Show skeleton',
      ),
    );
  }
}

/// A text block that swaps between the shimmer and its loaded content.
class _SkeletonSkeletonBlock extends StatefulWidget {
  const _SkeletonSkeletonBlock();

  @override
  State<_SkeletonSkeletonBlock> createState() => _SkeletonSkeletonBlockState();
}

class _SkeletonSkeletonBlockState extends State<_SkeletonSkeletonBlock> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _SkeletonSkeletonToggle(
          loading: _loading,
          onPressed: () => setState(() => _loading = !_loading),
        ),
        Gap(theme.spacing.lg),
        Skeleton(
          enabled: _loading,
          child: Container(
            width: 260,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: theme.colors.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Card title',
                  style: TextStyle(color: theme.colors.foreground),
                ),
                Gap(theme.spacing.sm),
                Text(
                  'Body copy that keeps its box while loading.',
                  // Body copy renders over the muted shimmer sweep.
                  style: TextStyle(color: theme.colors.onMuted),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _skeletonDefault(BuildContext context) => const _SkeletonSkeletonBlock();
''',
    ),
    DocsExampleSource(
      name: 'Card',
      builder: '_skeletonCard',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/skeleton/skeleton.dart';

/// A circular skeleton next to two bars.
class _SkeletonSkeletonCard extends StatelessWidget {
  const _SkeletonSkeletonCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Skeleton(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          child: SizedBox(width: 80, height: 80),
        ),
        Gap(theme.spacing.lg),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 180,
              child: Skeleton(
                child: Text(
                  'Title',
                  style: TextStyle(color: theme.colors.foreground),
                ),
              ),
            ),
            Gap(theme.spacing.sm),
            SizedBox(
              width: 140,
              child: Skeleton(
                child: Text(
                  'Supporting copy',
                  style: TextStyle(color: theme.colors.mutedForeground),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _skeletonCard(BuildContext context) => const _SkeletonSkeletonCard();
''',
    ),
    DocsExampleSource(
      name: 'List',
      builder: '_skeletonList',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/skeleton/skeleton.dart';

Widget _skeletonList(BuildContext context) => const SkeletonList(itemCount: 3);
''',
    ),
    DocsExampleSource(
      name: 'Loading card',
      builder: '_skeletonLoadingCard',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/skeleton/skeleton.dart';

Widget _skeletonLoadingCard(BuildContext context) =>
    const SkeletonCard(showAvatar: true, contentLines: 2, showFooter: true);
''',
    ),
    DocsExampleSource(
      name: 'Table',
      builder: '_skeletonTable',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/skeleton/skeleton.dart';

Widget _skeletonTable(BuildContext context) =>
    const SkeletonTable(columns: 3, rows: 4);
''',
    ),
  ],
  'spinner': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_spinnerDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/spinner/spinner.dart';

/// The size scale and a couple of stroke widths in one row.
Widget _spinnerDefault(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Wrap(
    spacing: spacing.xl,
    runSpacing: spacing.xl,
    alignment: WrapAlignment.center,
    children: const <Widget>[
      Spinner(),
      Spinner(size: 16),
      Spinner(size: 32),
      Spinner(size: 48),
      Spinner(strokeWidth: 2),
      Spinner(strokeWidth: 6),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Small',
      builder: '_spinnerSmall',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/spinner/spinner.dart';

/// A small spinner inside a text row.
Widget _spinnerSmall(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      const Spinner(size: 14, strokeWidth: 2),
      Gap(spacing.sm),
      Text(
        'Loading...',
        style: TextStyle(
          fontSize: 13,
          color: Theme.of(context).colors.mutedForeground,
        ),
      ),
    ],
  );
}
''',
    ),
  ],
  'toast': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/toast/toast.dart';

/// Centred trigger column.
class _Trigger extends StatelessWidget {
  const _Trigger({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

Widget _default(BuildContext context) => _Trigger(
  label: 'Show toast',
  onPressed: () => showToast(
    context,
    builder: (context) => Text('Saved to your workspace.'),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Destructive',
      builder: '_destructive',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/toast/toast.dart';

/// Centred trigger column.
class _Trigger extends StatelessWidget {
  const _Trigger({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

Widget _destructive(BuildContext context) => _Trigger(
  label: 'Show destructive toast',
  onPressed: () => showToast(
    context,
    placement: ToastPlacement.bottomCenter,
    builder: (BuildContext toastContext) => Text(
      'Could not save the file.',
      style: TextStyle(
        color: Theme.of(toastContext).colors.destructive,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'With action',
      builder: '_withAction',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/toast/toast.dart';

/// Centred trigger column.
class _Trigger extends StatelessWidget {
  const _Trigger({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

/// Toast with a live inline action.
class _ActionTrigger extends StatelessWidget {
  const _ActionTrigger();

  @override
  Widget build(BuildContext context) {
    return _Trigger(
      label: 'Show toast with action',
      onPressed: () => showToast(
        context,
        placement: ToastPlacement.bottomTrailing,
        builder: (BuildContext toastContext) => Wrap(
          spacing: Theme.of(toastContext).spacing.md,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text('Deployment started.'),
            Button(
              variant: ButtonVariant.secondary,
              size: ButtonSize.sm,
              onPressed: () => toastControllerOf(toastContext)?.dismissAll(),
              child: Text('View'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _withAction(BuildContext context) => const _ActionTrigger();
''',
    ),
    DocsExampleSource(
      name: 'Positions',
      builder: '_positions',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/toast/toast.dart';

/// One trigger per window position, all over the app.
Widget _positions(BuildContext context) {
  final double gap = Theme.of(context).spacing.sm;
  return Center(
    child: Wrap(
      spacing: gap,
      runSpacing: gap,
      alignment: WrapAlignment.center,
      children: <Widget>[
        for (final ToastPlacement placement in ToastPlacement.values)
          Button(
            variant: ButtonVariant.outline,
            size: ButtonSize.sm,
            onPressed: () => showToast(
              context,
              placement: placement,
              builder: (context) => Text('Toast at ${placement.name}.'),
            ),
            child: Text(placement.name),
          ),
      ],
    ),
  );
}
''',
    ),
  ],
  'autocomplete': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_autocompleteDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/input_features/input_features.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';
import 'package:<your_app>/ui/dashcn/components/autocomplete/autocomplete.dart';

List<String> _autocompleteFruits = <String>[
  'Apple',
  'Apricot',
  'Avocado',
  'Banana',
  'Cherry',
  'Grape',
  'Kiwi',
  'Lemon',
  'Mango',
  'Orange',
  'Peach',
  'Pear',
  'Pineapple',
  'Strawberry',
  'Watermelon',
];

Iterable<String> _autocompleteFilter(String query) {
  final String needle = query.toLowerCase();
  if (needle.isEmpty) {
    return const <String>[];
  }
  return _autocompleteFruits.where(
    (fruit) => fruit.toLowerCase().contains(needle),
  );
}

/// One completion field, plus the example's own selection echo.
class _AutocompleteAutoCompleteField extends StatefulWidget {
  const _AutocompleteAutoCompleteField({
    required this.hint,
    this.mode,
    this.completer,
    this.itemBuilder,
  });

  final String hint;
  final AutoCompleteMode? mode;
  final AutoCompleteCompleter? completer;
  final Widget Function(BuildContext context, String suggestion, bool selected)?
  itemBuilder;

  @override
  State<_AutocompleteAutoCompleteField> createState() =>
      _AutocompleteAutoCompleteFieldState();
}

class _AutocompleteAutoCompleteFieldState
    extends State<_AutocompleteAutoCompleteField> {
  String _selected = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Input(
            hintText: 'Type a fruit - ${widget.hint}',
            features: <InputFeature>[
              AutoCompleteFeature(
                suggestions: _autocompleteFilter,
                mode: widget.mode,
                completer: widget.completer ?? (String s) => s,
                itemBuilder: widget.itemBuilder,
                onSuggestionSelected: (String value) =>
                    setState(() => _selected = value),
              ),
            ],
          ),
          Gap(theme.spacing.md),
          Text(
            'Last selected: ${_selected.isEmpty ? '-' : _selected}',
            style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
          ),
        ],
      ),
    );
  }
}

/// The default replacement mode.
Widget _autocompleteDefault(BuildContext context) =>
    _AutocompleteAutoCompleteField(
      hint: 'replaces the word',
    );
''',
    ),
    DocsExampleSource(
      name: 'Append',
      builder: '_autocompleteAppend',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/input_features/input_features.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';
import 'package:<your_app>/ui/dashcn/components/autocomplete/autocomplete.dart';

List<String> _autocompleteFruits = <String>[
  'Apple',
  'Apricot',
  'Avocado',
  'Banana',
  'Cherry',
  'Grape',
  'Kiwi',
  'Lemon',
  'Mango',
  'Orange',
  'Peach',
  'Pear',
  'Pineapple',
  'Strawberry',
  'Watermelon',
];

Iterable<String> _autocompleteFilter(String query) {
  final String needle = query.toLowerCase();
  if (needle.isEmpty) {
    return const <String>[];
  }
  return _autocompleteFruits.where(
    (fruit) => fruit.toLowerCase().contains(needle),
  );
}

/// One completion field, plus the example's own selection echo.
class _AutocompleteAutoCompleteField extends StatefulWidget {
  const _AutocompleteAutoCompleteField({
    required this.hint,
    this.mode,
    this.completer,
    this.itemBuilder,
  });

  final String hint;
  final AutoCompleteMode? mode;
  final AutoCompleteCompleter? completer;
  final Widget Function(BuildContext context, String suggestion, bool selected)?
  itemBuilder;

  @override
  State<_AutocompleteAutoCompleteField> createState() =>
      _AutocompleteAutoCompleteFieldState();
}

class _AutocompleteAutoCompleteFieldState
    extends State<_AutocompleteAutoCompleteField> {
  String _selected = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Input(
            hintText: 'Type a fruit - ${widget.hint}',
            features: <InputFeature>[
              AutoCompleteFeature(
                suggestions: _autocompleteFilter,
                mode: widget.mode,
                completer: widget.completer ?? (String s) => s,
                itemBuilder: widget.itemBuilder,
                onSuggestionSelected: (String value) =>
                    setState(() => _selected = value),
              ),
            ],
          ),
          Gap(theme.spacing.md),
          Text(
            'Last selected: ${_selected.isEmpty ? '-' : _selected}',
            style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
          ),
        ],
      ),
    );
  }
}

/// Append mode: the suggestion is inserted at the caret.
Widget _autocompleteAppend(BuildContext context) =>
    _AutocompleteAutoCompleteField(
      hint: 'appended at the caret',
      mode: AutoCompleteMode.append,
    );
''',
    ),
    DocsExampleSource(
      name: 'Replace all',
      builder: '_autocompleteReplaceAll',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/input_features/input_features.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';
import 'package:<your_app>/ui/dashcn/components/autocomplete/autocomplete.dart';

List<String> _autocompleteFruits = <String>[
  'Apple',
  'Apricot',
  'Avocado',
  'Banana',
  'Cherry',
  'Grape',
  'Kiwi',
  'Lemon',
  'Mango',
  'Orange',
  'Peach',
  'Pear',
  'Pineapple',
  'Strawberry',
  'Watermelon',
];

Iterable<String> _autocompleteFilter(String query) {
  final String needle = query.toLowerCase();
  if (needle.isEmpty) {
    return const <String>[];
  }
  return _autocompleteFruits.where(
    (fruit) => fruit.toLowerCase().contains(needle),
  );
}

/// One completion field, plus the example's own selection echo.
class _AutocompleteAutoCompleteField extends StatefulWidget {
  const _AutocompleteAutoCompleteField({
    required this.hint,
    this.mode,
    this.completer,
    this.itemBuilder,
  });

  final String hint;
  final AutoCompleteMode? mode;
  final AutoCompleteCompleter? completer;
  final Widget Function(BuildContext context, String suggestion, bool selected)?
  itemBuilder;

  @override
  State<_AutocompleteAutoCompleteField> createState() =>
      _AutocompleteAutoCompleteFieldState();
}

class _AutocompleteAutoCompleteFieldState
    extends State<_AutocompleteAutoCompleteField> {
  String _selected = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Input(
            hintText: 'Type a fruit - ${widget.hint}',
            features: <InputFeature>[
              AutoCompleteFeature(
                suggestions: _autocompleteFilter,
                mode: widget.mode,
                completer: widget.completer ?? (String s) => s,
                itemBuilder: widget.itemBuilder,
                onSuggestionSelected: (String value) =>
                    setState(() => _selected = value),
              ),
            ],
          ),
          Gap(theme.spacing.md),
          Text(
            'Last selected: ${_selected.isEmpty ? '-' : _selected}',
            style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
          ),
        ],
      ),
    );
  }
}

/// Replace-all mode: the whole field is replaced.
Widget _autocompleteReplaceAll(BuildContext context) =>
    _AutocompleteAutoCompleteField(
      hint: 'replaces the whole field',
      mode: AutoCompleteMode.replaceAll,
    );
''',
    ),
    DocsExampleSource(
      name: 'Custom row',
      builder: '_autocompleteCustomRow',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/input_features/input_features.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';
import 'package:<your_app>/ui/dashcn/components/autocomplete/autocomplete.dart';

List<String> _autocompleteFruits = <String>[
  'Apple',
  'Apricot',
  'Avocado',
  'Banana',
  'Cherry',
  'Grape',
  'Kiwi',
  'Lemon',
  'Mango',
  'Orange',
  'Peach',
  'Pear',
  'Pineapple',
  'Strawberry',
  'Watermelon',
];

Iterable<String> _autocompleteFilter(String query) {
  final String needle = query.toLowerCase();
  if (needle.isEmpty) {
    return const <String>[];
  }
  return _autocompleteFruits.where(
    (fruit) => fruit.toLowerCase().contains(needle),
  );
}

/// One completion field, plus the example's own selection echo.
class _AutocompleteAutoCompleteField extends StatefulWidget {
  const _AutocompleteAutoCompleteField({
    required this.hint,
    this.mode,
    this.completer,
    this.itemBuilder,
  });

  final String hint;
  final AutoCompleteMode? mode;
  final AutoCompleteCompleter? completer;
  final Widget Function(BuildContext context, String suggestion, bool selected)?
  itemBuilder;

  @override
  State<_AutocompleteAutoCompleteField> createState() =>
      _AutocompleteAutoCompleteFieldState();
}

class _AutocompleteAutoCompleteFieldState
    extends State<_AutocompleteAutoCompleteField> {
  String _selected = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Input(
            hintText: 'Type a fruit - ${widget.hint}',
            features: <InputFeature>[
              AutoCompleteFeature(
                suggestions: _autocompleteFilter,
                mode: widget.mode,
                completer: widget.completer ?? (String s) => s,
                itemBuilder: widget.itemBuilder,
                onSuggestionSelected: (String value) =>
                    setState(() => _selected = value),
              ),
            ],
          ),
          Gap(theme.spacing.md),
          Text(
            'Last selected: ${_selected.isEmpty ? '-' : _selected}',
            style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
          ),
        ],
      ),
    );
  }
}

/// A custom completer plus a custom row builder.
Widget _autocompleteCustomRow(BuildContext context) =>
    _AutocompleteAutoCompleteField(
      hint: 'with a padded completion',
      completer: _autocompletePad,
      itemBuilder: _autocompleteBoldWhenSelected,
    );

String _autocompletePad(String suggestion) => '$suggestion ';

Widget _autocompleteBoldWhenSelected(
  BuildContext context,
  String suggestion,
  bool selected,
) => Text(
  suggestion,
  style: TextStyle(fontWeight: selected ? FontWeight.w600 : FontWeight.w400),
);
''',
    ),
  ],
  'checkbox': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_checkboxDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/checkbox/checkbox.dart';

/// One labelled checkbox row; the component owns the label gap (upstream
/// `gap-2`) and makes the whole row clickable.
Widget _checkboxRow(BuildContext context, Checkbox checkbox, String label) {
  return Checkbox(
    value: checkbox.value,
    controller: checkbox.controller,
    onChanged: checkbox.onChanged,
    tristate: checkbox.tristate,
    enabled: checkbox.enabled,
    size: checkbox.size,
    gap: checkbox.gap,
    padding: checkbox.padding,
    theme: checkbox.theme,
    focusNode: checkbox.focusNode,
    label: Text(label),
  );
}

/// Unchecked, the default.
class _CheckboxDefaultCheckbox extends StatefulWidget {
  const _CheckboxDefaultCheckbox();

  @override
  State<_CheckboxDefaultCheckbox> createState() =>
      _CheckboxDefaultCheckboxState();
}

class _CheckboxDefaultCheckboxState extends State<_CheckboxDefaultCheckbox> {
  CheckboxValue _value = CheckboxValue.unchecked;

  @override
  Widget build(BuildContext context) {
    return _checkboxRow(
      context,
      Checkbox(
        value: _value,
        onChanged: (CheckboxValue value) => setState(() => _value = value),
      ),
      'Accept terms',
    );
  }
}

Widget _checkboxDefault(BuildContext context) =>
    const _CheckboxDefaultCheckbox();
''',
    ),
    DocsExampleSource(
      name: 'Checked',
      builder: '_checkboxChecked',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/checkbox/checkbox.dart';

/// One labelled checkbox row; the component owns the label gap (upstream
/// `gap-2`) and makes the whole row clickable.
Widget _checkboxRow(BuildContext context, Checkbox checkbox, String label) {
  return Checkbox(
    value: checkbox.value,
    controller: checkbox.controller,
    onChanged: checkbox.onChanged,
    tristate: checkbox.tristate,
    enabled: checkbox.enabled,
    size: checkbox.size,
    gap: checkbox.gap,
    padding: checkbox.padding,
    theme: checkbox.theme,
    focusNode: checkbox.focusNode,
    label: Text(label),
  );
}

/// Checked.
class _CheckboxCheckedCheckbox extends StatefulWidget {
  const _CheckboxCheckedCheckbox();

  @override
  State<_CheckboxCheckedCheckbox> createState() =>
      _CheckboxCheckedCheckboxState();
}

class _CheckboxCheckedCheckboxState extends State<_CheckboxCheckedCheckbox> {
  CheckboxValue _value = CheckboxValue.checked;

  @override
  Widget build(BuildContext context) {
    return _checkboxRow(
      context,
      Checkbox(
        value: _value,
        onChanged: (CheckboxValue value) => setState(() => _value = value),
      ),
      'Notify me',
    );
  }
}

Widget _checkboxChecked(BuildContext context) =>
    const _CheckboxCheckedCheckbox();
''',
    ),
    DocsExampleSource(
      name: 'Indeterminate',
      builder: '_checkboxIndeterminate',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/checkbox/checkbox.dart';

/// One labelled checkbox row; the component owns the label gap (upstream
/// `gap-2`) and makes the whole row clickable.
Widget _checkboxRow(BuildContext context, Checkbox checkbox, String label) {
  return Checkbox(
    value: checkbox.value,
    controller: checkbox.controller,
    onChanged: checkbox.onChanged,
    tristate: checkbox.tristate,
    enabled: checkbox.enabled,
    size: checkbox.size,
    gap: checkbox.gap,
    padding: checkbox.padding,
    theme: checkbox.theme,
    focusNode: checkbox.focusNode,
    label: Text(label),
  );
}

/// Tri-state: the unchecked -> indeterminate -> checked cycle.
class _CheckboxTristateCheckbox extends StatefulWidget {
  const _CheckboxTristateCheckbox();

  @override
  State<_CheckboxTristateCheckbox> createState() =>
      _CheckboxTristateCheckboxState();
}

class _CheckboxTristateCheckboxState extends State<_CheckboxTristateCheckbox> {
  CheckboxValue _value = CheckboxValue.unchecked;

  @override
  Widget build(BuildContext context) {
    return _checkboxRow(
      context,
      Checkbox(
        tristate: true,
        value: _value,
        onChanged: (CheckboxValue value) => setState(() => _value = value),
      ),
      _value.name,
    );
  }
}

Widget _checkboxIndeterminate(BuildContext context) =>
    const _CheckboxTristateCheckbox();
''',
    ),
    DocsExampleSource(
      name: 'Disabled',
      builder: '_checkboxDisabled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/checkbox/checkbox.dart';

/// One labelled checkbox row; the component owns the label gap (upstream
/// `gap-2`) and makes the whole row clickable.
Widget _checkboxRow(BuildContext context, Checkbox checkbox, String label) {
  return Checkbox(
    value: checkbox.value,
    controller: checkbox.controller,
    onChanged: checkbox.onChanged,
    tristate: checkbox.tristate,
    enabled: checkbox.enabled,
    size: checkbox.size,
    gap: checkbox.gap,
    padding: checkbox.padding,
    theme: checkbox.theme,
    focusNode: checkbox.focusNode,
    label: Text(label),
  );
}

/// Disabled in both states.
Widget _checkboxDisabled(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    spacing: spacing.md,
    children: <Widget>[
      _checkboxRow(
        context,
        const Checkbox(value: CheckboxValue.checked),
        'On (disabled)',
      ),
      _checkboxRow(
        context,
        const Checkbox(value: CheckboxValue.unchecked),
        'Off',
      ),
    ],
  );
}
''',
    ),
  ],
  'chip_input': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_chipInputDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chip_input/chip_input.dart';

/// The controlled field: the example owns the chip list.
class _ChipInputControlledChips extends StatefulWidget {
  const _ChipInputControlledChips();

  @override
  State<_ChipInputControlledChips> createState() =>
      _ChipInputControlledChipsState();
}

class _ChipInputControlledChipsState extends State<_ChipInputControlledChips> {
  List<String> _chips = <String>['flutter'];

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ChipInput<String>(
          hintText: 'Add a tag and press Enter',
          chips: _chips,
          onChipsChanged: (List<String> chips) =>
              setState(() => _chips = chips),
          onChipSubmit: (String text) => text.trim().toLowerCase(),
        ),
        Gap(spacing.sm),
        Text('value: ${_chips.join(', ')}'),
      ],
    );
  }
}

Widget _chipInputDefault(BuildContext context) =>
    const _ChipInputControlledChips();
''',
    ),
    DocsExampleSource(
      name: 'With suggestions',
      builder: '_chipInputSuggestions',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chip_input/chip_input.dart';

/// Rejects the word at the caret; used where the typed word is irrelevant.
String? _chipInputReject(String text) => null;

/// Suggestions for the suggestion example.
const List<String> _chipInputFruits = <String>[
  'apple',
  'apricot',
  'avocado',
  'banana',
  'blueberry',
  'cherry',
];

/// The suggestion list filtering as you type.
class _ChipInputSuggestedChips extends StatelessWidget {
  const _ChipInputSuggestedChips();

  @override
  Widget build(BuildContext context) {
    return ChipInput<String>(
      hintText: 'Type to filter the fruits',
      onChipSubmit: _chipInputReject,
      suggestions: (String query) => _chipInputFruits
          .where((String fruit) => fruit.startsWith(query.toLowerCase()))
          .take(5),
    );
  }
}

Widget _chipInputSuggestions(BuildContext context) =>
    const _ChipInputSuggestedChips();
''',
    ),
    DocsExampleSource(
      name: 'Read-only',
      builder: '_chipInputReadOnly',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chip_input/chip_input.dart';

/// Rejects the word at the caret; used where the typed word is irrelevant.
String? _chipInputReject(String text) => null;

/// Read-only tokens: no remove button.
class _ChipInputReadOnlyChips extends StatelessWidget {
  const _ChipInputReadOnlyChips();

  @override
  Widget build(BuildContext context) {
    return ChipInput<String>(
      hintText: 'Tokens without a remove button',
      initialChips: <String>['flutter', 'dashcn'],
      theme: ChipInputTheme(removable: false),
      onChipSubmit: _chipInputReject,
    );
  }
}

Widget _chipInputReadOnly(BuildContext context) =>
    const _ChipInputReadOnlyChips();
''',
    ),
    DocsExampleSource(
      name: 'Validated',
      builder: '_chipInputValidated',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chip_input/chip_input.dart';

/// Rejects the word at the caret; used where the typed word is irrelevant.
String? _chipInputReject(String text) => null;

/// The validated field, below the minimum.
class _ChipInputValidatedChips extends StatelessWidget {
  const _ChipInputValidatedChips();

  @override
  Widget build(BuildContext context) {
    return ChipInput<String>(
      hintText: 'Needs at least two chips',
      initialChips: const <String>['flutter'],
      validator: (List<String> chips) => chips.length < 2
          ? 'Pick at least two chips.'
          : null,
      onChipSubmit: _chipInputReject,
    );
  }
}

Widget _chipInputValidated(BuildContext context) =>
    const _ChipInputValidatedChips();
''',
    ),
    DocsExampleSource(
      name: 'Disabled',
      builder: '_chipInputDisabled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/chip_input/chip_input.dart';

/// Rejects the word at the caret; used where the typed word is irrelevant.
String? _chipInputReject(String text) => null;

/// The disabled field.
class _ChipInputDisabledChips extends StatelessWidget {
  const _ChipInputDisabledChips();

  @override
  Widget build(BuildContext context) {
    return const ChipInput<String>(
      enabled: false,
      initialChips: <String>['disabled'],
      onChipSubmit: _chipInputReject,
    );
  }
}

Widget _chipInputDisabled(BuildContext context) =>
    const _ChipInputDisabledChips();
''',
    ),
  ],
  'dropzone': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_dropzoneDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/dropzone/dropzone.dart';

/// The interactive zone: browse, hover and state switching all work.
class _DropzoneDemo extends StatefulWidget {
  const _DropzoneDemo();

  @override
  State<_DropzoneDemo> createState() => _DropzoneDemoState();
}

class _DropzoneDemoState extends State<_DropzoneDemo> {
  DropzoneState _state = DropzoneState.idle;
  bool _dragOver = false;

  void _setState(DropzoneState state) => setState(() => _state = state);

  void _browse() {
    setState(() {
      _dragOver = false;
      _state = _state == DropzoneState.uploading
          ? DropzoneState.success
          : DropzoneState.uploading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        MouseRegion(
          onEnter: (_) => setState(() => _dragOver = true),
          onExit: (_) => setState(() => _dragOver = false),
          child: Dropzone(
            state: _state,
            isDragOver: _dragOver,
            hint: Text('Up to 10 MB each.'),
            onBrowse: _browse,
          ),
        ),
        Gap(spacing.md),
        Wrap(
          spacing: spacing.sm,
          runSpacing: spacing.sm,
          children: <Widget>[
            for (final DropzoneState state in const <DropzoneState>[
              DropzoneState.idle,
              DropzoneState.uploading,
              DropzoneState.success,
              DropzoneState.error,
            ])
              Button(
                size: ButtonSize.sm,
                variant: ButtonVariant.outline,
                onPressed: () => _setState(state),
                child: Text(state.name),
              ),
          ],
        ),
      ],
    );
  }
}

Widget _dropzoneDefault(BuildContext context) => const _DropzoneDemo();
''',
    ),
    DocsExampleSource(
      name: 'Drag over',
      builder: '_dropzoneDragOver',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/dropzone/dropzone.dart';

/// The zone while a drag hovers over it.
Widget _dropzoneDragOver(BuildContext context) {
  return Dropzone(
    isDragOver: true,
    hint: Text('Release to upload.'),
    onBrowse: _dropzoneBrowse,
  );
}

void _dropzoneBrowse() {}
''',
    ),
    DocsExampleSource(
      name: 'Uploading',
      builder: '_dropzoneUploading',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/dropzone/dropzone.dart';

/// The uploading state, then a success one.
Widget _dropzoneUploading(BuildContext context) {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Dropzone(state: DropzoneState.uploading),
      SizedBox(height: 24),
      Dropzone(state: DropzoneState.success),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Error',
      builder: '_dropzoneError',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/dropzone/dropzone.dart';

/// The error state plus the disabled one.
Widget _dropzoneError(BuildContext context) {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Dropzone(state: DropzoneState.error),
      SizedBox(height: 24),
      Dropzone(enabled: false),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Custom content',
      builder: '_dropzoneCustom',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/dropzone/dropzone.dart';

/// The zone with a custom hint instead of the default content.
Widget _dropzoneCustom(BuildContext context) {
  return Dropzone(
    showAction: false,
    content: Text(
      'Drop a folder here to upload it whole.',
    ),
  );
}
''',
    ),
  ],
  'file_picker': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Dropzone',
      builder: '_dropzone',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/file_picker/file_picker.dart';

/// Fake platform picker used by the examples.
Future<List<FileValue>> _fakePick(FileUploadPickRequest request) async {
  return <FileValue>[
    FileValue(
      id: 'pick-pdf',
      name: 'report.pdf',
      size: 482000,
      mimeType: 'application/pdf',
    ),
    if (request.allowMultiple)
      FileValue(
        id: 'pick-png',
        name: 'photo.png',
        size: 1200000,
        mimeType: 'image/png',
      ),
  ];
}

/// Items caught mid-upload, showing the transfer states.
List<FileItem> _uploadingItems() {
  return <FileItem>[
    const FileItem(
      file: FileValue(id: 'queued', name: 'notes.txt', size: 1200),
    ),
    FileItem(
      file: const FileValue(id: 'uploading', name: 'design.pdf', size: 842000),
      status: FileStatus.uploading,
      progress: 0.45,
    ),
  ];
}

/// Drag-and-drop surface with a live transfer list.
class _DropzoneExample extends StatefulWidget {
  const _DropzoneExample();

  @override
  State<_DropzoneExample> createState() => _DropzoneExampleState();
}

class _DropzoneExampleState extends State<_DropzoneExample> {
  late final FileUploadController _controller = FileUploadController(
    initialItems: _uploadingItems(),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: FileUpload(
        pick: _fakePick,
        controller: _controller,
        upload: (_) => const Stream<double>.empty(),
      ),
    );
  }
}

Widget _dropzone(BuildContext context) => const _DropzoneExample();
''',
    ),
    DocsExampleSource(
      name: 'Tile',
      builder: '_tile',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/file_picker/file_picker.dart';

/// Fake platform picker used by the examples.
Future<List<FileValue>> _fakePick(FileUploadPickRequest request) async {
  return <FileValue>[
    FileValue(
      id: 'pick-pdf',
      name: 'report.pdf',
      size: 482000,
      mimeType: 'application/pdf',
    ),
    if (request.allowMultiple)
      FileValue(
        id: 'pick-png',
        name: 'photo.png',
        size: 1200000,
        mimeType: 'image/png',
      ),
  ];
}

/// Settled items for the compact surfaces.
List<FileItem> _settledItems() {
  return <FileItem>[
    const FileItem(
      file: FileValue(id: 'queued', name: 'notes.txt', size: 1200),
    ),
    FileItem(
      file: const FileValue(id: 'settled', name: 'archive.zip', size: 5400000),
      status: FileStatus.success,
      progress: 1,
    ),
  ];
}

/// One-line picker tile (label + chosen file name).
class _TileExample extends StatefulWidget {
  const _TileExample();

  @override
  State<_TileExample> createState() => _TileExampleState();
}

class _TileExampleState extends State<_TileExample> {
  late final FileUploadController _controller = FileUploadController(
    initialItems: _settledItems(),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: FileUpload(
        variant: FileUploadVariant.tile,
        pick: _fakePick,
        controller: _controller,
      ),
    );
  }
}

Widget _tile(BuildContext context) => const _TileExample();
''',
    ),
    DocsExampleSource(
      name: 'Trigger',
      builder: '_trigger',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/file_picker/file_picker.dart';

/// Fake platform picker used by the examples.
Future<List<FileValue>> _fakePick(FileUploadPickRequest request) async {
  return <FileValue>[
    FileValue(
      id: 'pick-pdf',
      name: 'report.pdf',
      size: 482000,
      mimeType: 'application/pdf',
    ),
    if (request.allowMultiple)
      FileValue(
        id: 'pick-png',
        name: 'photo.png',
        size: 1200000,
        mimeType: 'image/png',
      ),
  ];
}

/// Compact trigger for small layouts.
Widget _trigger(BuildContext context) {
  return const SizedBox(
    width: 320,
    child: FileUpload(variant: FileUploadVariant.mobile, pick: _fakePick),
  );
}
''',
    ),
  ],
  'form': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';
import 'package:<your_app>/ui/dashcn/components/form/form.dart';

/// A submit flow: one field, a submit button and the result line.
class _DefaultForm extends StatefulWidget {
  const _DefaultForm();

  @override
  State<_DefaultForm> createState() => _DefaultFormState();
}

class _DefaultFormState extends State<_DefaultForm> {
  final FormController _controller = FormController();
  final FormKey<String> _emailKey = const FormKey<String>('email');
  String _result = 'Not submitted';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SizedBox(
      width: 320,
      child: FormScope(
        controller: _controller,
        onSubmit: (values) =>
            setState(() => _result = 'Submitted ${values.length} value(s)'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FormItem<String>(
              key: _emailKey,
              label: Text('Email'),
              hint: Text('We never share it.'),
              validator: const NotEmptyValidator() & const EmailValidator(),
              child: const Input(),
            ),
            Gap(theme.spacing.lg),
            Button(
              onPressed: () => _controller.submit(context),
              child: Text('Submit'),
            ),
            Gap(theme.spacing.sm),
            Text(_result),
          ],
        ),
      ),
    );
  }
}

Widget _default(BuildContext context) => const _DefaultForm();
''',
    ),
    DocsExampleSource(
      name: 'Validating',
      builder: '_validating',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';
import 'package:<your_app>/ui/dashcn/components/form/form.dart';

/// A field validating on every change: the message appears as soon as the
/// typed value is invalid, and not a frame sooner.
class _ValidatingForm extends StatefulWidget {
  const _ValidatingForm();

  @override
  State<_ValidatingForm> createState() => _ValidatingFormState();
}

class _ValidatingFormState extends State<_ValidatingForm> {
  final FormController _controller = FormController();
  final FormKey<String> _emailKey = const FormKey<String>('email');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: FormScope(
        controller: _controller,
        child: FormItem<String>(
          key: _emailKey,
          label: Text('Email'),
          hint: Text(
            'The message shows only once you type.',
          ),
          validator: const NotEmptyValidator() & const EmailValidator(),
          showErrors: const <FormValidationMode>{FormValidationMode.changed},
          child: const Input(),
        ),
      ),
    );
  }
}

Widget _validating(BuildContext context) => const _ValidatingForm();
''',
    ),
  ],
  'formatted_input': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Phone',
      builder: '_phone',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/primitives/form_core/form_core.dart';
import 'package:<your_app>/ui/dashcn/components/formatted_input/formatted_input.dart';

/// A `(555) 123-4567` phone field in controlled mode.
class _PhoneExample extends StatefulWidget {
  const _PhoneExample();

  @override
  State<_PhoneExample> createState() => _PhoneExampleState();
}

class _PhoneExampleState extends State<_PhoneExample> {
  static final SegmentedValue _initial = SegmentedValue(<SegmentPart>[
    const SegmentPart.separator('('),
    SegmentPart.editable(
      length: 3,
      placeholder: const Text('555'),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
    ),
    const SegmentPart.separator(') '),
    SegmentPart.editable(
      length: 3,
      placeholder: const Text('123'),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
    ),
    const SegmentPart.separator('-'),
    SegmentPart.editable(
      length: 4,
      placeholder: const Text('4567'),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
    ),
  ]);

  SegmentedValue _value = _initial;

  @override
  Widget build(BuildContext context) {
    return FormattedInput(
      leading: const Icon(LucideIcons.phone, size: 16),
      value: _value,
      onChanged: (SegmentedValue value) => setState(() => _value = value),
    );
  }
}

Widget _phone(BuildContext context) => const _PhoneExample();
''',
    ),
    DocsExampleSource(
      name: 'Date',
      builder: '_date',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/primitives/form_core/form_core.dart';
import 'package:<your_app>/ui/dashcn/components/formatted_input/formatted_input.dart';

/// A date field reporting a validation error while incomplete.
Widget _date(BuildContext context) {
  return FormattedInput(
    initialValue: SegmentedValue(<SegmentPart>[
      SegmentPart.editable(
        length: 2,
        placeholder: const Text('MM'),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
      const SegmentPart.separator('/'),
      SegmentPart.editable(
        length: 2,
        placeholder: const Text('DD'),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
      const SegmentPart.separator('/'),
      SegmentPart.editable(
        length: 4,
        placeholder: const Text('YYYY'),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    ]),
    validator: _validateDate,
    autovalidateMode: FormValidationMode.changed,
  );
}

String? _validateDate(String? text) {
  final String value = text ?? '';
  if (value.length == 8) {
    return null;
  }
  return 'Enter a full date (MM/DD/YYYY).';
}
''',
    ),
    DocsExampleSource(
      name: 'Card',
      builder: '_card',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/primitives/form_core/form_core.dart';
import 'package:<your_app>/ui/dashcn/components/formatted_input/formatted_input.dart';

/// A 16-digit card field.
Widget _card(BuildContext context) {
  return FormattedInput(
    initialValue: SegmentedValue(<SegmentPart>[
      SegmentPart.editable(
        length: 4,
        placeholder: const Text('1234'),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
      const SegmentPart.separator(' '),
      SegmentPart.editable(
        length: 4,
        placeholder: const Text('5678'),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
      const SegmentPart.separator(' '),
      SegmentPart.editable(
        length: 4,
        placeholder: const Text('9012'),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
      const SegmentPart.separator(' '),
      SegmentPart.editable(
        length: 4,
        placeholder: const Text('3456'),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    ]),
  );
}
''',
    ),
  ],
  'input': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_inputDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/primitives/input_features/adornment_features.dart';
import 'package:<your_app>/ui/dashcn/primitives/input_features/input_features.dart';
import 'package:<your_app>/ui/dashcn/primitives/input_features/numeric_features.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';

/// A small section label above a field.
class _InputSection extends StatelessWidget {
  const _InputSection(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: theme.spacing.xs),
      child: Text(
        label,
        style: theme.typography.small.copyWith(
          color: theme.colors.mutedForeground,
        ),
      ),
    );
  }
}

/// The default email field.
//
// P7-D1b: capped at 400 px so the stage centres it instead of stretching it
// full-bleed.
Widget _inputDefault(BuildContext context) {
  return ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 400),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _InputSection('Email'),
        Input(hintText: 'Email'),
      ],
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'With icon',
      builder: '_inputWithIconExample',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/primitives/input_features/adornment_features.dart';
import 'package:<your_app>/ui/dashcn/primitives/input_features/input_features.dart';
import 'package:<your_app>/ui/dashcn/primitives/input_features/numeric_features.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';

/// A field with a leading icon and the clear/copy features.
class _InputWithIcon extends StatefulWidget {
  const _InputWithIcon();

  @override
  State<_InputWithIcon> createState() => _InputWithIconState();
}

class _InputWithIconState extends State<_InputWithIcon> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Input(
            controller: _controller,
            hintText: 'Type to enable clear/copy',
            features: <InputFeature>[
              InputLeadingFeature(const Icon(LucideIcons.search, size: 16)),
              InputClearFeature(),
              InputCopyFeature(),
              const InputPasteFeature(),
            ],
          ),
          Gap(spacing.lg),
          Input(
            obscureText: true,
            hintText: 'Password',
            features: const <InputFeature>[InputPasswordToggleFeature()],
          ),
          Gap(spacing.lg),
          Input(
            keyboardType: TextInputType.number,
            hintText: 'Quantity',
            features: const <InputFeature>[
              InputSpinnerFeature(min: 0, max: 10),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _inputWithIconExample(BuildContext context) => const _InputWithIcon();
''',
    ),
    DocsExampleSource(
      name: 'Invalid',
      builder: '_inputInvalid',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/primitives/input_features/adornment_features.dart';
import 'package:<your_app>/ui/dashcn/primitives/input_features/input_features.dart';
import 'package:<your_app>/ui/dashcn/primitives/input_features/numeric_features.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';

/// A small section label above a field.
class _InputSection extends StatelessWidget {
  const _InputSection(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: theme.spacing.xs),
      child: Text(
        label,
        style: theme.typography.small.copyWith(
          color: theme.colors.mutedForeground,
        ),
      ),
    );
  }
}

/// An invalid field.
Widget _inputInvalid(BuildContext context) {
  return ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 400),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _InputSection('Invalid'),
        Input(
          hintText: 'Invalid while non-empty',
          validator: _inputNotAllowed,
          features: <InputFeature>[InputRevalidateFeature()],
        ),
        _InputSection('Above / below and hint'),
        Input(
          hintText: 'With helper rows',
          features: <InputFeature>[
            InputAboveBelowFeature.above(Text('Label')),
            InputAboveBelowFeature.below(
              Text('Helper text'),
            ),
            InputHintFeature(popupBuilder: _inputHintPopup),
          ],
        ),
      ],
    ),
  );
}

String? _inputNotAllowed(String? value) => (value ?? '').isEmpty
    ? null
    : 'This value is not allowed.';

Widget _inputHintPopup(BuildContext context) =>
    Text('Extra information');
''',
    ),
    DocsExampleSource(
      name: 'Disabled',
      builder: '_inputDisabled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/primitives/input_features/adornment_features.dart';
import 'package:<your_app>/ui/dashcn/primitives/input_features/input_features.dart';
import 'package:<your_app>/ui/dashcn/primitives/input_features/numeric_features.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';

/// A small section label above a field.
class _InputSection extends StatelessWidget {
  const _InputSection(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: theme.spacing.xs),
      child: Text(
        label,
        style: theme.typography.small.copyWith(
          color: theme.colors.mutedForeground,
        ),
      ),
    );
  }
}

/// A disabled field beside a read-only one.
Widget _inputDisabled(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 400),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _InputSection('Disabled'),
        Input(hintText: 'Disabled', enabled: false),
        Gap(spacing.lg),
        _InputSection('Read-only'),
        Input(
          hintText: 'Read-only',
          readOnly: true,
          initialValue: 'Read-only value',
        ),
      ],
    ),
  );
}
''',
    ),
  ],
  'input_otp': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_inputOtpDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/input_otp/input_otp.dart';

/// The six-slot code field.
class _InputOtpOtp extends StatefulWidget {
  const _InputOtpOtp({
    this.length = 6,
    this.separatorEvery,
    this.obscureText = false,
  });

  final int length;
  final int? separatorEvery;
  final bool obscureText;

  @override
  State<_InputOtpOtp> createState() => _InputOtpOtpState();
}

class _InputOtpOtpState extends State<_InputOtpOtp> {
  String _code = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InputOtp(
          length: widget.length,
          separatorEvery: widget.separatorEvery,
          obscureText: widget.obscureText,
          onChanged: (String code) => setState(() => _code = code),
        ),
        Gap(theme.spacing.md),
        Text(
          'code: "$_code"',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

/// The default field.
Widget _inputOtpDefault(BuildContext context) => const _InputOtpOtp();
''',
    ),
    DocsExampleSource(
      name: 'Separated',
      builder: '_inputOtpSeparated',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/input_otp/input_otp.dart';

/// The six-slot code field.
class _InputOtpOtp extends StatefulWidget {
  const _InputOtpOtp({
    this.length = 6,
    this.separatorEvery,
    this.obscureText = false,
  });

  final int length;
  final int? separatorEvery;
  final bool obscureText;

  @override
  State<_InputOtpOtp> createState() => _InputOtpOtpState();
}

class _InputOtpOtpState extends State<_InputOtpOtp> {
  String _code = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InputOtp(
          length: widget.length,
          separatorEvery: widget.separatorEvery,
          obscureText: widget.obscureText,
          onChanged: (String code) => setState(() => _code = code),
        ),
        Gap(theme.spacing.md),
        Text(
          'code: "$_code"',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

/// A grouped field: a separator every three slots.
Widget _inputOtpSeparated(BuildContext context) =>
    const _InputOtpOtp(separatorEvery: 3);
''',
    ),
    DocsExampleSource(
      name: 'Obscured',
      builder: '_inputOtpObscured',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/input_otp/input_otp.dart';

/// The six-slot code field.
class _InputOtpOtp extends StatefulWidget {
  const _InputOtpOtp({
    this.length = 6,
    this.separatorEvery,
    this.obscureText = false,
  });

  final int length;
  final int? separatorEvery;
  final bool obscureText;

  @override
  State<_InputOtpOtp> createState() => _InputOtpOtpState();
}

class _InputOtpOtpState extends State<_InputOtpOtp> {
  String _code = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InputOtp(
          length: widget.length,
          separatorEvery: widget.separatorEvery,
          obscureText: widget.obscureText,
          onChanged: (String code) => setState(() => _code = code),
        ),
        Gap(theme.spacing.md),
        Text(
          'code: "$_code"',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

/// An obscured field (each character paints as a dot).
Widget _inputOtpObscured(BuildContext context) =>
    const _InputOtpOtp(obscureText: true);
''',
    ),
    DocsExampleSource(
      name: 'Four slots',
      builder: '_inputOtpFourSlots',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/input_otp/input_otp.dart';

/// The six-slot code field.
class _InputOtpOtp extends StatefulWidget {
  const _InputOtpOtp({
    this.length = 6,
    this.separatorEvery,
    this.obscureText = false,
  });

  final int length;
  final int? separatorEvery;
  final bool obscureText;

  @override
  State<_InputOtpOtp> createState() => _InputOtpOtpState();
}

class _InputOtpOtpState extends State<_InputOtpOtp> {
  String _code = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        InputOtp(
          length: widget.length,
          separatorEvery: widget.separatorEvery,
          obscureText: widget.obscureText,
          onChanged: (String code) => setState(() => _code = code),
        ),
        Gap(theme.spacing.md),
        Text(
          'code: "$_code"',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

/// The shorter four-slot field.
Widget _inputOtpFourSlots(BuildContext context) =>
    const _InputOtpOtp(length: 4);
''',
    ),
  ],
  'item_picker': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Grid',
      builder: '_grid',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/item_picker/item_picker.dart';

/// Grid body with a live selection.
class _GridExample extends StatefulWidget {
  const _GridExample();

  @override
  State<_GridExample> createState() => _GridExampleState();
}

class _GridExampleState extends State<_GridExample> {
  String? _value = 'B';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: ItemPickerDialog<String>(
        items: ItemList<String>(<String>['A', 'B', 'C', 'D']),
        builder: (BuildContext context, String value) =>
            ItemPickerOption<String>(
              value: value,
              child: Center(child: Text(value)),
            ),
        value: _value,
        onChanged: (String? next) => setState(() => _value = next),
      ),
    );
  }
}

Widget _grid(BuildContext context) => _GridExample();
''',
    ),
    DocsExampleSource(
      name: 'List',
      builder: '_list',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/item_picker/item_picker.dart';

/// List body with a swatch per row and a live selection.
class _ListExample extends StatefulWidget {
  const _ListExample();

  @override
  State<_ListExample> createState() => _ListExampleState();
}

class _ListExampleState extends State<_ListExample> {
  String? _value = 'Coral';

  static final List<String> _items = <String>[
    'Coral',
    'Mint',
    'Sky',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: ItemPickerDialog<String>(
        items: ItemList<String>(_items),
        layout: ItemPickerLayout.list,
        builder: (BuildContext context, String value) =>
            ItemPickerOption<String>(
              value: value,
              label: Text(value),
              child: _Swatch(value),
            ),
        value: _value,
        onChanged: (String? next) => setState(() => _value = next),
      ),
    );
  }
}

/// Theme-token swatch for the list example.
class _Swatch extends StatelessWidget {
  const _Swatch(this.name);

  final String name;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colors;
    final Color color = switch (name) {
      'Coral' => colors.chart1,
      'Mint' => colors.chart2,
      _ => colors.chart3,
    };
    return SizedBox(
      width: Theme.of(context).spacing.xl,
      height: Theme.of(context).spacing.xl,
      child: ColoredBox(color: color, child: const SizedBox()),
    );
  }
}

Widget _list(BuildContext context) => _ListExample();
''',
    ),
  ],
  'multi_select': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/multi_select/multi_select.dart';

List<String> _options = <String>[
  'Apple',
  'Banana',
  'Cherry',
  'Date',
  'Grape',
];

/// A controlled picker with one fruit selected.
class _DefaultExample extends StatefulWidget {
  const _DefaultExample();

  @override
  State<_DefaultExample> createState() => _DefaultExampleState();
}

class _DefaultExampleState extends State<_DefaultExample> {
  Iterable<String>? _fruits = <String>['Apple'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: MultiSelect<String>(
        value: _fruits,
        onChanged: (Iterable<String>? value) => setState(() => _fruits = value),
        placeholder: Text('Select fruits'),
        itemBuilder: (BuildContext context, String value) =>
            MultiSelectChip<String>(
              value: value,
              child: Text(value),
            ),
        items: <Widget>[
          for (final String fruit in _options)
            MultiSelectItem<String>(
              value: fruit,
              child: Text(fruit),
            ),
        ],
      ),
    );
  }
}

Widget _default(BuildContext context) => const _DefaultExample();
''',
    ),
    DocsExampleSource(
      name: 'With badges',
      builder: '_withBadges',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/multi_select/multi_select.dart';

List<String> _options = <String>[
  'Apple',
  'Banana',
  'Cherry',
  'Date',
  'Grape',
];

/// A controlled picker whose trigger wraps three removable chips.
class _BadgesExample extends StatefulWidget {
  const _BadgesExample();

  @override
  State<_BadgesExample> createState() => _BadgesExampleState();
}

class _BadgesExampleState extends State<_BadgesExample> {
  Iterable<String>? _fruits = <String>[
    'Apple',
    'Cherry',
    'Grape',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: MultiSelect<String>(
        value: _fruits,
        onChanged: (Iterable<String>? value) => setState(() => _fruits = value),
        placeholder: Text('Select fruits'),
        itemBuilder: (BuildContext context, String value) =>
            MultiSelectChip<String>(
              value: value,
              child: Text(value),
            ),
        items: <Widget>[
          for (final String fruit in _options)
            MultiSelectItem<String>(
              value: fruit,
              child: Text(fruit),
            ),
        ],
      ),
    );
  }
}

Widget _withBadges(BuildContext context) => const _BadgesExample();
''',
    ),
    DocsExampleSource(
      name: 'Disabled',
      builder: '_disabled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/multi_select/multi_select.dart';

List<String> _options = <String>[
  'Apple',
  'Banana',
  'Cherry',
  'Date',
  'Grape',
];

/// A disabled picker.
class _DisabledExample extends StatefulWidget {
  const _DisabledExample();

  @override
  State<_DisabledExample> createState() => _DisabledExampleState();
}

class _DisabledExampleState extends State<_DisabledExample> {
  Iterable<String>? _fruits = <String>['Apple'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: MultiSelect<String>(
        value: _fruits,
        onChanged: (Iterable<String>? value) => setState(() => _fruits = value),
        enabled: false,
        placeholder: Text('Select fruits'),
        itemBuilder: (BuildContext context, String value) =>
            MultiSelectChip<String>(
              value: value,
              child: Text(value),
            ),
        items: <Widget>[
          for (final String fruit in _options)
            MultiSelectItem<String>(
              value: fruit,
              child: Text(fruit),
            ),
        ],
      ),
    );
  }
}

Widget _disabled(BuildContext context) => const _DisabledExample();
''',
    ),
  ],
  'object_input': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Date',
      builder: '_date',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/time_of_day.dart';
import 'package:<your_app>/ui/dashcn/primitives/form_core/object_form_field.dart';
import 'package:<your_app>/ui/dashcn/components/object_input/object_input.dart';

/// A date field; the value lives in this example's state.
class _DateDemo extends StatefulWidget {
  const _DateDemo();

  @override
  State<_DateDemo> createState() => _DateDemoState();
}

class _DateDemoState extends State<_DateDemo> {
  DateTime? _date;

  @override
  Widget build(BuildContext context) {
    return DateInput(
      value: _date,
      // Dialog: the example may not provide an OverlayManager.
      mode: PromptMode.dialog,
      onChanged: (DateTime? next) => setState(() => _date = next),
    );
  }
}

Widget _date(BuildContext context) => const _DateDemo();
''',
    ),
    DocsExampleSource(
      name: 'Time',
      builder: '_time',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/time_of_day.dart';
import 'package:<your_app>/ui/dashcn/primitives/form_core/object_form_field.dart';
import 'package:<your_app>/ui/dashcn/components/object_input/object_input.dart';

/// A time field; the value lives in this example's state.
class _TimeDemo extends StatefulWidget {
  const _TimeDemo();

  @override
  State<_TimeDemo> createState() => _TimeDemoState();
}

class _TimeDemoState extends State<_TimeDemo> {
  TimeOfDay? _time;

  @override
  Widget build(BuildContext context) {
    return TimeInput(
      value: _time,
      onChanged: (TimeOfDay? next) => setState(() => _time = next),
    );
  }
}

Widget _time(BuildContext context) => const _TimeDemo();
''',
    ),
    DocsExampleSource(
      name: 'Duration',
      builder: '_duration',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/time_of_day.dart';
import 'package:<your_app>/ui/dashcn/primitives/form_core/object_form_field.dart';
import 'package:<your_app>/ui/dashcn/components/object_input/object_input.dart';

/// A duration field; the value lives in this example's state.
class _DurationDemo extends StatefulWidget {
  const _DurationDemo();

  @override
  State<_DurationDemo> createState() => _DurationDemoState();
}

class _DurationDemoState extends State<_DurationDemo> {
  Duration? _duration;

  @override
  Widget build(BuildContext context) {
    return DurationInput(
      value: _duration,
      onChanged: (Duration? next) => setState(() => _duration = next),
    );
  }
}

Widget _duration(BuildContext context) => const _DurationDemo();
''',
    ),
  ],
  'phone_input': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/primitives/countries.dart';
import 'package:<your_app>/ui/dashcn/components/form/form.dart';
import 'package:<your_app>/ui/dashcn/components/phone_input/phone_input.dart';

/// Widths that fit both the 720-wide stage and a 375-wide phone. The country
/// selector needs 136 logical pixels for its flag, dial code and chevron.
const PhoneInputTheme _compact = PhoneInputTheme(
  selectWidth: 136,
  maxWidth: 160,
);

/// A phone field with a default country and value.
class _DefaultPhone extends StatefulWidget {
  const _DefaultPhone();

  @override
  State<_DefaultPhone> createState() => _DefaultPhoneState();
}

class _DefaultPhoneState extends State<_DefaultPhone> {
  PhoneNumber? _value = const PhoneNumber(
    Country(dialCode: '+62', code: 'ID'),
    '812345678',
  );

  @override
  Widget build(BuildContext context) {
    return PhoneInput(
      initialValue: _value,
      onChanged: (PhoneNumber? value) => setState(() => _value = value),
      theme: _compact,
    );
  }
}

Widget _default(BuildContext context) => const _DefaultPhone();
''',
    ),
    DocsExampleSource(
      name: 'Custom countries',
      builder: '_customCountries',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/primitives/countries.dart';
import 'package:<your_app>/ui/dashcn/components/form/form.dart';
import 'package:<your_app>/ui/dashcn/components/phone_input/phone_input.dart';

/// Widths that fit both the 720-wide stage and a 375-wide phone. The country
/// selector needs 136 logical pixels for its flag, dial code and chevron.
const PhoneInputTheme _compact = PhoneInputTheme(
  selectWidth: 136,
  maxWidth: 160,
);

/// A phone field offering a custom country list.
class _CustomCountriesPhone extends StatefulWidget {
  const _CustomCountriesPhone();

  @override
  State<_CustomCountriesPhone> createState() => _CustomCountriesPhoneState();
}

class _CustomCountriesPhoneState extends State<_CustomCountriesPhone> {
  PhoneNumber? _value;

  @override
  Widget build(BuildContext context) {
    return PhoneInput(
      initialCountry: const Country(dialCode: '+44', code: 'GB'),
      initialValue: _value,
      countries: <CountryInfo>[
        CountryInfo('GB', '+44', 'GBP', 'United Kingdom'),
        CountryInfo('IE', '+353', 'EUR', 'Ireland'),
        CountryInfo('FR', '+33', 'EUR', 'France'),
      ],
      onChanged: (PhoneNumber? value) => setState(() => _value = value),
      theme: _compact,
    );
  }
}

Widget _customCountries(BuildContext context) => const _CustomCountriesPhone();
''',
    ),
    DocsExampleSource(
      name: 'Invalid',
      builder: '_invalid',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/primitives/countries.dart';
import 'package:<your_app>/ui/dashcn/components/form/form.dart';
import 'package:<your_app>/ui/dashcn/components/phone_input/phone_input.dart';

/// Widths that fit both the 720-wide stage and a 375-wide phone. The country
/// selector needs 136 logical pixels for its flag, dial code and chevron.
const PhoneInputTheme _compact = PhoneInputTheme(
  selectWidth: 136,
  maxWidth: 160,
);

/// A phone field showing the validator error for a short number.
///
/// The example opts into showing an untouched field's error
/// ([showErrors] including `initial`): its purpose is to document what the
/// error state looks like. A real form uses the default modes, where the
/// message only appears after the user edits the field or submits.
class _InvalidPhone extends StatefulWidget {
  const _InvalidPhone();

  @override
  State<_InvalidPhone> createState() => _InvalidPhoneState();
}

class _InvalidPhoneState extends State<_InvalidPhone> {
  PhoneNumber? _value = const PhoneNumber(
    Country(dialCode: '+1', code: 'US'),
    '1',
  );

  @override
  Widget build(BuildContext context) {
    return FormScope(
      child: FormItem<PhoneNumber>(
        key: const FormKey<PhoneNumber>('preview-phone-invalid'),
        label: Text('Phone'),
        validator: const PhoneNumberValidator(),
        showErrors: const <FormValidationMode>{
          FormValidationMode.initial,
          FormValidationMode.changed,
          FormValidationMode.submitted,
        },
        child: PhoneInput(
          initialValue: _value,
          onChanged: (PhoneNumber? value) => setState(() => _value = value),
          theme: _compact,
        ),
      ),
    );
  }
}

Widget _invalid(BuildContext context) => const _InvalidPhone();
''',
    ),
  ],
  'radio_group': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/radio_group/radio_group.dart';

/// A vertical group of row items; the selection lives in this example.
class _RowsDemo extends StatefulWidget {
  const _RowsDemo();

  @override
  State<_RowsDemo> createState() => _RowsDemoState();
}

class _RowsDemoState extends State<_RowsDemo> {
  String _plan = 'free';

  @override
  Widget build(BuildContext context) {
    return RadioSet<String>(
      value: _plan,
      onChanged: (String value) => setState(() => _plan = value),
      items: <Widget>[
        RadioItem<String>(
          value: 'free',
          label: Text('Free'),
        ),
        RadioItem<String>(value: 'pro', label: Text('Pro')),
        RadioItem<String>(
          value: 'team',
          label: Text('Team'),
        ),
      ],
    );
  }
}

Widget _default(BuildContext context) => const _RowsDemo();
''',
    ),
    DocsExampleSource(
      name: 'Card items',
      builder: '_cardItems',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/radio_group/radio_group.dart';

/// A group of card items; the selection lives in this example.
class _CardsDemo extends StatefulWidget {
  const _CardsDemo();

  @override
  State<_CardsDemo> createState() => _CardsDemoState();
}

class _CardsDemoState extends State<_CardsDemo> {
  String _plan = 'pro';

  @override
  Widget build(BuildContext context) {
    return RadioSet<String>(
      value: _plan,
      onChanged: (String value) => setState(() => _plan = value),
      items: <Widget>[
        for (final String plan in <String>['free', 'pro'])
          RadioCard<String>(
            value: plan,
            child: Text(
              plan == 'free' ? 'Free' : 'Pro',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
      ],
    );
  }
}

Widget _cardItems(BuildContext context) => const _CardsDemo();
''',
    ),
  ],
  'search_bar': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_searchBarDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/search_bar/search_bar.dart';

List<String> _searchFruits = <String>[
  'Apple',
  'Apricot',
  'Avocado',
  'Banana',
  'Cherry',
  'Grape',
  'Kiwi',
  'Lemon',
  'Mango',
  'Orange',
  'Peach',
  'Pear',
  'Pineapple',
  'Strawberry',
  'Watermelon',
];

/// The status line every interactive example writes to.
class _StatusLine extends StatelessWidget {
  const _StatusLine(this.status);

  final String status;

  @override
  Widget build(BuildContext context) {
    return Text(
      status,
      style: TextStyle(
        fontSize: 12,
        color: Theme.of(context).colors.mutedForeground,
      ),
    );
  }
}

/// The default ranked field with a debounced echo and a selection echo.
class _SearchBarDefault extends StatefulWidget {
  const _SearchBarDefault();

  @override
  State<_SearchBarDefault> createState() => _SearchBarDefaultState();
}

class _SearchBarDefaultState extends State<_SearchBarDefault> {
  String _query = '';
  String _selected = '';

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SearchBar<String>(
            items: _searchFruits,
            hintText: 'Search fruit',
            onChanged: (String query) => setState(() => _query = query),
            onSelected: (String item) => setState(() => _selected = item),
          ),
          Gap(spacing.sm),
          _StatusLine(
            _selected.isEmpty
                ? (_query.isEmpty
                      ? 'Type to filter'
                      : 'query: $_query')
                : 'Selected $_selected for "$_query"',
          ),
        ],
      ),
    );
  }
}

Widget _searchBarDefault(BuildContext context) => const _SearchBarDefault();
''',
    ),
    DocsExampleSource(
      name: 'With groups',
      builder: '_searchBarGroups',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/search_bar/search_bar.dart';

/// The status line every interactive example writes to.
class _StatusLine extends StatelessWidget {
  const _StatusLine(this.status);

  final String status;

  @override
  Widget build(BuildContext context) {
    return Text(
      status,
      style: TextStyle(
        fontSize: 12,
        color: Theme.of(context).colors.mutedForeground,
      ),
    );
  }
}

/// Ranked groups with headings; empty groups never render.
class _SearchBarGroups extends StatefulWidget {
  const _SearchBarGroups();

  @override
  State<_SearchBarGroups> createState() => _SearchBarGroupsState();
}

class _SearchBarGroupsState extends State<_SearchBarGroups> {
  String _selected = '';

  static final List<SearchBarGroup<String>> _groups = <SearchBarGroup<String>>[
    SearchBarGroup<String>(
      label: 'Suggestions',
      items: <String>[
        'Calendar',
        'Search Emoji',
        'Launch',
      ],
    ),
    SearchBarGroup<String>(
      label: 'Settings',
      items: <String>[
        'Profile',
        'Mail',
        'Settings',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SearchBar<String>(
            groups: _groups,
            hintText: 'Search commands',
            onSelected: (String item) => setState(() => _selected = item),
          ),
          Gap(spacing.sm),
          _StatusLine(
            _selected.isEmpty
                ? 'Pick a command'
                : 'Ran $_selected',
          ),
        ],
      ),
    );
  }
}

Widget _searchBarGroups(BuildContext context) => const _SearchBarGroups();
''',
    ),
    DocsExampleSource(
      name: 'With cancel',
      builder: '_searchBarCancel',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/search_bar/search_bar.dart';

List<String> _searchFruits = <String>[
  'Apple',
  'Apricot',
  'Avocado',
  'Banana',
  'Cherry',
  'Grape',
  'Kiwi',
  'Lemon',
  'Mango',
  'Orange',
  'Peach',
  'Pear',
  'Pineapple',
  'Strawberry',
  'Watermelon',
];

/// The status line every interactive example writes to.
class _StatusLine extends StatelessWidget {
  const _StatusLine(this.status);

  final String status;

  @override
  Widget build(BuildContext context) {
    return Text(
      status,
      style: TextStyle(
        fontSize: 12,
        color: Theme.of(context).colors.mutedForeground,
      ),
    );
  }
}

/// A field with a cancel button that clears and reports.
class _SearchBarCancel extends StatefulWidget {
  const _SearchBarCancel();

  @override
  State<_SearchBarCancel> createState() => _SearchBarCancelState();
}

class _SearchBarCancelState extends State<_SearchBarCancel> {
  String _status = 'Type, then cancel';

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SearchBar<String>(
            items: _searchFruits,
            hintText: 'Search fruit',
            showCancelButton: true,
            onCancelled: () =>
                setState(() => _status = 'Cancelled'),
            onSelected: (String item) =>
                setState(() => _status = 'Selected $item'),
          ),
          Gap(spacing.sm),
          _StatusLine(_status),
        ],
      ),
    );
  }
}

Widget _searchBarCancel(BuildContext context) => const _SearchBarCancel();
''',
    ),
    DocsExampleSource(
      name: 'Custom row',
      builder: '_searchBarCustomRow',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/search_bar/search_bar.dart';

List<String> _searchFruits = <String>[
  'Apple',
  'Apricot',
  'Avocado',
  'Banana',
  'Cherry',
  'Grape',
  'Kiwi',
  'Lemon',
  'Mango',
  'Orange',
  'Peach',
  'Pear',
  'Pineapple',
  'Strawberry',
  'Watermelon',
];

/// The status line every interactive example writes to.
class _StatusLine extends StatelessWidget {
  const _StatusLine(this.status);

  final String status;

  @override
  Widget build(BuildContext context) {
    return Text(
      status,
      style: TextStyle(
        fontSize: 12,
        color: Theme.of(context).colors.mutedForeground,
      ),
    );
  }
}

/// A custom row builder with a leading count.
class _SearchBarCustomRow extends StatefulWidget {
  const _SearchBarCustomRow();

  @override
  State<_SearchBarCustomRow> createState() => _SearchBarCustomRowState();
}

class _SearchBarCustomRowState extends State<_SearchBarCustomRow> {
  String _selected = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SearchBar<String>(
            items: _searchFruits,
            hintText: 'Search fruit',
            itemBuilder: (context, item, highlight, highlighted) =>
                Text('$item (${highlight.length} hits)'),
            onSelected: (String item) => setState(() => _selected = item),
          ),
          Gap(Theme.of(context).spacing.sm),
          _StatusLine(
            _selected.isEmpty
                ? 'Custom rows'
                : 'Selected $_selected',
          ),
        ],
      ),
    );
  }
}

Widget _searchBarCustomRow(BuildContext context) => const _SearchBarCustomRow();
''',
    ),
  ],
  'segmented_control': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_segmentedDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/segmented_control/segmented_control.dart';

/// The default example: one selected segment out of three.
class _SegmentedDefault extends StatefulWidget {
  const _SegmentedDefault();

  @override
  State<_SegmentedDefault> createState() => _SegmentedDefaultState();
}

class _SegmentedDefaultState extends State<_SegmentedDefault> {
  String _value = 'day';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedControl<String>(
        value: _value,
        onChanged: (String value) => setState(() => _value = value),
        segments: <SegmentedControlSegment<String>>[
          SegmentedControlSegment<String>(value: 'day', label: Text('Day')),
          SegmentedControlSegment<String>(
            value: 'week',
            label: Text('Week'),
          ),
          SegmentedControlSegment<String>(
            value: 'month',
            label: Text('Month'),
          ),
        ],
      ),
    );
  }
}

Widget _segmentedDefault(BuildContext context) => const _SegmentedDefault();
''',
    ),
    DocsExampleSource(
      name: 'Icons',
      builder: '_segmentedIcons',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/segmented_control/segmented_control.dart';

/// Icons only.
class _SegmentedIcons extends StatefulWidget {
  const _SegmentedIcons();

  @override
  State<_SegmentedIcons> createState() => _SegmentedIconsState();
}

class _SegmentedIconsState extends State<_SegmentedIcons> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedControl<int>(
        value: _value,
        onChanged: (int value) => setState(() => _value = value),
        segments: <SegmentedControlSegment<int>>[
          SegmentedControlSegment<int>(
            value: 0,
            icon: Icon(LucideIcons.list),
            semanticLabel: 'List',
          ),
          SegmentedControlSegment<int>(
            value: 1,
            icon: Icon(LucideIcons.layoutGrid),
            semanticLabel: 'Grid',
          ),
          SegmentedControlSegment<int>(
            value: 2,
            icon: Icon(LucideIcons.layers),
            semanticLabel: 'Layers',
          ),
        ],
      ),
    );
  }
}

Widget _segmentedIcons(BuildContext context) => const _SegmentedIcons();
''',
    ),
    DocsExampleSource(
      name: 'Multiple',
      builder: '_segmentedMultiple',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/segmented_control/segmented_control.dart';

/// Multiple selection: any number of segments can be picked.
class _SegmentedMultiple extends StatefulWidget {
  const _SegmentedMultiple();

  @override
  State<_SegmentedMultiple> createState() => _SegmentedMultipleState();
}

class _SegmentedMultipleState extends State<_SegmentedMultiple> {
  Set<String> _values = <String>{'bold'};

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedControl<String>(
        selection: SegmentedControlSelection.multiple,
        values: _values,
        onValuesChanged: (Set<String> values) =>
            setState(() => _values = values),
        segments: <SegmentedControlSegment<String>>[
          SegmentedControlSegment<String>(
            value: 'bold',
            icon: Icon(LucideIcons.bold),
            semanticLabel: 'Bold',
          ),
          SegmentedControlSegment<String>(
            value: 'italic',
            icon: Icon(LucideIcons.italic),
            semanticLabel: 'Italic',
          ),
          SegmentedControlSegment<String>(
            value: 'underline',
            icon: Icon(LucideIcons.underline),
            semanticLabel: 'Underline',
          ),
        ],
      ),
    );
  }
}

Widget _segmentedMultiple(BuildContext context) => const _SegmentedMultiple();
''',
    ),
    DocsExampleSource(
      name: 'Disabled',
      builder: '_segmentedDisabled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/segmented_control/segmented_control.dart';

/// A disabled segment.
class _SegmentedDisabled extends StatefulWidget {
  const _SegmentedDisabled();

  @override
  State<_SegmentedDisabled> createState() => _SegmentedDisabledState();
}

class _SegmentedDisabledState extends State<_SegmentedDisabled> {
  String _value = 'a';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedControl<String>(
        value: _value,
        onChanged: (String value) => setState(() => _value = value),
        segments: const <SegmentedControlSegment<String>>[
          SegmentedControlSegment<String>(value: 'a', label: Text('A')),
          SegmentedControlSegment<String>(
            value: 'b',
            label: Text('B'),
            enabled: false,
          ),
          SegmentedControlSegment<String>(value: 'c', label: Text('C')),
        ],
      ),
    );
  }
}

Widget _segmentedDisabled(BuildContext context) => const _SegmentedDisabled();
''',
    ),
    DocsExampleSource(
      name: 'Full width',
      builder: '_segmentedFullWidth',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/segmented_control/segmented_control.dart';

/// The control filling the width it is given.
class _SegmentedFullWidth extends StatefulWidget {
  const _SegmentedFullWidth();

  @override
  State<_SegmentedFullWidth> createState() => _SegmentedFullWidthState();
}

class _SegmentedFullWidthState extends State<_SegmentedFullWidth> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 320,
        child: SegmentedControl<int>(
          expand: true,
          value: _value,
          onChanged: (int value) => setState(() => _value = value),
          segments: <SegmentedControlSegment<int>>[
            SegmentedControlSegment<int>(value: 0, label: Text('One')),
            SegmentedControlSegment<int>(value: 1, label: Text('Two')),
            SegmentedControlSegment<int>(
              value: 2,
              label: Text('Three'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _segmentedFullWidth(BuildContext context) => const _SegmentedFullWidth();
''',
    ),
    DocsExampleSource(
      name: 'Customized',
      builder: '_segmentedCustomized',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/segmented_control/segmented_control.dart';

/// A customised control: a rounded track and a filled thumb.
Widget _segmentedCustomized(BuildContext context) {
  return Center(
    child: SegmentedControl<String>(
      value: 'left',
      onChanged: _noop,
      style: const SegmentedControlStyle(
        background: ThemedColor.ref(ColorRef.accent, alpha: 0.25),
        thumbBackground: ThemedColor.ref(ColorRef.accent),
        thumbBorderColor: ThemedColor.ref(ColorRef.accent),
        thumbBorderWidth: 1,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        padding: EdgeInsets.all(4),
      ),
      segments: <SegmentedControlSegment<String>>[
        SegmentedControlSegment<String>(
          value: 'left',
          label: Text('Left'),
        ),
        SegmentedControlSegment<String>(
          value: 'right',
          label: Text('Right'),
        ),
      ],
    ),
  );
}

void _noop(String value) {}
''',
    ),
  ],
  'select': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/select/select.dart';

/// A controlled fruit picker; the selection lives in this example's state.
class _FruitSelect extends StatefulWidget {
  const _FruitSelect();

  @override
  State<_FruitSelect> createState() => _FruitSelectState();
}

class _FruitSelectState extends State<_FruitSelect> {
  String? _fruit;

  static final List<String> _fruits = <String>[
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Grape',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Select<String>(
        value: _fruit,
        onChanged: (String? value) => setState(() => _fruit = value),
        placeholder: Text('Select a fruit'),
        itemBuilder: (BuildContext context, String value) =>
            Text(value),
        items: <Widget>[
          for (final String fruit in _fruits)
            SelectItem<String>(
              value: fruit,
              child: Text(fruit),
            ),
        ],
      ),
    );
  }
}

Widget _default(BuildContext context) => const _FruitSelect();
''',
    ),
    DocsExampleSource(
      name: 'With groups',
      builder: '_withGroups',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/select/select.dart';

/// A picker grouping its rows under disabled header rows.
class _GroupedSelect extends StatefulWidget {
  const _GroupedSelect();

  @override
  State<_GroupedSelect> createState() => _GroupedSelectState();
}

class _GroupedSelectState extends State<_GroupedSelect> {
  String? _produce;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Select<String>(
        value: _produce,
        onChanged: (String? value) => setState(() => _produce = value),
        placeholder: Text('Select produce'),
        itemBuilder: (BuildContext context, String value) =>
            Text(value),
        items: <Widget>[
          SelectItem<String>(
            value: '__fruits',
            enabled: false,
            child: Text('Fruits'),
          ),
          SelectItem<String>(
            value: 'Apple',
            child: Text('Apple'),
          ),
          SelectItem<String>(
            value: 'Banana',
            child: Text('Banana'),
          ),
          SelectItem<String>(
            value: '__vegetables',
            enabled: false,
            child: Text('Vegetables'),
          ),
          SelectItem<String>(
            value: 'Carrot',
            child: Text('Carrot'),
          ),
          SelectItem<String>(
            value: 'Lettuce',
            child: Text('Lettuce'),
          ),
        ],
      ),
    );
  }
}

Widget _withGroups(BuildContext context) => const _GroupedSelect();
''',
    ),
    DocsExampleSource(
      name: 'Disabled',
      builder: '_disabled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/select/select.dart';

/// A disabled picker showing its selected value.
Widget _disabled(BuildContext context) {
  return SizedBox(
    width: 220,
    child: Select<String>(
      value: 'Apple',
      onChanged: (String? value) {},
      enabled: false,
      placeholder: Text('Select a fruit'),
      itemBuilder: (BuildContext context, String value) =>
          Text(value),
      items: <Widget>[
        SelectItem<String>(
          value: 'Apple',
          child: Text('Apple'),
        ),
        SelectItem<String>(
          value: 'Banana',
          child: Text('Banana'),
        ),
      ],
    ),
  );
}
''',
    ),
  ],
  'signature_pad': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/signature_pad/signature_pad.dart';

/// A pad with undo/redo/clear controls and a live stroke count.
class _InteractivePad extends StatefulWidget {
  const _InteractivePad();

  @override
  State<_InteractivePad> createState() => _InteractivePadState();
}

class _InteractivePadState extends State<_InteractivePad> {
  late final SignaturePadController _controller = SignaturePadController();
  int _count = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle label = theme.typography.small.copyWith(
      color: theme.colors.mutedForeground,
    );
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 360),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SignaturePad(
            controller: _controller,
            onChanged: (int count) => setState(() => _count = count),
            semanticsLabel: 'Signature pad demo',
          ),
          Gap(theme.spacing.sm),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _PadButton(
                label: 'Undo',
                onTap: _controller.canUndo
                    ? () => setState(_controller.undo)
                    : null,
              ),
              Gap(theme.spacing.sm),
              _PadButton(
                label: 'Redo',
                onTap: _controller.canRedo
                    ? () => setState(_controller.redo)
                    : null,
              ),
              Gap(theme.spacing.sm),
              _PadButton(
                label: 'Clear',
                onTap: _controller.isEmpty
                    ? null
                    : () => setState(_controller.clear),
              ),
              const Spacer(),
              Text(
                _count == 1
                    ? '1 stroke'
                    : '$_count strokes',
                style: label,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A small widgets-only text button (keeps the preview free of other
/// components so the scorecard harness renders it standalone).
class _PadButton extends StatelessWidget {
  const _PadButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Disabled uses the muted token rather than Opacity: dimming the text
    // would drop its contrast below the 4.5 minimum.
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: theme.typography.small.copyWith(
          color: onTap == null
              ? theme.colors.mutedForeground
              : theme.colors.primary,
        ),
      ),
    );
  }
}

Widget _default(BuildContext context) => const _InteractivePad();
''',
    ),
    DocsExampleSource(
      name: 'Read-only',
      builder: '_readOnly',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/signature_pad/signature_pad.dart';

/// A read-only pad preloaded with a saved stroke, as a restore would show.
class _ReadOnlyPad extends StatefulWidget {
  const _ReadOnlyPad();

  @override
  State<_ReadOnlyPad> createState() => _ReadOnlyPadState();
}

class _ReadOnlyPadState extends State<_ReadOnlyPad> {
  late final SignaturePadController _controller = SignaturePadController()
    ..addStroke(_demoStroke(const Color(0xFF000000)));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 360),
      child: SignaturePad(
        controller: _controller,
        readOnly: true,
        semanticsLabel: 'Saved signature',
      ),
    );
  }
}

Widget _readOnly(BuildContext context) => const _ReadOnlyPad();

/// A fixed demo stroke shared by the read-only example and the tests.
SignatureStroke _demoStroke(Color color) {
  final DateTime base = DateTime(2026, 1, 1);
  return SignatureStroke(
    points: <SignaturePoint>[
      for (var i = 0; i < 12; i++)
        SignaturePoint(
          Offset(24 + i * 24, 100 + (i.isEven ? -24 : 24)),
          base.add(Duration(milliseconds: i * 16)),
        ),
    ],
    color: color,
    width: 3,
    minWidth: 1,
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Disabled',
      builder: '_disabled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/signature_pad/signature_pad.dart';

/// A disabled pad; input is ignored and the surface dims.
Widget _disabled(BuildContext context) {
  return ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 360),
    child: SignaturePad(
      enabled: false,
      semanticsLabel: 'Signature pad unavailable',
    ),
  );
}
''',
    ),
  ],
  'slider': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/primitives/slider_value.dart';
import 'package:<your_app>/ui/dashcn/components/slider/slider.dart';

/// A single-value slider; the value lives in this example's state.
class _SingleSlider extends StatefulWidget {
  const _SingleSlider();

  @override
  State<_SingleSlider> createState() => _SingleSliderState();
}

class _SingleSliderState extends State<_SingleSlider> {
  double _value = 0.4;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Slider(
        value: _value,
        onChanged: (double value) => setState(() => _value = value),
        semanticLabel: 'Single',
      ),
    );
  }
}

Widget _default(BuildContext context) => const _SingleSlider();
''',
    ),
    DocsExampleSource(
      name: 'Range',
      builder: '_range',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/primitives/slider_value.dart';
import 'package:<your_app>/ui/dashcn/components/slider/slider.dart';

/// A ranged slider; the range lives in this example's state.
class _RangeSlider extends StatefulWidget {
  const _RangeSlider();

  @override
  State<_RangeSlider> createState() => _RangeSliderState();
}

class _RangeSliderState extends State<_RangeSlider> {
  SliderValue _range = const SliderValue.ranged(0.2, 0.7);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Slider.range(
        value: _range,
        onRangeChanged: (SliderValue value) => setState(() => _range = value),
        semanticLabel: 'Range',
      ),
    );
  }
}

Widget _range(BuildContext context) => const _RangeSlider();
''',
    ),
    DocsExampleSource(
      name: 'Steps',
      builder: '_steps',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/primitives/slider_value.dart';
import 'package:<your_app>/ui/dashcn/components/slider/slider.dart';

/// A stepped slider with dot marks; the value lives in this example's state.
class _StepsSlider extends StatefulWidget {
  const _StepsSlider();

  @override
  State<_StepsSlider> createState() => _StepsSliderState();
}

class _StepsSliderState extends State<_StepsSlider> {
  double _value = 2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Slider(
        value: _value,
        min: 0,
        max: 4,
        snap: const SliderSnap.steps(4),
        variant: SliderVariant.dots,
        onChanged: (double value) => setState(() => _value = value),
        semanticLabel: 'Steps',
      ),
    );
  }
}

Widget _steps(BuildContext context) => const _StepsSlider();
''',
    ),
  ],
  'star_rating': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/star_rating/star_rating.dart';

/// Interactive rating with half-star steps; owns its value.
class _InteractiveRating extends StatefulWidget {
  const _InteractiveRating();

  @override
  State<_InteractiveRating> createState() => _InteractiveRatingState();
}

class _InteractiveRatingState extends State<_InteractiveRating> {
  double _value = 3.5;

  @override
  Widget build(BuildContext context) {
    return StarRating(
      value: _value,
      onChanged: (double value) => setState(() => _value = value),
      semanticLabel: 'Rating',
    );
  }
}

Widget _default(BuildContext context) => const _InteractiveRating();
''',
    ),
    DocsExampleSource(
      name: 'Read-only',
      builder: '_readOnly',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/star_rating/star_rating.dart';

/// A non-interactive rating.
Widget _readOnly(BuildContext context) {
  return const StarRating(value: 4);
}
''',
    ),
    DocsExampleSource(
      name: 'Vertical',
      builder: '_vertical',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/star_rating/star_rating.dart';

/// A vertical rating that reports the value it settles on.
class _VerticalRating extends StatefulWidget {
  const _VerticalRating();

  @override
  State<_VerticalRating> createState() => _VerticalRatingState();
}

class _VerticalRatingState extends State<_VerticalRating> {
  double _value = 3;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        StarRating(
          value: _value,
          direction: Axis.vertical,
          onChanged: (double value) => setState(() => _value = value),
        ),
        Gap(theme.spacing.lg),
        Text(
          'rated ${_value.toStringAsFixed(1)}',
          style: TextStyle(color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _vertical(BuildContext context) => const _VerticalRating();
''',
    ),
    DocsExampleSource(
      name: 'Disabled',
      builder: '_disabled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/star_rating/star_rating.dart';

/// A disabled rating.
Widget _disabled(BuildContext context) {
  return const StarRating(value: 3, enabled: false);
}
''',
    ),
  ],
  'switch': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/switch/switch.dart';

/// Controlled switch; owns its value.
class _ControlledSwitch extends StatefulWidget {
  const _ControlledSwitch();

  @override
  State<_ControlledSwitch> createState() => _ControlledSwitchState();
}

class _ControlledSwitchState extends State<_ControlledSwitch> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _value,
      onChanged: (bool value) => setState(() => _value = value),
      label: Text('Airplane mode'),
    );
  }
}

Widget _default(BuildContext context) => const _ControlledSwitch();
''',
    ),
    DocsExampleSource(
      name: 'Rows',
      builder: '_switchRows',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/switch/switch.dart';

Widget _switchRows(BuildContext context) => const _SwitchRows();

/// A stack of switch rows: the group gap (upstream `gap-3`) between them, the
/// same one the radio group and a checkbox list use.
class _SwitchRows extends StatefulWidget {
  const _SwitchRows();

  @override
  State<_SwitchRows> createState() => _SwitchRowsState();
}

class _SwitchRowsState extends State<_SwitchRows> {
  bool _notifications = true;
  bool _sounds = false;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spacing.md,
      children: <Widget>[
        Switch(
          value: _notifications,
          onChanged: (bool value) => setState(() => _notifications = value),
          label: Text('Notifications'),
        ),
        Switch(
          value: _sounds,
          onChanged: (bool value) => setState(() => _sounds = value),
          label: Text('Sounds'),
        ),
      ],
    );
  }
}
''',
    ),
    DocsExampleSource(
      name: 'Controller',
      builder: '_controller',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/switch/switch.dart';

/// Controller-driven switch; the controller owns the value.
class _ControllerSwitch extends StatefulWidget {
  const _ControllerSwitch();

  @override
  State<_ControllerSwitch> createState() => _ControllerSwitchState();
}

class _ControllerSwitchState extends State<_ControllerSwitch> {
  final SwitchController _controller = SwitchController(true);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_refresh);
  }

  void _refresh() => setState(() {});

  @override
  void dispose() {
    _controller.removeListener(_refresh);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Wrap(
      spacing: spacing.lg,
      runSpacing: spacing.sm,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Switch(
          controller: _controller,
          label: Text('Driven by a controller'),
        ),
        Text('value: ${_controller.value}'),
      ],
    );
  }
}

Widget _controller(BuildContext context) => const _ControllerSwitch();
''',
    ),
    DocsExampleSource(
      name: 'Disabled',
      builder: '_disabled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/switch/switch.dart';

/// On and off switches with no callback, so both are disabled.
Widget _disabled(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Wrap(
    spacing: spacing.xl,
    runSpacing: spacing.md,
    children: <Widget>[
      Switch(
        value: true,
        label: Text('Notifications (on)'),
      ),
      Switch(value: false, label: Text('Sounds (off)')),
    ],
  );
}
''',
    ),
  ],
  'text_area': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/text_area/text_area.dart';

/// The default three-line field.
Widget _default(BuildContext context) {
  return SizedBox(
    width: 320,
    child: TextArea(initialValue: 'Hello, World!'),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Placeholder',
      builder: '_placeholder',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/text_area/text_area.dart';

/// A taller field with placeholder text.
Widget _placeholder(BuildContext context) {
  return SizedBox(
    width: 320,
    child: TextArea(
      placeholder: Text('Type your message here...'),
      minLines: 4,
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Resizable',
      builder: '_resizable',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/text_area/text_area.dart';

/// A field that grows with its content.
Widget _resizable(BuildContext context) {
  return SizedBox(
    width: 320,
    child: TextArea(
      hintText: 'No cap: paste a long paragraph',
      minLines: 2,
      maxLines: 8,
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Invalid',
      builder: '_invalid',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/text_area/text_area.dart';

/// A validating field; owns the typed value it echoes.
class _InvalidArea extends StatefulWidget {
  const _InvalidArea();

  @override
  State<_InvalidArea> createState() => _InvalidAreaState();
}

class _InvalidAreaState extends State<_InvalidArea> {
  String _code = 'abc';

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return SizedBox(
      width: 320,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextArea(
            initialValue: 'abc',
            minLines: 2,
            validator: (String? value) => (value ?? '').length < 8
                ? 'At least 8 characters'
                : null,
            onChanged: (String value) => setState(() => _code = value),
          ),
          SizedBox(height: spacing.sm),
          Text(
            'typed: ${_code.isEmpty ? '(empty)' : _code}',
            style: TextStyle(color: Theme.of(context).colors.mutedForeground),
          ),
        ],
      ),
    );
  }
}

Widget _invalid(BuildContext context) => const _InvalidArea();
''',
    ),
    DocsExampleSource(
      name: 'Disabled',
      builder: '_disabled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/text_area/text_area.dart';

/// A disabled field.
Widget _disabled(BuildContext context) {
  return SizedBox(
    width: 320,
    child: TextArea(
      initialValue: 'Disabled',
      enabled: false,
    ),
  );
}
''',
    ),
  ],
  'wheel_picker': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/wheel_picker/wheel_picker.dart';

/// One wheel column of numbers, 01-12.
const List<String> _hours = <String>[
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12',
];

/// A single-column hour wheel; owns its selection.
class _DefaultWheel extends StatefulWidget {
  const _DefaultWheel();

  @override
  State<_DefaultWheel> createState() => _DefaultWheelState();
}

class _DefaultWheelState extends State<_DefaultWheel> {
  List<int> _value = <int>[3];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        WheelPicker(
          columns: <WheelColumn>[WheelColumn(items: _hours)],
          value: _value,
          onChanged: (List<int> value) => setState(() => _value = value),
        ),
        Gap(theme.spacing.lg),
        Text(
          _hours[_value[0]],
          style: TextStyle(color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _default(BuildContext context) => const _DefaultWheel();
''',
    ),
    DocsExampleSource(
      name: 'Time',
      builder: '_time',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/wheel_picker/wheel_picker.dart';

/// One wheel column of numbers, 01-12.
const List<String> _hours = <String>[
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12',
];

/// A three-column time picker (hours / minutes / meridiem).
class _TimeWheel extends StatefulWidget {
  const _TimeWheel();

  @override
  State<_TimeWheel> createState() => _TimeWheelState();
}

class _TimeWheelState extends State<_TimeWheel> {
  List<int> _value = <int>[3, 25, 1];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        WheelPicker(
          columns: <WheelColumn>[
            WheelColumn(items: _hours),
            WheelColumn(
              items: <String>[
                for (int m = 0; m < 60; m += 5) m.toString().padLeft(2, '0'),
              ],
            ),
            WheelColumn(items: <String>['AM', 'PM']),
          ],
          value: _value,
          onChanged: (List<int> value) => setState(() => _value = value),
        ),
        Gap(theme.spacing.lg),
        Text(
          '${_hours[_value[0]]}:${_value[1].toString().padLeft(2, '0')} '
          '${_value[2] == 0 ? 'AM' : 'PM'}',
          style: TextStyle(color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _time(BuildContext context) => const _TimeWheel();
''',
    ),
    DocsExampleSource(
      name: 'Looping',
      builder: '_looping',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/wheel_picker/wheel_picker.dart';

/// A looping wheel that never clamps at the ends.
class _LoopingWheel extends StatefulWidget {
  const _LoopingWheel();

  @override
  State<_LoopingWheel> createState() => _LoopingWheelState();
}

class _LoopingWheelState extends State<_LoopingWheel> {
  static final List<String> _colours = <String>[
    'Red',
    'Orange',
    'Yellow',
    'Green',
    'Blue',
    'Violet',
  ];
  List<int> _value = <int>[0];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        WheelPicker(
          columns: <WheelColumn>[WheelColumn(items: _colours)],
          value: _value,
          looping: true,
          onChanged: (List<int> value) => setState(() => _value = value),
        ),
        Gap(theme.spacing.lg),
        Text(
          _colours[_value[0]],
          style: TextStyle(color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _looping(BuildContext context) => const _LoopingWheel();
''',
    ),
    DocsExampleSource(
      name: '3D Perspective',
      builder: '_perspective',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/wheel_picker/wheel_picker.dart';

/// A 3D cylinder wheel with custom row content.
class _PerspectiveWheel extends StatefulWidget {
  const _PerspectiveWheel();

  @override
  State<_PerspectiveWheel> createState() => _PerspectiveWheelState();
}

class _PerspectiveWheelState extends State<_PerspectiveWheel> {
  List<int> _value = <int>[2];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        WheelPicker(
          columns: <WheelColumn>[
            WheelColumn(
              items: <String>['A', 'B', 'C', 'D', 'E', 'F', 'G'],
              builder: (BuildContext context, int index) {
                final bool selected = index == _value[0];
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selected
                            ? theme.colors.accent
                            : theme.colors.mutedForeground,
                      ),
                    ),
                    const Gap(6),
                    Text(
                      String.fromCharCode(65 + index),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
          value: _value,
          perspective: true,
          onChanged: (List<int> value) => setState(() => _value = value),
        ),
        Gap(theme.spacing.lg),
        Text(
          'letter ${String.fromCharCode(65 + _value[0])}',
          style: TextStyle(color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _perspective(BuildContext context) => const _PerspectiveWheel();
''',
    ),
    DocsExampleSource(
      name: 'Customized',
      builder: '_customized',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/wheel_picker/wheel_picker.dart';

/// A customized wheel: theme overrides and a fixed column width.
class _CustomizedWheel extends StatefulWidget {
  const _CustomizedWheel();

  @override
  State<_CustomizedWheel> createState() => _CustomizedWheelState();
}

class _CustomizedWheelState extends State<_CustomizedWheel> {
  static final List<String> _sizes = <String>[
    'Small',
    'Medium',
    'Large',
  ];
  static const List<String> _codes = <String>['S', 'M', 'L', 'XL'];
  List<int> _value = <int>[1, 0];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        WheelPicker(
          columns: <WheelColumn>[
            WheelColumn(items: _sizes, width: 120),
            WheelColumn(items: _codes),
          ],
          value: _value,
          theme: const WheelPickerTheme(
            itemHeight: 36,
            visibleItems: 3,
            selectionColor: ThemedColor.ref(ColorRef.accent, alpha: 0.25),
            fontSize: 15,
          ),
          onChanged: (List<int> value) => setState(() => _value = value),
        ),
        Gap(theme.spacing.lg),
        Text(
          '${_sizes[_value[0]]} / ${_codes[_value[1]]}',
          style: TextStyle(color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _customized(BuildContext context) => const _CustomizedWheel();
''',
    ),
    DocsExampleSource(
      name: 'Read-only',
      builder: '_readOnly',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/wheel_picker/wheel_picker.dart';

/// A read-only wheel with no callback.
Widget _readOnly(BuildContext context) {
  return SizedBox(
    width: 120,
    child: WheelPicker(
      columns: <WheelColumn>[
        WheelColumn(
          items: <String>['One', 'Two', 'Three'],
        ),
      ],
      initialValue: <int>[1],
    ),
  );
}
''',
    ),
  ],
  'accordion': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_accordionDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/accordion/accordion.dart';

/// The three classic questions, collapsed.
Widget _accordionDefault(BuildContext context) {
  return ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 420),
    child: Accordion(
      items: <Widget>[
        AccordionItem(
          trigger: AccordionTrigger(
            child: Text('Is it accessible?'),
          ),
          content: Text(
            'Yes. It follows the WAI-ARIA disclosure pattern and responds to Enter and Space.',
          ),
        ),
        AccordionItem(
          trigger: AccordionTrigger(
            child: Text('Is it styled?'),
          ),
          content: Text(
            'Yes. Defaults come from the global tokens and every part is overridable through AccordionTheme.',
          ),
        ),
        AccordionItem(
          trigger: AccordionTrigger(
            child: Text('Is it animated?'),
          ),
          content: Text(
            'Yes. Items animate with the theme duration.',
          ),
        ),
      ],
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Expanded',
      builder: '_accordionExpanded',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/accordion/accordion.dart';

/// The second item is opened on the first frame.
Widget _accordionExpanded(BuildContext context) {
  return ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 420),
    child: Accordion(
      items: <Widget>[
        AccordionItem(
          trigger: AccordionTrigger(
            child: Text('Is it accessible?'),
          ),
          content: Text(
            'Yes. It follows the WAI-ARIA disclosure pattern and responds to Enter and Space.',
          ),
        ),
        AccordionItem(
          expanded: true,
          trigger: AccordionTrigger(
            child: Text('Is it styled?'),
          ),
          content: Text(
            'Yes. Defaults come from the global tokens and every part is overridable through AccordionTheme.',
          ),
        ),
        AccordionItem(
          trigger: AccordionTrigger(
            child: Text('Is it animated?'),
          ),
          content: Text(
            'Yes. Items animate with the theme duration.',
          ),
        ),
      ],
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Multiple',
      builder: '_accordionMultiple',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/accordion/accordion.dart';

/// Two accordions stacked, so more than one can be open at a time.
Widget _accordionMultiple(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: _AccordionTwoItemAccordion(),
      ),
      Gap(spacing.lg),
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: _AccordionTwoItemAccordion(),
      ),
    ],
  );
}

class _AccordionTwoItemAccordion extends StatelessWidget {
  const _AccordionTwoItemAccordion();

  @override
  Widget build(BuildContext context) {
    return Accordion(
      items: <Widget>[
        AccordionItem(
          trigger: AccordionTrigger(
            child: Text('Shipping'),
          ),
          content: Text(
            'Dispatched within two working days.',
          ),
        ),
        AccordionItem(
          trigger: AccordionTrigger(
            child: Text('Returns'),
          ),
          content: Text('Free returns within 30 days.'),
        ),
      ],
    );
  }
}
''',
    ),
  ],
  'card': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_cardDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/card/card.dart';

/// The full upstream slot composition.
//
// P7-D1b: capped at 320 px (not fixed) so narrow phones shrink it instead of
// overflowing; the stage centres it.
class _CardDefault extends StatefulWidget {
  const _CardDefault();

  @override
  State<_CardDefault> createState() => _CardDefaultState();
}

class _CardDefaultState extends State<_CardDefault> {
  String _status = 'Ready to deploy';

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CardHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CardTitle(
                        child: Text('Deployments'),
                      ),
                      CardDescription(
                        child: Text(
                          'Ship a new build to production.',
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(spacing.lg),
                CardContent(
                  child: Text(
                    'Every deploy is immutable; roll back from the history tab.',
                  ),
                ),
                Gap(spacing.lg),
                CardFooter(
                  child: Builder(
                    builder: (context) {
                      // Narrow phone viewports stack the touch-sized footer
                      // actions; wider viewports keep them side by side.
                      final bool stack = MediaQuery.widthOf(context) < 600;
                      final List<Widget> actions = <Widget>[
                        Button(
                          size: ButtonSize.sm,
                          variant: ButtonVariant.ghost,
                          onPressed: () => setState(
                            () => _status = 'Deploy cancelled',
                          ),
                          child: Text('Cancel'),
                        ),
                        Button(
                          size: ButtonSize.sm,
                          onPressed: () => setState(
                            () =>
                                _status = 'Deploy queued',
                          ),
                          child: Text('Deploy'),
                        ),
                      ];
                      if (!stack) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            actions[0],
                            Gap(spacing.sm),
                            actions[1],
                          ],
                        );
                      }
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          actions[0],
                          Gap(spacing.sm),
                          actions[1],
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Gap(spacing.md),
        Text(
          _status,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}

Widget _cardDefault(BuildContext context) => const _CardDefault();
''',
    ),
    DocsExampleSource(
      name: 'With media',
      builder: '_cardWithMedia',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/card/card.dart';

/// A card whose header carries a clipped media band.
Widget _cardWithMedia(BuildContext context) {
  final theme = Theme.of(context);
  return ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 320),
    child: Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 96,
            child: ColoredBox(
              color: theme.colors.muted,
              child: Center(
                child: Icon(
                  LucideIcons.image,
                  size: 24,
                  color: theme.colors.mutedForeground,
                ),
              ),
            ),
          ),
          CardHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CardTitle(child: Text('Cover art')),
                CardDescription(
                  child: Text(
                    'Generated from the preset palette.',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'With footer',
      builder: '_cardWithFooter',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/card/card.dart';

/// A bare surface whose footer button is live.
class _CardWithFooter extends StatefulWidget {
  const _CardWithFooter();

  @override
  State<_CardWithFooter> createState() => _CardWithFooterState();
}

class _CardWithFooterState extends State<_CardWithFooter> {
  String _status = 'Plan unchanged';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CardTitle(child: Text('Billing')),
                Gap(theme.spacing.xs),
                Text(
                  'Bare card, default padding',
                  style: TextStyle(color: theme.colors.mutedForeground),
                ),
                Gap(theme.spacing.lg),
                CardFooter(
                  padding: EdgeInsetsDensity.pxAll(0),
                  child: Button(
                    size: ButtonSize.sm,
                    variant: ButtonVariant.outline,
                    onPressed: () => setState(
                      () => _status = 'Opened the plan',
                    ),
                    child: Text('Manage plan'),
                  ),
                ),
              ],
            ),
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          _status,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _cardWithFooter(BuildContext context) => const _CardWithFooter();
''',
    ),
  ],
  'card_image': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Vertical',
      builder: '_cardImageVertical',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/card_image/card_image.dart';

/// One grid tile's content.
class _Tile {
  const _Tile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.chart,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  /// Index into `ThemeColors.chartColors`.
  final int chart;
}

List<_Tile> _tiles = <_Tile>[
  _Tile(
    title: 'Sunset',
    subtitle: '18:42 · Lisbon',
    icon: LucideIcons.mountain,
    chart: 0,
  ),
  _Tile(
    title: 'Harbor nights',
    subtitle: '3:21 · focus mix',
    icon: LucideIcons.music,
    chart: 1,
  ),
];

/// A theme-token poster thumb: a chart fill with a card-coloured glyph. It
/// carries no size of its own — the card's aspect-ratio surface sizes it —
/// so this is also the shape a user `Image` takes.
Widget _thumb(BuildContext context, _Tile tile) {
  final theme = Theme.of(context);
  final List<Color> charts = theme.colors.chartColors;
  return ColoredBox(
    color: charts[tile.chart % charts.length],
    child: Center(child: Icon(tile.icon, size: 36, color: theme.colors.card)),
  );
}

/// One pressable card for [tile], selected when [selected].
Widget _tileCard(
  BuildContext context,
  _Tile tile,
  bool selected,
  VoidCallback onPressed,
) {
  return CardImage(
    image: _thumb(context, tile),
    title: Text(
      tile.title,
      style: TextStyle(
        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
      ),
    ),
    subtitle: Text(tile.subtitle),
    trailing: const Icon(LucideIcons.chevronRight, size: 16),
    onPressed: onPressed,
  );
}

/// A grid of vertical cards sharing one selection echo.
class _CardImageGrid extends StatefulWidget {
  const _CardImageGrid();

  @override
  State<_CardImageGrid> createState() => _CardImageGridState();
}

class _CardImageGridState extends State<_CardImageGrid> {
  int? _opened;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ConstrainedBox(
          // Two cards per row at 200px: the grid stays inside the 720x420
          // preview stage (three across wraps to a 3+1 layout and overflows).
          constraints: const BoxConstraints(maxWidth: 424),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: theme.spacing.lg,
            runSpacing: theme.spacing.lg,
            children: <Widget>[
              for (int i = 0; i < _tiles.length; i++)
                SizedBox(
                  width: 200,
                  child: _tileCard(
                    context,
                    _tiles[i],
                    _opened == i,
                    () => setState(() => _opened = _opened == i ? null : i),
                  ),
                ),
            ],
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          _opened == null
              ? 'Tap the card to open it'
              : 'Opened "${_tiles[_opened!].title}"',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _cardImageVertical(BuildContext context) => const _CardImageGrid();
''',
    ),
    DocsExampleSource(
      name: 'Horizontal',
      builder: '_cardImageHorizontal',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/card_image/card_image.dart';

/// One grid tile's content.
class _Tile {
  const _Tile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.chart,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  /// Index into `ThemeColors.chartColors`.
  final int chart;
}

List<_Tile> _tiles = <_Tile>[
  _Tile(
    title: 'Sunset',
    subtitle: '18:42 · Lisbon',
    icon: LucideIcons.mountain,
    chart: 0,
  ),
  _Tile(
    title: 'Harbor nights',
    subtitle: '3:21 · focus mix',
    icon: LucideIcons.music,
    chart: 1,
  ),
];

/// A theme-token poster thumb: a chart fill with a card-coloured glyph. It
/// carries no size of its own — the card's aspect-ratio surface sizes it —
/// so this is also the shape a user `Image` takes.
Widget _thumb(BuildContext context, _Tile tile) {
  final theme = Theme.of(context);
  final List<Color> charts = theme.colors.chartColors;
  return ColoredBox(
    color: charts[tile.chart % charts.length],
    child: Center(child: Icon(tile.icon, size: 36, color: theme.colors.card)),
  );
}

/// Horizontal composition: media beside the text block.
class _CardImageHorizontal extends StatefulWidget {
  const _CardImageHorizontal();

  @override
  State<_CardImageHorizontal> createState() => _CardImageHorizontalState();
}

class _CardImageHorizontalState extends State<_CardImageHorizontal> {
  bool _opened = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 320,
          child: CardImage(
            theme: const CardImageTheme(direction: Axis.horizontal),
            image: SizedBox(
              width: 96,
              height: 96,
              child: _thumb(context, _tiles[1]),
            ),
            title: Text(
              _tiles[1].title,
              style: TextStyle(
                fontWeight: _opened ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            subtitle: Text(_tiles[1].subtitle),
            trailing: const Icon(LucideIcons.chevronRight, size: 16),
            onPressed: () => setState(() => _opened = !_opened),
          ),
        ),
        Gap(theme.spacing.sm),
        Text(
          _opened
              ? 'Opened "${_tiles[1].title}"'
              : 'Tap the card to open it',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _cardImageHorizontal(BuildContext context) =>
    const _CardImageHorizontal();
''',
    ),
    DocsExampleSource(
      name: 'Disabled',
      builder: '_cardImageDisabled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/card_image/card_image.dart';

/// One grid tile's content.
class _Tile {
  const _Tile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.chart,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  /// Index into `ThemeColors.chartColors`.
  final int chart;
}

List<_Tile> _tiles = <_Tile>[
  _Tile(
    title: 'Sunset',
    subtitle: '18:42 · Lisbon',
    icon: LucideIcons.mountain,
    chart: 0,
  ),
  _Tile(
    title: 'Harbor nights',
    subtitle: '3:21 · focus mix',
    icon: LucideIcons.music,
    chart: 1,
  ),
];

/// A theme-token poster thumb: a chart fill with a card-coloured glyph. It
/// carries no size of its own — the card's aspect-ratio surface sizes it —
/// so this is also the shape a user `Image` takes.
Widget _thumb(BuildContext context, _Tile tile) {
  final theme = Theme.of(context);
  final List<Color> charts = theme.colors.chartColors;
  return ColoredBox(
    color: charts[tile.chart % charts.length],
    child: Center(child: Icon(tile.icon, size: 36, color: theme.colors.card)),
  );
}

/// The disabled card next to a live one, so the pair reads as one row.
class _CardImageDisabledPair extends StatefulWidget {
  const _CardImageDisabledPair();

  @override
  State<_CardImageDisabledPair> createState() => _CardImageDisabledPairState();
}

class _CardImageDisabledPairState extends State<_CardImageDisabledPair> {
  bool _opened = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: Theme.of(context).spacing.lg,
      runSpacing: Theme.of(context).spacing.lg,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 200,
          child: CardImage(
            image: _thumb(context, _tiles[1]),
            title: Text('Archived'),
            subtitle: const Text('read-only'),
            enabled: false,
            onPressed: () {},
          ),
        ),
        SizedBox(
          width: 200,
          child: CardImage(
            image: _thumb(context, _tiles[0]),
            title: Text(
              'In progress',
              style: TextStyle(
                fontWeight: _opened ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            subtitle: Text('tap to open'),
            trailing: const Icon(LucideIcons.chevronRight, size: 16),
            onPressed: () => setState(() => _opened = !_opened),
          ),
        ),
      ],
    );
  }
}

Widget _cardImageDisabled(BuildContext context) =>
    const _CardImageDisabledPair();
''',
    ),
  ],
  'collapsible': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_collapsibleDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/collapsible/collapsible.dart';

/// One muted row of the branch list.
Widget _collapsibleRow(BuildContext context, String label) {
  final theme = Theme.of(context);
  return DecoratedBox(
    decoration: BoxDecoration(
      color: theme.colors.muted,
      borderRadius: theme.borderRadiusLg,
    ),
    child: DensityContentPadding(
      padding: EdgeInsetsDensity.pxAll(12),
      child: Text(label),
    ),
  );
}

/// Uncontrolled: the section keeps its own state.
class _CollapsibleUncontrolled extends StatelessWidget {
  const _CollapsibleUncontrolled();

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 360),
      child: Collapsible(
        children: <Widget>[
          CollapsibleTrigger(
            child: Text('Recent activity'),
          ),
          Gap(spacing.sm),
          _collapsibleRow(context, '@mibrar-dev/dashcn'),
          CollapsibleContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Gap(spacing.sm),
                _collapsibleRow(context, '@flutter/flutter'),
                Gap(spacing.sm),
                _collapsibleRow(context, '@dart-lang/sdk'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _collapsibleDefault(BuildContext context) =>
    const _CollapsibleUncontrolled();
''',
    ),
    DocsExampleSource(
      name: 'Controlled',
      builder: '_collapsibleControlledExample',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/collapsible/collapsible.dart';

/// One muted row of the branch list.
Widget _collapsibleRow(BuildContext context, String label) {
  final theme = Theme.of(context);
  return DecoratedBox(
    decoration: BoxDecoration(
      color: theme.colors.muted,
      borderRadius: theme.borderRadiusLg,
    ),
    child: DensityContentPadding(
      padding: EdgeInsetsDensity.pxAll(12),
      child: Text(label),
    ),
  );
}

/// Controlled: the example owns the expansion state.
class _CollapsibleControlled extends StatefulWidget {
  const _CollapsibleControlled();

  @override
  State<_CollapsibleControlled> createState() => _CollapsibleControlledState();
}

class _CollapsibleControlledState extends State<_CollapsibleControlled> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 360),
      child: Collapsible(
        isExpanded: _expanded,
        onExpansionChanged: (bool value) => setState(() => _expanded = value),
        children: <Widget>[
          CollapsibleTrigger(
            child: Text('Controlled section'),
          ),
          Gap(spacing.sm),
          CollapsibleContent(
            child: _collapsibleRow(
              context,
              'Toggled by the parent',
            ),
          ),
          Gap(spacing.sm),
          Text(_expanded ? 'open' : 'closed'),
        ],
      ),
    );
  }
}

Widget _collapsibleControlledExample(BuildContext context) =>
    const _CollapsibleControlled();
''',
    ),
  ],
  'filter_bar': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/filter_bar/filter_bar.dart';

List<FilterSortOption> _sortOptions([
  BuildContext? context,
]) => <FilterSortOption>[
  FilterSortOption(id: 'newest', label: 'Newest'),
  FilterSortOption(id: 'oldest', label: 'Oldest'),
  FilterSortOption(id: 'popular', label: 'Most popular'),
];

/// Inline bar with sort options, query applied, and a result count.
class _DefaultFilterBar extends StatefulWidget {
  const _DefaultFilterBar();

  @override
  State<_DefaultFilterBar> createState() => _DefaultFilterBarState();
}

class _DefaultFilterBarState extends State<_DefaultFilterBar> {
  FilterState _state = const FilterState(sortId: 'newest');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 520,
      child: FilterBar(
        state: _state,
        onStateChanged: (FilterState next) => setState(() => _state = next),
        sortOptions: _sortOptions(context),
        resultsCount: 42,
        presentation: FilterBarPresentation.inline,
      ),
    );
  }
}

Widget _default(BuildContext context) => const _DefaultFilterBar();
''',
    ),
    DocsExampleSource(
      name: 'With chips',
      builder: '_withChips',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/filter_bar/filter_bar.dart';

List<FilterSortOption> _sortOptions([
  BuildContext? context,
]) => <FilterSortOption>[
  FilterSortOption(id: 'newest', label: 'Newest'),
  FilterSortOption(id: 'oldest', label: 'Oldest'),
  FilterSortOption(id: 'popular', label: 'Most popular'),
];

/// Inline bar with active filter chips and clear-all control.
class _ChipsFilterBar extends StatefulWidget {
  const _ChipsFilterBar();

  @override
  State<_ChipsFilterBar> createState() => _ChipsFilterBarState();
}

class _ChipsFilterBarState extends State<_ChipsFilterBar> {
  FilterState _state = FilterState(
    sortId: 'newest',
    chips: <FilterChipData>[
      FilterChipData(key: 'tag:design', label: 'Tag: Design'),
      FilterChipData(
        key: 'status:active',
        label: 'Status: Active',
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 520,
      child: FilterBar(
        state: _state,
        onStateChanged: (FilterState next) => setState(() => _state = next),
        sortOptions: _sortOptions(context),
        resultsCount: 3,
        presentation: FilterBarPresentation.inline,
      ),
    );
  }
}

Widget _withChips(BuildContext context) => const _ChipsFilterBar();
''',
    ),
    DocsExampleSource(
      name: 'Popup',
      builder: '_overflowMenu',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/filter_bar/filter_bar.dart';

List<FilterSortOption> _sortOptions([
  BuildContext? context,
]) => <FilterSortOption>[
  FilterSortOption(id: 'newest', label: 'Newest'),
  FilterSortOption(id: 'oldest', label: 'Oldest'),
  FilterSortOption(id: 'popular', label: 'Most popular'),
];

/// Narrow bar that overflows secondary controls into a compact menu trigger.
class _OverflowFilterBar extends StatefulWidget {
  const _OverflowFilterBar();

  @override
  State<_OverflowFilterBar> createState() => _OverflowFilterBarState();
}

class _OverflowFilterBarState extends State<_OverflowFilterBar> {
  FilterState _state = const FilterState(search: 'theme', sortId: 'newest');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      child: FilterBar(
        state: _state,
        onStateChanged: (FilterState next) => setState(() => _state = next),
        sortOptions: _sortOptions(context),
        enableDateRange: true,
        resultsCount: 12,
        // Anchored compact popup menu (the canonical anchored variant).
        presentation: FilterBarPresentation.popup,
      ),
    );
  }
}

Widget _overflowMenu(BuildContext context) => const _OverflowFilterBar();
''',
    ),
    DocsExampleSource(
      name: 'Dialog',
      builder: '_dialog',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/filter_bar/filter_bar.dart';

List<FilterSortOption> _sortOptions([
  BuildContext? context,
]) => <FilterSortOption>[
  FilterSortOption(id: 'newest', label: 'Newest'),
  FilterSortOption(id: 'oldest', label: 'Oldest'),
  FilterSortOption(id: 'popular', label: 'Most popular'),
];

/// Narrow bar that opens its overflow in a centred dialog.
class _DialogFilterBar extends StatefulWidget {
  const _DialogFilterBar();

  @override
  State<_DialogFilterBar> createState() => _DialogFilterBarState();
}

class _DialogFilterBarState extends State<_DialogFilterBar> {
  FilterState _state = const FilterState(search: 'theme', sortId: 'newest');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      child: FilterBar(
        state: _state,
        onStateChanged: (FilterState next) => setState(() => _state = next),
        sortOptions: _sortOptions(context),
        enableDateRange: true,
        resultsCount: 12,
        // Centred dialog: same tokens as the inline bar and popup menu.
        presentation: FilterBarPresentation.dialog,
      ),
    );
  }
}

Widget _dialog(BuildContext context) => const _DialogFilterBar();
''',
    ),
    DocsExampleSource(
      name: 'Sheet',
      builder: '_sheet',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/filter_bar/filter_bar.dart';

List<FilterSortOption> _sortOptions([
  BuildContext? context,
]) => <FilterSortOption>[
  FilterSortOption(id: 'newest', label: 'Newest'),
  FilterSortOption(id: 'oldest', label: 'Oldest'),
  FilterSortOption(id: 'popular', label: 'Most popular'),
];

/// Narrow bar that opens its overflow in a bottom sheet on phone widths.
class _SheetFilterBar extends StatefulWidget {
  const _SheetFilterBar();

  @override
  State<_SheetFilterBar> createState() => _SheetFilterBarState();
}

class _SheetFilterBarState extends State<_SheetFilterBar> {
  FilterState _state = const FilterState(search: 'theme', sortId: 'newest');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      child: FilterBar(
        state: _state,
        onStateChanged: (FilterState next) => setState(() => _state = next),
        sortOptions: _sortOptions(context),
        enableDateRange: true,
        resultsCount: 12,
        // Bottom sheet on phone widths via the drawer sheet scaffold.
        presentation: FilterBarPresentation.sheet,
      ),
    );
  }
}

Widget _sheet(BuildContext context) => const _SheetFilterBar();
''',
    ),
    DocsExampleSource(
      name: 'Overflow menu open',
      builder: '_openMenu',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/filter_bar/filter_bar.dart';

List<FilterSortOption> _sortOptions([
  BuildContext? context,
]) => <FilterSortOption>[
  FilterSortOption(id: 'newest', label: 'Newest'),
  FilterSortOption(id: 'oldest', label: 'Oldest'),
  FilterSortOption(id: 'popular', label: 'Most popular'),
];

/// Overflow menu shown open with a filter applied.
class _OpenMenuFilterBar extends StatefulWidget {
  const _OpenMenuFilterBar();

  @override
  State<_OpenMenuFilterBar> createState() => _OpenMenuFilterBarState();
}

class _OpenMenuFilterBarState extends State<_OpenMenuFilterBar> {
  FilterState _state = FilterState(
    sortId: 'newest',
    chips: <FilterChipData>[
      FilterChipData(key: 'tag:ui', label: 'Tag: UI'),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FilterBar(
            state: _state,
            onStateChanged: (FilterState next) => setState(() => _state = next),
            sortOptions: _sortOptions(context),
            resultsCount: 7,
            presentation: FilterBarPresentation.menu,
          ),
          const Gap(kSpace2),
          FilterBarOverflowMenu(
            title: 'Filters',
            activeCount: _state.activeFilterCount,
            resultsCount: 7,
            width: 320,
            onClearAll: () => setState(() => _state = _state.cleared()),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FilterBarSortControl(
                  value: _state.sortId,
                  options: _sortOptions(context),
                  onChanged: (String? next) =>
                      setState(() => _state = _state.copyWith(sortId: next)),
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _openMenu(BuildContext context) => const _OpenMenuFilterBar();
''',
    ),
    DocsExampleSource(
      name: 'Customized',
      builder: '_customized',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/filter_bar/filter_bar.dart';

List<FilterSortOption> _sortOptions([
  BuildContext? context,
]) => <FilterSortOption>[
  FilterSortOption(id: 'newest', label: 'Newest'),
  FilterSortOption(id: 'oldest', label: 'Oldest'),
  FilterSortOption(id: 'popular', label: 'Most popular'),
];

/// Customized filter bar with style overrides and comfortable density.
class _CustomizedFilterBar extends StatefulWidget {
  const _CustomizedFilterBar();

  @override
  State<_CustomizedFilterBar> createState() => _CustomizedFilterBarState();
}

class _CustomizedFilterBarState extends State<_CustomizedFilterBar> {
  FilterState _state = const FilterState(search: 'compact', sortId: 'popular');

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    return SizedBox(
      width: 560,
      child: FilterBar(
        state: _state,
        onStateChanged: (FilterState next) => setState(() => _state = next),
        sortOptions: _sortOptions(context),
        resultsCount: 19,
        densityTokens: DensityTokens.comfortable,
        presentation: FilterBarPresentation.inline,
        style: FilterBarStyle(
          borderRadius: ambient.borderRadiusXl,
          padding: const EdgeInsets.all(kSpace3),
          searchWidth: 240,
          controlWidth: 200,
          controlHeight: 40,
          iconSize: 20,
        ),
      ),
    );
  }
}

Widget _customized(BuildContext context) => const _CustomizedFilterBar();
''',
    ),
  ],
  'overflow_marquee': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_defaultMarquee',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/badge/badge.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/overflow_marquee/overflow_marquee.dart';

Widget _band(BuildContext context, Widget child) {
  final theme = Theme.of(context);
  return DecoratedBox(
    decoration: BoxDecoration(
      color: theme.colors.card,
      border: Border.all(color: theme.colors.border),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(padding: EdgeInsets.all(theme.spacing.sm), child: child),
  );
}

Widget _defaultMarquee(BuildContext context) {
  final theme = Theme.of(context);
  return SizedBox(
    width: 340,
    child: _band(
      context,
      Row(
        children: <Widget>[
          Icon(LucideIcons.bell, size: 16, color: theme.colors.primary),
          Gap(theme.spacing.sm),
          Expanded(
            child: OverflowMarquee(
              speed: 45.0,
              gap: 28.0,
              child: Text(
                'Breaking News: dashcn continuous marquee components now live across all platforms! • Seamless looping with soft edge fades • Fully keyboard accessible',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Now playing',
      builder: '_nowPlaying',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/badge/badge.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/overflow_marquee/overflow_marquee.dart';

Widget _band(BuildContext context, Widget child) {
  final theme = Theme.of(context);
  return DecoratedBox(
    decoration: BoxDecoration(
      color: theme.colors.card,
      border: Border.all(color: theme.colors.border),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(padding: EdgeInsets.all(theme.spacing.sm), child: child),
  );
}

class _NowPlaying extends StatefulWidget {
  const _NowPlaying();

  @override
  State<_NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<_NowPlaying> {
  final MarqueeController _controller = MarqueeController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 320,
      child: _band(
        context,
        Row(
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: theme.colors.muted,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Icon(
                  LucideIcons.music,
                  size: 20,
                  color: theme.colors.primary,
                ),
              ),
            ),
            Gap(theme.spacing.sm),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  OverflowMarquee(
                    controller: _controller,
                    speed: 40.0,
                    gap: 32.0,
                    child: Text(
                      'Midnight City — M83 (Extended Club Mix, 2024 Remaster)',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    _controller.isPlaying
                        ? 'Playing · Synthwave'
                        : 'Paused',
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            Gap(theme.spacing.sm),
            Button(
              size: ButtonSize.icon,
              variant: ButtonVariant.ghost,
              onPressed: () {
                _controller.toggle();
                setState(() {});
              },
              child: Semantics(
                label: _controller.isPlaying
                    ? 'Pause'
                    : 'Play',
                child: Icon(
                  _controller.isPlaying ? LucideIcons.pause : LucideIcons.play,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _nowPlaying(BuildContext context) => const _NowPlaying();
''',
    ),
    DocsExampleSource(
      name: 'News ticker',
      builder: '_newsTicker',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/badge/badge.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/overflow_marquee/overflow_marquee.dart';

Widget _band(BuildContext context, Widget child) {
  final theme = Theme.of(context);
  return DecoratedBox(
    decoration: BoxDecoration(
      color: theme.colors.card,
      border: Border.all(color: theme.colors.border),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(padding: EdgeInsets.all(theme.spacing.sm), child: child),
  );
}

Widget _newsTicker(BuildContext context) {
  final theme = Theme.of(context);
  return SizedBox(
    width: 340,
    child: _band(
      context,
      Row(
        children: <Widget>[
          const Badge(variant: BadgeVariant.destructive, child: Text('LIVE')),
          Gap(theme.spacing.sm),
          const Expanded(
            child: OverflowMarquee(
              speed: 55.0,
              gap: 32.0,
              child: Text(
                'dashcn 1.0 ships 145 components • pull-to-refresh learns trackpads • '
                'continuous marquees loop seamlessly • cards never collapse',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Vertical',
      builder: '_verticalCredits',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/badge/badge.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/overflow_marquee/overflow_marquee.dart';

Widget _band(BuildContext context, Widget child) {
  final theme = Theme.of(context);
  return DecoratedBox(
    decoration: BoxDecoration(
      color: theme.colors.card,
      border: Border.all(color: theme.colors.border),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(padding: EdgeInsets.all(theme.spacing.sm), child: child),
  );
}

Widget _verticalCredits(BuildContext context) {
  return SizedBox(
    width: 280,
    height: 96,
    child: _band(
      context,
      Center(
        child: OverflowMarquee(
          direction: AxisDirectional.up,
          speed: 25.0,
          gap: 16.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Directed by dashcn Team',
                style: TextStyle(fontSize: 13),
              ),
              Text(
                'Original Score by Synthwave',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                'Starring Continuous Marquee',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                'Special Thanks to Open Source',
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'RTL reverse',
      builder: '_rtlTicker',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/badge/badge.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/overflow_marquee/overflow_marquee.dart';

Widget _band(BuildContext context, Widget child) {
  final theme = Theme.of(context);
  return DecoratedBox(
    decoration: BoxDecoration(
      color: theme.colors.card,
      border: Border.all(color: theme.colors.border),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(padding: EdgeInsets.all(theme.spacing.sm), child: child),
  );
}

Widget _rtlTicker(BuildContext context) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: SizedBox(
      width: 320,
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);
          return _band(
            context,
            Row(
              children: <Widget>[
                const Badge(child: Text('عاجل')),
                Gap(theme.spacing.sm),
                Expanded(
                  child: OverflowMarquee(
                    direction: AxisDirectional.start,
                    speed: 45.0,
                    gap: 30.0,
                    child: Text(
                      'مكتبة dashcn تدعم الاتجاه من اليمين إلى اليسار بشكل كامل مع حركة مستمرة وسلسة',
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Customized',
      builder: '_customizedMarquee',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/badge/badge.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/overflow_marquee/overflow_marquee.dart';

Widget _band(BuildContext context, Widget child) {
  final theme = Theme.of(context);
  return DecoratedBox(
    decoration: BoxDecoration(
      color: theme.colors.card,
      border: Border.all(color: theme.colors.border),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(padding: EdgeInsets.all(theme.spacing.sm), child: child),
  );
}

Widget _customizedMarquee(BuildContext context) {
  final theme = Theme.of(context);
  return SizedBox(
    width: 340,
    child: _band(
      context,
      OverflowMarquee(
        speed: 75.0,
        gap: 40.0,
        fadePortion: 0.15,
        leading: Padding(
          padding: EdgeInsets.only(right: theme.spacing.sm),
          child: const Badge(
            variant: BadgeVariant.secondary,
            child: Text('FAST'),
          ),
        ),
        trailing: Padding(
          padding: EdgeInsets.only(left: theme.spacing.sm),
          child: Icon(LucideIcons.zap, size: 16, color: theme.colors.primary),
        ),
        child: Text(
          'Custom speed: 75 px/s • Custom gap: 40 px • Custom edge fades • Pinned builder slots',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    ),
  );
}
''',
    ),
  ],
  'resizable': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Absolute',
      builder: '_absolute',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/resizable/resizable.dart';

/// A muted pane label in theme tokens.
class _Pane extends StatelessWidget {
  const _Pane(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      color: theme.colors.muted,
      child: Text(
        label,
        textAlign: TextAlign.center,
        // The pane fill is muted: the raw token fails AA on it.
        style: TextStyle(color: theme.colors.onMuted),
      ),
    );
  }
}

/// Panes sized in absolute pixels.
Widget _absolute(BuildContext context) {
  // P7-TH1: the box hugs the declared sizes (120 + 1px handle + 200) so the
  // demo centres exactly; a wider box would strand transparent leftover on
  // the right because absolute panels pack from the start.
  return SizedBox(
    width: 321,
    height: 140,
    child: ResizablePanelGroup(
      children: <Widget>[
        ResizablePanel(defaultSize: 120, child: _Pane('Sidebar')),
        ResizableHandle(withHandle: true),
        ResizablePanel(
          defaultSize: 200,
          child: _Pane('Main'),
        ),
      ],
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Flexible',
      builder: '_flexible',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/resizable/resizable.dart';

/// A muted pane label in theme tokens.
class _Pane extends StatelessWidget {
  const _Pane(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      color: theme.colors.muted,
      child: Text(
        label,
        textAlign: TextAlign.center,
        // The pane fill is muted: the raw token fails AA on it.
        style: TextStyle(color: theme.colors.onMuted),
      ),
    );
  }
}

/// Panes sharing space by flex.
Widget _flexible(BuildContext context) {
  return SizedBox(
    width: 360,
    height: 140,
    child: ResizablePanelGroup(
      children: <Widget>[
        ResizablePanel(flex: 2, child: _Pane('Main')),
        ResizableHandle(withHandle: true),
        ResizablePanel(flex: 1, child: _Pane('Inspector')),
      ],
    ),
  );
}
''',
    ),
  ],
  'scaffold': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/dropdown_menu/dropdown_menu.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/scaffold/scaffold.dart';

/// One icon action in the app bar: a real `Button` so it is keyboard reachable.
class _AppBarAction extends StatelessWidget {
  const _AppBarAction({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      size: ButtonSize.icon,
      variant: ButtonVariant.ghost,
      onPressed: onPressed,
      child: Semantics(label: label, child: Icon(icon, size: 16)),
    );
  }
}

/// A shell whose header and footer actions report what they did.
class _ScaffoldDefault extends StatefulWidget {
  const _ScaffoldDefault();

  @override
  State<_ScaffoldDefault> createState() => _ScaffoldDefaultState();
}

class _ScaffoldDefaultState extends State<_ScaffoldDefault> {
  String _lastAction = 'Tap an app-bar action';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          width: 360,
          height: 280,
          child: Scaffold(
            headers: <Widget>[
              AppBar(
                leading: <Widget>[
                  _AppBarAction(
                    icon: LucideIcons.chevronLeft,
                    label: 'Back',
                    onPressed: () => setState(
                      () => _lastAction = 'Went back',
                    ),
                  ),
                ],
                title: Text('My Application'),
                subtitle: Text('Dashboard'),
                trailing: <Widget>[
                  _AppBarAction(
                    icon: LucideIcons.ellipsis,
                    label: 'More',
                    onPressed: _openMenu,
                  ),
                ],
              ),
            ],
            footers: <Widget>[
              AppBar(
                title: Text('Status'),
                subtitle: Text('All systems go'),
              ),
            ],
            child: Center(
              child: Text('Main content area'),
            ),
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          _lastAction,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }

  void _openMenu() {
    showDropdown<void>(
      context: context,
      children: <Widget>[
        MenuButton(
          child: Text('Rename'),
          onPressed: (_) => _run('Rename chosen'),
        ),
        MenuButton(
          child: Text('Duplicate'),
          onPressed: (_) => _run('Duplicated'),
        ),
        const MenuSeparator(),
        MenuButton(
          child: Text('Archive'),
          onPressed: (_) => _run('Archived'),
        ),
      ],
    );
  }

  void _run(String action) => setState(() => _lastAction = action);
}

Widget _default(BuildContext context) => const _ScaffoldDefault();
''',
    ),
    DocsExampleSource(
      name: 'With loading',
      builder: '_withLoading',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/dropdown_menu/dropdown_menu.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/scaffold/scaffold.dart';

/// A shell showing the loading bar over fetching content.
Widget _withLoading(BuildContext context) {
  return SizedBox(
    width: 360,
    height: 200,
    child: Scaffold(
      headers: <Widget>[AppBar(title: Text('Syncing'))],
      loadingProgress: 0.4,
      showLoadingSparks: true,
      child: Center(child: Text('Fetching...')),
    ),
  );
}
''',
    ),
  ],
  'scrollbar': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/scrollbar/scrollbar.dart';

/// A scrollable list; the controller lives in the example's own state.
class _ScrollbarDemo extends StatefulWidget {
  const _ScrollbarDemo({this.thumbVisibility, this.trackVisibility});

  final bool? thumbVisibility;
  final bool? trackVisibility;

  @override
  State<_ScrollbarDemo> createState() => _ScrollbarDemoState();
}

class _ScrollbarDemoState extends State<_ScrollbarDemo> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 180,
      child: Scrollbar(
        controller: _controller,
        thumbVisibility: widget.thumbVisibility,
        trackVisibility: widget.trackVisibility,
        child: ListView.builder(
          controller: _controller,
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.all(8),
            child: Text('Item ${index + 1}'),
          ),
        ),
      ),
    );
  }
}

/// The default auto-hiding thumb.
Widget _default(BuildContext context) => const _ScrollbarDemo();
''',
    ),
    DocsExampleSource(
      name: 'Always visible',
      builder: '_alwaysVisible',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/scrollbar/scrollbar.dart';

/// A scrollable list; the controller lives in the example's own state.
class _ScrollbarDemo extends StatefulWidget {
  const _ScrollbarDemo({this.thumbVisibility, this.trackVisibility});

  final bool? thumbVisibility;
  final bool? trackVisibility;

  @override
  State<_ScrollbarDemo> createState() => _ScrollbarDemoState();
}

class _ScrollbarDemoState extends State<_ScrollbarDemo> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 180,
      child: Scrollbar(
        controller: _controller,
        thumbVisibility: widget.thumbVisibility,
        trackVisibility: widget.trackVisibility,
        child: ListView.builder(
          controller: _controller,
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.all(8),
            child: Text('Item ${index + 1}'),
          ),
        ),
      ),
    );
  }
}

/// A permanently visible thumb over a track.
Widget _alwaysVisible(BuildContext context) =>
    const _ScrollbarDemo(thumbVisibility: true, trackVisibility: true);
''',
    ),
    DocsExampleSource(
      name: 'Themed',
      builder: '_themed',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/scrollbar/scrollbar.dart';

/// A scrollable list; the controller lives in the example's own state.
class _ScrollbarDemo extends StatefulWidget {
  const _ScrollbarDemo({this.thumbVisibility, this.trackVisibility});

  final bool? thumbVisibility;
  final bool? trackVisibility;

  @override
  State<_ScrollbarDemo> createState() => _ScrollbarDemoState();
}

class _ScrollbarDemoState extends State<_ScrollbarDemo> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 180,
      child: Scrollbar(
        controller: _controller,
        thumbVisibility: widget.thumbVisibility,
        trackVisibility: widget.trackVisibility,
        child: ListView.builder(
          controller: _controller,
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.all(8),
            child: Text('Item ${index + 1}'),
          ),
        ),
      ),
    );
  }
}

/// A thumb tinted from the theme tokens.
Widget _themed(BuildContext context) {
  return const ComponentTheme<ScrollbarTheme>(
    data: ScrollbarTheme(
      color: ThemedColor.ref(ColorRef.primary),
      thickness: 10,
    ),
    child: _ScrollbarDemo(thumbVisibility: true),
  );
}
''',
    ),
  ],
  'sortable': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/sortable/sortable.dart';

/// One draggable row in theme tokens.
class _Row extends StatelessWidget {
  const _Row({required this.item, this.candidate = false, this.last = false});

  final String item;
  final bool candidate;

  /// Whether this is the last row of the list: the last row keeps no bottom
  /// margin, so the staged list centres exactly (P7-TH1).
  final bool last;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      // Inter-item breathing room lives between rows only — never trailing
      // the list — so the demo centres in its stage.
      margin: EdgeInsets.only(bottom: last ? 0 : 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: candidate ? theme.colors.accent : theme.colors.card,
        border: Border.all(color: theme.colors.border),
        borderRadius: theme.borderRadiusMd,
      ),
      child: Row(
        children: <Widget>[
          SortableDragHandle(
            child: Icon(
              LucideIcons.gripVertical,
              size: 14,
              color: theme.colors.mutedForeground,
            ),
          ),
          Gap(theme.spacing.md),
          // Tile text inherits the surface color explicitly so the
          // rows stay readable outside the app's default text scope.
          Expanded(
            child: Text(
              item,
              style: TextStyle(
                color: candidate
                    ? theme.colors.accentForeground
                    : theme.colors.cardForeground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A reorderable vertical list.
class _ListDemo extends StatefulWidget {
  const _ListDemo();

  @override
  State<_ListDemo> createState() => _ListDemoState();
}

class _ListDemoState extends State<_ListDemo> {
  final List<String> _items = <String>[
    'Alpha',
    'Beta',
    'Gamma',
    'Delta',
  ];

  void _move(String dragged, String target, bool above) {
    setState(() {
      _items.remove(dragged);
      final int index = _items.indexOf(target);
      _items.insert(above ? index : index + 1, dragged);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: SortableLayer(
        lock: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            for (int i = 0; i < _items.length; i++)
              Sortable<String>(
                key: ValueKey<String>(_items[i]),
                data: SortableData<String>(_items[i]),
                onAcceptTop: (SortableData<String> data) =>
                    _move(data.data, _items[i], true),
                onAcceptBottom: (SortableData<String> data) =>
                    _move(data.data, _items[i], false),
                candidateFallback: _Row(item: _items[i], candidate: true),
                fallback: Opacity(opacity: 0.3, child: _Row(item: _items[i])),
                child: _Row(item: _items[i], last: i == _items.length - 1),
              ),
          ],
        ),
      ),
    );
  }
}

Widget _default(BuildContext context) => const _ListDemo();
''',
    ),
    DocsExampleSource(
      name: 'Grid',
      builder: '_grid',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/sortable/sortable.dart';

/// One draggable tile in theme tokens.
class _Tile extends StatelessWidget {
  const _Tile({required this.item, this.candidate = false});

  final String item;
  final bool candidate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 104,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: candidate ? theme.colors.accent : theme.colors.card,
        border: Border.all(color: theme.colors.border),
        borderRadius: theme.borderRadiusMd,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SortableDragHandle(
            child: Icon(
              LucideIcons.gripVertical,
              size: 14,
              color: theme.colors.mutedForeground,
            ),
          ),
          Gap(theme.spacing.sm),
          Expanded(
            child: Text(
              item,
              style: TextStyle(
                color: candidate
                    ? theme.colors.accentForeground
                    : theme.colors.cardForeground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The same items as a wrapping grid of tiles.
class _GridDemo extends StatefulWidget {
  const _GridDemo();

  @override
  State<_GridDemo> createState() => _GridDemoState();
}

class _GridDemoState extends State<_GridDemo> {
  final List<String> _items = <String>[
    'Alpha',
    'Beta',
    'Gamma',
    'Delta',
    'Epsilon',
    'Zeta',
  ];

  void _move(String dragged, String target, bool above) {
    setState(() {
      _items.remove(dragged);
      final int index = _items.indexOf(target);
      _items.insert(above ? index : index + 1, dragged);
    });
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return SizedBox(
      width: 340,
      child: SortableLayer(
        lock: true,
        // P7-TH1: the layer's Stack parks the shrink-wrapped Wrap at the
        // start; the Center keeps the runs in the middle of the 340px box
        // at every spacing (the Wrap alignment alone cannot — the Wrap
        // shrink-wraps to its runs).
        child: Center(
          child: Wrap(
            spacing: spacing.sm,
            runSpacing: spacing.sm,
            // P7-TH1: runs centre in the 340px box (the 3-up rows are 328
            // wide and would otherwise pack left).
            alignment: WrapAlignment.center,
            children: <Widget>[
              for (final String item in _items)
                Sortable<String>(
                  key: ValueKey<String>(item),
                  data: SortableData<String>(item),
                  onAcceptTop: (SortableData<String> data) =>
                      _move(data.data, item, true),
                  onAcceptBottom: (SortableData<String> data) =>
                      _move(data.data, item, false),
                  candidateFallback: _Tile(item: item, candidate: true),
                  fallback: Opacity(opacity: 0.3, child: _Tile(item: item)),
                  child: _Tile(item: item),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _grid(BuildContext context) => const _GridDemo();
''',
    ),
  ],
  'steps': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/steps/steps.dart';

/// The default vertical flow.
Widget _default(BuildContext context) {
  return Steps(
    children: <Widget>[
      StepItem(
        title: Text('Account'),
        content: <Widget>[
          Text('Sign up with your email address.'),
        ],
      ),
      StepItem(
        title: Text('Verify'),
        content: <Widget>[
          Text('Check your inbox for a code.'),
        ],
      ),
      StepItem(
        title: Text('Profile'),
        content: <Widget>[
          Text('Add your personal information.'),
        ],
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Custom indicators',
      builder: '_custom',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/steps/steps.dart';

/// Larger indicators tinted with the primary token.
Widget _custom(BuildContext context) {
  return Steps(
    theme: const StepsTheme(
      indicatorSize: 32,
      indicatorColor: ThemedColor.ref(ColorRef.primary),
      indicatorForeground: ThemedColor.ref(ColorRef.primaryForeground),
      connectorColor: ThemedColor.ref(ColorRef.primary, alpha: 0.4),
    ),
    children: <Widget>[
      StepItem(
        title: Text('Cart'),
        content: <Widget>[Text('Review items.')],
      ),
      StepItem(
        title: Text('Pay'),
        content: <Widget>[Text('Choose a method.')],
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Single step',
      builder: '_single',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/steps/steps.dart';

/// A single step.
Widget _single(BuildContext context) {
  return Steps(
    children: <Widget>[
      StepItem(
        title: Text('Done'),
        content: <Widget>[Text('Nothing else.')],
      ),
    ],
  );
}
''',
    ),
  ],
  'command': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_commandDefault',
      code: r'''import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/platform.dart';
import 'package:<your_app>/ui/dashcn/primitives/subfocus_list_item.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/command/command.dart';

// Temporary hit-test-only 32 -> 48 px expansion for command rows.
//
// SIZING: menu-family rows are 32 px on desktop and mobile alike; touch
// comfort comes from an invisible hit area, never larger visuals. PR 60's
// `touch_hit_area` primitive implements exactly this (hit-test + semantics
// expansion with no layout growth) but lives on branch
// `fix/sizing-controls-tiles`, not yet in this branch, so these demos keep
// a local wrapper with the same contract. Switch these rows to
// `TouchHitArea` once PR 60 merges and delete the local wrapper.
class _CommandRowHitArea extends StatelessWidget {
  /// Creates a hit-area wrapper with per-side [vertical] expansion.
  const _CommandRowHitArea({required this.vertical, required this.child});

  /// Invisible expansion per side, top and bottom.
  final double vertical;

  /// The 32 px row.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (vertical <= 0) {
      return child;
    }
    if (Theme.of(context).touchTargets == TouchTargets.shrinkWrap) {
      return child;
    }
    if (!isMobile(Theme.of(context).platform)) {
      return child;
    }
    return _CommandHitExpander(vertical: vertical, child: child);
  }
}

/// Render-object expander: same layout size as [child], larger semantics
/// and hit test on touch platforms.
class _CommandHitExpander extends SingleChildRenderObjectWidget {
  /// Creates an expander with per-side [vertical] growth.
  const _CommandHitExpander({required this.vertical, required super.child});

  /// Expansion per side, top and bottom.
  final double vertical;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderCommandHitArea(vertical: vertical);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderCommandHitArea renderObject,
  ) {
    renderObject.vertical = vertical;
  }
}

/// Proxy whose layout size is the child's size, but whose semantics bounds
/// and hit test include the invisible per-side expansion.
///
/// A semantics container that merges non-container descendants (the tap from
/// `Clickable`/`GestureDetector`) into the expanded rect, so the scorecard
/// tap guidelines (which read `SemanticsNode.rect`) see the platform
/// minimum while `tester.getSize` still reports the 32 px visual size.
class _RenderCommandHitArea extends RenderProxyBox
    with SemanticsAnnotationsMixin {
  /// Creates a hit-area proxy with per-side expansion.
  _RenderCommandHitArea({required double vertical})
    // ignore: prefer_initializing_formals
    : _vertical = vertical {
    initSemanticsAnnotations(
      properties: const SemanticsProperties(),
      container: true,
      explicitChildNodes: false,
      excludeSemantics: false,
      blockUserActions: false,
      localeForSubtree: null,
      textDirection: null,
    );
  }

  double _vertical;

  /// Expansion per side, top and bottom.
  double get vertical => _vertical;

  /// Sets the vertical expansion and marks semantics layout dirty when it
  /// changes (the semantics rect derives from it).
  set vertical(double value) {
    if (_vertical == value) {
      return;
    }
    _vertical = value;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  @override
  void performLayout() {
    if (child != null) {
      child!.layout(constraints, parentUsesSize: true);
      size = child!.size;
    } else {
      size = constraints.smallest;
    }
  }

  /// Semantics bounds include the invisible expansion so the scorecard tap
  /// target guidelines (which read `SemanticsNode.rect`) see the platform
  /// minimum while `tester.getSize` still reports the visual size.
  @override
  Rect get semanticBounds {
    if (_vertical <= 0) {
      return Offset.zero & size;
    }
    return Rect.fromLTWH(
      0,
      -_vertical,
      size.width,
      size.height + _vertical * 2,
    );
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (_vertical <= 0) {
      return super.hitTest(result, position: position);
    }
    final Rect expanded = Rect.fromLTWH(
      0,
      -_vertical,
      size.width,
      size.height + _vertical * 2,
    );
    if (!expanded.contains(position)) {
      return false;
    }
    if (child == null) {
      return false;
    }
    // Inside the visual box: normal hit test. In the invisible overflow:
    // forward to the nearest edge so padding taps still press the control.
    final Offset clamped = Offset(
      position.dx.clamp(0.0, size.width),
      position.dy.clamp(0.0, size.height),
    );
    return child!.hitTest(result, position: clamped);
  }
}

/// Commands the palette offers.
List<String> _commandValues = <String>[
  'Calendar',
  'Search Emoji',
  'Launch',
  'Profile',
  'Mail',
  'Settings',
];

/// The palette itself, sized to the stage.
class _CommandPalette extends StatefulWidget {
  const _CommandPalette({this.buildGroups = false});

  final bool buildGroups;

  @override
  State<_CommandPalette> createState() => _CommandPaletteState();
}

class _CommandPaletteState extends State<_CommandPalette> {
  String? _lastCommand;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Center(
      child: SizedBox(
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 300,
              child: Command(
                debounceDuration: Duration.zero,
                builder: (context, query) async* {
                  // Ranked through the shared `primitives/search` ranker —
                  // the same files the `search_bar` component filters
                  // through — instead of a local substring check.
                  final List<String> ranked = rankCommandLabels(
                    _commandValues,
                    query,
                  );
                  final List<Widget> items = <Widget>[];
                  if (!widget.buildGroups) {
                    for (final String value in ranked) {
                      items.add(
                        // SIZING h-8 (32 px) like the menu family; the
                        // hit-test-only wrapper reports the 48 px tap target
                        // without changing layout (switch to TouchHitArea
                        // once PR 60 merges).
                        _CommandRowHitArea(
                          vertical: 8,
                          child: SubFocusListItem(
                            minHeight: 32,
                            title: Text(value),
                            onTap: () => setState(() => _lastCommand = value),
                          ),
                        ),
                      );
                    }
                  } else {
                    for (final String group in <String>[
                      'Suggestions',
                      'Settings',
                    ]) {
                      items.add(
                        // upstream group heading: `px-2 py-1.5 text-xs font-medium`
                        // in the muted colour.
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          child: Text(
                            group,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colors.mutedForeground,
                            ),
                          ),
                        ),
                      );
                      for (final String value in ranked) {
                        items.add(
                          // SIZING h-8 (32 px); hit-test-only 48 px target
                          // via the local wrapper (switch to TouchHitArea
                          // once PR 60 merges).
                          _CommandRowHitArea(
                            vertical: 8,
                            child: SubFocusListItem(
                              minHeight: 32,
                              title: Text(value),
                              onTap: () => setState(() => _lastCommand = value),
                            ),
                          ),
                        );
                      }
                      items.add(SizedBox(height: spacing.sm));
                    }
                  }
                  yield items;
                },
              ),
            ),
            SizedBox(height: spacing.sm),
            Text(
              _lastCommand == null
                  ? 'Run a command to see it here'
                  : 'Ran $_lastCommand',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colors.mutedForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The default palette.
Widget _commandDefault(BuildContext context) => const _CommandPalette();
''',
    ),
    DocsExampleSource(
      name: 'With groups',
      builder: '_commandWithGroups',
      code: r'''import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/platform.dart';
import 'package:<your_app>/ui/dashcn/primitives/subfocus_list_item.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/command/command.dart';

// Temporary hit-test-only 32 -> 48 px expansion for command rows.
//
// SIZING: menu-family rows are 32 px on desktop and mobile alike; touch
// comfort comes from an invisible hit area, never larger visuals. PR 60's
// `touch_hit_area` primitive implements exactly this (hit-test + semantics
// expansion with no layout growth) but lives on branch
// `fix/sizing-controls-tiles`, not yet in this branch, so these demos keep
// a local wrapper with the same contract. Switch these rows to
// `TouchHitArea` once PR 60 merges and delete the local wrapper.
class _CommandRowHitArea extends StatelessWidget {
  /// Creates a hit-area wrapper with per-side [vertical] expansion.
  const _CommandRowHitArea({required this.vertical, required this.child});

  /// Invisible expansion per side, top and bottom.
  final double vertical;

  /// The 32 px row.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (vertical <= 0) {
      return child;
    }
    if (Theme.of(context).touchTargets == TouchTargets.shrinkWrap) {
      return child;
    }
    if (!isMobile(Theme.of(context).platform)) {
      return child;
    }
    return _CommandHitExpander(vertical: vertical, child: child);
  }
}

/// Render-object expander: same layout size as [child], larger semantics
/// and hit test on touch platforms.
class _CommandHitExpander extends SingleChildRenderObjectWidget {
  /// Creates an expander with per-side [vertical] growth.
  const _CommandHitExpander({required this.vertical, required super.child});

  /// Expansion per side, top and bottom.
  final double vertical;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderCommandHitArea(vertical: vertical);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderCommandHitArea renderObject,
  ) {
    renderObject.vertical = vertical;
  }
}

/// Proxy whose layout size is the child's size, but whose semantics bounds
/// and hit test include the invisible per-side expansion.
///
/// A semantics container that merges non-container descendants (the tap from
/// `Clickable`/`GestureDetector`) into the expanded rect, so the scorecard
/// tap guidelines (which read `SemanticsNode.rect`) see the platform
/// minimum while `tester.getSize` still reports the 32 px visual size.
class _RenderCommandHitArea extends RenderProxyBox
    with SemanticsAnnotationsMixin {
  /// Creates a hit-area proxy with per-side expansion.
  _RenderCommandHitArea({required double vertical})
    // ignore: prefer_initializing_formals
    : _vertical = vertical {
    initSemanticsAnnotations(
      properties: const SemanticsProperties(),
      container: true,
      explicitChildNodes: false,
      excludeSemantics: false,
      blockUserActions: false,
      localeForSubtree: null,
      textDirection: null,
    );
  }

  double _vertical;

  /// Expansion per side, top and bottom.
  double get vertical => _vertical;

  /// Sets the vertical expansion and marks semantics layout dirty when it
  /// changes (the semantics rect derives from it).
  set vertical(double value) {
    if (_vertical == value) {
      return;
    }
    _vertical = value;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  @override
  void performLayout() {
    if (child != null) {
      child!.layout(constraints, parentUsesSize: true);
      size = child!.size;
    } else {
      size = constraints.smallest;
    }
  }

  /// Semantics bounds include the invisible expansion so the scorecard tap
  /// target guidelines (which read `SemanticsNode.rect`) see the platform
  /// minimum while `tester.getSize` still reports the visual size.
  @override
  Rect get semanticBounds {
    if (_vertical <= 0) {
      return Offset.zero & size;
    }
    return Rect.fromLTWH(
      0,
      -_vertical,
      size.width,
      size.height + _vertical * 2,
    );
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (_vertical <= 0) {
      return super.hitTest(result, position: position);
    }
    final Rect expanded = Rect.fromLTWH(
      0,
      -_vertical,
      size.width,
      size.height + _vertical * 2,
    );
    if (!expanded.contains(position)) {
      return false;
    }
    if (child == null) {
      return false;
    }
    // Inside the visual box: normal hit test. In the invisible overflow:
    // forward to the nearest edge so padding taps still press the control.
    final Offset clamped = Offset(
      position.dx.clamp(0.0, size.width),
      position.dy.clamp(0.0, size.height),
    );
    return child!.hitTest(result, position: clamped);
  }
}

/// Commands the palette offers.
List<String> _commandValues = <String>[
  'Calendar',
  'Search Emoji',
  'Launch',
  'Profile',
  'Mail',
  'Settings',
];

/// The palette itself, sized to the stage.
class _CommandPalette extends StatefulWidget {
  const _CommandPalette({this.buildGroups = false});

  final bool buildGroups;

  @override
  State<_CommandPalette> createState() => _CommandPaletteState();
}

class _CommandPaletteState extends State<_CommandPalette> {
  String? _lastCommand;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Center(
      child: SizedBox(
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 300,
              child: Command(
                debounceDuration: Duration.zero,
                builder: (context, query) async* {
                  // Ranked through the shared `primitives/search` ranker —
                  // the same files the `search_bar` component filters
                  // through — instead of a local substring check.
                  final List<String> ranked = rankCommandLabels(
                    _commandValues,
                    query,
                  );
                  final List<Widget> items = <Widget>[];
                  if (!widget.buildGroups) {
                    for (final String value in ranked) {
                      items.add(
                        // SIZING h-8 (32 px) like the menu family; the
                        // hit-test-only wrapper reports the 48 px tap target
                        // without changing layout (switch to TouchHitArea
                        // once PR 60 merges).
                        _CommandRowHitArea(
                          vertical: 8,
                          child: SubFocusListItem(
                            minHeight: 32,
                            title: Text(value),
                            onTap: () => setState(() => _lastCommand = value),
                          ),
                        ),
                      );
                    }
                  } else {
                    for (final String group in <String>[
                      'Suggestions',
                      'Settings',
                    ]) {
                      items.add(
                        // upstream group heading: `px-2 py-1.5 text-xs font-medium`
                        // in the muted colour.
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          child: Text(
                            group,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colors.mutedForeground,
                            ),
                          ),
                        ),
                      );
                      for (final String value in ranked) {
                        items.add(
                          // SIZING h-8 (32 px); hit-test-only 48 px target
                          // via the local wrapper (switch to TouchHitArea
                          // once PR 60 merges).
                          _CommandRowHitArea(
                            vertical: 8,
                            child: SubFocusListItem(
                              minHeight: 32,
                              title: Text(value),
                              onTap: () => setState(() => _lastCommand = value),
                            ),
                          ),
                        );
                      }
                      items.add(SizedBox(height: spacing.sm));
                    }
                  }
                  yield items;
                },
              ),
            ),
            SizedBox(height: spacing.sm),
            Text(
              _lastCommand == null
                  ? 'Run a command to see it here'
                  : 'Ran $_lastCommand',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colors.mutedForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The palette with grouped results.
Widget _commandWithGroups(BuildContext context) =>
    const _CommandPalette(buildGroups: true);
''',
    ),
    DocsExampleSource(
      name: 'Dialog',
      builder: '_commandDialog',
      code: r'''import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/platform.dart';
import 'package:<your_app>/ui/dashcn/primitives/subfocus_list_item.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/command/command.dart';

// Temporary hit-test-only 32 -> 48 px expansion for command rows.
//
// SIZING: menu-family rows are 32 px on desktop and mobile alike; touch
// comfort comes from an invisible hit area, never larger visuals. PR 60's
// `touch_hit_area` primitive implements exactly this (hit-test + semantics
// expansion with no layout growth) but lives on branch
// `fix/sizing-controls-tiles`, not yet in this branch, so these demos keep
// a local wrapper with the same contract. Switch these rows to
// `TouchHitArea` once PR 60 merges and delete the local wrapper.
class _CommandRowHitArea extends StatelessWidget {
  /// Creates a hit-area wrapper with per-side [vertical] expansion.
  const _CommandRowHitArea({required this.vertical, required this.child});

  /// Invisible expansion per side, top and bottom.
  final double vertical;

  /// The 32 px row.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (vertical <= 0) {
      return child;
    }
    if (Theme.of(context).touchTargets == TouchTargets.shrinkWrap) {
      return child;
    }
    if (!isMobile(Theme.of(context).platform)) {
      return child;
    }
    return _CommandHitExpander(vertical: vertical, child: child);
  }
}

/// Render-object expander: same layout size as [child], larger semantics
/// and hit test on touch platforms.
class _CommandHitExpander extends SingleChildRenderObjectWidget {
  /// Creates an expander with per-side [vertical] growth.
  const _CommandHitExpander({required this.vertical, required super.child});

  /// Expansion per side, top and bottom.
  final double vertical;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderCommandHitArea(vertical: vertical);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderCommandHitArea renderObject,
  ) {
    renderObject.vertical = vertical;
  }
}

/// Proxy whose layout size is the child's size, but whose semantics bounds
/// and hit test include the invisible per-side expansion.
///
/// A semantics container that merges non-container descendants (the tap from
/// `Clickable`/`GestureDetector`) into the expanded rect, so the scorecard
/// tap guidelines (which read `SemanticsNode.rect`) see the platform
/// minimum while `tester.getSize` still reports the 32 px visual size.
class _RenderCommandHitArea extends RenderProxyBox
    with SemanticsAnnotationsMixin {
  /// Creates a hit-area proxy with per-side expansion.
  _RenderCommandHitArea({required double vertical})
    // ignore: prefer_initializing_formals
    : _vertical = vertical {
    initSemanticsAnnotations(
      properties: const SemanticsProperties(),
      container: true,
      explicitChildNodes: false,
      excludeSemantics: false,
      blockUserActions: false,
      localeForSubtree: null,
      textDirection: null,
    );
  }

  double _vertical;

  /// Expansion per side, top and bottom.
  double get vertical => _vertical;

  /// Sets the vertical expansion and marks semantics layout dirty when it
  /// changes (the semantics rect derives from it).
  set vertical(double value) {
    if (_vertical == value) {
      return;
    }
    _vertical = value;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  @override
  void performLayout() {
    if (child != null) {
      child!.layout(constraints, parentUsesSize: true);
      size = child!.size;
    } else {
      size = constraints.smallest;
    }
  }

  /// Semantics bounds include the invisible expansion so the scorecard tap
  /// target guidelines (which read `SemanticsNode.rect`) see the platform
  /// minimum while `tester.getSize` still reports the visual size.
  @override
  Rect get semanticBounds {
    if (_vertical <= 0) {
      return Offset.zero & size;
    }
    return Rect.fromLTWH(
      0,
      -_vertical,
      size.width,
      size.height + _vertical * 2,
    );
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (_vertical <= 0) {
      return super.hitTest(result, position: position);
    }
    final Rect expanded = Rect.fromLTWH(
      0,
      -_vertical,
      size.width,
      size.height + _vertical * 2,
    );
    if (!expanded.contains(position)) {
      return false;
    }
    if (child == null) {
      return false;
    }
    // Inside the visual box: normal hit test. In the invisible overflow:
    // forward to the nearest edge so padding taps still press the control.
    final Offset clamped = Offset(
      position.dx.clamp(0.0, size.width),
      position.dy.clamp(0.0, size.height),
    );
    return child!.hitTest(result, position: clamped);
  }
}

/// Commands the palette offers.
List<String> _commandValues = <String>[
  'Calendar',
  'Search Emoji',
  'Launch',
  'Profile',
  'Mail',
  'Settings',
];

/// A trigger that opens the palette as a modal dialog with `showCommandDialog`.
class _CommandDialogTrigger extends StatelessWidget {
  const _CommandDialogTrigger();

  Stream<List<Widget>> _results(BuildContext context, String? query) async* {
    final List<String> ranked = rankCommandLabels(_commandValues, query);
    yield <Widget>[
      // SIZING h-8 (32 px); hit-test-only 48 px target (local wrapper until
      // PR 60's TouchHitArea lands).
      for (final String value in ranked)
        _CommandRowHitArea(
          vertical: 8,
          child: SubFocusListItem(minHeight: 32, title: Text(value)),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Button(
      variant: ButtonVariant.outline,
      size: ButtonSize.sm,
      onPressed: () =>
          showCommandDialog<void>(context: context, builder: _results),
      child: Text('Open command palette'),
    );
  }
}

Widget _commandDialog(BuildContext context) => const _CommandDialogTrigger();
''',
    ),
    DocsExampleSource(
      name: 'Customized',
      builder: '_commandCustomized',
      code: r'''import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/platform.dart';
import 'package:<your_app>/ui/dashcn/primitives/subfocus_list_item.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/command/command.dart';

// Temporary hit-test-only 32 -> 48 px expansion for command rows.
//
// SIZING: menu-family rows are 32 px on desktop and mobile alike; touch
// comfort comes from an invisible hit area, never larger visuals. PR 60's
// `touch_hit_area` primitive implements exactly this (hit-test + semantics
// expansion with no layout growth) but lives on branch
// `fix/sizing-controls-tiles`, not yet in this branch, so these demos keep
// a local wrapper with the same contract. Switch these rows to
// `TouchHitArea` once PR 60 merges and delete the local wrapper.
class _CommandRowHitArea extends StatelessWidget {
  /// Creates a hit-area wrapper with per-side [vertical] expansion.
  const _CommandRowHitArea({required this.vertical, required this.child});

  /// Invisible expansion per side, top and bottom.
  final double vertical;

  /// The 32 px row.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (vertical <= 0) {
      return child;
    }
    if (Theme.of(context).touchTargets == TouchTargets.shrinkWrap) {
      return child;
    }
    if (!isMobile(Theme.of(context).platform)) {
      return child;
    }
    return _CommandHitExpander(vertical: vertical, child: child);
  }
}

/// Render-object expander: same layout size as [child], larger semantics
/// and hit test on touch platforms.
class _CommandHitExpander extends SingleChildRenderObjectWidget {
  /// Creates an expander with per-side [vertical] growth.
  const _CommandHitExpander({required this.vertical, required super.child});

  /// Expansion per side, top and bottom.
  final double vertical;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderCommandHitArea(vertical: vertical);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderCommandHitArea renderObject,
  ) {
    renderObject.vertical = vertical;
  }
}

/// Proxy whose layout size is the child's size, but whose semantics bounds
/// and hit test include the invisible per-side expansion.
///
/// A semantics container that merges non-container descendants (the tap from
/// `Clickable`/`GestureDetector`) into the expanded rect, so the scorecard
/// tap guidelines (which read `SemanticsNode.rect`) see the platform
/// minimum while `tester.getSize` still reports the 32 px visual size.
class _RenderCommandHitArea extends RenderProxyBox
    with SemanticsAnnotationsMixin {
  /// Creates a hit-area proxy with per-side expansion.
  _RenderCommandHitArea({required double vertical})
    // ignore: prefer_initializing_formals
    : _vertical = vertical {
    initSemanticsAnnotations(
      properties: const SemanticsProperties(),
      container: true,
      explicitChildNodes: false,
      excludeSemantics: false,
      blockUserActions: false,
      localeForSubtree: null,
      textDirection: null,
    );
  }

  double _vertical;

  /// Expansion per side, top and bottom.
  double get vertical => _vertical;

  /// Sets the vertical expansion and marks semantics layout dirty when it
  /// changes (the semantics rect derives from it).
  set vertical(double value) {
    if (_vertical == value) {
      return;
    }
    _vertical = value;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  @override
  void performLayout() {
    if (child != null) {
      child!.layout(constraints, parentUsesSize: true);
      size = child!.size;
    } else {
      size = constraints.smallest;
    }
  }

  /// Semantics bounds include the invisible expansion so the scorecard tap
  /// target guidelines (which read `SemanticsNode.rect`) see the platform
  /// minimum while `tester.getSize` still reports the visual size.
  @override
  Rect get semanticBounds {
    if (_vertical <= 0) {
      return Offset.zero & size;
    }
    return Rect.fromLTWH(
      0,
      -_vertical,
      size.width,
      size.height + _vertical * 2,
    );
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (_vertical <= 0) {
      return super.hitTest(result, position: position);
    }
    final Rect expanded = Rect.fromLTWH(
      0,
      -_vertical,
      size.width,
      size.height + _vertical * 2,
    );
    if (!expanded.contains(position)) {
      return false;
    }
    if (child == null) {
      return false;
    }
    // Inside the visual box: normal hit test. In the invisible overflow:
    // forward to the nearest edge so padding taps still press the control.
    final Offset clamped = Offset(
      position.dx.clamp(0.0, size.width),
      position.dy.clamp(0.0, size.height),
    );
    return child!.hitTest(result, position: clamped);
  }
}

/// Commands the palette offers.
List<String> _commandValues = <String>[
  'Calendar',
  'Search Emoji',
  'Launch',
  'Profile',
  'Mail',
  'Settings',
];

/// A customized palette: widget-leg theme override (muted tint that stays
/// readable in light and dark mode).
Widget _commandCustomized(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 320,
      child: SizedBox(
        height: 300,
        child: Command(
          debounceDuration: Duration.zero,
          theme: const CommandTheme(
            background: ThemedColor.ref(ColorRef.muted),
          ),
          builder: (context, query) async* {
            final List<String> ranked = rankCommandLabels(
              _commandValues,
              query,
            );
            yield <Widget>[
              // SIZING h-8 (32 px); hit-test-only 48 px target (local
              // wrapper until PR 60's TouchHitArea lands).
              for (final String value in ranked)
                _CommandRowHitArea(
                  vertical: 8,
                  child: SubFocusListItem(minHeight: 32, title: Text(value)),
                ),
            ];
          },
        ),
      ),
    ),
  );
}
''',
    ),
  ],
  'context_menu': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_contextMenuDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/context_menu/context_menu.dart';

/// Visible gesture hint: an icon plus the platform's open gesture.
///
/// Touch platforms read "Long-press …", desktop reads "Right-click …", and
/// the caption always names both so the demo is discoverable either way.
class _GestureHint extends StatelessWidget {
  const _GestureHint({required this.action});

  /// What the hinted surface does, e.g. 'this card'.
  final String action;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TargetPlatform platform = theme.platform;
    final bool touch =
        platform == TargetPlatform.iOS ||
        platform == TargetPlatform.android ||
        platform == TargetPlatform.fuchsia;
    // Short lines on purpose: the hint must stay inside the 232px card
    // content on every font (widget-test fonts run wider than Inter).
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              touch ? LucideIcons.hand : LucideIcons.mousePointerClick,
              size: 14,
              color: theme.colors.foreground,
            ),
            SizedBox(width: theme.spacing.xs),
            Flexible(
              child: Text(
                '${touch ? 'Long-press' : 'Right-click'} $action',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: theme.colors.foreground,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: theme.spacing.xs),
        Text(
          'Desktop: right-click · touch: long-press',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

class _ContextMenuSurface extends StatefulWidget {
  const _ContextMenuSurface({
    this.hintAction = 'here',
    this.targetPadding = const EdgeInsets.all(8),
    this.minTargetSize = kContextMenuMinTargetSize,
    this.menuMinWidth,
    this.menuMaxWidth,
    this.popupTheme,
    this.withSubmenu = false,
    this.child,
    this.showTargetOutline = false,
  });

  final String hintAction;
  final EdgeInsetsGeometry targetPadding;
  final double? minTargetSize;
  final double? menuMinWidth;
  final double? menuMaxWidth;
  final MenuPopupTheme? popupTheme;
  final bool withSubmenu;
  final bool showTargetOutline;

  /// Custom trigger child; null draws the default card.
  final Widget? child;

  @override
  State<_ContextMenuSurface> createState() => _ContextMenuSurfaceState();
}

class _ContextMenuSurfaceState extends State<_ContextMenuSurface> {
  String? _lastAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget trigger =
        widget.child ??
        Container(
          width: 280,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(color: theme.colors.border),
            borderRadius: theme.borderRadiusMd,
          ),
          child: _GestureHint(action: widget.hintAction),
        );
    if (widget.showTargetOutline) {
      // The muted wash marks the padded hit region around the child so the
      // expanded target is visible, not just larger.
      trigger = Container(
        padding: widget.targetPadding,
        decoration: BoxDecoration(
          color: theme.colors.muted,
          borderRadius: theme.borderRadiusMd,
        ),
        child: trigger,
      );
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Custom-child demos (e.g. the bare touch icon) label the trigger
          // with the same gesture hint the cards carry inside.
          if (widget.child != null) ...<Widget>[
            _GestureHint(action: widget.hintAction),
            SizedBox(height: theme.spacing.md),
          ],
          ContextMenu(
            targetPadding: widget.showTargetOutline
                ? EdgeInsets.zero
                : widget.targetPadding,
            minTargetSize: widget.minTargetSize,
            menuMinWidth: widget.menuMinWidth,
            menuMaxWidth: widget.menuMaxWidth,
            popupTheme: widget.popupTheme,
            semanticsLabel: 'Actions for ${widget.hintAction}',
            items: <Widget>[
              MenuButton(
                child: Text('Back'),
                onPressed: (_) => _run('Went back'),
              ),
              MenuButton(
                child: Text('Reload'),
                onPressed: (_) =>
                    _run('Reloaded the page'),
              ),
              MenuButton(
                trailing: MenuShortcut(shortcut: '⌘C'),
                child: Text('Copy link'),
                onPressed: (_) => _run('Copied the link'),
              ),
              const MenuSeparator(),
              MenuButton(
                trailing: const Icon(LucideIcons.chevronRight, size: 14),
                enabled: widget.withSubmenu,
                child: Text('More tools'),
                onPressed: (_) {},
              ),
              MenuButton(
                enabled: false,
                child: Text('Inspect'),
                onPressed: (_) {},
              ),
            ],
            child: trigger,
          ),
          SizedBox(height: theme.spacing.md),
          Text(
            _lastAction ??
                  'Pick an action from the menu',
            style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
          ),
        ],
      ),
    );
  }

  void _run(String action) => setState(() => _lastAction = action);
}

/// The default context menu surface.
Widget _contextMenuDefault(BuildContext context) => const _ContextMenuSurface();
''',
    ),
    DocsExampleSource(
      name: 'With submenu',
      builder: '_contextMenuWithSubmenu',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/context_menu/context_menu.dart';

/// Visible gesture hint: an icon plus the platform's open gesture.
///
/// Touch platforms read "Long-press …", desktop reads "Right-click …", and
/// the caption always names both so the demo is discoverable either way.
class _GestureHint extends StatelessWidget {
  const _GestureHint({required this.action});

  /// What the hinted surface does, e.g. 'this card'.
  final String action;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TargetPlatform platform = theme.platform;
    final bool touch =
        platform == TargetPlatform.iOS ||
        platform == TargetPlatform.android ||
        platform == TargetPlatform.fuchsia;
    // Short lines on purpose: the hint must stay inside the 232px card
    // content on every font (widget-test fonts run wider than Inter).
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              touch ? LucideIcons.hand : LucideIcons.mousePointerClick,
              size: 14,
              color: theme.colors.foreground,
            ),
            SizedBox(width: theme.spacing.xs),
            Flexible(
              child: Text(
                '${touch ? 'Long-press' : 'Right-click'} $action',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: theme.colors.foreground,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: theme.spacing.xs),
        Text(
          'Desktop: right-click · touch: long-press',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

class _ContextMenuSurface extends StatefulWidget {
  const _ContextMenuSurface({
    this.hintAction = 'here',
    this.targetPadding = const EdgeInsets.all(8),
    this.minTargetSize = kContextMenuMinTargetSize,
    this.menuMinWidth,
    this.menuMaxWidth,
    this.popupTheme,
    this.withSubmenu = false,
    this.child,
    this.showTargetOutline = false,
  });

  final String hintAction;
  final EdgeInsetsGeometry targetPadding;
  final double? minTargetSize;
  final double? menuMinWidth;
  final double? menuMaxWidth;
  final MenuPopupTheme? popupTheme;
  final bool withSubmenu;
  final bool showTargetOutline;

  /// Custom trigger child; null draws the default card.
  final Widget? child;

  @override
  State<_ContextMenuSurface> createState() => _ContextMenuSurfaceState();
}

class _ContextMenuSurfaceState extends State<_ContextMenuSurface> {
  String? _lastAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget trigger =
        widget.child ??
        Container(
          width: 280,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(color: theme.colors.border),
            borderRadius: theme.borderRadiusMd,
          ),
          child: _GestureHint(action: widget.hintAction),
        );
    if (widget.showTargetOutline) {
      // The muted wash marks the padded hit region around the child so the
      // expanded target is visible, not just larger.
      trigger = Container(
        padding: widget.targetPadding,
        decoration: BoxDecoration(
          color: theme.colors.muted,
          borderRadius: theme.borderRadiusMd,
        ),
        child: trigger,
      );
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Custom-child demos (e.g. the bare touch icon) label the trigger
          // with the same gesture hint the cards carry inside.
          if (widget.child != null) ...<Widget>[
            _GestureHint(action: widget.hintAction),
            SizedBox(height: theme.spacing.md),
          ],
          ContextMenu(
            targetPadding: widget.showTargetOutline
                ? EdgeInsets.zero
                : widget.targetPadding,
            minTargetSize: widget.minTargetSize,
            menuMinWidth: widget.menuMinWidth,
            menuMaxWidth: widget.menuMaxWidth,
            popupTheme: widget.popupTheme,
            semanticsLabel: 'Actions for ${widget.hintAction}',
            items: <Widget>[
              MenuButton(
                child: Text('Back'),
                onPressed: (_) => _run('Went back'),
              ),
              MenuButton(
                child: Text('Reload'),
                onPressed: (_) =>
                    _run('Reloaded the page'),
              ),
              MenuButton(
                trailing: MenuShortcut(shortcut: '⌘C'),
                child: Text('Copy link'),
                onPressed: (_) => _run('Copied the link'),
              ),
              const MenuSeparator(),
              MenuButton(
                trailing: const Icon(LucideIcons.chevronRight, size: 14),
                enabled: widget.withSubmenu,
                child: Text('More tools'),
                onPressed: (_) {},
              ),
              MenuButton(
                enabled: false,
                child: Text('Inspect'),
                onPressed: (_) {},
              ),
            ],
            child: trigger,
          ),
          SizedBox(height: theme.spacing.md),
          Text(
            _lastAction ??
                  'Pick an action from the menu',
            style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
          ),
        ],
      ),
    );
  }

  void _run(String action) => setState(() => _lastAction = action);
}

/// A surface whose menu row opens a submenu.
Widget _contextMenuWithSubmenu(BuildContext context) => _ContextMenuSurface(
  hintAction: 'this card',
  withSubmenu: true,
);
''',
    ),
    DocsExampleSource(
      name: 'Touch target',
      builder: '_contextMenuTouchTarget',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/context_menu/context_menu.dart';

/// Visible gesture hint: an icon plus the platform's open gesture.
///
/// Touch platforms read "Long-press …", desktop reads "Right-click …", and
/// the caption always names both so the demo is discoverable either way.
class _GestureHint extends StatelessWidget {
  const _GestureHint({required this.action});

  /// What the hinted surface does, e.g. 'this card'.
  final String action;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TargetPlatform platform = theme.platform;
    final bool touch =
        platform == TargetPlatform.iOS ||
        platform == TargetPlatform.android ||
        platform == TargetPlatform.fuchsia;
    // Short lines on purpose: the hint must stay inside the 232px card
    // content on every font (widget-test fonts run wider than Inter).
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              touch ? LucideIcons.hand : LucideIcons.mousePointerClick,
              size: 14,
              color: theme.colors.foreground,
            ),
            SizedBox(width: theme.spacing.xs),
            Flexible(
              child: Text(
                '${touch ? 'Long-press' : 'Right-click'} $action',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: theme.colors.foreground,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: theme.spacing.xs),
        Text(
          'Desktop: right-click · touch: long-press',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

class _ContextMenuSurface extends StatefulWidget {
  const _ContextMenuSurface({
    this.hintAction = 'here',
    this.targetPadding = const EdgeInsets.all(8),
    this.minTargetSize = kContextMenuMinTargetSize,
    this.menuMinWidth,
    this.menuMaxWidth,
    this.popupTheme,
    this.withSubmenu = false,
    this.child,
    this.showTargetOutline = false,
  });

  final String hintAction;
  final EdgeInsetsGeometry targetPadding;
  final double? minTargetSize;
  final double? menuMinWidth;
  final double? menuMaxWidth;
  final MenuPopupTheme? popupTheme;
  final bool withSubmenu;
  final bool showTargetOutline;

  /// Custom trigger child; null draws the default card.
  final Widget? child;

  @override
  State<_ContextMenuSurface> createState() => _ContextMenuSurfaceState();
}

class _ContextMenuSurfaceState extends State<_ContextMenuSurface> {
  String? _lastAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget trigger =
        widget.child ??
        Container(
          width: 280,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(color: theme.colors.border),
            borderRadius: theme.borderRadiusMd,
          ),
          child: _GestureHint(action: widget.hintAction),
        );
    if (widget.showTargetOutline) {
      // The muted wash marks the padded hit region around the child so the
      // expanded target is visible, not just larger.
      trigger = Container(
        padding: widget.targetPadding,
        decoration: BoxDecoration(
          color: theme.colors.muted,
          borderRadius: theme.borderRadiusMd,
        ),
        child: trigger,
      );
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Custom-child demos (e.g. the bare touch icon) label the trigger
          // with the same gesture hint the cards carry inside.
          if (widget.child != null) ...<Widget>[
            _GestureHint(action: widget.hintAction),
            SizedBox(height: theme.spacing.md),
          ],
          ContextMenu(
            targetPadding: widget.showTargetOutline
                ? EdgeInsets.zero
                : widget.targetPadding,
            minTargetSize: widget.minTargetSize,
            menuMinWidth: widget.menuMinWidth,
            menuMaxWidth: widget.menuMaxWidth,
            popupTheme: widget.popupTheme,
            semanticsLabel: 'Actions for ${widget.hintAction}',
            items: <Widget>[
              MenuButton(
                child: Text('Back'),
                onPressed: (_) => _run('Went back'),
              ),
              MenuButton(
                child: Text('Reload'),
                onPressed: (_) =>
                    _run('Reloaded the page'),
              ),
              MenuButton(
                trailing: MenuShortcut(shortcut: '⌘C'),
                child: Text('Copy link'),
                onPressed: (_) => _run('Copied the link'),
              ),
              const MenuSeparator(),
              MenuButton(
                trailing: const Icon(LucideIcons.chevronRight, size: 14),
                enabled: widget.withSubmenu,
                child: Text('More tools'),
                onPressed: (_) {},
              ),
              MenuButton(
                enabled: false,
                child: Text('Inspect'),
                onPressed: (_) {},
              ),
            ],
            child: trigger,
          ),
          SizedBox(height: theme.spacing.md),
          Text(
            _lastAction ??
                  'Pick an action from the menu',
            style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
          ),
        ],
      ),
    );
  }

  void _run(String action) => setState(() => _lastAction = action);
}

/// A 24px icon trigger: the 48px touch floor keeps it hittable on mobile.
Widget _contextMenuTouchTarget(BuildContext context) {
  final ThemeData theme = Theme.of(context);
  return _ContextMenuSurface(
    hintAction: 'the icon',
    // The 48px touch floor is the point of this demo: pass it explicitly.
    minTargetSize: kContextMenuMinTargetSize,
    child: Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        border: Border.all(color: theme.colors.border),
        borderRadius: theme.borderRadiusSm,
      ),
      child: Icon(LucideIcons.hand, size: 14, color: theme.colors.foreground),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Expanded target',
      builder: '_contextMenuExpandedTarget',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/context_menu/context_menu.dart';

/// Visible gesture hint: an icon plus the platform's open gesture.
///
/// Touch platforms read "Long-press …", desktop reads "Right-click …", and
/// the caption always names both so the demo is discoverable either way.
class _GestureHint extends StatelessWidget {
  const _GestureHint({required this.action});

  /// What the hinted surface does, e.g. 'this card'.
  final String action;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TargetPlatform platform = theme.platform;
    final bool touch =
        platform == TargetPlatform.iOS ||
        platform == TargetPlatform.android ||
        platform == TargetPlatform.fuchsia;
    // Short lines on purpose: the hint must stay inside the 232px card
    // content on every font (widget-test fonts run wider than Inter).
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              touch ? LucideIcons.hand : LucideIcons.mousePointerClick,
              size: 14,
              color: theme.colors.foreground,
            ),
            SizedBox(width: theme.spacing.xs),
            Flexible(
              child: Text(
                '${touch ? 'Long-press' : 'Right-click'} $action',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: theme.colors.foreground,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: theme.spacing.xs),
        Text(
          'Desktop: right-click · touch: long-press',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

class _ContextMenuSurface extends StatefulWidget {
  const _ContextMenuSurface({
    this.hintAction = 'here',
    this.targetPadding = const EdgeInsets.all(8),
    this.minTargetSize = kContextMenuMinTargetSize,
    this.menuMinWidth,
    this.menuMaxWidth,
    this.popupTheme,
    this.withSubmenu = false,
    this.child,
    this.showTargetOutline = false,
  });

  final String hintAction;
  final EdgeInsetsGeometry targetPadding;
  final double? minTargetSize;
  final double? menuMinWidth;
  final double? menuMaxWidth;
  final MenuPopupTheme? popupTheme;
  final bool withSubmenu;
  final bool showTargetOutline;

  /// Custom trigger child; null draws the default card.
  final Widget? child;

  @override
  State<_ContextMenuSurface> createState() => _ContextMenuSurfaceState();
}

class _ContextMenuSurfaceState extends State<_ContextMenuSurface> {
  String? _lastAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget trigger =
        widget.child ??
        Container(
          width: 280,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(color: theme.colors.border),
            borderRadius: theme.borderRadiusMd,
          ),
          child: _GestureHint(action: widget.hintAction),
        );
    if (widget.showTargetOutline) {
      // The muted wash marks the padded hit region around the child so the
      // expanded target is visible, not just larger.
      trigger = Container(
        padding: widget.targetPadding,
        decoration: BoxDecoration(
          color: theme.colors.muted,
          borderRadius: theme.borderRadiusMd,
        ),
        child: trigger,
      );
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Custom-child demos (e.g. the bare touch icon) label the trigger
          // with the same gesture hint the cards carry inside.
          if (widget.child != null) ...<Widget>[
            _GestureHint(action: widget.hintAction),
            SizedBox(height: theme.spacing.md),
          ],
          ContextMenu(
            targetPadding: widget.showTargetOutline
                ? EdgeInsets.zero
                : widget.targetPadding,
            minTargetSize: widget.minTargetSize,
            menuMinWidth: widget.menuMinWidth,
            menuMaxWidth: widget.menuMaxWidth,
            popupTheme: widget.popupTheme,
            semanticsLabel: 'Actions for ${widget.hintAction}',
            items: <Widget>[
              MenuButton(
                child: Text('Back'),
                onPressed: (_) => _run('Went back'),
              ),
              MenuButton(
                child: Text('Reload'),
                onPressed: (_) =>
                    _run('Reloaded the page'),
              ),
              MenuButton(
                trailing: MenuShortcut(shortcut: '⌘C'),
                child: Text('Copy link'),
                onPressed: (_) => _run('Copied the link'),
              ),
              const MenuSeparator(),
              MenuButton(
                trailing: const Icon(LucideIcons.chevronRight, size: 14),
                enabled: widget.withSubmenu,
                child: Text('More tools'),
                onPressed: (_) {},
              ),
              MenuButton(
                enabled: false,
                child: Text('Inspect'),
                onPressed: (_) {},
              ),
            ],
            child: trigger,
          ),
          SizedBox(height: theme.spacing.md),
          Text(
            _lastAction ??
                  'Pick an action from the menu',
            style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
          ),
        ],
      ),
    );
  }

  void _run(String action) => setState(() => _lastAction = action);
}

/// The padded hit region, drawn as a muted wash around the card.
Widget _contextMenuExpandedTarget(BuildContext context) => _ContextMenuSurface(
  hintAction: 'the wash',
  targetPadding: EdgeInsets.all(28),
  showTargetOutline: true,
);
''',
    ),
    DocsExampleSource(
      name: 'Compact menu',
      builder: '_contextMenuCompactMenu',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/context_menu/context_menu.dart';

/// Visible gesture hint: an icon plus the platform's open gesture.
///
/// Touch platforms read "Long-press …", desktop reads "Right-click …", and
/// the caption always names both so the demo is discoverable either way.
class _GestureHint extends StatelessWidget {
  const _GestureHint({required this.action});

  /// What the hinted surface does, e.g. 'this card'.
  final String action;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TargetPlatform platform = theme.platform;
    final bool touch =
        platform == TargetPlatform.iOS ||
        platform == TargetPlatform.android ||
        platform == TargetPlatform.fuchsia;
    // Short lines on purpose: the hint must stay inside the 232px card
    // content on every font (widget-test fonts run wider than Inter).
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              touch ? LucideIcons.hand : LucideIcons.mousePointerClick,
              size: 14,
              color: theme.colors.foreground,
            ),
            SizedBox(width: theme.spacing.xs),
            Flexible(
              child: Text(
                '${touch ? 'Long-press' : 'Right-click'} $action',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: theme.colors.foreground,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: theme.spacing.xs),
        Text(
          'Desktop: right-click · touch: long-press',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

class _ContextMenuSurface extends StatefulWidget {
  const _ContextMenuSurface({
    this.hintAction = 'here',
    this.targetPadding = const EdgeInsets.all(8),
    this.minTargetSize = kContextMenuMinTargetSize,
    this.menuMinWidth,
    this.menuMaxWidth,
    this.popupTheme,
    this.withSubmenu = false,
    this.child,
    this.showTargetOutline = false,
  });

  final String hintAction;
  final EdgeInsetsGeometry targetPadding;
  final double? minTargetSize;
  final double? menuMinWidth;
  final double? menuMaxWidth;
  final MenuPopupTheme? popupTheme;
  final bool withSubmenu;
  final bool showTargetOutline;

  /// Custom trigger child; null draws the default card.
  final Widget? child;

  @override
  State<_ContextMenuSurface> createState() => _ContextMenuSurfaceState();
}

class _ContextMenuSurfaceState extends State<_ContextMenuSurface> {
  String? _lastAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget trigger =
        widget.child ??
        Container(
          width: 280,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(color: theme.colors.border),
            borderRadius: theme.borderRadiusMd,
          ),
          child: _GestureHint(action: widget.hintAction),
        );
    if (widget.showTargetOutline) {
      // The muted wash marks the padded hit region around the child so the
      // expanded target is visible, not just larger.
      trigger = Container(
        padding: widget.targetPadding,
        decoration: BoxDecoration(
          color: theme.colors.muted,
          borderRadius: theme.borderRadiusMd,
        ),
        child: trigger,
      );
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Custom-child demos (e.g. the bare touch icon) label the trigger
          // with the same gesture hint the cards carry inside.
          if (widget.child != null) ...<Widget>[
            _GestureHint(action: widget.hintAction),
            SizedBox(height: theme.spacing.md),
          ],
          ContextMenu(
            targetPadding: widget.showTargetOutline
                ? EdgeInsets.zero
                : widget.targetPadding,
            minTargetSize: widget.minTargetSize,
            menuMinWidth: widget.menuMinWidth,
            menuMaxWidth: widget.menuMaxWidth,
            popupTheme: widget.popupTheme,
            semanticsLabel: 'Actions for ${widget.hintAction}',
            items: <Widget>[
              MenuButton(
                child: Text('Back'),
                onPressed: (_) => _run('Went back'),
              ),
              MenuButton(
                child: Text('Reload'),
                onPressed: (_) =>
                    _run('Reloaded the page'),
              ),
              MenuButton(
                trailing: MenuShortcut(shortcut: '⌘C'),
                child: Text('Copy link'),
                onPressed: (_) => _run('Copied the link'),
              ),
              const MenuSeparator(),
              MenuButton(
                trailing: const Icon(LucideIcons.chevronRight, size: 14),
                enabled: widget.withSubmenu,
                child: Text('More tools'),
                onPressed: (_) {},
              ),
              MenuButton(
                enabled: false,
                child: Text('Inspect'),
                onPressed: (_) {},
              ),
            ],
            child: trigger,
          ),
          SizedBox(height: theme.spacing.md),
          Text(
            _lastAction ??
                  'Pick an action from the menu',
            style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
          ),
        ],
      ),
    );
  }

  void _run(String action) => setState(() => _lastAction = action);
}

/// A customized menu: clamped width plus a per-instance surface override.
Widget _contextMenuCompactMenu(BuildContext context) => _ContextMenuSurface(
  hintAction: 'this card',
  menuMinWidth: 200,
  menuMaxWidth: 240,
  popupTheme: MenuPopupTheme(padding: EdgeInsetsDensity.pxAll(8)),
);
''',
    ),
  ],
  'dropdown_menu': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_dropdownMenuDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/overlay.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/dropdown_menu/dropdown_menu.dart';

/// The menu surface, 220px wide like the docs page shows it.
class _DropdownMenuDropdown extends StatefulWidget {
  const _DropdownMenuDropdown({
    this.withShortcut = false,
    this.withCheckbox = false,
  });

  final bool withShortcut;
  final bool withCheckbox;

  @override
  State<_DropdownMenuDropdown> createState() => _DropdownMenuDropdownState();
}

class _DropdownMenuDropdownState extends State<_DropdownMenuDropdown> {
  String _lastAction = 'Pick a row';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // P7-TH1: centred column — the 220px menu stays centred through the
    // inner `Center`, and the status line centres under it (a `start`
    // column would strand the status at x=0 once the `Center` expands the
    // column to the full stage width).
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: 220,
            child: DropdownMenu(
              children: <Widget>[
                MenuButton(
                  child: Text('Profile'),
                  onPressed: (_) =>
                      _run('Opened the profile'),
                ),
                MenuButton(
                  child: Text('Settings'),
                  onPressed: (_) =>
                      _run('Opened settings'),
                ),
                const MenuSeparator(),
                if (widget.withShortcut)
                  MenuButton(
                    trailing: MenuShortcut(shortcut: '⌘Q'),
                    child: Text('Sign out'),
                    onPressed: (_) => _run('Signed out'),
                  )
                else
                  MenuButton(
                    child: Text('Sign out'),
                    onPressed: (_) => _run('Signed out'),
                  ),
                if (widget.withCheckbox) ...<Widget>[
                  const MenuSeparator(),
                  MenuButton(
                    trailing: Text(_statusBar ? 'on' : 'off'),
                    child: Text('Show status bar'),
                    onPressed: (_) => setState(() => _statusBar = !_statusBar),
                  ),
                  MenuButton(
                    trailing: Text(_bookmarks ? 'on' : 'off'),
                    child: Text('Show bookmarks bar'),
                    onPressed: (_) => setState(() => _bookmarks = !_bookmarks),
                  ),
                ],
              ],
            ),
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          _lastAction,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }

  bool _statusBar = true;
  bool _bookmarks = false;

  void _run(String action) => setState(() => _lastAction = action);
}

/// The default menu.
Widget _dropdownMenuDefault(BuildContext context) =>
    const _DropdownMenuDropdown();
''',
    ),
    DocsExampleSource(
      name: 'With shortcut',
      builder: '_dropdownMenuWithShortcut',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/overlay.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/dropdown_menu/dropdown_menu.dart';

/// The menu surface, 220px wide like the docs page shows it.
class _DropdownMenuDropdown extends StatefulWidget {
  const _DropdownMenuDropdown({
    this.withShortcut = false,
    this.withCheckbox = false,
  });

  final bool withShortcut;
  final bool withCheckbox;

  @override
  State<_DropdownMenuDropdown> createState() => _DropdownMenuDropdownState();
}

class _DropdownMenuDropdownState extends State<_DropdownMenuDropdown> {
  String _lastAction = 'Pick a row';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // P7-TH1: centred column — the 220px menu stays centred through the
    // inner `Center`, and the status line centres under it (a `start`
    // column would strand the status at x=0 once the `Center` expands the
    // column to the full stage width).
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: 220,
            child: DropdownMenu(
              children: <Widget>[
                MenuButton(
                  child: Text('Profile'),
                  onPressed: (_) =>
                      _run('Opened the profile'),
                ),
                MenuButton(
                  child: Text('Settings'),
                  onPressed: (_) =>
                      _run('Opened settings'),
                ),
                const MenuSeparator(),
                if (widget.withShortcut)
                  MenuButton(
                    trailing: MenuShortcut(shortcut: '⌘Q'),
                    child: Text('Sign out'),
                    onPressed: (_) => _run('Signed out'),
                  )
                else
                  MenuButton(
                    child: Text('Sign out'),
                    onPressed: (_) => _run('Signed out'),
                  ),
                if (widget.withCheckbox) ...<Widget>[
                  const MenuSeparator(),
                  MenuButton(
                    trailing: Text(_statusBar ? 'on' : 'off'),
                    child: Text('Show status bar'),
                    onPressed: (_) => setState(() => _statusBar = !_statusBar),
                  ),
                  MenuButton(
                    trailing: Text(_bookmarks ? 'on' : 'off'),
                    child: Text('Show bookmarks bar'),
                    onPressed: (_) => setState(() => _bookmarks = !_bookmarks),
                  ),
                ],
              ],
            ),
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          _lastAction,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }

  bool _statusBar = true;
  bool _bookmarks = false;

  void _run(String action) => setState(() => _lastAction = action);
}

/// A menu with keyboard shortcuts.
Widget _dropdownMenuWithShortcut(BuildContext context) =>
    const _DropdownMenuDropdown(withShortcut: true);
''',
    ),
    DocsExampleSource(
      name: 'With checkbox item',
      builder: '_dropdownMenuWithCheckboxItem',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/overlay.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/dropdown_menu/dropdown_menu.dart';

/// The menu surface, 220px wide like the docs page shows it.
class _DropdownMenuDropdown extends StatefulWidget {
  const _DropdownMenuDropdown({
    this.withShortcut = false,
    this.withCheckbox = false,
  });

  final bool withShortcut;
  final bool withCheckbox;

  @override
  State<_DropdownMenuDropdown> createState() => _DropdownMenuDropdownState();
}

class _DropdownMenuDropdownState extends State<_DropdownMenuDropdown> {
  String _lastAction = 'Pick a row';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // P7-TH1: centred column — the 220px menu stays centred through the
    // inner `Center`, and the status line centres under it (a `start`
    // column would strand the status at x=0 once the `Center` expands the
    // column to the full stage width).
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: 220,
            child: DropdownMenu(
              children: <Widget>[
                MenuButton(
                  child: Text('Profile'),
                  onPressed: (_) =>
                      _run('Opened the profile'),
                ),
                MenuButton(
                  child: Text('Settings'),
                  onPressed: (_) =>
                      _run('Opened settings'),
                ),
                const MenuSeparator(),
                if (widget.withShortcut)
                  MenuButton(
                    trailing: MenuShortcut(shortcut: '⌘Q'),
                    child: Text('Sign out'),
                    onPressed: (_) => _run('Signed out'),
                  )
                else
                  MenuButton(
                    child: Text('Sign out'),
                    onPressed: (_) => _run('Signed out'),
                  ),
                if (widget.withCheckbox) ...<Widget>[
                  const MenuSeparator(),
                  MenuButton(
                    trailing: Text(_statusBar ? 'on' : 'off'),
                    child: Text('Show status bar'),
                    onPressed: (_) => setState(() => _statusBar = !_statusBar),
                  ),
                  MenuButton(
                    trailing: Text(_bookmarks ? 'on' : 'off'),
                    child: Text('Show bookmarks bar'),
                    onPressed: (_) => setState(() => _bookmarks = !_bookmarks),
                  ),
                ],
              ],
            ),
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          _lastAction,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }

  bool _statusBar = true;
  bool _bookmarks = false;

  void _run(String action) => setState(() => _lastAction = action);
}

/// A menu with checkbox-style rows.
Widget _dropdownMenuWithCheckboxItem(BuildContext context) =>
    const _DropdownMenuDropdown(withCheckbox: true);
''',
    ),
    DocsExampleSource(
      name: 'Trigger',
      builder: '_dropdownMenuTriggerExample',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/overlay.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/dropdown_menu/dropdown_menu.dart';

/// A trigger that anchors the menu with `showDropdown`.
class _DropdownMenuTrigger extends StatelessWidget {
  const _DropdownMenuTrigger();

  @override
  Widget build(BuildContext context) {
    return Button(
      variant: ButtonVariant.outline,
      size: ButtonSize.sm,
      onPressed: () => showDropdown<void>(
        context: context,
        children: <Widget>[
          MenuButton(
            child: Text('Profile'),
            onPressed: (_) =>
                closeOverlay(context, 'Profile'),
          ),
          MenuButton(
            child: Text('Settings'),
            onPressed: (_) =>
                closeOverlay(context, 'Settings'),
          ),
          const MenuSeparator(),
          MenuButton(
            trailing: MenuShortcut(shortcut: '⌘Q'),
            child: Text('Sign out'),
            onPressed: (_) =>
                closeOverlay(context, 'Sign out'),
          ),
        ],
      ),
      child: Text('Open menu'),
    );
  }
}

/// An anchored dropdown opened from a button.
Widget _dropdownMenuTriggerExample(BuildContext context) =>
    const _DropdownMenuTrigger();
''',
    ),
    DocsExampleSource(
      name: 'Customized',
      builder: '_dropdownMenuCustomized',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/overlay.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/dropdown_menu/dropdown_menu.dart';

/// A customized surface: widget-leg theme override (tinted fill).
Widget _dropdownMenuCustomized(BuildContext context) {
  return SizedBox(
    width: 220,
    child: DropdownMenu(
      theme: MenuPopupTheme(background: ThemedColor.value(Color(0xFFF0FDF4))),
      children: <Widget>[
        MenuButton(child: Text('Profile')),
        MenuButton(child: Text('Settings')),
      ],
    ),
  );
}
''',
    ),
  ],
  'menu': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';

/// Menu rows with a submenu and a disabled row.
class _MenuDefault extends StatefulWidget {
  const _MenuDefault();

  @override
  State<_MenuDefault> createState() => _MenuDefaultState();
}

class _MenuDefaultState extends State<_MenuDefault> {
  String _lastAction = 'Pick a command';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MenuPopup(
          width: 240,
          children: <Widget>[
            MenuGroup(
              autofocus: false,
              children: <Widget>[
                MenuButton(
                  child: Text('Cut'),
                  onPressed: (_) =>
                      _run('Cut the selection'),
                ),
                MenuButton(
                  child: Text('Copy'),
                  onPressed: (_) =>
                      _run('Copied to the clipboard'),
                ),
                MenuButton(
                  child: Text('Paste'),
                  onPressed: (_) =>
                      _run('Pasted from the clipboard'),
                ),
                const MenuSeparator(),
                MenuButton(
                  subMenu: <Widget>[
                    MenuButton(
                      child: Text('Email'),
                      onPressed: (_) =>
                          _run('Shared by email'),
                    ),
                    MenuButton(
                      child: Text('Link'),
                      onPressed: (_) =>
                          _run('Copied a share link'),
                    ),
                  ],
                  onPressed: (_) {},
                  child: Text('Share'),
                ),
                MenuButton(
                  destructive: true,
                  onPressed: (_) =>
                      _run('Deleted the selection'),
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
        Gap(theme.spacing.md),
        Text(
          _lastAction,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }

  void _run(String action) => setState(() => _lastAction = action);
}

/// The default menu, with its live action line.
Widget _default(BuildContext context) => const _MenuDefault();
''',
    ),
    DocsExampleSource(
      name: 'With checkbox item',
      builder: '_withCheckboxItem',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';

/// A labelled group with a live checkbox row.
class _CheckboxExample extends StatefulWidget {
  const _CheckboxExample();

  @override
  State<_CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<_CheckboxExample> {
  bool _toolbar = true;

  @override
  Widget build(BuildContext context) {
    return MenuPopup(
      width: 240,
      children: <Widget>[
        MenuGroup(
          autofocus: false,
          children: <Widget>[
            MenuLabel(child: Text('Options')),
            MenuCheckboxItem(
              value: _toolbar,
              onChanged: (BuildContext _, bool value) =>
                  setState(() => _toolbar = value),
              trailing: MenuShortcut(shortcut: '⌘T'),
              child: Text('Toolbar'),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _withCheckboxItem(BuildContext context) => const _CheckboxExample();
''',
    ),
    DocsExampleSource(
      name: 'With radio group',
      builder: '_withRadioGroup',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';

/// A live radio group.
class _RadioExample extends StatefulWidget {
  const _RadioExample();

  @override
  State<_RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<_RadioExample> {
  String _side = 'left';

  @override
  Widget build(BuildContext context) {
    return MenuPopup(
      width: 240,
      children: <Widget>[
        MenuGroup(
          autofocus: false,
          children: <Widget>[
            MenuRadioGroup<String>(
              value: _side,
              onChanged: (BuildContext _, String value) =>
                  setState(() => _side = value),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  MenuRadioItem<String>(
                    value: 'left',
                    child: Text('Left'),
                  ),
                  MenuRadioItem<String>(
                    value: 'right',
                    child: Text('Right'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _withRadioGroup(BuildContext context) => const _RadioExample();
''',
    ),
  ],
  'menubar': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/menubar/menubar.dart';

/// File / Edit / View triggers, each with a submenu of menu rows.
class _MenubarDefault extends StatefulWidget {
  const _MenubarDefault();

  @override
  State<_MenubarDefault> createState() => _MenubarDefaultState();
}

class _MenubarDefaultState extends State<_MenubarDefault> {
  String _lastAction = 'Open a menu and pick a command';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Menubar(
          children: <Widget>[
            MenuButton(
              subMenu: <Widget>[
                MenuButton(
                  child: Text('New'),
                  onPressed: (_) => _run('New document'),
                ),
                MenuButton(
                  child: Text('Open'),
                  onPressed: (_) =>
                      _run('Opened a document'),
                ),
                const MenuSeparator(),
                MenuButton(
                  trailing: MenuShortcut(shortcut: '⌘S'),
                  child: Text('Save'),
                  onPressed: (_) =>
                      _run('Saved the document'),
                ),
              ],
              child: Text('File'),
            ),
            MenuButton(
              subMenu: <Widget>[
                MenuButton(
                  child: Text('Cut'),
                  onPressed: (_) =>
                      _run('Cut the selection'),
                ),
                MenuButton(
                  child: Text('Copy'),
                  onPressed: (_) =>
                      _run('Copied to the clipboard'),
                ),
              ],
              child: Text('Edit'),
            ),
            MenuButton(
              subMenu: <Widget>[
                MenuLabel(child: Text('Zoom')),
                MenuButton(
                  child: const Text('100%'),
                  onPressed: (_) => _run('Zoom 100%'),
                ),
                MenuButton(
                  child: const Text('150%'),
                  onPressed: (_) => _run('Zoom 150%'),
                ),
              ],
              child: Text('View'),
            ),
          ],
        ),
        Gap(theme.spacing.md),
        Text(
          _lastAction,
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }

  void _run(String action) => setState(() => _lastAction = action);
}

/// The default bar with its live action line.
Widget _default(BuildContext context) => const _MenubarDefault();
''',
    ),
    DocsExampleSource(
      name: 'With submenu',
      builder: '_withSubmenu',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/menubar/menubar.dart';

/// A nested submenu under the View trigger.
class _WithSubmenu extends StatelessWidget {
  const _WithSubmenu();

  @override
  Widget build(BuildContext context) {
    return Menubar(
      children: <Widget>[
        MenuButton(
          subMenu: <Widget>[
            MenuLabel(child: Text('Zoom')),
            MenuSub(
              trigger: Text('Zoom level'),
              children: <Widget>[
                MenuButton(child: const Text('100%'), onPressed: (_) {}),
                MenuButton(child: const Text('150%'), onPressed: (_) {}),
              ],
            ),
          ],
          child: Text('View'),
        ),
      ],
    );
  }
}

/// A nested submenu under the View trigger.
Widget _withSubmenu(BuildContext context) => const _WithSubmenu();
''',
    ),
  ],
  'breadcrumb': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_breadcrumbDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/dropdown_menu/dropdown_menu.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/breadcrumb/breadcrumb.dart';

/// Current-page line under a trail, so navigation is visible (and testable).
Widget _currentLine(BuildContext context, String page) {
  final theme = Theme.of(context);
  return Text(
    '${'Current page: '}${page}',
    style: TextStyle(color: theme.colors.mutedForeground, fontSize: 12),
  );
}

/// Clickable crumbs for [path] except the last one, which is the current
/// (non-link) page.
List<Widget> _crumbs(
  BuildContext context,
  List<String> path,
  void Function(int index) onTap,
) => <Widget>[
  for (int i = 0; i < path.length; i++)
    if (i == path.length - 1)
      Text(path[i])
    else
      BreadcrumbLink(
        onPressed: () => onTap(i),
        child: Text(path[i]),
      ),
];

/// Default chevron trail, centred.
class _DefaultTrail extends StatefulWidget {
  const _DefaultTrail();

  @override
  State<_DefaultTrail> createState() => _DefaultTrailState();
}

class _DefaultTrailState extends State<_DefaultTrail> {
  List<String> _path = <String>[
    'Home',
    'Components',
    'Breadcrumb',
  ];

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Breadcrumb(
            children: _crumbs(
              context,
              _path,
              (int i) => setState(() {
                _path = _path.sublist(0, i + 1);
              }),
            ),
          ),
        ),
        Gap(spacing.sm),
        _currentLine(context, _path.last),
      ],
    );
  }
}

Widget _breadcrumbDefault(BuildContext context) => const _DefaultTrail();
''',
    ),
    DocsExampleSource(
      name: 'With slash',
      builder: '_breadcrumbSlash',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/dropdown_menu/dropdown_menu.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/breadcrumb/breadcrumb.dart';

/// Current-page line under a trail, so navigation is visible (and testable).
Widget _currentLine(BuildContext context, String page) {
  final theme = Theme.of(context);
  return Text(
    '${'Current page: '}${page}',
    style: TextStyle(color: theme.colors.mutedForeground, fontSize: 12),
  );
}

/// Clickable crumbs for [path] except the last one, which is the current
/// (non-link) page.
List<Widget> _crumbs(
  BuildContext context,
  List<String> path,
  void Function(int index) onTap,
) => <Widget>[
  for (int i = 0; i < path.length; i++)
    if (i == path.length - 1)
      Text(path[i])
    else
      BreadcrumbLink(
        onPressed: () => onTap(i),
        child: Text(path[i]),
      ),
];

/// Slash-separated file path, centred.
class _SlashTrail extends StatefulWidget {
  const _SlashTrail();

  @override
  State<_SlashTrail> createState() => _SlashTrailState();
}

class _SlashTrailState extends State<_SlashTrail> {
  List<String> _path = const <String>['src', 'components', 'breadcrumb.dart'];

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Breadcrumb(
            separator: Breadcrumb.slashSeparator,
            children: _crumbs(
              context,
              _path,
              (int i) => setState(() {
                _path = _path.sublist(0, i + 1);
              }),
            ),
          ),
        ),
        Gap(spacing.sm),
        _currentLine(context, _path.last),
      ],
    );
  }
}

Widget _breadcrumbSlash(BuildContext context) => const _SlashTrail();
''',
    ),
    DocsExampleSource(
      name: 'With ellipsis',
      builder: '_breadcrumbEllipsis',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/dropdown_menu/dropdown_menu.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/breadcrumb/breadcrumb.dart';

/// Current-page line under a trail, so navigation is visible (and testable).
Widget _currentLine(BuildContext context, String page) {
  final theme = Theme.of(context);
  return Text(
    '${'Current page: '}${page}',
    style: TextStyle(color: theme.colors.mutedForeground, fontSize: 12),
  );
}

/// Opens the [hidden] crumbs as a dropdown; tapping one navigates to it.
Future<void> _openHidden(
  BuildContext context,
  List<String> hidden,
  void Function(String crumb) onSelect,
) {
  return showDropdown<void>(
    context: context,
    children: <Widget>[
      for (final crumb in hidden)
        MenuButton(
          child: Text(crumb),
          onPressed: (_) => onSelect(crumb),
        ),
    ],
  );
}

/// Clickable crumbs for [path] except the last one, which is the current
/// (non-link) page.
List<Widget> _crumbs(
  BuildContext context,
  List<String> path,
  void Function(int index) onTap,
) => <Widget>[
  for (int i = 0; i < path.length; i++)
    if (i == path.length - 1)
      Text(path[i])
    else
      BreadcrumbLink(
        onPressed: () => onTap(i),
        child: Text(path[i]),
      ),
];

/// Long trail with an ellipsis dropdown for the collapsed middle.
class _EllipsisTrail extends StatefulWidget {
  const _EllipsisTrail();

  @override
  State<_EllipsisTrail> createState() => _EllipsisTrailState();
}

class _EllipsisTrailState extends State<_EllipsisTrail> {
  List<String> _path = <String>[
    'Home',
    'Docs',
    'Guides',
    'Components',
    'Navigation',
    'Breadcrumb',
  ];

  void _goTo(String crumb) => setState(() {
    _path = _path.sublist(0, _path.indexOf(crumb) + 1);
  });

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    // A short trail needs no ellipsis.
    final Widget trail = _path.length <= 3
        ? Breadcrumb(
            children: _crumbs(context, _path, (int i) => _goTo(_path[i])),
          )
        : Builder(
            builder: (BuildContext context) {
              final List<String> hidden = _path.sublist(1, _path.length - 2);
              return Breadcrumb(
                children: <Widget>[
                  BreadcrumbLink(
                    onPressed: () => _goTo(_path.first),
                    child: Text(_path.first),
                  ),
                  Button(
                    size: ButtonSize.icon,
                    variant: ButtonVariant.ghost,
                    onPressed: () => _openHidden(context, hidden, _goTo),
                    child: const Icon(LucideIcons.ellipsis, size: 16),
                  ),
                  ..._crumbs(context, _path.sublist(_path.length - 2), (int i) {
                    _goTo(_path[_path.length - 2 + i]);
                  }),
                ],
              );
            },
          );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(alignment: Alignment.center, child: trail),
        Gap(spacing.sm),
        _currentLine(context, _path.last),
      ],
    );
  }
}

Widget _breadcrumbEllipsis(BuildContext context) => const _EllipsisTrail();
''',
    ),
    DocsExampleSource(
      name: 'Responsive',
      builder: '_breadcrumbResponsive',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/dropdown_menu/dropdown_menu.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/breadcrumb/breadcrumb.dart';

/// Current-page line under a trail, so navigation is visible (and testable).
Widget _currentLine(BuildContext context, String page) {
  final theme = Theme.of(context);
  return Text(
    '${'Current page: '}${page}',
    style: TextStyle(color: theme.colors.mutedForeground, fontSize: 12),
  );
}

/// Opens the [hidden] crumbs as a dropdown; tapping one navigates to it.
Future<void> _openHidden(
  BuildContext context,
  List<String> hidden,
  void Function(String crumb) onSelect,
) {
  return showDropdown<void>(
    context: context,
    children: <Widget>[
      for (final crumb in hidden)
        MenuButton(
          child: Text(crumb),
          onPressed: (_) => onSelect(crumb),
        ),
    ],
  );
}

/// Clickable crumbs for [path] except the last one, which is the current
/// (non-link) page.
List<Widget> _crumbs(
  BuildContext context,
  List<String> path,
  void Function(int index) onTap,
) => <Widget>[
  for (int i = 0; i < path.length; i++)
    if (i == path.length - 1)
      Text(path[i])
    else
      BreadcrumbLink(
        onPressed: () => onTap(i),
        child: Text(path[i]),
      ),
];

/// Responsive trail: full above 420px, first + ellipsis + last below.
class _ResponsiveTrail extends StatefulWidget {
  const _ResponsiveTrail();

  @override
  State<_ResponsiveTrail> createState() => _ResponsiveTrailState();
}

class _ResponsiveTrailState extends State<_ResponsiveTrail> {
  List<String> _path = <String>[
    'Home',
    'Library',
    'Components',
    'Navigation',
    'Breadcrumb',
  ];

  void _goTo(String crumb) => setState(() {
    _path = _path.sublist(0, _path.indexOf(crumb) + 1);
  });

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool collapsed =
                  constraints.maxWidth < 420 && _path.length > 3;
              final List<Widget> children;
              if (!collapsed) {
                children = _crumbs(context, _path, (int i) => _goTo(_path[i]));
              } else {
                children = <Widget>[
                  BreadcrumbLink(
                    onPressed: () => _goTo(_path.first),
                    child: Text(_path.first),
                  ),
                  Button(
                    size: ButtonSize.icon,
                    variant: ButtonVariant.ghost,
                    onPressed: () => _openHidden(
                      context,
                      _path.sublist(1, _path.length - 1),
                      _goTo,
                    ),
                    child: const Icon(LucideIcons.ellipsis, size: 16),
                  ),
                  Text(_path.last),
                ];
              }
              return Breadcrumb(children: children);
            },
          ),
        ),
        Gap(spacing.sm),
        _currentLine(context, _path.last),
      ],
    );
  }
}

Widget _breadcrumbResponsive(BuildContext context) => const _ResponsiveTrail();
''',
    ),
  ],
  'navigation_bar': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/radix_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/navigation_bar/navigation_bar.dart';

/// Shared bar items for the horizontal examples.
List<NavigationBarItem> _barItems([BuildContext? context]) =>
    <NavigationBarItem>[
      NavigationItem(
        label: Text('Home'),
        child: const Icon(RadixIcons.home),
      ),
      NavigationItem(
        label: Text('Search'),
        child: const Icon(RadixIcons.magnifyingGlass),
      ),
      NavigationItem(
        label: Text('Settings'),
        child: const Icon(RadixIcons.gear),
      ),
      NavigationItem(
        label: Text('Disabled'),
        enabled: false,
        child: const Icon(RadixIcons.person),
      ),
    ];

/// An interactive horizontal bar; selection lives in this example's state.
class _InteractiveBar extends StatefulWidget {
  const _InteractiveBar({this.labelType});

  final NavigationLabelType? labelType;

  @override
  State<_InteractiveBar> createState() => _InteractiveBarState();
}

class _InteractiveBarState extends State<_InteractiveBar> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      index: _index,
      onSelected: (int value) => setState(() => _index = value),
      labelType: widget.labelType,
      children: _barItems(context),
    );
  }
}

/// The default bar: only the selected item shows its label.
Widget _default(BuildContext context) =>
    const _InteractiveBar(labelType: NavigationLabelType.selected);
''',
    ),
    DocsExampleSource(
      name: 'With labels',
      builder: '_withLabels',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/radix_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/navigation_bar/navigation_bar.dart';

/// Shared bar items for the horizontal examples.
List<NavigationBarItem> _barItems([BuildContext? context]) =>
    <NavigationBarItem>[
      NavigationItem(
        label: Text('Home'),
        child: const Icon(RadixIcons.home),
      ),
      NavigationItem(
        label: Text('Search'),
        child: const Icon(RadixIcons.magnifyingGlass),
      ),
      NavigationItem(
        label: Text('Settings'),
        child: const Icon(RadixIcons.gear),
      ),
      NavigationItem(
        label: Text('Disabled'),
        enabled: false,
        child: const Icon(RadixIcons.person),
      ),
    ];

/// An interactive horizontal bar; selection lives in this example's state.
class _InteractiveBar extends StatefulWidget {
  const _InteractiveBar({this.labelType});

  final NavigationLabelType? labelType;

  @override
  State<_InteractiveBar> createState() => _InteractiveBarState();
}

class _InteractiveBarState extends State<_InteractiveBar> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      index: _index,
      onSelected: (int value) => setState(() => _index = value),
      labelType: widget.labelType,
      children: _barItems(context),
    );
  }
}

/// A bar with every label visible.
Widget _withLabels(BuildContext context) =>
    const _InteractiveBar(labelType: NavigationLabelType.all);
''',
    ),
    DocsExampleSource(
      name: 'Sidebar',
      builder: '_sidebar',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/radix_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/navigation_bar/navigation_bar.dart';

/// Shared bar items for the horizontal examples.
List<NavigationBarItem> _barItems([BuildContext? context]) =>
    <NavigationBarItem>[
      NavigationItem(
        label: Text('Home'),
        child: const Icon(RadixIcons.home),
      ),
      NavigationItem(
        label: Text('Search'),
        child: const Icon(RadixIcons.magnifyingGlass),
      ),
      NavigationItem(
        label: Text('Settings'),
        child: const Icon(RadixIcons.gear),
      ),
      NavigationItem(
        label: Text('Disabled'),
        enabled: false,
        child: const Icon(RadixIcons.person),
      ),
    ];

/// A bounded sidebar with a label, a divider and a grouped collapsible.
class _SidebarDemo extends StatefulWidget {
  const _SidebarDemo();

  @override
  State<_SidebarDemo> createState() => _SidebarDemoState();
}

class _SidebarDemoState extends State<_SidebarDemo> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Tall enough for the header, both groups, the expanded collapsible
    // children and the footer with no scrolling.
    return SizedBox(
      width: 256,
      height: 420,
      child: NavigationBar(
        container: NavigationContainerType.sidebar,
        index: _index,
        onSelected: (int value) => setState(() => _index = value),
        header: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
            child: Text(
              'Acme Inc',
              style: theme.typography.small.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        footer: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
            child: Text(
              'v1.0.0',
              style: theme.typography.xSmall.copyWith(
                color: theme.colors.mutedForeground,
              ),
            ),
          ),
        ],
        children: <NavigationBarItem>[
          NavigationLabel(child: Text('Main')),
          ..._barItems(context),
          const NavigationDivider(),
          NavigationGroup(
            label: Text('Account'),
            children: <Widget>[
              NavigationCollapsible(
                label: Text('Profile'),
                leading: const Icon(RadixIcons.person),
                initialExpanded: true,
                children: <Widget>[
                  NavigationItem(
                    index: 4,
                    label: Text('Details'),
                    child: const Icon(RadixIcons.idCard),
                  ),
                  NavigationItem(
                    index: 5,
                    label: Text('Security'),
                    child: const Icon(RadixIcons.lockClosed),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _sidebar(BuildContext context) => const _SidebarDemo();
''',
    ),
  ],
  'navigation_menu': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_defaultBar',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/primitives/text/text_extension.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/navigation_menu/navigation_menu.dart';

/// Featured tile for the Getting-started panel (upstream's gradient card).
Widget _featuredTile(ThemeData theme) {
  return Button(
    variant: ButtonVariant.ghost,
    onPressed: () {},
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[theme.colors.muted, theme.colors.accent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('dashcn').small().medium(),
          const SizedBox(height: 4),
          Text(
            'Beautifully designed components',
          ).muted().small(),
        ],
      ),
    ),
  );
}

/// Getting-started panel: featured tile plus three links.
Widget _gettingStarted(ThemeData theme) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(width: 200, child: _featuredTile(theme)),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            NavigationMenuContent(
              title: Text('Introduction'),
              content: Text(
                'Re-usable components for your apps',
              ),
              onPressed: _noop,
            ),
            SizedBox(height: 8),
            NavigationMenuContent(
              title: Text('Installation'),
              content: Text(
                'How to install dependencies and code',
              ),
              onPressed: _noop,
            ),
            SizedBox(height: 8),
            NavigationMenuContent(
              title: Text('Typography'),
              content: Text(
                'Styles for headings and paragraphs',
              ),
              onPressed: _noop,
            ),
          ],
        ),
      ),
    ],
  );
}

void _noop() {}

/// Components panel: two-column grid of six links.
Widget _componentsGrid() {
  return NavigationMenuContentList(
    crossAxisCount: 2,
    children: <Widget>[
      NavigationMenuContent(
        title: Text('Alert Dialog'),
        content: Text(
          'A modal dialog that interrupts the user',
        ),
        onPressed: _noop,
      ),
      NavigationMenuContent(
        title: Text('Hover Card'),
        content: Text('For sighted users to preview content'),
        onPressed: _noop,
      ),
      NavigationMenuContent(
        title: Text('Progress'),
        content: Text(
          'Displays an indicator showing progress',
        ),
        onPressed: _noop,
      ),
      NavigationMenuContent(
        title: Text('Scroll Area'),
        content: Text(
          'Visually separates content into sections',
        ),
        onPressed: _noop,
      ),
      NavigationMenuContent(
        title: Text('Tabs'),
        content: Text('A set of layered sections of content'),
        onPressed: _noop,
      ),
      NavigationMenuContent(
        title: Text('Tooltip'),
        content: Text('A popup that displays information'),
        onPressed: _noop,
      ),
    ],
  );
}

/// Default bar: featured Getting-started panel, Components grid, Docs link.
class _DefaultBar extends StatefulWidget {
  const _DefaultBar();

  @override
  State<_DefaultBar> createState() => _DefaultBarState();
}

class _DefaultBarState extends State<_DefaultBar> {
  String _page = 'Getting started';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Intrinsic width: a fixed box clipped the bar under real text
        // metrics, and the bar is wider than the 375 phone stage.
        FittedBox(
          fit: BoxFit.scaleDown,
          child: NavigationMenu(
            children: <Widget>[
              NavigationMenuItem(
                content: _gettingStarted(theme),
                child: Text('Getting started'),
              ),
              NavigationMenuItem(
                content: _componentsGrid(),
                child: Text('Components'),
              ),
              NavigationMenuItem(
                onPressed: () => setState(
                  () => _page = 'Documentation',
                ),
                child: Text('Docs'),
              ),
            ],
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          'Viewing $_page',
          style: TextStyle(fontSize: 12, color: theme.colors.mutedForeground),
        ),
      ],
    );
  }
}

Widget _defaultBar(BuildContext context) => const _DefaultBar();
''',
    ),
    DocsExampleSource(
      name: 'Content list',
      builder: '_contentList',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/primitives/text/text_extension.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/navigation_menu/navigation_menu.dart';

void _noop() {}

/// A standalone two-column content list.
Widget _contentList(BuildContext context) {
  return SizedBox(
    width: 360,
    child: NavigationMenuContentList(
      crossAxisCount: 2,
      children: <Widget>[
        NavigationMenuContent(
          title: Text('Dashboard'),
          content: Text('Analytics'),
          onPressed: _noop,
        ),
        NavigationMenuContent(
          title: Text('Settings'),
          content: Text('Preferences'),
          onPressed: _noop,
        ),
        NavigationMenuContent(
          title: Text('Billing'),
          content: Text('Plans'),
          onPressed: _noop,
        ),
        NavigationMenuContent(
          title: Text('Notifications'),
          content: Text('Alerts'),
          onPressed: _noop,
        ),
      ],
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'With icons',
      builder: '_withIcons',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/primitives/text/text_extension.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/navigation_menu/navigation_menu.dart';

void _noop() {}

/// A standalone list with leading icons.
Widget _withIcons(BuildContext context) {
  return SizedBox(
    width: 300,
    child: NavigationMenuContentList(
      crossAxisCount: 1,
      children: <Widget>[
        NavigationMenuContent(
          leading: Icon(LucideIcons.layoutDashboard, size: 16),
          title: Text('Dashboard'),
          content: Text('Analytics'),
          onPressed: _noop,
        ),
        NavigationMenuContent(
          leading: Icon(LucideIcons.settings, size: 16),
          title: Text('Settings'),
          content: Text('Preferences'),
          onPressed: _noop,
        ),
        NavigationMenuContent(
          leading: Icon(LucideIcons.fileText, size: 16),
          title: Text('Billing'),
          content: Text('Invoices'),
          onPressed: _noop,
        ),
        NavigationMenuContent(
          leading: Icon(LucideIcons.bell, size: 16),
          title: Text('Notifications'),
          content: Text('Alerts'),
          onPressed: _noop,
        ),
      ],
    ),
  );
}
''',
    ),
  ],
  'pagination': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Labelled',
      builder: '_labelled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/pagination/pagination.dart';

/// An interactive labelled pager; the page lives in this example's state.
class _LabelledPagination extends StatefulWidget {
  const _LabelledPagination();

  @override
  State<_LabelledPagination> createState() => _LabelledPaginationState();
}

class _LabelledPaginationState extends State<_LabelledPagination> {
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    return Pagination(
      page: _page,
      totalPages: 10,
      onPageChanged: (int page) => setState(() => _page = page),
    );
  }
}

Widget _labelled(BuildContext context) => const _LabelledPagination();
''',
    ),
    DocsExampleSource(
      name: 'Icon only',
      builder: '_iconOnly',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/pagination/pagination.dart';

/// Page buttons without the "Page x of y" label; the page lives here too.
class _IconOnlyPagination extends StatefulWidget {
  const _IconOnlyPagination();

  @override
  State<_IconOnlyPagination> createState() => _IconOnlyPaginationState();
}

class _IconOnlyPaginationState extends State<_IconOnlyPagination> {
  int _page = 5;

  @override
  Widget build(BuildContext context) {
    return Pagination(
      page: _page,
      totalPages: 12,
      showLabel: false,
      onPageChanged: (int page) => setState(() => _page = page),
    );
  }
}

Widget _iconOnly(BuildContext context) => const _IconOnlyPagination();
''',
    ),
  ],
  'sidebar': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Dashboard',
      builder: '_dashboard',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/drawer/drawer.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/sidebar/sidebar.dart';

/// Width below which the shells switch to the phone bar + drawer pattern.
///
/// Tracks the density phone breakpoint ([kPhoneWidthBreakpoint], 600 px) so
/// the docs 295 px example stage (375 px viewport) and any narrow stage use
/// the phone bar (no 256 px rail) instead of overflowing.
const double kSidebarPhoneWidth = kPhoneWidthBreakpoint;

/// Fallback shell height when the stage leaves the height unbounded.
const double kSidebarFallbackHeight = 360.0;

/// Sample navigation shared by the examples.
List<SidebarSection> _sampleSections([BuildContext? context]) =>
    <SidebarSection>[
      SidebarSection(
        label: 'Main',
        items: <SidebarItem>[
          SidebarItem(
            label: 'Dashboard',
            icon: LucideIcons.layoutDashboard,
          ),
          SidebarItem(
            label: 'Documents',
            icon: LucideIcons.fileText,
            badge: '12',
          ),
          SidebarItem(
            label: 'Reports',
            icon: LucideIcons.chartBar,
          ),
        ],
      ),
      SidebarSection(
        label: 'Account',
        items: <SidebarItem>[
          SidebarItem(
            label: 'Settings',
            icon: LucideIcons.settings,
            children: <SidebarItem>[
              SidebarItem(
                label: 'Profile',
                icon: LucideIcons.circleUser,
              ),
              SidebarItem(
                label: 'Billing',
                icon: LucideIcons.creditCard,
              ),
            ],
          ),
          SidebarItem(
            label: 'Help',
            icon: LucideIcons.circleHelp,
          ),
        ],
      ),
    ];

/// The footer account shared by the examples.
SidebarUser _sampleUser = SidebarUser(
  name: 'Ibrar Ahmed',
  email: 'm@example.com',
);

/// Small content panel shown beside the rail. Scrolls internally when the
/// height is bounded, shrink-wraps otherwise.
class _DemoContent extends StatelessWidget {
  const _DemoContent(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Density tokens drive the card thumb (control height: 32 compact,
    // 48 touch) and the gaps, so the content tracks compact/touch density
    // instead of hard-coding 32/8.
    final DensityTokens tokens = resolveDensityTokens(context);
    final Widget cards = Column(
      children: <Widget>[
        for (int i = 0; i < 6; i++)
          Container(
            margin: EdgeInsets.only(bottom: theme.spacing.sm),
            padding: EdgeInsets.all(theme.spacing.md),
            decoration: BoxDecoration(
              color: theme.colors.card,
              borderRadius: theme.borderRadiusLg,
              border: Border.all(color: theme.colors.border),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: tokens.controlHeight,
                  height: tokens.controlHeight,
                  decoration: BoxDecoration(
                    color: theme.colors.accent,
                    borderRadius: theme.borderRadiusSm,
                  ),
                ),
                Gap(tokens.gap),
                Expanded(
                  child: Text(
                    '${'Card'} ${i + 1}',
                    style: theme.typography.textSmall,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
    return ColoredBox(
      color: theme.colors.background,
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final Widget body = Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: theme.typography.textLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(theme.spacing.sm),
                Text(
                  'Pick a row in the sidebar to switch sections.',
                  style: theme.typography.textSmall.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                ),
                Gap(theme.spacing.md),
                cards,
              ],
            );
            if (!constraints.maxHeight.isFinite) {
              return body;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  title,
                  style: theme.typography.textLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(theme.spacing.sm),
                Text(
                  'Pick a row in the sidebar to switch sections.',
                  style: theme.typography.textSmall.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                ),
                Gap(theme.spacing.md),
                Expanded(child: SingleChildScrollView(child: cards)),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Phone-width bar whose menu button opens the sidebar in a drawer, with
/// content below. Fills bounded heights, shrink-wraps otherwise.
class _PhoneDemo extends StatefulWidget {
  const _PhoneDemo({required this.selected, required this.onSelected});

  final String selected;
  final ValueChanged<String> onSelected;

  @override
  State<_PhoneDemo> createState() => _PhoneDemoState();
}

class _PhoneDemoState extends State<_PhoneDemo> {
  void _openNav() {
    openDrawer(
      context: context,
      position: OverlayPosition.start,
      builder: (BuildContext drawerContext) => DashboardSidebar(
        sections: _sampleSections(drawerContext),
        selectedId: widget.selected,
        onSelected: (String id) {
          widget.onSelected(id);
          closeDrawer(drawerContext);
        },
        user: _sampleUser,
        onUserPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Density-aware menu glyph (16 compact, 24 touch) and gaps.
    final DensityTokens tokens = resolveDensityTokens(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Widget bar = Container(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.md,
            vertical: theme.spacing.sm,
          ),
          decoration: BoxDecoration(
            color: theme.colors.sidebar,
            borderRadius: theme.borderRadiusLg,
            border: Border.all(color: theme.colors.sidebarBorder),
          ),
          child: Row(
            children: <Widget>[
              Button(
                variant: ButtonVariant.ghost,
                size: ButtonSize.icon,
                onPressed: _openNav,
                child: Icon(LucideIcons.menu, size: resolveIconSize(tokens)),
              ),
              Gap(tokens.gap),
              Expanded(
                child: Text(
                  widget.selected,
                  style: theme.typography.textSmall.copyWith(
                    color: theme.colors.sidebarForeground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
        if (!constraints.maxHeight.isFinite) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              bar,
              Gap(theme.spacing.md),
              _DemoContent(widget.selected),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            bar,
            Gap(theme.spacing.md),
            Expanded(child: _DemoContent(widget.selected)),
          ],
        );
      },
    );
  }
}

/// Full sidebar beside content on wide stages, phone bar + drawer below
/// [kSidebarPhoneWidth] (the density phone breakpoint). Narrow desktop
/// stages use the collapsed 64 px rail so the 256 px rail never overflows
/// the docs 560 px example stage; the content column scrolls vertically
/// when the stage height is bounded. Collapse control and account footer
/// included.
class _DashboardDemo extends StatefulWidget {
  const _DashboardDemo();

  @override
  State<_DashboardDemo> createState() => _DashboardDemoState();
}

class _DashboardDemoState extends State<_DashboardDemo> {
  String _selected = 'Dashboard';
  bool _collapsed = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : kPhoneWidthBreakpoint;
        final double height = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : kSidebarFallbackHeight;
        final Widget body;
        if (width < kSidebarPhoneWidth) {
          body = _PhoneDemo(
            selected: _selected,
            onSelected: (String id) => setState(() => _selected = id),
          );
        } else {
          // Docs stages (560 px at 1440 px viewports, 295 px at 375 px
          // viewports which take the phone branch above) stay overflow-free:
          // tight desktop widths keep the collapsed rail (narrower sidebar
          // inside the stage) instead of forcing the full 256 px rail.
          final bool narrowStage = width < 720;
          body = Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DashboardSidebar(
                sections: _sampleSections(context),
                selectedId: _selected,
                onSelected: (String id) => setState(() => _selected = id),
                collapsed: narrowStage ? true : _collapsed,
                onToggleCollapsed: () =>
                    setState(() => _collapsed = !_collapsed),
                user: _sampleUser,
                onUserPressed: () {},
              ),
              Expanded(child: _DemoContent(_selected)),
            ],
          );
        }
        return SizedBox(width: width, height: height, child: body);
      },
    );
  }
}

/// Collapsed 64 px icon rail beside content, with tooltips on every row.
/// Below [kSidebarPhoneWidth] the rail stays beside a squeezed content
/// column (both fit the 295 px phone stage).
class _CollapsedDemo extends StatefulWidget {
  const _CollapsedDemo();

  @override
  State<_CollapsedDemo> createState() => _CollapsedDemoState();
}

class _CollapsedDemoState extends State<_CollapsedDemo> {
  String _selected = 'Dashboard';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : 480;
        final double height = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : kSidebarFallbackHeight;
        return SizedBox(
          width: width,
          height: height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DashboardSidebar(
                sections: _sampleSections(context),
                selectedId: _selected,
                onSelected: (String id) => setState(() => _selected = id),
                collapsed: true,
                user: _sampleUser,
                onUserPressed: () {},
              ),
              Expanded(child: _DemoContent(_selected)),
            ],
          ),
        );
      },
    );
  }
}

Widget _dashboard(BuildContext context) => const _DashboardDemo();

Widget _collapsed(BuildContext context) => const _CollapsedDemo();
''',
    ),
    DocsExampleSource(
      name: 'Drawer',
      builder: '_drawer',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/drawer/drawer.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/sidebar/sidebar.dart';

/// Sample navigation shared by the examples.
List<SidebarSection> _sampleSections([BuildContext? context]) =>
    <SidebarSection>[
      SidebarSection(
        label: 'Main',
        items: <SidebarItem>[
          SidebarItem(
            label: 'Dashboard',
            icon: LucideIcons.layoutDashboard,
          ),
          SidebarItem(
            label: 'Documents',
            icon: LucideIcons.fileText,
            badge: '12',
          ),
          SidebarItem(
            label: 'Reports',
            icon: LucideIcons.chartBar,
          ),
        ],
      ),
      SidebarSection(
        label: 'Account',
        items: <SidebarItem>[
          SidebarItem(
            label: 'Settings',
            icon: LucideIcons.settings,
            children: <SidebarItem>[
              SidebarItem(
                label: 'Profile',
                icon: LucideIcons.circleUser,
              ),
              SidebarItem(
                label: 'Billing',
                icon: LucideIcons.creditCard,
              ),
            ],
          ),
          SidebarItem(
            label: 'Help',
            icon: LucideIcons.circleHelp,
          ),
        ],
      ),
    ];

/// The footer account shared by the examples.
SidebarUser _sampleUser = SidebarUser(
  name: 'Ibrar Ahmed',
  email: 'm@example.com',
);

/// Small content panel shown beside the rail. Scrolls internally when the
/// height is bounded, shrink-wraps otherwise.
class _DemoContent extends StatelessWidget {
  const _DemoContent(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Density tokens drive the card thumb (control height: 32 compact,
    // 48 touch) and the gaps, so the content tracks compact/touch density
    // instead of hard-coding 32/8.
    final DensityTokens tokens = resolveDensityTokens(context);
    final Widget cards = Column(
      children: <Widget>[
        for (int i = 0; i < 6; i++)
          Container(
            margin: EdgeInsets.only(bottom: theme.spacing.sm),
            padding: EdgeInsets.all(theme.spacing.md),
            decoration: BoxDecoration(
              color: theme.colors.card,
              borderRadius: theme.borderRadiusLg,
              border: Border.all(color: theme.colors.border),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: tokens.controlHeight,
                  height: tokens.controlHeight,
                  decoration: BoxDecoration(
                    color: theme.colors.accent,
                    borderRadius: theme.borderRadiusSm,
                  ),
                ),
                Gap(tokens.gap),
                Expanded(
                  child: Text(
                    '${'Card'} ${i + 1}',
                    style: theme.typography.textSmall,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
    return ColoredBox(
      color: theme.colors.background,
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final Widget body = Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: theme.typography.textLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(theme.spacing.sm),
                Text(
                  'Pick a row in the sidebar to switch sections.',
                  style: theme.typography.textSmall.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                ),
                Gap(theme.spacing.md),
                cards,
              ],
            );
            if (!constraints.maxHeight.isFinite) {
              return body;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  title,
                  style: theme.typography.textLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(theme.spacing.sm),
                Text(
                  'Pick a row in the sidebar to switch sections.',
                  style: theme.typography.textSmall.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                ),
                Gap(theme.spacing.md),
                Expanded(child: SingleChildScrollView(child: cards)),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Phone-width bar whose menu button opens the sidebar in a drawer, with
/// content below. Fills bounded heights, shrink-wraps otherwise.
class _PhoneDemo extends StatefulWidget {
  const _PhoneDemo({required this.selected, required this.onSelected});

  final String selected;
  final ValueChanged<String> onSelected;

  @override
  State<_PhoneDemo> createState() => _PhoneDemoState();
}

class _PhoneDemoState extends State<_PhoneDemo> {
  void _openNav() {
    openDrawer(
      context: context,
      position: OverlayPosition.start,
      builder: (BuildContext drawerContext) => DashboardSidebar(
        sections: _sampleSections(drawerContext),
        selectedId: widget.selected,
        onSelected: (String id) {
          widget.onSelected(id);
          closeDrawer(drawerContext);
        },
        user: _sampleUser,
        onUserPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Density-aware menu glyph (16 compact, 24 touch) and gaps.
    final DensityTokens tokens = resolveDensityTokens(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Widget bar = Container(
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing.md,
            vertical: theme.spacing.sm,
          ),
          decoration: BoxDecoration(
            color: theme.colors.sidebar,
            borderRadius: theme.borderRadiusLg,
            border: Border.all(color: theme.colors.sidebarBorder),
          ),
          child: Row(
            children: <Widget>[
              Button(
                variant: ButtonVariant.ghost,
                size: ButtonSize.icon,
                onPressed: _openNav,
                child: Icon(LucideIcons.menu, size: resolveIconSize(tokens)),
              ),
              Gap(tokens.gap),
              Expanded(
                child: Text(
                  widget.selected,
                  style: theme.typography.textSmall.copyWith(
                    color: theme.colors.sidebarForeground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
        if (!constraints.maxHeight.isFinite) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              bar,
              Gap(theme.spacing.md),
              _DemoContent(widget.selected),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            bar,
            Gap(theme.spacing.md),
            Expanded(child: _DemoContent(widget.selected)),
          ],
        );
      },
    );
  }
}

/// Phone shell: the bar opens the same sidebar in a drawer. Sized to its
/// stage (capped at the density overlay max width) so it reads as a phone
/// mock on desktop stages and full-bleed on phones.
class _DrawerDemo extends StatefulWidget {
  const _DrawerDemo();

  @override
  State<_DrawerDemo> createState() => _DrawerDemoState();
}

class _DrawerDemoState extends State<_DrawerDemo> {
  String _selected = 'Dashboard';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Density-aware phone cap (320 compact, 400 touch) sized to the
        // stage: full-bleed at 375 px viewports (295 px stage), capped mock
        // at 1440 px viewports (560 px stage).
        final DensityTokens tokens = resolveDensityTokens(context);
        final double cap = tokens.overlayMaxWidth;
        final double width = constraints.maxWidth.isFinite
            ? (constraints.maxWidth > cap ? cap : constraints.maxWidth)
            : cap;
        final double height = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : 560;
        return SizedBox(
          width: width,
          height: height,
          child: _PhoneDemo(
            selected: _selected,
            onSelected: (String id) => setState(() => _selected = id),
          ),
        );
      },
    );
  }
}

Widget _drawer(BuildContext context) => const _DrawerDemo();
''',
    ),
    DocsExampleSource(
      name: 'Collapsed',
      builder: '_collapsed',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/drawer/drawer.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/sidebar/sidebar.dart';

/// Width below which the shells switch to the phone bar + drawer pattern.
///
/// Tracks the density phone breakpoint ([kPhoneWidthBreakpoint], 600 px) so
/// the docs 295 px example stage (375 px viewport) and any narrow stage use
/// the phone bar (no 256 px rail) instead of overflowing.
const double kSidebarPhoneWidth = kPhoneWidthBreakpoint;

/// Fallback shell height when the stage leaves the height unbounded.
const double kSidebarFallbackHeight = 360.0;

/// Sample navigation shared by the examples.
List<SidebarSection> _sampleSections([BuildContext? context]) =>
    <SidebarSection>[
      SidebarSection(
        label: 'Main',
        items: <SidebarItem>[
          SidebarItem(
            label: 'Dashboard',
            icon: LucideIcons.layoutDashboard,
          ),
          SidebarItem(
            label: 'Documents',
            icon: LucideIcons.fileText,
            badge: '12',
          ),
          SidebarItem(
            label: 'Reports',
            icon: LucideIcons.chartBar,
          ),
        ],
      ),
      SidebarSection(
        label: 'Account',
        items: <SidebarItem>[
          SidebarItem(
            label: 'Settings',
            icon: LucideIcons.settings,
            children: <SidebarItem>[
              SidebarItem(
                label: 'Profile',
                icon: LucideIcons.circleUser,
              ),
              SidebarItem(
                label: 'Billing',
                icon: LucideIcons.creditCard,
              ),
            ],
          ),
          SidebarItem(
            label: 'Help',
            icon: LucideIcons.circleHelp,
          ),
        ],
      ),
    ];

/// The footer account shared by the examples.
SidebarUser _sampleUser = SidebarUser(
  name: 'Ibrar Ahmed',
  email: 'm@example.com',
);

/// Small content panel shown beside the rail. Scrolls internally when the
/// height is bounded, shrink-wraps otherwise.
class _DemoContent extends StatelessWidget {
  const _DemoContent(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Density tokens drive the card thumb (control height: 32 compact,
    // 48 touch) and the gaps, so the content tracks compact/touch density
    // instead of hard-coding 32/8.
    final DensityTokens tokens = resolveDensityTokens(context);
    final Widget cards = Column(
      children: <Widget>[
        for (int i = 0; i < 6; i++)
          Container(
            margin: EdgeInsets.only(bottom: theme.spacing.sm),
            padding: EdgeInsets.all(theme.spacing.md),
            decoration: BoxDecoration(
              color: theme.colors.card,
              borderRadius: theme.borderRadiusLg,
              border: Border.all(color: theme.colors.border),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: tokens.controlHeight,
                  height: tokens.controlHeight,
                  decoration: BoxDecoration(
                    color: theme.colors.accent,
                    borderRadius: theme.borderRadiusSm,
                  ),
                ),
                Gap(tokens.gap),
                Expanded(
                  child: Text(
                    '${'Card'} ${i + 1}',
                    style: theme.typography.textSmall,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
    return ColoredBox(
      color: theme.colors.background,
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final Widget body = Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: theme.typography.textLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(theme.spacing.sm),
                Text(
                  'Pick a row in the sidebar to switch sections.',
                  style: theme.typography.textSmall.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                ),
                Gap(theme.spacing.md),
                cards,
              ],
            );
            if (!constraints.maxHeight.isFinite) {
              return body;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  title,
                  style: theme.typography.textLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(theme.spacing.sm),
                Text(
                  'Pick a row in the sidebar to switch sections.',
                  style: theme.typography.textSmall.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                ),
                Gap(theme.spacing.md),
                Expanded(child: SingleChildScrollView(child: cards)),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Collapsed 64 px icon rail beside content, with tooltips on every row.
/// Below [kSidebarPhoneWidth] the rail stays beside a squeezed content
/// column (both fit the 295 px phone stage).
class _CollapsedDemo extends StatefulWidget {
  const _CollapsedDemo();

  @override
  State<_CollapsedDemo> createState() => _CollapsedDemoState();
}

class _CollapsedDemoState extends State<_CollapsedDemo> {
  String _selected = 'Dashboard';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : 480;
        final double height = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : kSidebarFallbackHeight;
        return SizedBox(
          width: width,
          height: height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DashboardSidebar(
                sections: _sampleSections(context),
                selectedId: _selected,
                onSelected: (String id) => setState(() => _selected = id),
                collapsed: true,
                user: _sampleUser,
                onUserPressed: () {},
              ),
              Expanded(child: _DemoContent(_selected)),
            ],
          ),
        );
      },
    );
  }
}

Widget _collapsed(BuildContext context) => const _CollapsedDemo();
''',
    ),
  ],
  'stepper': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/stepper/stepper.dart';

List<StepperStep> _steps([BuildContext? context]) => <StepperStep>[
  StepperStep(
    title: Text('Account'),
    content: Text('Email, password'),
  ),
  StepperStep(
    title: Text('Profile'),
    content: Text('Name, avatar'),
  ),
  StepperStep(
    title: Text('Payment'),
    content: Text('Card, invoice'),
  ),
];

/// A stepper that moves when a step is activated; owns its index.
class _InteractiveStepper extends StatefulWidget {
  const _InteractiveStepper({this.direction = Axis.horizontal});

  final Axis direction;

  @override
  State<_InteractiveStepper> createState() => _InteractiveStepperState();
}

class _InteractiveStepperState extends State<_InteractiveStepper> {
  int _current = 1;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _current,
      onStepChanged: (int index) => setState(() => _current = index),
      direction: widget.direction,
      steps: _steps(context),
    );
  }
}

/// Horizontal circle stepper.
Widget _default(BuildContext context) => const _InteractiveStepper();
''',
    ),
    DocsExampleSource(
      name: 'Vertical',
      builder: '_vertical',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/stepper/stepper.dart';

List<StepperStep> _steps([BuildContext? context]) => <StepperStep>[
  StepperStep(
    title: Text('Account'),
    content: Text('Email, password'),
  ),
  StepperStep(
    title: Text('Profile'),
    content: Text('Name, avatar'),
  ),
  StepperStep(
    title: Text('Payment'),
    content: Text('Card, invoice'),
  ),
];

/// A stepper that moves when a step is activated; owns its index.
class _InteractiveStepper extends StatefulWidget {
  const _InteractiveStepper({this.direction = Axis.horizontal});

  final Axis direction;

  @override
  State<_InteractiveStepper> createState() => _InteractiveStepperState();
}

class _InteractiveStepperState extends State<_InteractiveStepper> {
  int _current = 1;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _current,
      onStepChanged: (int index) => setState(() => _current = index),
      direction: widget.direction,
      steps: _steps(context),
    );
  }
}

/// Vertical circle stepper.
Widget _vertical(BuildContext context) {
  return const _InteractiveStepper(direction: Axis.vertical);
}
''',
    ),
    DocsExampleSource(
      name: 'Sizes',
      builder: '_sizes',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/stepper/stepper.dart';

List<StepperStep> _steps([BuildContext? context]) => <StepperStep>[
  StepperStep(
    title: Text('Account'),
    content: Text('Email, password'),
  ),
  StepperStep(
    title: Text('Profile'),
    content: Text('Name, avatar'),
  ),
  StepperStep(
    title: Text('Payment'),
    content: Text('Card, invoice'),
  ),
];

/// The three indicator sizes, each one tappable and reporting its step.
class _SizesStepper extends StatefulWidget {
  const _SizesStepper();

  @override
  State<_SizesStepper> createState() => _SizesStepperState();
}

class _SizesStepperState extends State<_SizesStepper> {
  int _current = 1;
  String _last = 'Tap a step indicator';

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    // P7-TH1: centred column — the full-width steppers define the box and
    // the labels sit under them instead of stranding at x=0.
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        for (final StepperSize size in StepperSize.values) ...<Widget>[
          Text('${size.name} (${size.indicatorSize}px)'),
          Stepper(
            currentStep: _current,
            size: size,
            steps: _steps(context),
            onStepChanged: (int index) => setState(() {
              _current = index;
              _last = '${size.name} step ${index + 1}';
            }),
          ),
          Gap(spacing.md),
        ],
        Text(_last),
      ],
    );
  }
}

Widget _sizes(BuildContext context) => const _SizesStepper();
''',
    ),
    DocsExampleSource(
      name: 'Failed step',
      builder: '_failed',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/stepper/stepper.dart';

List<StepperStep> _steps([BuildContext? context]) => <StepperStep>[
  StepperStep(
    title: Text('Account'),
    content: Text('Email, password'),
  ),
  StepperStep(
    title: Text('Profile'),
    content: Text('Name, avatar'),
  ),
  StepperStep(
    title: Text('Payment'),
    content: Text('Card, invoice'),
  ),
];

/// A controller-driven stepper with the first step flagged as failed.
class _FailedStepper extends StatefulWidget {
  const _FailedStepper();

  @override
  State<_FailedStepper> createState() => _FailedStepperState();
}

class _FailedStepperState extends State<_FailedStepper> {
  final StepperController _controller = StepperController(1);

  @override
  void initState() {
    super.initState();
    _controller.setStepState(0, StepperStepState.failed);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(controller: _controller, steps: _steps(context));
  }
}

Widget _failed(BuildContext context) => const _FailedStepper();
''',
    ),
  ],
  'tabs': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/tabs/tabs.dart';

/// Interactive pill strip; owns its index.
class _InteractiveTabs extends StatefulWidget {
  const _InteractiveTabs();

  @override
  State<_InteractiveTabs> createState() => _InteractiveTabsState();
}

class _InteractiveTabsState extends State<_InteractiveTabs> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Tabs(
      index: _index,
      onChanged: (int index) => setState(() => _index = index),
      children: <TabItem>[
        TabItem(child: Text('Account')),
        TabItem(child: Text('Password')),
        TabItem(child: Text('Settings')),
      ],
    );
  }
}

Widget _default(BuildContext context) {
  // The strip sizes to its content; it scrolls instead of overflowing on a
  // 375-wide phone.
  return const SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: _InteractiveTabs(),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Disabled',
      builder: '_disabled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/tabs/tabs.dart';

/// Strip with no callback, so every tab is disabled.
Widget _disabled(BuildContext context) {
  return Tabs(
    index: 0,
    children: <TabItem>[
      TabItem(child: Text('Account')),
      TabItem(child: Text('Password')),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Tab pane',
      builder: '_pane',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/tabs/tabs.dart';

/// Sortable IDE-style pane over a content card; owns its order. The fixed
/// height is inherent: the content card flexes inside the pane.
class _PaneDemo extends StatefulWidget {
  const _PaneDemo();

  @override
  State<_PaneDemo> createState() => _PaneDemoState();
}

class _PaneDemoState extends State<_PaneDemo> {
  int _focused = 1;
  List<TabPaneData<String>> _order = const <TabPaneData<String>>[
    TabPaneData<String>('main.dart'),
    TabPaneData<String>('tabs.dart'),
    TabPaneData<String>('README.md'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: TabPane<String>(
        items: _order,
        focused: _focused,
        onFocused: (int index) => setState(() => _focused = index),
        onSort: (List<TabPaneData<String>> next) =>
            setState(() => _order = next),
        itemBuilder:
            (BuildContext context, TabPaneData<String> item, int index) =>
                Text(item.data, overflow: TextOverflow.ellipsis),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text('Editor content'),
        ),
      ),
    );
  }
}

Widget _pane(BuildContext context) => const _PaneDemo();
''',
    ),
  ],
  'action_sheet': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Trigger',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/action_sheet/action_sheet.dart';
import 'package:<your_app>/ui/dashcn/components/action_sheet/action_sheet_show.dart';

Widget _default(BuildContext context) => Center(
  child: Button(
    variant: ButtonVariant.outline,
    size: ButtonSize.sm,
    onPressed: () => showActionSheet<void>(
      context: context,
      title: 'Actions',
      message: 'Choose an action',
      actions: <ActionSheetAction<void>>[
        ActionSheetAction<void>(
          label: 'Edit',
          icon: const Icon(LucideIcons.pencil),
        ),
        ActionSheetAction<void>(
          label: 'Share',
          icon: const Icon(LucideIcons.share),
        ),
        ActionSheetAction<void>(
          label: 'Delete',
          icon: const Icon(LucideIcons.trash),
          isDestructive: true,
        ),
      ],
      cancelAction: ActionSheetAction<void>(
        label: 'Cancel',
      ),
    ),
    child: Text('Open action sheet'),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Destructive',
      builder: '_destructive',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/action_sheet/action_sheet.dart';
import 'package:<your_app>/ui/dashcn/components/action_sheet/action_sheet_show.dart';

Widget _destructive(BuildContext context) => Center(
  child: Button(
    variant: ButtonVariant.destructive,
    size: ButtonSize.sm,
    onPressed: () => showActionSheet<void>(
      context: context,
      title: 'Delete item?',
      message: 'This cannot be undone.',
      actions: <ActionSheetAction<void>>[
        ActionSheetAction<void>(
          label: 'Delete',
          icon: const Icon(LucideIcons.trash),
          isDestructive: true,
        ),
      ],
      cancelAction: ActionSheetAction<void>(
        label: 'Cancel',
      ),
    ),
    child: Text('Delete item'),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Long',
      builder: '_long',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/action_sheet/action_sheet.dart';
import 'package:<your_app>/ui/dashcn/components/action_sheet/action_sheet_show.dart';

Widget _long(BuildContext context) => Center(
  child: Button(
    variant: ButtonVariant.secondary,
    size: ButtonSize.sm,
    onPressed: () => showActionSheet<void>(
      context: context,
      title: 'Many actions',
      actions: List<ActionSheetAction<void>>.generate(
        12,
        (int i) => ActionSheetAction<void>(label: 'Action ${i + 1}'),
      ),
      cancelAction: ActionSheetAction<void>(
        label: 'Cancel',
      ),
    ),
    child: Text('Many actions'),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Compact',
      builder: '_compact',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/action_sheet/action_sheet.dart';
import 'package:<your_app>/ui/dashcn/components/action_sheet/action_sheet_show.dart';

Widget _compact(BuildContext context) => ActionSheet<void>(
  densityTokens: DensityTokens.compact,
  title: 'Compact (default)',
  message: 'Row 40, icon 16, padding 12/6',
  actions: <ActionSheetAction<void>>[
    ActionSheetAction<void>(
      label: 'Edit',
      icon: Icon(LucideIcons.pencil),
    ),
    ActionSheetAction<void>(
      label: 'Share',
      icon: Icon(LucideIcons.share),
    ),
  ],
  cancelAction: ActionSheetAction<void>(label: 'Cancel'),
);
''',
    ),
    DocsExampleSource(
      name: 'Comfortable',
      builder: '_comfortable',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/action_sheet/action_sheet.dart';
import 'package:<your_app>/ui/dashcn/components/action_sheet/action_sheet_show.dart';

Widget _comfortable(BuildContext context) => ActionSheet<void>(
  densityTokens: DensityTokens.comfortable,
  title: 'Comfortable',
  message: 'Row 40-44, icon 20, padding 14/8',
  actions: <ActionSheetAction<void>>[
    ActionSheetAction<void>(
      label: 'Edit',
      icon: Icon(LucideIcons.pencil),
    ),
    ActionSheetAction<void>(
      label: 'Share',
      icon: Icon(LucideIcons.share),
    ),
  ],
  cancelAction: ActionSheetAction<void>(label: 'Cancel'),
);
''',
    ),
    DocsExampleSource(
      name: 'Customized',
      builder: '_customized',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/action_sheet/action_sheet.dart';
import 'package:<your_app>/ui/dashcn/components/action_sheet/action_sheet_show.dart';

Widget _customized(BuildContext context) => Center(
  child: Button(
    variant: ButtonVariant.outline,
    size: ButtonSize.sm,
    onPressed: () => showActionSheet<void>(
      context: context,
      title: 'Customized',
      actions: <ActionSheetAction<void>>[
        ActionSheetAction<void>(label: 'Do it'),
      ],
      theme: const ActionSheetTheme(),
      cancelAction: ActionSheetAction<void>(
        label: 'Dismiss',
      ),
    ),
    child: Text('Customized'),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Builders',
      builder: '_builders',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/action_sheet/action_sheet.dart';
import 'package:<your_app>/ui/dashcn/components/action_sheet/action_sheet_show.dart';

Widget _builders(BuildContext context) => ActionSheet<void>(
  title: 'Builders',
  message: 'Custom title and row',
  titleBuilder: (BuildContext context, String title, TextStyle style) => Text(
    title.toUpperCase(),
    style: style.copyWith(fontWeight: FontWeight.w800),
    textAlign: TextAlign.center,
  ),
  actionBuilder:
      (
        BuildContext context,
        ActionSheetAction<void> action,
        Widget row,
        bool isCancel,
      ) => Container(
        decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: Color(0xFF888888), width: 2)),
        ),
        child: row,
      ),
  actions: <ActionSheetAction<void>>[
    ActionSheetAction<void>(
      label: 'Edit',
      icon: Icon(LucideIcons.pencil),
    ),
    ActionSheetAction<void>(
      label: 'Delete',
      isDestructive: true,
    ),
  ],
  cancelAction: ActionSheetAction<void>(label: 'Cancel'),
);
''',
    ),
    DocsExampleSource(
      name: 'Inline',
      builder: '_inline',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/action_sheet/action_sheet.dart';
import 'package:<your_app>/ui/dashcn/components/action_sheet/action_sheet_show.dart';

Widget _inline(BuildContext context) => ActionSheet<void>(
  title: 'Inline sheet',
  message: 'Embedded directly into a layout',
  actions: <ActionSheetAction<void>>[
    ActionSheetAction<void>(
      label: 'Edit',
      icon: Icon(LucideIcons.pencil),
    ),
    ActionSheetAction<void>(
      label: 'Share',
      icon: Icon(LucideIcons.share),
    ),
  ],
  cancelAction: ActionSheetAction<void>(label: 'Cancel'),
);
''',
    ),
  ],
  'alert_dialog': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Delete account',
      builder: '_deleteAccount',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/alert_dialog/alert_dialog.dart';

/// Centred trigger button, like the `dialog` previews.
class _Trigger extends StatelessWidget {
  const _Trigger({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

/// Confirm/cancel footer. Built from the dialog's own context: popping the
/// caller's context would pop the page under the dialog in apps with nested
/// navigators.
List<Widget> _confirmActions(
  BuildContext dialogContext, {
  required String confirmLabel,
  required ButtonVariant confirmVariant,
}) {
  return <Widget>[
    Button(
      size: ButtonSize.sm,
      variant: ButtonVariant.outline,
      onPressed: () => Navigator.of(dialogContext).pop(false),
      child: Text('Cancel'),
    ),
    Button(
      size: ButtonSize.sm,
      variant: confirmVariant,
      onPressed: () => Navigator.of(dialogContext).pop(true),
      child: Text(confirmLabel),
    ),
  ];
}

/// Destructive delete-account confirmation.
Widget _deleteAccount(BuildContext context) => _Trigger(
  label: 'Delete account',
  onPressed: () => showAlertDialog<bool>(
    context: context,
    icon: const Icon(LucideIcons.circleAlert),
    title: Text('Delete your account?'),
    description: Text(
      'This permanently deletes your account and all of its data. This action cannot be undone.',
    ),
    actionsBuilder: (BuildContext dialogContext) => _confirmActions(
      dialogContext,
      confirmLabel: 'Delete account',
      confirmVariant: ButtonVariant.destructive,
    ),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Discard changes',
      builder: '_discardChanges',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/alert_dialog/alert_dialog.dart';

/// Centred trigger button, like the `dialog` previews.
class _Trigger extends StatelessWidget {
  const _Trigger({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

/// Confirm/cancel footer. Built from the dialog's own context: popping the
/// caller's context would pop the page under the dialog in apps with nested
/// navigators.
List<Widget> _confirmActions(
  BuildContext dialogContext, {
  required String confirmLabel,
  required ButtonVariant confirmVariant,
}) {
  return <Widget>[
    Button(
      size: ButtonSize.sm,
      variant: ButtonVariant.outline,
      onPressed: () => Navigator.of(dialogContext).pop(false),
      child: Text('Cancel'),
    ),
    Button(
      size: ButtonSize.sm,
      variant: confirmVariant,
      onPressed: () => Navigator.of(dialogContext).pop(true),
      child: Text(confirmLabel),
    ),
  ];
}

/// Discard-changes confirmation.
Widget _discardChanges(BuildContext context) => _Trigger(
  label: 'Discard changes',
  onPressed: () => showAlertDialog<bool>(
    context: context,
    icon: const Icon(LucideIcons.triangleAlert),
    title: Text('Discard unsaved changes?'),
    description: Text(
      'You have unsaved changes to this document. Leaving now will lose them.',
    ),
    actionsBuilder: (BuildContext dialogContext) => _confirmActions(
      dialogContext,
      confirmLabel: 'Discard',
      confirmVariant: ButtonVariant.destructive,
    ),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Session expiring',
      builder: '_sessionExpiring',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/alert_dialog/alert_dialog.dart';

/// Centred trigger button, like the `dialog` previews.
class _Trigger extends StatelessWidget {
  const _Trigger({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

/// Live countdown text of the session dialog; ticks while the dialog is open.
class _SessionCountdown extends StatefulWidget {
  const _SessionCountdown();

  @override
  State<_SessionCountdown> createState() => _SessionCountdownState();
}

class _SessionCountdownState extends State<_SessionCountdown> {
  static const int _total = 90;
  int _left = _total;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) {
        return;
      }
      setState(() => _left = _left > 0 ? _left - 1 : 0);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int minutes = _left ~/ 60;
    final String seconds = (_left % 60).toString().padLeft(2, '0');
    return Text(
      'Your session ends in $minutes:$seconds. Extend it to keep working.',
    );
  }
}

/// Session-expiring countdown with an explicit way out.
Widget _sessionExpiring(BuildContext context) => _Trigger(
  label: 'Session expiring',
  onPressed: () => showAlertDialog<bool>(
    context: context,
    icon: const Icon(LucideIcons.clock),
    title: Text('Session expiring'),
    description: const _SessionCountdown(),
    actionsBuilder: (BuildContext dialogContext) => <Widget>[
      Button(
        size: ButtonSize.sm,
        variant: ButtonVariant.outline,
        onPressed: () => Navigator.of(dialogContext).pop(false),
        child: Text('Sign out'),
      ),
      Button(
        size: ButtonSize.sm,
        variant: ButtonVariant.primary,
        onPressed: () => Navigator.of(dialogContext).pop(true),
        child: Text('Stay signed in'),
      ),
    ],
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Success',
      builder: '_success',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/alert_dialog/alert_dialog.dart';

/// Centred trigger button, like the `dialog` previews.
class _Trigger extends StatelessWidget {
  const _Trigger({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

/// Success confirmation.
Widget _success(BuildContext context) => _Trigger(
  label: 'Show success',
  onPressed: () => showAlertDialog<bool>(
    context: context,
    icon: const Icon(LucideIcons.circleCheck),
    title: Text('Payment successful'),
    description: Text(
      'Your subscription is active. A receipt was sent to your inbox.',
    ),
    actionsBuilder: (BuildContext dialogContext) => <Widget>[
      Button(
        size: ButtonSize.sm,
        variant: ButtonVariant.primary,
        onPressed: () => Navigator.of(dialogContext).pop(true),
        child: Text('Done'),
      ),
    ],
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Live push',
      builder: '_livePush',
      code: r'''import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/alert_dialog/alert_dialog.dart';

/// A live push through `showAlertDialog` over the whole app.
class _LivePush extends StatelessWidget {
  const _LivePush();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        onPressed: () => showAlertDialog<bool>(
          context: context,
          icon: const Icon(LucideIcons.triangleAlert),
          title: Text('Delete this project?'),
          description: Text(
            'This action cannot be undone. The project and its history is removed.',
          ),
          actionsBuilder: (BuildContext dialogContext) => <Widget>[
            Button(
              variant: ButtonVariant.outline,
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text('Cancel'),
            ),
            Button(
              variant: ButtonVariant.destructive,
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text('Delete'),
            ),
          ],
        ),
        child: Text('Show alert dialog'),
      ),
    );
  }
}

Widget _livePush(BuildContext context) => const _LivePush();
''',
    ),
  ],
  'dialog': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Edit profile',
      builder: '_editProfile',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';
import 'package:<your_app>/ui/dashcn/components/dialog/dialog.dart';

/// Centred trigger button.
class _Trigger extends StatelessWidget {
  const _Trigger({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

/// Dialog title line in the foreground token.
Widget _title(BuildContext context, String text) {
  final theme = Theme.of(context);
  return Text(
    text,
    style: TextStyle(
      color: theme.colors.foreground,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );
}

/// Action row: right-aligned, wraps on narrow cards.
Widget _actions(BuildContext context, List<Widget> buttons) {
  return Wrap(
    alignment: WrapAlignment.end,
    spacing: 8,
    runSpacing: 8,
    children: buttons,
  );
}

/// Edit-profile form with working Save/Cancel.
class _EditProfileBody extends StatefulWidget {
  const _EditProfileBody();

  @override
  State<_EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<_EditProfileBody> {
  final TextEditingController _name = TextEditingController(text: 'Ada');
  final TextEditingController _user = TextEditingController(text: 'ada');

  @override
  void dispose() {
    _name.dispose();
    _user.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gap = Theme.of(context).spacing.md;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _title(context, 'Edit profile'),
        Gap(gap),
        Input(
          controller: _name,
          placeholder: Text('Name'),
        ),
        Gap(gap),
        Input(
          controller: _user,
          placeholder: Text('Username'),
        ),
        Gap(gap * 2),
        _actions(context, <Widget>[
          Button(
            variant: ButtonVariant.outline,
            size: ButtonSize.sm,
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel'),
          ),
          Button(
            size: ButtonSize.sm,
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Save'),
          ),
        ]),
      ],
    );
  }
}

Widget _editProfile(BuildContext context) => _Trigger(
  label: 'Edit profile',
  onPressed: () => showDialog<bool>(
    context: context,
    builder: (context) => const _EditProfileBody(),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Share link',
      builder: '_share',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';
import 'package:<your_app>/ui/dashcn/components/dialog/dialog.dart';

/// Centred trigger button.
class _Trigger extends StatelessWidget {
  const _Trigger({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

/// Dialog title line in the foreground token.
Widget _title(BuildContext context, String text) {
  final theme = Theme.of(context);
  return Text(
    text,
    style: TextStyle(
      color: theme.colors.foreground,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );
}

/// Dialog body text in the muted token.
Widget _body(BuildContext context, String text) {
  return Text(
    text,
    style: TextStyle(color: Theme.of(context).colors.mutedForeground),
  );
}

/// Action row: right-aligned, wraps on narrow cards.
Widget _actions(BuildContext context, List<Widget> buttons) {
  return Wrap(
    alignment: WrapAlignment.end,
    spacing: 8,
    runSpacing: 8,
    children: buttons,
  );
}

/// Share link with a working copy button.
class _ShareBody extends StatefulWidget {
  const _ShareBody();

  @override
  State<_ShareBody> createState() => _ShareBodyState();
}

class _ShareBodyState extends State<_ShareBody> {
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(
      const ClipboardData(text: 'https://example.com/s/abc123'),
    );
    if (mounted) setState(() => _copied = true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gap = theme.spacing.md;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _title(context, 'Share this document'),
        Gap(gap),
        _body(context, 'Anyone with the link can view.'),
        Gap(gap),
        DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colors.muted,
            borderRadius: theme.borderRadiusMd,
            border: Border.all(color: theme.colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: <Widget>[
                Flexible(child: Text('example.com/s/abc123')),
                Gap(gap),
                Button(
                  variant: ButtonVariant.secondary,
                  size: ButtonSize.sm,
                  onPressed: _copy,
                  child: Text(
                    _copied
                        ? 'Copied!'
                        : 'Copy',
                  ),
                ),
              ],
            ),
          ),
        ),
        Gap(gap * 2),
        _actions(context, <Widget>[
          Button(
            variant: ButtonVariant.outline,
            size: ButtonSize.sm,
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ]),
      ],
    );
  }
}

Widget _share(BuildContext context) => _Trigger(
  label: 'Share link',
  onPressed: () =>
      showDialog<void>(context: context, builder: (_) => const _ShareBody()),
);
''',
    ),
    DocsExampleSource(
      name: 'Invite members',
      builder: '_invite',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';
import 'package:<your_app>/ui/dashcn/components/dialog/dialog.dart';

/// Centred trigger button.
class _Trigger extends StatelessWidget {
  const _Trigger({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

/// Dialog title line in the foreground token.
Widget _title(BuildContext context, String text) {
  final theme = Theme.of(context);
  return Text(
    text,
    style: TextStyle(
      color: theme.colors.foreground,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );
}

/// Action row: right-aligned, wraps on narrow cards.
Widget _actions(BuildContext context, List<Widget> buttons) {
  return Wrap(
    alignment: WrapAlignment.end,
    spacing: 8,
    runSpacing: 8,
    children: buttons,
  );
}

/// Invite team members with a working list.
class _InviteBody extends StatefulWidget {
  const _InviteBody();

  @override
  State<_InviteBody> createState() => _InviteBodyState();
}

class _InviteBodyState extends State<_InviteBody> {
  final TextEditingController _email = TextEditingController();
  final List<String> _invited = <String>['ada@example.com'];

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gap = Theme.of(context).spacing.md;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _title(context, 'Invite members'),
        Gap(gap),
        Row(
          children: <Widget>[
            Flexible(
              child: Input(
                controller: _email,
                hintText: 'Email',
              ),
            ),
            Gap(gap),
            Button(
              size: ButtonSize.sm,
              onPressed: () {
                final String value = _email.text.trim();
                if (value.isEmpty) return;
                setState(() {
                  _invited.add(value);
                  _email.clear();
                });
              },
              child: Text('Invite'),
            ),
          ],
        ),
        Gap(gap),
        for (final String address in _invited) Text(address),
        Gap(gap * 2),
        _actions(context, <Widget>[
          Button(
            variant: ButtonVariant.outline,
            size: ButtonSize.sm,
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Done'),
          ),
        ]),
      ],
    );
  }
}

Widget _invite(BuildContext context) => _Trigger(
  label: 'Invite members',
  onPressed: () =>
      showDialog<void>(context: context, builder: (_) => const _InviteBody()),
);
''',
    ),
    DocsExampleSource(
      name: 'Terms',
      builder: '_terms',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';
import 'package:<your_app>/ui/dashcn/components/dialog/dialog.dart';

/// Centred trigger button.
class _Trigger extends StatelessWidget {
  const _Trigger({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

/// Dialog title line in the foreground token.
Widget _title(BuildContext context, String text) {
  final theme = Theme.of(context);
  return Text(
    text,
    style: TextStyle(
      color: theme.colors.foreground,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );
}

/// Dialog body text in the muted token.
Widget _body(BuildContext context, String text) {
  return Text(
    text,
    style: TextStyle(color: Theme.of(context).colors.mutedForeground),
  );
}

/// Action row: right-aligned, wraps on narrow cards.
Widget _actions(BuildContext context, List<Widget> buttons) {
  return Wrap(
    alignment: WrapAlignment.end,
    spacing: 8,
    runSpacing: 8,
    children: buttons,
  );
}

/// Scrollable terms with explicit Accept/Decline.
Widget _termsBody(BuildContext context) {
  final gap = Theme.of(context).spacing.md;
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _title(context, 'Terms of service'),
      Gap(gap),
      ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 220),
        child: SingleChildScrollView(
          child: _body(
            context,
            '1. Be kind.\n\n2. Ship working software.\n\n3. Respect the theme tokens.\n\n4. Prefer composition.\n\n'
            '5. Test what you ship.\n\n6. Document the contract.',
          ),
        ),
      ),
      Gap(gap * 2),
      _actions(context, <Widget>[
        Button(
          variant: ButtonVariant.outline,
          size: ButtonSize.sm,
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('Decline'),
        ),
        Button(
          size: ButtonSize.sm,
          onPressed: () => Navigator.of(context).pop(true),
          child: Text('Accept'),
        ),
      ]),
    ],
  );
}

Widget _terms(BuildContext context) => _Trigger(
  label: 'Read terms',
  onPressed: () => showDialog<bool>(
    context: context,
    builder: (context) => _termsBody(context),
  ),
);
''',
    ),
    DocsExampleSource(
      name: 'Picker',
      builder: '_picker',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';
import 'package:<your_app>/ui/dashcn/components/dialog/dialog.dart';

/// Centred trigger button.
class _Trigger extends StatelessWidget {
  const _Trigger({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

/// Dialog title line in the foreground token.
Widget _title(BuildContext context, String text) {
  final theme = Theme.of(context);
  return Text(
    text,
    style: TextStyle(
      color: theme.colors.foreground,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );
}

/// Dialog body text in the muted token.
Widget _body(BuildContext context, String text) {
  return Text(
    text,
    style: TextStyle(color: Theme.of(context).colors.mutedForeground),
  );
}

/// Command-like picker with a working filter.
class _PickerBody extends StatefulWidget {
  const _PickerBody();

  @override
  State<_PickerBody> createState() => _PickerBodyState();
}

class _PickerBodyState extends State<_PickerBody> {
  final TextEditingController _query = TextEditingController();
  String _filter = '';

  static final List<String> _items = <String>[
    'Calendar',
    'Search Emoji',
    'Calculator',
    'Activity',
  ];

  @override
  void initState() {
    super.initState();
    _query.addListener(() => setState(() => _filter = _query.text));
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gap = Theme.of(context).spacing.md;
    final List<String> shown = _items
        .where(
          (String item) => item.toLowerCase().contains(_filter.toLowerCase()),
        )
        .toList();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _title(context, 'Jump to…'),
        Gap(gap),
        Input(
          controller: _query,
          hintText: 'Type to filter',
        ),
        Gap(gap),
        for (final String item in shown)
          Button(
            variant: ButtonVariant.ghost,
            size: ButtonSize.sm,
            onPressed: () => Navigator.of(context).pop(item),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(item),
            ),
          ),
        if (shown.isEmpty) _body(context, 'No matches.'),
      ],
    );
  }
}

Widget _picker(BuildContext context) => _Trigger(
  label: 'Open picker',
  onPressed: () =>
      showDialog<String>(context: context, builder: (_) => const _PickerBody()),
);
''',
    ),
    DocsExampleSource(
      name: 'Barrier locked',
      builder: '_locked',
      code: r'''import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';
import 'package:<your_app>/ui/dashcn/components/dialog/dialog.dart';

/// Centred trigger button.
class _Trigger extends StatelessWidget {
  const _Trigger({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

/// Dialog title line in the foreground token.
Widget _title(BuildContext context, String text) {
  final theme = Theme.of(context);
  return Text(
    text,
    style: TextStyle(
      color: theme.colors.foreground,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );
}

/// Dialog body text in the muted token.
Widget _body(BuildContext context, String text) {
  return Text(
    text,
    style: TextStyle(color: Theme.of(context).colors.mutedForeground),
  );
}

/// Action row: right-aligned, wraps on narrow cards.
Widget _actions(BuildContext context, List<Widget> buttons) {
  return Wrap(
    alignment: WrapAlignment.end,
    spacing: 8,
    runSpacing: 8,
    children: buttons,
  );
}

/// Barrier-locked dialog with an explicit Cancel way out (never traps).
Widget _lockedBody(BuildContext context) {
  final gap = Theme.of(context).spacing.md;
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _title(context, 'Delete this project?'),
      Gap(gap),
      _body(
        context,
        'The barrier is locked: tap outside or press Escape does nothing. Use Cancel or Delete to leave.',
      ),
      Gap(gap * 2),
      _actions(context, <Widget>[
        Button(
          variant: ButtonVariant.outline,
          size: ButtonSize.sm,
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('Cancel'),
        ),
        Button(
          variant: ButtonVariant.destructive,
          size: ButtonSize.sm,
          onPressed: () => Navigator.of(context).pop(true),
          child: Text('Delete'),
        ),
      ]),
    ],
  );
}

Widget _locked(BuildContext context) => _Trigger(
  label: 'Open locked dialog',
  onPressed: () => showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => _lockedBody(context),
  ),
);
''',
    ),
  ],
  'drawer': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/drawer/drawer.dart';

/// Panel body used by the drawer examples.
class _DrawerContent extends StatelessWidget {
  const _DrawerContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Drawer content',
          style: TextStyle(
            color: theme.colors.foreground,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          'Slides in from the edge over the whole app.',
          style: TextStyle(color: theme.colors.mutedForeground),
        ),
        Gap(theme.spacing.lg),
        Button(
          size: ButtonSize.sm,
          onPressed: () => closeDrawer(context),
          child: Text('Close'),
        ),
      ],
    );
  }
}

/// Opens a drawer at [position].
class _DrawerTrigger extends StatelessWidget {
  const _DrawerTrigger({required this.position, required this.label});

  final OverlayPosition position;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Button(
      variant: ButtonVariant.outline,
      size: ButtonSize.sm,
      onPressed: () => openDrawer<void>(
        context: context,
        position: position,
        builder: (BuildContext context) => const _DrawerContent(),
      ),
      child: Text(label),
    );
  }
}

/// Side drawers, one row (upstream shows the four edges together).
Widget _default(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Center(
    child: Wrap(
      spacing: spacing.sm,
      runSpacing: spacing.sm,
      alignment: WrapAlignment.center,
      children: <Widget>[
        _DrawerTrigger(
          position: OverlayPosition.start,
          label: 'Open left',
        ),
        _DrawerTrigger(
          position: OverlayPosition.end,
          label: 'Open right',
        ),
        _DrawerTrigger(
          position: OverlayPosition.top,
          label: 'Open top',
        ),
        _DrawerTrigger(
          position: OverlayPosition.bottom,
          label: 'Open bottom',
        ),
      ],
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Sheet',
      builder: '_sheet',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/drawer/drawer.dart';

/// Sheet body used by the sheet example.
class _SheetContent extends StatelessWidget {
  const _SheetContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Sheet content',
          style: TextStyle(
            color: theme.colors.foreground,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          'An expanding bottom sheet with a drag handle.',
          style: TextStyle(color: theme.colors.mutedForeground),
        ),
        Gap(theme.spacing.lg),
        Button(
          variant: ButtonVariant.outline,
          size: ButtonSize.sm,
          onPressed: () => closeSheet(context),
          child: Text('Close'),
        ),
      ],
    );
  }
}

/// The bottom sheet form.
Widget _sheet(BuildContext context) {
  return Center(
    child: Button(
      variant: ButtonVariant.secondary,
      size: ButtonSize.sm,
      onPressed: () => openSheet<void>(
        context: context,
        draggable: true,
        builder: (BuildContext context) => const _SheetContent(),
      ),
      child: Text('Open sheet'),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Background scale',
      builder: '_scale',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/drawer/drawer.dart';

/// Panel body used by the drawer examples.
class _DrawerContent extends StatelessWidget {
  const _DrawerContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Drawer content',
          style: TextStyle(
            color: theme.colors.foreground,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          'Slides in from the edge over the whole app.',
          style: TextStyle(color: theme.colors.mutedForeground),
        ),
        Gap(theme.spacing.lg),
        Button(
          size: ButtonSize.sm,
          onPressed: () => closeDrawer(context),
          child: Text('Close'),
        ),
      ],
    );
  }
}

/// Background-scale demo: its own navigator + observer, so the scale reads
/// inside the stage. Opening the drawer scales the mock app to ≈0.95 with
/// rounded corners and a dim.
class _ScaleDemo extends StatefulWidget {
  const _ScaleDemo();

  @override
  State<_ScaleDemo> createState() => _ScaleDemoState();
}

class _ScaleDemoState extends State<_ScaleDemo> {
  final DrawerScaleObserver _observer = DrawerScaleObserver();
  final GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // A fixed box is inherent: the scale needs a mock app viewport to
    // transform, like toasts need a layer stage.
    // Semantics container: the nested `Navigator` inserts a `ModalBarrier`
    // (`BlockSemantics`) per route, which would otherwise hide sibling
    // page content (e.g. the docs article title) from assistive tech.
    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: Center(
        child: SizedBox(
          width: 340,
          height: 300,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: theme.colors.border),
              borderRadius: theme.borderRadiusLg,
            ),
            child: ClipRRect(
              borderRadius: theme.borderRadiusLg,
              child: Navigator(
                key: _key,
                observers: <NavigatorObserver>[_observer],
                onGenerateRoute: (RouteSettings settings) =>
                    PageRouteBuilder<void>(
                      settings: settings,
                      pageBuilder: (_, _, _) => DrawerBackgroundScale(
                        observer: _observer,
                        child: ColoredBox(
                          color: theme.colors.background,
                          child: Center(
                            child: Builder(
                              builder: (BuildContext context) => Button(
                                variant: ButtonVariant.outline,
                                size: ButtonSize.sm,
                                onPressed: () => openDrawer<void>(
                                  context: context,
                                  useRootNavigator: false,
                                  builder: (_) => const _DrawerContent(),
                                ),
                                child: Text(
                                  'Open scaled drawer',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _scale(BuildContext context) => const _ScaleDemo();
''',
    ),
    DocsExampleSource(
      name: 'Themed',
      builder: '_themed',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/drawer/drawer.dart';

/// Panel body used by the drawer examples.
class _DrawerContent extends StatelessWidget {
  const _DrawerContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Drawer content',
          style: TextStyle(
            color: theme.colors.foreground,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          'Slides in from the edge over the whole app.',
          style: TextStyle(color: theme.colors.mutedForeground),
        ),
        Gap(theme.spacing.lg),
        Button(
          size: ButtonSize.sm,
          onPressed: () => closeDrawer(context),
          child: Text('Close'),
        ),
      ],
    );
  }
}

/// A drawer themed from the widget leg.
Widget _themed(BuildContext context) {
  return Center(
    child: Button(
      variant: ButtonVariant.secondary,
      size: ButtonSize.sm,
      onPressed: () => openDrawer<void>(
        context: context,
        theme: const DrawerTheme(
          maxSize: 280,
          background: ThemedColor.ref(ColorRef.card),
        ),
        builder: (BuildContext context) => const _DrawerContent(),
      ),
      child: Text('Open themed drawer'),
    ),
  );
}
''',
    ),
  ],
  'gooey_toast': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Playground',
      builder: '_playground',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';
import 'package:<your_app>/ui/dashcn/components/gooey_toast/gooey_toast.dart';

/// Shared playground config: the single source of look for every demo.
class _Shared {
  const _Shared({
    this.shape = GooeyToastShapeStyle.sharp,
    this.animation = GooeyToastAnimationStyle.smooth,
    this.position = GooeyToastPosition.center,
    this.fill = const ThemedColor.value(gooeySurfaceFill),
  });

  final GooeyToastShapeStyle shape;
  final GooeyToastAnimationStyle animation;
  final GooeyToastPosition position;
  final ThemedColor fill;

  _Shared copyWith({
    GooeyToastShapeStyle? shape,
    GooeyToastAnimationStyle? animation,
    GooeyToastPosition? position,
    ThemedColor? fill,
  }) {
    return _Shared(
      shape: shape ?? this.shape,
      animation: animation ?? this.animation,
      position: position ?? this.position,
      fill: fill ?? this.fill,
    );
  }
}

/// The one shared config; the Playground mutates it, every demo reads it.
final ValueNotifier<_Shared> _shared = ValueNotifier<_Shared>(const _Shared());

const double _kWidth = 360;

const double _kRoundness = 16;

const GooeyAutopilot _kAutopilot = GooeyAutopilot(
  expandDelay: Duration(milliseconds: 180),
  collapseDelay: Duration(milliseconds: 3200),
);

/// One demo toast in the shared look for [state].
GooeyToastOptions _toast({
  required String title,
  required String description,
  required GooeyToastState state,
  GooeyToastAction? action,
}) {
  final _Shared shared = _shared.value;
  return GooeyToastOptions(
    title: title,
    description: description,
    state: state,
    action: action,
    position: shared.position,
    width: _kWidth,
    roundness: _kRoundness,
    shapeStyle: shared.shape,
    animationStyle: shared.animation,
    autopilot: _kAutopilot,
  );
}

/// Layer whose fill follows the shared config.
class _Layer extends StatefulWidget {
  const _Layer({required this.child, required this.controller});

  final Widget child;
  final GooeyToastController controller;

  @override
  State<_Layer> createState() => _LayerState();
}

class _LayerState extends State<_Layer> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<_Shared>(
      valueListenable: _shared,
      builder: (context, shared, _) => GooeyToastLayer(
        controller: widget.controller,
        theme: GooeyToastTheme(fill: shared.fill),
        child: widget.child,
      ),
    );
  }
}

/// Small option chip used by the controls bar.
Widget _chip({
  required String label,
  required bool selected,
  required VoidCallback onPressed,
}) {
  return Button(
    variant: selected ? ButtonVariant.primary : ButtonVariant.outline,
    size: ButtonSize.sm,
    onPressed: onPressed,
    child: Text(label),
  );
}

/// The Playground: shared controls plus one trigger per variant.
class _Playground extends StatefulWidget {
  const _Playground();

  @override
  State<_Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<_Playground> {
  final GooeyToastController _controller = GooeyToastController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _show(GooeyToastState state) {
    final (String title, String description) = _copy(state);
    _controller.showGooeyToast(
      context,
      _toast(
        title: title,
        description: description,
        state: state,
        action: state == GooeyToastState.action
            ? GooeyToastAction(
                label: 'Confirm',
                onPressed: () {},
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double gap = Theme.of(context).density.baseGap;
    return _Layer(
      controller: _controller,
      child: ValueListenableBuilder<_Shared>(
        valueListenable: _shared,
        builder: (context, shared, _) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Wrap(
              spacing: gap,
              runSpacing: gap,
              alignment: WrapAlignment.center,
              children: <Widget>[
                _chip(
                  label: 'sharp',
                  selected: shared.shape == GooeyToastShapeStyle.sharp,
                  onPressed: () => _shared.value = shared.copyWith(
                    shape: GooeyToastShapeStyle.sharp,
                  ),
                ),
                _chip(
                  label: 'soft',
                  selected: shared.shape == GooeyToastShapeStyle.soft,
                  onPressed: () => _shared.value = shared.copyWith(
                    shape: GooeyToastShapeStyle.soft,
                  ),
                ),
              ],
            ),
            SizedBox(height: gap),
            Wrap(
              spacing: gap,
              runSpacing: gap,
              alignment: WrapAlignment.center,
              children: <Widget>[
                for (final GooeyToastAnimationStyle style
                    in GooeyToastAnimationStyle.values)
                  _chip(
                    label: style.name,
                    selected: shared.animation == style,
                    onPressed: () =>
                        _shared.value = shared.copyWith(animation: style),
                  ),
              ],
            ),
            SizedBox(height: gap),
            Wrap(
              spacing: gap,
              runSpacing: gap,
              alignment: WrapAlignment.center,
              children: <Widget>[
                for (final GooeyToastPosition position
                    in GooeyToastPosition.values)
                  _chip(
                    label: position.name,
                    selected: shared.position == position,
                    onPressed: () =>
                        _shared.value = shared.copyWith(position: position),
                  ),
              ],
            ),
            SizedBox(height: gap),
            Wrap(
              spacing: gap,
              runSpacing: gap,
              alignment: WrapAlignment.center,
              children: <Widget>[
                _chip(
                  label: 'light fill',
                  selected:
                      shared.fill == const ThemedColor.value(gooeySurfaceFill),
                  onPressed: () => _shared.value = shared.copyWith(
                    fill: const ThemedColor.value(gooeySurfaceFill),
                  ),
                ),
                _chip(
                  label: 'dark fill',
                  selected:
                      shared.fill == const ThemedColor.value(Color(0xFF232326)),
                  onPressed: () => _shared.value = shared.copyWith(
                    fill: const ThemedColor.value(Color(0xFF232326)),
                  ),
                ),
                _chip(
                  label: 'popover fill',
                  selected:
                      shared.fill == const ThemedColor.ref(ColorRef.popover),
                  onPressed: () => _shared.value = shared.copyWith(
                    fill: const ThemedColor.ref(ColorRef.popover),
                  ),
                ),
              ],
            ),
            SizedBox(height: gap * 2),
            Wrap(
              spacing: gap,
              runSpacing: gap,
              alignment: WrapAlignment.center,
              children: <Widget>[
                for (final GooeyToastState state in GooeyToastState.values)
                  Button(
                    variant: ButtonVariant.outline,
                    size: ButtonSize.sm,
                    onPressed: () => _show(state),
                    child: Text(state.name),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

(String, String) _copy(GooeyToastState state) => switch (state) {
  GooeyToastState.success => (
    'Success',
    'Workspace settings were saved.',
  ),
  GooeyToastState.loading => (
    'Processing',
    'Please wait while we process.',
  ),
  GooeyToastState.error => (
    'Error',
    'Failed to sync your workspace.',
  ),
  GooeyToastState.warning => (
    'Storage Warning',
    'You are running out of storage space.',
  ),
  GooeyToastState.info => (
    'Heads up',
    'A new update is available.',
  ),
  GooeyToastState.action => (
    'Action Required',
    'Review and confirm this request.',
  ),
};

Widget _playground(BuildContext context) => const _Playground();
''',
    ),
    DocsExampleSource(
      name: 'Promise',
      builder: '_promise',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';
import 'package:<your_app>/ui/dashcn/components/gooey_toast/gooey_toast.dart';

/// Shared playground config: the single source of look for every demo.
class _Shared {
  const _Shared({
    this.shape = GooeyToastShapeStyle.sharp,
    this.animation = GooeyToastAnimationStyle.smooth,
    this.position = GooeyToastPosition.center,
    this.fill = const ThemedColor.value(gooeySurfaceFill),
  });

  final GooeyToastShapeStyle shape;
  final GooeyToastAnimationStyle animation;
  final GooeyToastPosition position;
  final ThemedColor fill;

  _Shared copyWith({
    GooeyToastShapeStyle? shape,
    GooeyToastAnimationStyle? animation,
    GooeyToastPosition? position,
    ThemedColor? fill,
  }) {
    return _Shared(
      shape: shape ?? this.shape,
      animation: animation ?? this.animation,
      position: position ?? this.position,
      fill: fill ?? this.fill,
    );
  }
}

/// The one shared config; the Playground mutates it, every demo reads it.
final ValueNotifier<_Shared> _shared = ValueNotifier<_Shared>(const _Shared());

const double _kWidth = 360;

const double _kRoundness = 16;

const GooeyAutopilot _kAutopilot = GooeyAutopilot(
  expandDelay: Duration(milliseconds: 180),
  collapseDelay: Duration(milliseconds: 3200),
);

/// One demo toast in the shared look for [state].
GooeyToastOptions _toast({
  required String title,
  required String description,
  required GooeyToastState state,
  GooeyToastAction? action,
}) {
  final _Shared shared = _shared.value;
  return GooeyToastOptions(
    title: title,
    description: description,
    state: state,
    action: action,
    position: shared.position,
    width: _kWidth,
    roundness: _kRoundness,
    shapeStyle: shared.shape,
    animationStyle: shared.animation,
    autopilot: _kAutopilot,
  );
}

/// Layer whose fill follows the shared config.
class _Layer extends StatefulWidget {
  const _Layer({required this.child, required this.controller});

  final Widget child;
  final GooeyToastController controller;

  @override
  State<_Layer> createState() => _LayerState();
}

class _LayerState extends State<_Layer> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<_Shared>(
      valueListenable: _shared,
      builder: (context, shared, _) => GooeyToastLayer(
        controller: widget.controller,
        theme: GooeyToastTheme(fill: shared.fill),
        child: widget.child,
      ),
    );
  }
}

/// Promise flow in the shared look.
class _PromiseDemo extends StatefulWidget {
  const _PromiseDemo();

  @override
  State<_PromiseDemo> createState() => _PromiseDemoState();
}

class _PromiseDemoState extends State<_PromiseDemo> {
  final GooeyToastController _controller = GooeyToastController();
  bool _running = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _run() async {
    if (_running) return;
    setState(() => _running = true);
    final _Shared shared = _shared.value;
    final String id = _controller.showGooeyToast(
      context,
      GooeyToastOptions(
        title: 'Uploading',
        state: GooeyToastState.loading,
        persistUntilDismissed: true,
        autopilot: const GooeyAutopilot(),
        position: shared.position,
        shapeStyle: shared.shape,
        animationStyle: shared.animation,
      ),
      id: 'promise',
      autoDismiss: false,
      duration: const Duration(milliseconds: 400),
    );
    await Future<void>.delayed(const Duration(milliseconds: 1300));
    if (!mounted) return;
    _controller.showGooeyToast(
      context,
      _toast(
        title: 'Upload Complete',
        description: 'Your file is ready.',
        state: GooeyToastState.success,
      ),
      id: id,
      duration: const Duration(milliseconds: 4000),
    );
    if (mounted) setState(() => _running = false);
  }

  @override
  Widget build(BuildContext context) {
    return _Layer(
      controller: _controller,
      child: Center(
        child: Button(
          variant: ButtonVariant.outline,
          size: ButtonSize.sm,
          onPressed: _running ? null : _run,
          child: Text(
            _running
                ? 'Uploading…'
                : 'Start upload',
          ),
        ),
      ),
    );
  }
}

Widget _promise(BuildContext context) => const _PromiseDemo();
''',
    ),
    DocsExampleSource(
      name: 'Interactive Reply',
      builder: '_reply',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';
import 'package:<your_app>/ui/dashcn/components/gooey_toast/gooey_toast.dart';

/// Shared playground config: the single source of look for every demo.
class _Shared {
  const _Shared({
    this.shape = GooeyToastShapeStyle.sharp,
    this.animation = GooeyToastAnimationStyle.smooth,
    this.position = GooeyToastPosition.center,
    this.fill = const ThemedColor.value(gooeySurfaceFill),
  });

  final GooeyToastShapeStyle shape;
  final GooeyToastAnimationStyle animation;
  final GooeyToastPosition position;
  final ThemedColor fill;

  _Shared copyWith({
    GooeyToastShapeStyle? shape,
    GooeyToastAnimationStyle? animation,
    GooeyToastPosition? position,
    ThemedColor? fill,
  }) {
    return _Shared(
      shape: shape ?? this.shape,
      animation: animation ?? this.animation,
      position: position ?? this.position,
      fill: fill ?? this.fill,
    );
  }
}

/// The one shared config; the Playground mutates it, every demo reads it.
final ValueNotifier<_Shared> _shared = ValueNotifier<_Shared>(const _Shared());

const double _kWidth = 360;

const double _kRoundness = 16;

const GooeyAutopilot _kAutopilot = GooeyAutopilot(
  expandDelay: Duration(milliseconds: 180),
  collapseDelay: Duration(milliseconds: 3200),
);

/// One demo toast in the shared look for [state].
GooeyToastOptions _toast({
  required String title,
  required String description,
  required GooeyToastState state,
  GooeyToastAction? action,
}) {
  final _Shared shared = _shared.value;
  return GooeyToastOptions(
    title: title,
    description: description,
    state: state,
    action: action,
    position: shared.position,
    width: _kWidth,
    roundness: _kRoundness,
    shapeStyle: shared.shape,
    animationStyle: shared.animation,
    autopilot: _kAutopilot,
  );
}

/// Layer whose fill follows the shared config.
class _Layer extends StatefulWidget {
  const _Layer({required this.child, required this.controller});

  final Widget child;
  final GooeyToastController controller;

  @override
  State<_Layer> createState() => _LayerState();
}

class _LayerState extends State<_Layer> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<_Shared>(
      valueListenable: _shared,
      builder: (context, shared, _) => GooeyToastLayer(
        controller: widget.controller,
        theme: GooeyToastTheme(fill: shared.fill),
        child: widget.child,
      ),
    );
  }
}

/// Interactive reply in the shared look.
class _ReplyDemo extends StatefulWidget {
  const _ReplyDemo();

  @override
  State<_ReplyDemo> createState() => _ReplyDemoState();
}

class _ReplyDemoState extends State<_ReplyDemo> {
  final GooeyToastController _controller = GooeyToastController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _show() {
    final _Shared shared = _shared.value;
    _controller.showGooeyToast(
      context,
      GooeyToastOptions(
        title: 'Thread Reply',
        state: GooeyToastState.action,
        position: shared.position,
        shapeStyle: shared.shape,
        animationStyle: shared.animation,
        expandedChild: _ReplyForm(
          onSend: (String message) => _controller.showGooeyToast(
            context,
            _toast(
              title: 'Message Sent',
              description: 'Your reply was sent. "$message"',
              state: GooeyToastState.success,
            ),
            id: 'demo-reply',
            behavior: GooeyToastNewToastBehavior.transition,
          ),
        ),
      ),
      id: 'demo-reply',
    );
  }

  @override
  Widget build(BuildContext context) {
    return _Layer(
      controller: _controller,
      child: Center(
        child: Button(
          variant: ButtonVariant.outline,
          size: ButtonSize.sm,
          onPressed: _show,
          child: Text('Interactive Reply Demo'),
        ),
      ),
    );
  }
}

class _ReplyForm extends StatefulWidget {
  const _ReplyForm({required this.onSend});

  final ValueChanged<String> onSend;

  @override
  State<_ReplyForm> createState() => _ReplyFormState();
}

class _ReplyFormState extends State<_ReplyForm> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final String message = _controller.text.trim();
    if (message.length < 3) return;
    _controller.clear();
    widget.onSend(message);
  }

  @override
  Widget build(BuildContext context) {
    final double gap = Theme.of(context).density.baseGap;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Input(
          controller: _controller,
          placeholder: Text('Type your reply...'),
          minLines: 2,
          maxLines: 3,
          onSubmitted: (_) => _submit(),
        ),
        SizedBox(height: gap),
        Button(
          variant: ButtonVariant.primary,
          size: ButtonSize.sm,
          onPressed: _submit,
          child: Text('Send Reply'),
        ),
      ],
    );
  }
}

Widget _reply(BuildContext context) => const _ReplyDemo();
''',
    ),
  ],
  'hover_card': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/hover_card/hover_card.dart';

/// Sample card content.
Widget _card(BuildContext context) {
  final theme = Theme.of(context);
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text('@dashcn'),
      Gap(theme.spacing.xs),
      Text(
        'Beautifully designed components.',
        style: TextStyle(color: theme.colors.mutedForeground),
      ),
    ],
  );
}

/// The default card after the hover delay.
Widget _default(BuildContext context) {
  return HoverCard(hoverBuilder: _card, child: Text('@dashcn'));
}
''',
    ),
    DocsExampleSource(
      name: 'Rich content',
      builder: '_richContent',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/hover_card/hover_card.dart';

/// Rich content: title, bio and follower count.
Widget _richContent(BuildContext context) {
  final theme = Theme.of(context);
  return HoverCard(
    hoverBuilder: (BuildContext context) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('@dashcn'),
        Gap(theme.spacing.xs),
        Text(
          'Beautifully designed components that you can copy and paste.',
          style: TextStyle(color: theme.colors.mutedForeground),
        ),
        Gap(theme.spacing.sm),
        Text(
          '12k followers',
          style: TextStyle(color: theme.colors.mutedForeground, fontSize: 12),
        ),
      ],
    ),
    child: Text('@dashcn (rich)'),
  );
}
''',
    ),
  ],
  'image_lightbox': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/image/image.dart';
import 'package:<your_app>/ui/dashcn/components/image_lightbox/image_lightbox.dart';

const String _redPng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUElEQVR42u3PQREAAAQAMITRP5AwUni42xospzs+q3hOQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA4N4CDKIBqK4z/20AAAAASUVORK5CYII=';

const String _greenPng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUUlEQVR42u3PMQ0AMAgAMJgIRGETo1PBQdI6aNZ0XPbiOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAYF9HxJZAYMtZ/JwAAAAAElFTkSuQmCC';

const String _bluePng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUUlEQVR42u3PMQ0AMAgAMJgXlCEfE1PBQdI6aFZPXPbiOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAYF9Hy4iAfMxiKoyAAAAAElFTkSuQmCC';

const String _amberPng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUUlEQVR42u3PMQ0AMAgAMNiBZbTiZio4SFoHzemKy14cJyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgILDvA7hbAdZfb5ZtAAAAAElFTkSuQmCC';

final List<LightboxImage> _photos = <LightboxImage>[
  LightboxImage(
    image: MemoryImage(base64Decode(_redPng)),
    caption: 'Red sample',
    semanticLabel: 'Red sample image',
  ),
  LightboxImage(
    image: MemoryImage(base64Decode(_greenPng)),
    caption: 'Green sample',
    semanticLabel: 'Green sample image',
  ),
  LightboxImage(
    image: MemoryImage(base64Decode(_bluePng)),
    caption: 'Blue sample',
    semanticLabel: 'Blue sample image',
  ),
  LightboxImage(
    image: MemoryImage(base64Decode(_amberPng)),
    caption: 'Amber sample',
    semanticLabel: 'Amber sample image',
  ),
];

/// A fixed box is inherent to a full-screen overlay: the docs stage only
/// bounds the width (the page scrollable leaves the height unbounded), so the
/// lightbox gets a bounded viewport of its own — the same convention the
/// `drawer` preview uses for its mock app viewport.
Widget _framed(Widget child) {
  return SizedBox(width: double.infinity, height: 360, child: child);
}

/// The default lightbox: counter, captions and the thumbnail strip.
Widget _default(BuildContext context) {
  return _framed(ImageLightbox(images: _photos));
}
''',
    ),
    DocsExampleSource(
      name: 'Minimal',
      builder: '_minimal',
      code: r'''import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/image/image.dart';
import 'package:<your_app>/ui/dashcn/components/image_lightbox/image_lightbox.dart';

const String _redPng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUElEQVR42u3PQREAAAQAMITRP5AwUni42xospzs+q3hOQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA4N4CDKIBqK4z/20AAAAASUVORK5CYII=';

const String _greenPng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUUlEQVR42u3PMQ0AMAgAMJgIRGETo1PBQdI6aNZ0XPbiOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAYF9HxJZAYMtZ/JwAAAAAElFTkSuQmCC';

const String _bluePng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUUlEQVR42u3PMQ0AMAgAMJgXlCEfE1PBQdI6aFZPXPbiOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAYF9Hy4iAfMxiKoyAAAAAElFTkSuQmCC';

const String _amberPng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUUlEQVR42u3PMQ0AMAgAMNiBZbTiZio4SFoHzemKy14cJyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgILDvA7hbAdZfb5ZtAAAAAElFTkSuQmCC';

final List<LightboxImage> _photos = <LightboxImage>[
  LightboxImage(
    image: MemoryImage(base64Decode(_redPng)),
    caption: 'Red sample',
    semanticLabel: 'Red sample image',
  ),
  LightboxImage(
    image: MemoryImage(base64Decode(_greenPng)),
    caption: 'Green sample',
    semanticLabel: 'Green sample image',
  ),
  LightboxImage(
    image: MemoryImage(base64Decode(_bluePng)),
    caption: 'Blue sample',
    semanticLabel: 'Blue sample image',
  ),
  LightboxImage(
    image: MemoryImage(base64Decode(_amberPng)),
    caption: 'Amber sample',
    semanticLabel: 'Amber sample image',
  ),
];

/// A fixed box is inherent to a full-screen overlay: the docs stage only
/// bounds the width (the page scrollable leaves the height unbounded), so the
/// lightbox gets a bounded viewport of its own — the same convention the
/// `drawer` preview uses for its mock app viewport.
Widget _framed(Widget child) {
  return SizedBox(width: double.infinity, height: 360, child: child);
}

/// A single image with no chrome.
Widget _minimal(BuildContext context) {
  return _framed(
    ImageLightbox(
      images: <LightboxImage>[_photos[1]],
      showCounter: false,
      showThumbnails: false,
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Customized',
      builder: '_customized',
      code: r'''import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/image/image.dart';
import 'package:<your_app>/ui/dashcn/components/image_lightbox/image_lightbox.dart';

const String _redPng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUElEQVR42u3PQREAAAQAMITRP5AwUni42xospzs+q3hOQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA4N4CDKIBqK4z/20AAAAASUVORK5CYII=';

const String _greenPng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUUlEQVR42u3PMQ0AMAgAMJgIRGETo1PBQdI6aNZ0XPbiOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAYF9HxJZAYMtZ/JwAAAAAElFTkSuQmCC';

const String _bluePng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUUlEQVR42u3PMQ0AMAgAMJgXlCEfE1PBQdI6aFZPXPbiOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAYF9Hy4iAfMxiKoyAAAAAElFTkSuQmCC';

const String _amberPng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUUlEQVR42u3PMQ0AMAgAMNiBZbTiZio4SFoHzemKy14cJyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgILDvA7hbAdZfb5ZtAAAAAElFTkSuQmCC';

final List<LightboxImage> _photos = <LightboxImage>[
  LightboxImage(
    image: MemoryImage(base64Decode(_redPng)),
    caption: 'Red sample',
    semanticLabel: 'Red sample image',
  ),
  LightboxImage(
    image: MemoryImage(base64Decode(_greenPng)),
    caption: 'Green sample',
    semanticLabel: 'Green sample image',
  ),
  LightboxImage(
    image: MemoryImage(base64Decode(_bluePng)),
    caption: 'Blue sample',
    semanticLabel: 'Blue sample image',
  ),
  LightboxImage(
    image: MemoryImage(base64Decode(_amberPng)),
    caption: 'Amber sample',
    semanticLabel: 'Amber sample image',
  ),
];

/// A fixed box is inherent to a full-screen overlay: the docs stage only
/// bounds the width (the page scrollable leaves the height unbounded), so the
/// lightbox gets a bounded viewport of its own — the same convention the
/// `drawer` preview uses for its mock app viewport.
Widget _framed(Widget child) {
  return SizedBox(width: double.infinity, height: 360, child: child);
}

/// A customized lightbox: theme overrides and a deeper scrim.
Widget _customized(BuildContext context) {
  return _framed(
    ImageLightbox(
      images: _photos,
      theme: const ImageLightboxTheme(
        barrierColor: ThemedColor.value(Color(0xCC000000)),
        maxScale: 5,
        thumbnailHeight: 64,
        thumbnailBorderWidth: 3,
      ),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'From thumbnails',
      builder: '_gallery',
      code: r'''import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/image/image.dart';
import 'package:<your_app>/ui/dashcn/components/image_lightbox/image_lightbox.dart';

const String _redPng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUElEQVR42u3PQREAAAQAMITRP5AwUni42xospzs+q3hOQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA4N4CDKIBqK4z/20AAAAASUVORK5CYII=';

const String _greenPng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUUlEQVR42u3PMQ0AMAgAMJgIRGETo1PBQdI6aNZ0XPbiOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAYF9HxJZAYMtZ/JwAAAAAElFTkSuQmCC';

const String _bluePng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUUlEQVR42u3PMQ0AMAgAMJgXlCEfE1PBQdI6aFZPXPbiOAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAYF9Hy4iAfMxiKoyAAAAAElFTkSuQmCC';

const String _amberPng =
    'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAUUlEQVR42u3PMQ0AMAgAMNiBZbTiZio4SFoHzemKy14cJyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgILDvA7hbAdZfb5ZtAAAAAElFTkSuQmCC';

final List<LightboxImage> _photos = <LightboxImage>[
  LightboxImage(
    image: MemoryImage(base64Decode(_redPng)),
    caption: 'Red sample',
    semanticLabel: 'Red sample image',
  ),
  LightboxImage(
    image: MemoryImage(base64Decode(_greenPng)),
    caption: 'Green sample',
    semanticLabel: 'Green sample image',
  ),
  LightboxImage(
    image: MemoryImage(base64Decode(_bluePng)),
    caption: 'Blue sample',
    semanticLabel: 'Blue sample image',
  ),
  LightboxImage(
    image: MemoryImage(base64Decode(_amberPng)),
    caption: 'Amber sample',
    semanticLabel: 'Amber sample image',
  ),
];

/// A lightbox opened from a thumbnail grid, the way a caller uses it.
class _Gallery extends StatefulWidget {
  const _Gallery();

  @override
  State<_Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<_Gallery> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      spacing: theme.spacing.md,
      runSpacing: theme.spacing.md,
      children: <Widget>[
        for (int i = 0; i < _photos.length; i++)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => showImageLightbox<void>(
              context: context,
              images: _photos,
              initialIndex: i,
            ),
            child: ClipRRect(
              borderRadius: theme.borderRadiusMd,
              child: Picture(
                image: _photos[i].image,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
                semanticLabel: _photos[i].semanticLabel,
              ),
            ),
          ),
      ],
    );
  }
}

Widget _gallery(BuildContext context) => const _Gallery();
''',
    ),
  ],
  'popup': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/popup/popup.dart';

/// The profile card shown on the popup surface by both examples.
class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Ibrar Ali'),
              SizedBox(height: 2),
              Text('ibrar@example.com', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        const MenuSeparator(),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Signed in with a passkey',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colors.mutedForeground,
            ),
          ),
        ),
      ],
    );
  }
}

/// The popup surface rendered inline.
Widget _default(BuildContext context) {
  return const SizedBox(
    width: 220,
    child: MenuPopup(children: <Widget>[_ProfileCard()]),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Anchored',
      builder: '_anchored',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/popup/popup.dart';

/// The profile card shown on the popup surface by both examples.
class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Ibrar Ali'),
              SizedBox(height: 2),
              Text('ibrar@example.com', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        const MenuSeparator(),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Signed in with a passkey',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colors.mutedForeground,
            ),
          ),
        ),
      ],
    );
  }
}

/// A trigger that anchors the same surface with `showPopup`.
class _AnchoredDemo extends StatelessWidget {
  const _AnchoredDemo();

  @override
  Widget build(BuildContext context) {
    return Button(
      variant: ButtonVariant.secondary,
      size: ButtonSize.sm,
      onPressed: () => showPopup(
        context: context,
        builder: (BuildContext context) => const _ProfileCard(),
      ),
      child: Text('Show popup'),
    );
  }
}

Widget _anchored(BuildContext context) => const _AnchoredDemo();
''',
    ),
    DocsExampleSource(
      name: 'Customized',
      builder: '_customized',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';
import 'package:<your_app>/ui/dashcn/components/popup/popup.dart';

/// The profile card shown on the popup surface by both examples.
class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Ibrar Ali'),
              SizedBox(height: 2),
              Text('ibrar@example.com', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
        const MenuSeparator(),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Signed in with a passkey',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colors.mutedForeground,
            ),
          ),
        ),
      ],
    );
  }
}

/// A customized surface: widget-leg theme override (tinted fill). The fill
/// and the text come from the paired `secondary` tokens so the text stays
/// readable in light and dark mode alike.
Widget _customized(BuildContext context) {
  return const SizedBox(
    width: 220,
    child: MenuPopup(
      theme: MenuPopupTheme(
        background: ThemedColor.ref(ColorRef.secondary),
        foreground: ThemedColor.ref(ColorRef.secondaryForeground),
      ),
      children: <Widget>[_ProfileCard()],
    ),
  );
}
''',
    ),
  ],
  'refresh_trigger': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/refresh_trigger/refresh_trigger.dart';

/// A live pull-to-refresh list in a bounded box.
class _DefaultRefresh extends StatefulWidget {
  const _DefaultRefresh();

  @override
  State<_DefaultRefresh> createState() => _DefaultRefreshState();
}

class _DefaultRefreshState extends State<_DefaultRefresh> {
  final List<String> _rows = <String>[
    'Row 1',
    'Row 2',
    'Row 3',
    'Row 4',
    'Row 5',
    'Row 6',
  ];
  int _refreshes = 0;

  Future<void> _refresh() async {
    await Future<void>.delayed(Duration.zero);
    if (!mounted) {
      return;
    }
    setState(() {
      _refreshes++;
      _rows.insert(0, 'Fresh row $_refreshes');
    });
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          width: 320,
          height: 200,
          child: RefreshTrigger(
            onRefresh: _refresh,
            child: ListView.builder(
              itemCount: _rows.length,
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(_rows[index]),
              ),
            ),
          ),
        ),
        Gap(spacing.sm),
        Text('Refreshed $_refreshes time(s)'),
      ],
    );
  }
}

Widget _default(BuildContext context) => const _DefaultRefresh();
''',
    ),
    DocsExampleSource(
      name: 'Refreshing',
      builder: '_refreshing',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/refresh_trigger/refresh_trigger.dart';

/// The pill indicator frozen in its refreshing stage.
Widget _refreshing(BuildContext context) {
  return const DefaultRefreshIndicator(
    stage: RefreshTriggerStage(
      TriggerStage.refreshing,
      AlwaysStoppedAnimation<double>(0.8),
      Axis.vertical,
      false,
    ),
  );
}
''',
    ),
  ],
  'tooltip': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/tooltip/tooltip.dart';

/// Label tooltip after the default delay.
Widget _default(BuildContext context) {
  return _anchor(context, LucideIcons.info, 'Details');
}

Widget _anchor(
  BuildContext context,
  IconData icon,
  String label, {
  Duration waitDuration = kTooltipWaitDuration,
}) {
  final theme = Theme.of(context);
  // P7-TH1: the anchor hugs the trigger and sits in the middle of the stage.
  return Align(
    alignment: Alignment.center,
    child: Tooltip(
      waitDuration: waitDuration,
      // The anchor carries the message as its semantic label so screen
      // readers announce it without waiting for the hover overlay.
      semanticLabel: label,
      tooltip: (BuildContext context) => Text(label),
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: theme.colors.border),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: theme.colors.foreground),
      ),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Instant',
      builder: '_instant',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/tooltip/tooltip.dart';

/// Label tooltip with no delay.
Widget _instant(BuildContext context) {
  return _anchor(
    context,
    LucideIcons.zap,
    'Instant',
    waitDuration: Duration.zero,
  );
}

Widget _anchor(
  BuildContext context,
  IconData icon,
  String label, {
  Duration waitDuration = kTooltipWaitDuration,
}) {
  final theme = Theme.of(context);
  // P7-TH1: the anchor hugs the trigger and sits in the middle of the stage.
  return Align(
    alignment: Alignment.center,
    child: Tooltip(
      waitDuration: waitDuration,
      // The anchor carries the message as its semantic label so screen
      // readers announce it without waiting for the hover overlay.
      semanticLabel: label,
      tooltip: (BuildContext context) => Text(label),
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: theme.colors.border),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: theme.colors.foreground),
      ),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Rich content',
      builder: '_rich',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/tooltip/tooltip.dart';

/// Title plus description in one tooltip.
Widget _rich(BuildContext context) {
  return Tooltip(
    // The anchor carries the message as its semantic label so screen
    // readers announce it without waiting for the hover overlay.
    semanticLabel: 'Deployment. Ships when the checks pass.',
    tooltip: (BuildContext context) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Deployment',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Text('Ships when the checks pass.'),
      ],
    ),
    child: Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colors.border),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        LucideIcons.rocket,
        size: 16,
        color: Theme.of(context).colors.foreground,
      ),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Container',
      builder: '_container',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/tooltip/tooltip.dart';

/// The container on its own, without hover behaviour.
Widget _container(BuildContext context) {
  return TooltipContainer(child: Text('Primary surface'));
}
''',
    ),
  ],
  'audio_player': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/audio_player/audio_player.dart';

/// Caps [child] at [maxWidth] but shrinks to the stage when narrower.
///
/// `PreviewStage` hands a bounded `maxWidth` (phone ~295, desktop ~560);
/// a fixed `SizedBox(width: 640)` would overflow the phone stage by ~300.
/// `LayoutBuilder` reads the available width and picks the smaller, so the
/// same example fits at 375 and 1280 with no overflow.
Widget _capped(double maxWidth, Widget child) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final double avail = constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : maxWidth;
      final double width = avail < maxWidth ? avail : maxWidth;
      return SizedBox(width: width, child: child);
    },
  );
}

/// Gradient cover used by the previews (the live app passes real artwork).
Widget _coverArt(List<Color> colors) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    alignment: Alignment.center,
    child: const Icon(LucideIcons.music, size: 56, color: Color(0xFFFFFFFF)),
  );
}

/// Default: expanded card on the three-track SPEC playlist.
class _DefaultAudio extends StatefulWidget {
  const _DefaultAudio();

  @override
  State<_DefaultAudio> createState() => _DefaultAudioState();
}

class _DefaultAudioState extends State<_DefaultAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController(
    tracks: demoAudioTracks,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      360,
      AudioPlayer(
        controller: _controller,
        variant: AudioPlayerVariant.full,
        cover: _coverArt(const <Color>[Color(0xFF7C3AED), Color(0xFFEC4899)]),
      ),
    );
  }
}

Widget _default(BuildContext context) => const _DefaultAudio();
''',
    ),
    DocsExampleSource(
      name: 'Compact',
      builder: '_compact',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/audio_player/audio_player.dart';

/// Caps [child] at [maxWidth] but shrinks to the stage when narrower.
///
/// `PreviewStage` hands a bounded `maxWidth` (phone ~295, desktop ~560);
/// a fixed `SizedBox(width: 640)` would overflow the phone stage by ~300.
/// `LayoutBuilder` reads the available width and picks the smaller, so the
/// same example fits at 375 and 1280 with no overflow.
Widget _capped(double maxWidth, Widget child) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final double avail = constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : maxWidth;
      final double width = avail < maxWidth ? avail : maxWidth;
      return SizedBox(width: width, child: child);
    },
  );
}

/// Compact pill on the SPEC playlist (single shared controller concept).
class _CompactAudio extends StatefulWidget {
  const _CompactAudio();

  @override
  State<_CompactAudio> createState() => _CompactAudioState();
}

class _CompactAudioState extends State<_CompactAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController(
    isPlaying: true,
    position: const Duration(minutes: 1, seconds: 1),
    duration: const Duration(minutes: 5, seconds: 40),
    tracks: demoAudioTracks,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      420,
      AudioPlayer(
        controller: _controller,
        variant: AudioPlayerVariant.compact,
        onDownload: () {},
      ),
    );
  }
}

Widget _compact(BuildContext context) => const _CompactAudio();
''',
    ),
    DocsExampleSource(
      name: 'Expanded card',
      builder: '_expanded',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/audio_player/audio_player.dart';

/// Caps [child] at [maxWidth] but shrinks to the stage when narrower.
///
/// `PreviewStage` hands a bounded `maxWidth` (phone ~295, desktop ~560);
/// a fixed `SizedBox(width: 640)` would overflow the phone stage by ~300.
/// `LayoutBuilder` reads the available width and picks the smaller, so the
/// same example fits at 375 and 1280 with no overflow.
Widget _capped(double maxWidth, Widget child) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final double avail = constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : maxWidth;
      final double width = avail < maxWidth ? avail : maxWidth;
      return SizedBox(width: width, child: child);
    },
  );
}

/// Gradient cover used by the previews (the live app passes real artwork).
Widget _coverArt(List<Color> colors) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    alignment: Alignment.center,
    child: const Icon(LucideIcons.music, size: 56, color: Color(0xFFFFFFFF)),
  );
}

/// Expanded card, second track selected.
class _ExpandedAudio extends StatefulWidget {
  const _ExpandedAudio();

  @override
  State<_ExpandedAudio> createState() => _ExpandedAudioState();
}

class _ExpandedAudioState extends State<_ExpandedAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController(
    tracks: demoAudioTracks,
    currentIndex: 1,
    position: const Duration(seconds: 29),
    duration: const Duration(minutes: 6, seconds: 12),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      360,
      AudioPlayer(
        controller: _controller,
        variant: AudioPlayerVariant.full,
        cover: _coverArt(const <Color>[Color(0xFF0EA5E9), Color(0xFF312E81)]),
      ),
    );
  }
}

Widget _expanded(BuildContext context) => const _ExpandedAudio();
''',
    ),
    DocsExampleSource(
      name: 'Shared playlist',
      builder: '_shared',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/audio_player/audio_player.dart';

/// Caps [child] at [maxWidth] but shrinks to the stage when narrower.
///
/// `PreviewStage` hands a bounded `maxWidth` (phone ~295, desktop ~560);
/// a fixed `SizedBox(width: 640)` would overflow the phone stage by ~300.
/// `LayoutBuilder` reads the available width and picks the smaller, so the
/// same example fits at 375 and 1280 with no overflow.
Widget _capped(double maxWidth, Widget child) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final double avail = constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : maxWidth;
      final double width = avail < maxWidth ? avail : maxWidth;
      return SizedBox(width: width, child: child);
    },
  );
}

/// Density gap for the shared example (12 px at the default density).
double _gapMd(BuildContext context) {
  final ThemeData ambient = Theme.of(context);
  return ambient.density.baseGap * ambient.scaling * gapMd;
}

/// Gradient cover used by the previews (the live app passes real artwork).
Widget _coverArt(List<Color> colors) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    alignment: Alignment.center,
    child: const Icon(LucideIcons.music, size: 56, color: Color(0xFFFFFFFF)),
  );
}

/// One controller drives the compact pill and the expanded card together.
class _SharedAudio extends StatefulWidget {
  const _SharedAudio();

  @override
  State<_SharedAudio> createState() => _SharedAudioState();
}

class _SharedAudioState extends State<_SharedAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController(
    tracks: demoAudioTracks,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      360,
      SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            AudioPlayer(
              controller: _controller,
              variant: AudioPlayerVariant.compact,
              onDownload: () {},
            ),
            SizedBox(height: _gapMd(context)),
            AudioPlayer(
              controller: _controller,
              variant: AudioPlayerVariant.full,
              cover: _coverArt(const <Color>[
                Color(0xFF059669),
                Color(0xFF10B981),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _shared(BuildContext context) => const _SharedAudio();
''',
    ),
    DocsExampleSource(
      name: 'Phone width',
      builder: '_phone',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/audio_player/audio_player.dart';

/// Caps [child] at [maxWidth] but shrinks to the stage when narrower.
///
/// `PreviewStage` hands a bounded `maxWidth` (phone ~295, desktop ~560);
/// a fixed `SizedBox(width: 640)` would overflow the phone stage by ~300.
/// `LayoutBuilder` reads the available width and picks the smaller, so the
/// same example fits at 375 and 1280 with no overflow.
Widget _capped(double maxWidth, Widget child) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final double avail = constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : maxWidth;
      final double width = avail < maxWidth ? avail : maxWidth;
      return SizedBox(width: width, child: child);
    },
  );
}

/// Compact pill at phone width (volume icon stays, slider overlays).
class _PhoneAudio extends StatefulWidget {
  const _PhoneAudio();

  @override
  State<_PhoneAudio> createState() => _PhoneAudioState();
}

class _PhoneAudioState extends State<_PhoneAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController(
    tracks: demoAudioTracks,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      320,
      AudioPlayer(
        controller: _controller,
        variant: AudioPlayerVariant.compact,
        onDownload: () {},
      ),
    );
  }
}

Widget _phone(BuildContext context) => const _PhoneAudio();
''',
    ),
    DocsExampleSource(
      name: 'Customized',
      builder: '_custom',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/audio_player/audio_player.dart';

/// Caps [child] at [maxWidth] but shrinks to the stage when narrower.
///
/// `PreviewStage` hands a bounded `maxWidth` (phone ~295, desktop ~560);
/// a fixed `SizedBox(width: 640)` would overflow the phone stage by ~300.
/// `LayoutBuilder` reads the available width and picks the smaller, so the
/// same example fits at 375 and 1280 with no overflow.
Widget _capped(double maxWidth, Widget child) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final double avail = constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : maxWidth;
      final double width = avail < maxWidth ? avail : maxWidth;
      return SizedBox(width: width, child: child);
    },
  );
}

/// Customized theme plus a custom play button and download slot.
class _CustomAudio extends StatefulWidget {
  const _CustomAudio();

  @override
  State<_CustomAudio> createState() => _CustomAudioState();
}

class _CustomAudioState extends State<_CustomAudio> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController(
    tracks: demoAudioTracks,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      360,
      AudioPlayer(
        controller: _controller,
        variant: AudioPlayerVariant.full,
        theme: const AudioPlayerTheme(
          accent: ThemedColor.value(Color(0xFFE11D48)),
          controlSize: 48,
        ),
        playButtonBuilder: (context, c) => GestureDetector(
          onTap: c.toggle,
          child: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFE11D48),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              c.isPlaying ? LucideIcons.pause : LucideIcons.play,
              color: const Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _custom(BuildContext context) => const _CustomAudio();
''',
    ),
    DocsExampleSource(
      name: 'Live playback',
      description:
          'Real just_audio playback: shared compact pill + expanded card.',
      builder: '_liveAudio',
      code: r'''import 'package:docs/media/audio_adapter.dart';
import 'package:docs/ui/dashcn/components/audio_player/audio_player.dart';
import 'package:docs/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:docs/ui/dashcn/theme/theme.dart';
import 'package:docs/web_bridge.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';

/// Gradient placeholder shown while a cover loads or when it 404s.
Widget _coverFallback(List<Color> colors) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    alignment: Alignment.center,
    child: const Icon(LucideIcons.music, size: 56, color: Color(0xFFFFFFFF)),
  );
}

/// File name for a track download.
String _downloadName(AudioTrack track) =>
    '${track.artist}-${track.title}'.replaceAll(RegExp('[^A-Za-z0-9]+'), '-');

/// Live audio docs example: shared controller, compact + expanded.
class _LiveAudio extends StatefulWidget {
  const _LiveAudio();

  @override
  State<_LiveAudio> createState() => _LiveAudioState();
}

class _LiveAudioState extends State<_LiveAudio> {
  audio.AudioPlayer? _player;
  JustAudioAdapter? _adapter;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    final audio.AudioPlayer player = audio.AudioPlayer();
    final JustAudioAdapter adapter = JustAudioAdapter(player);
    try {
      await adapter.setTracks(demoAudioTracks);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _player = player;
        _adapter = adapter;
        _failed = true;
      });
      return;
    }
    if (!mounted) {
      adapter.dispose();
      try {
        await player.dispose();
      } catch (_) {}
      return;
    }
    setState(() {
      _player = player;
      _adapter = adapter;
    });
  }

  @override
  void dispose() {
    _adapter?.dispose();
    // Plugin dispose is fire-and-forget here; swallow the
    // MissingPluginException it throws where plugins are absent (VM tests).
    _player?.dispose().then((_) {}, onError: (_) {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final JustAudioAdapter? adapter = _adapter;
    if (adapter == null) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double avail = constraints.maxWidth.isFinite
              ? constraints.maxWidth
              : 360;
          final double width = avail < 360 ? avail : 360;
          return SizedBox(
            width: width,
            height: 120,
            child: const Center(
              child: Text(
                'Loading live audio…',
                style: TextStyle(fontSize: 13),
              ),
            ),
          );
        },
      );
    }
    return ListenableBuilder(
      listenable: adapter,
      builder: (BuildContext context, Widget? _) {
        final AudioTrack? track = adapter.currentTrack;
        final String? coverUrl = track?.coverUrl;
        final List<Color> gradient = const <Color>[
          Color(0xFF7C3AED),
          Color(0xFFEC4899),
        ];
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double avail = constraints.maxWidth.isFinite
                ? constraints.maxWidth
                : 360;
            final double width = avail < 360 ? avail : 360;
            final double gap =
                Theme.of(context).density.baseGap *
                Theme.of(context).scaling *
                1.5;
            return SizedBox(
              width: width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _TrackSelector(adapter: adapter),
                  SizedBox(height: gap),
                  SizedBox(
                    width: width,
                    child: AudioPlayer(
                      controller: adapter,
                      variant: AudioPlayerVariant.compact,
                      onDownload: _downloadCurrent,
                    ),
                  ),
                  SizedBox(height: gap),
                  SizedBox(
                    width: width,
                    child: AudioPlayer(
                      controller: adapter,
                      variant: AudioPlayerVariant.full,
                      cover: coverUrl == null
                          ? _coverFallback(gradient)
                          : Image.network(
                              coverUrl,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (
                                    BuildContext context,
                                    Object error,
                                    StackTrace? stackTrace,
                                  ) => _coverFallback(gradient),
                            ),
                    ),
                  ),
                  if (adapter.error != null || _failed)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Playback failed: ${adapter.error ?? 'could not load track'}',
                        style: const TextStyle(
                          color: Color(0xFFDC2626),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _downloadCurrent() {
    final AudioTrack? track = _adapter?.currentTrack;
    final String? src = track?.src;
    if (src == null || track == null) return;
    webDownloadUrl(src, '${_downloadName(track)}.mp3');
  }
}

/// Track selector chips (docs chrome around the component).
class _TrackSelector extends StatelessWidget {
  const _TrackSelector({required this.adapter});

  final JustAudioAdapter adapter;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 0,
      runSpacing: 8,
      children: <Widget>[
        for (int i = 0; i < adapter.tracks.length; i++)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => adapter.setTrack(i),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: adapter.currentIndex == i
                    ? const Color(0xFF18181B)
                    : const Color(0x00000000),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: const Color(0xFF27272A)),
              ),
              child: Text(
                adapter.tracks[i].title,
                style: TextStyle(
                  color: adapter.currentIndex == i
                      ? const Color(0xFFFFFFFF)
                      : const Color(0xFF71717A),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

Widget _liveAudio(BuildContext context) => const _LiveAudio();
''',
    ),
  ],
  'code_snippet': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_codeSnippetDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/primitives/clickable.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/code_snippet/code_snippet.dart';

/// Default snippet with syntax colouring and copy button.
Widget _codeSnippetDefault(BuildContext context) {
  return const Align(
    alignment: Alignment.center,
    child: CodeSnippet(code: Text('const greeting = "hello";')),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'With actions',
      builder: '_codeSnippetWithActions',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/primitives/clickable.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/code_snippet/code_snippet.dart';

/// A small pill button for the snippet actions row.
class _CodeSnippetAction extends StatelessWidget {
  const _CodeSnippetAction({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      size: ButtonSize.sm,
      variant: ButtonVariant.ghost,
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

/// A snippet with an extra action button alongside the copy button.
class _CodeSnippetWithActions extends StatefulWidget {
  const _CodeSnippetWithActions();

  @override
  State<_CodeSnippetWithActions> createState() =>
      _CodeSnippetWithActionsState();
}

class _CodeSnippetWithActionsState extends State<_CodeSnippetWithActions> {
  String _status = 'idle';

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 320,
          child: CodeSnippet(
            showCopyButton: false,
            actions: <Widget>[
              _CodeSnippetAction(
                label: 'Copy',
                onPressed: () => setState(() => _status = 'copied'),
              ),
              _CodeSnippetAction(
                label: 'Run',
                onPressed: () => setState(() => _status = 'running'),
              ),
            ],
            code: Text('flutter run -d chrome'),
          ),
        ),
        Gap(spacing.sm),
        Text(
          _status,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}

Widget _codeSnippetWithActions(BuildContext context) =>
    const _CodeSnippetWithActions();
''',
    ),
    DocsExampleSource(
      name: 'Long lines',
      builder: '_codeSnippetLongLines',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/primitives/clickable.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/code_snippet/code_snippet.dart';

/// A long line that scrolls horizontally inside its bounded box without overflowing.
Widget _codeSnippetLongLines(BuildContext context) {
  return const Align(
    alignment: Alignment.center,
    child: SizedBox(
      width: 320,
      child: CodeSnippet(
        code: Text(
          'void main() { runApp(const MyApp(home: Center(child: Text("long line scrolls horizontally inside code block")))); }',
        ),
      ),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Languages',
      builder: '_codeSnippetLanguages',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/primitives/clickable.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/code_snippet/code_snippet.dart';

/// Interactive showcase across the supported languages.
class _CodeSnippetLanguages extends StatefulWidget {
  const _CodeSnippetLanguages();

  @override
  State<_CodeSnippetLanguages> createState() => _CodeSnippetLanguagesState();
}

class _CodeSnippetLanguagesState extends State<_CodeSnippetLanguages> {
  int _selected = 0;

  static final List<({String label, String lang, String code})> _samples = [
    (
      label: 'Dart',
      lang: 'dart',
      code: 'void main() {\n  runApp(MyApp());\n}',
    ),
    (
      label: 'JSON',
      lang: 'json',
      code:
          '{\n  "name": "dashcn",\n  "version": "1.0.0",\n  "private": true\n}',
    ),
    (
      label: 'YAML',
      lang: 'yaml',
      code: 'name: dashcn\nversion: 1.0.0\nenvironment:\n  sdk: ^3.0.0',
    ),
    (
      label: 'Shell',
      lang: 'bash',
      code: 'flutter pub add dashcn\ndashcn add code_snippet',
    ),
    (
      label: 'TypeScript',
      lang: 'ts',
      code: 'interface User {\n  id: string;\n  name: string;\n}',
    ),
    (
      label: 'HTML',
      lang: 'html',
      code: '<div class="card">\n  <span id="title">Hello</span>\n</div>',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final current = _samples[_selected];
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (int i = 0; i < _samples.length; i++) ...<Widget>[
                if (i > 0) Gap(theme.spacing.xs),
                Clickable(
                  onPressed: () => setState(() => _selected = i),
                  padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(
                      horizontal: theme.spacing.sm,
                      vertical: theme.spacing.xs,
                    ),
                  ),
                  decoration: WidgetStateProperty.resolveWith<Decoration?>((
                    states,
                  ) {
                    final bool active = i == _selected;
                    return BoxDecoration(
                      color: active
                          ? theme.colors.primary
                          : states.contains(WidgetState.hovered)
                          ? theme.colors.muted
                          : null,
                      borderRadius: theme.borderRadiusSm,
                    );
                  }),
                  child: Text(
                    _samples[i].label,
                    style: theme.typography.small.copyWith(
                      color: i == _selected
                          ? theme.colors.primaryForeground
                          : theme.colors.mutedForeground,
                      fontWeight: i == _selected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        Gap(theme.spacing.sm),
        SizedBox(
          width: 380,
          child: CodeSnippet(
            key: ValueKey<String>(current.lang),
            language: current.lang,
            code: Text(current.code),
          ),
        ),
      ],
    );
  }
}

Widget _codeSnippetLanguages(BuildContext context) =>
    const _CodeSnippetLanguages();
''',
    ),
    DocsExampleSource(
      name: 'Customized',
      builder: '_codeSnippetCustomized',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/primitives/clickable.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/code_snippet/code_snippet.dart';

/// A customized snippet using builder slots and per-instance style overrides.
Widget _codeSnippetCustomized(BuildContext context) {
  return Align(
    alignment: Alignment.center,
    child: SizedBox(
      width: 360,
      child: CodeSnippet(
        theme: const CodeSnippetTheme(
          borderColor: ThemedColor.ref(ColorRef.primary),
          borderWidth: 1.5,
        ),
        copyButtonBuilder: (context, onCopy, copied) {
          final theme = Theme.of(context);
          return Clickable(
            onPressed: onCopy,
            focusOutline: true,
            padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                horizontal: theme.spacing.sm,
                vertical: theme.spacing.xs,
              ),
            ),
            decoration: WidgetStateProperty.resolveWith<Decoration?>((states) {
              return BoxDecoration(
                color: copied
                    ? theme.colors.primary.withValues(alpha: 0.2)
                    : theme.colors.muted,
                borderRadius: theme.borderRadiusSm,
              );
            }),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  copied ? LucideIcons.check : LucideIcons.copy,
                  size: 13,
                  color: copied
                      ? theme.colors.primary
                      : theme.colors.foreground,
                ),
                Gap(theme.spacing.xs),
                Text(
                  copied
                      ? 'Copied!'
                      : 'Copy',
                  style: theme.typography.small.copyWith(
                    fontSize: 12,
                    color: copied
                        ? theme.colors.primary
                        : theme.colors.foreground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
        code: const Text('final custom = CodeSnippetCustomized();'),
      ),
    ),
  );
}
''',
    ),
  ],
  'image': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_imageDefault',
      code: r'''import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/image/image.dart';

/// A 48x48 PNG decoded from memory: the preview never hits the network, so it
/// renders identically offline and inside a widget test.
const String _imagePhotoBase64 =
    'iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAIAAADYYG7QAAAAWElEQVR42u3OoRGAMBBFwdPURBHoFIajKTS9hBL+ROTUzjz/ts7xxZ73js1x5eqIFRAQEBAQ0CKoczarYkBAQEBAQKugzhkQEBAQENAWUOMMCAgIC'
    'AhoQz/vbpR28UARAAAAAABJRU5ErkJggg==';

/// Local photo provider shared by the examples.
final ImageProvider _imagePhoto = MemoryImage(base64Decode(_imagePhotoBase64));

/// The default square avatar-shaped image.
Widget _imageDefault(BuildContext context) {
  // P7-TH1: centred in the stage (was centerStart).
  return Align(
    alignment: Alignment.center,
    child: Picture(
      image: _imagePhoto,
      width: 96,
      height: 96,
      aspectRatio: 1,
      semanticLabel: 'Photo',
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Rounded',
      builder: '_imageRounded',
      code: r'''import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/image/image.dart';

/// A 48x48 PNG decoded from memory: the preview never hits the network, so it
/// renders identically offline and inside a widget test.
const String _imagePhotoBase64 =
    'iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAIAAADYYG7QAAAAWElEQVR42u3OoRGAMBBFwdPURBHoFIajKTS9hBL+ROTUzjz/ts7xxZ73js1x5eqIFRAQEBAQ0CKoczarYkBAQEBAQKugzhkQEBAQENAWUOMMCAgIC'
    'AhoQz/vbpR28UARAAAAAABJRU5ErkJggg==';

/// Local photo provider shared by the examples.
final ImageProvider _imagePhoto = MemoryImage(base64Decode(_imagePhotoBase64));

/// The default image with the theme border radius.
Widget _imageRounded(BuildContext context) {
  final theme = Theme.of(context);
  // P7-TH1: centred in the stage (was centerStart).
  return Align(
    alignment: Alignment.center,
    child: Picture(
      image: _imagePhoto,
      width: 96,
      height: 96,
      aspectRatio: 1,
      borderRadius: theme.borderRadiusMd,
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Slots',
      builder: '_imageSlots',
      code: r'''import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/image/image.dart';

/// A 48x48 PNG decoded from memory: the preview never hits the network, so it
/// renders identically offline and inside a widget test.
const String _imagePhotoBase64 =
    'iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAIAAADYYG7QAAAAWElEQVR42u3OoRGAMBBFwdPURBHoFIajKTS9hBL+ROTUzjz/ts7xxZ73js1x5eqIFRAQEBAQ0CKoczarYkBAQEBAQKugzhkQEBAQENAWUOMMCAgIC'
    'AhoQz/vbpR28UARAAAAAABJRU5ErkJggg==';

/// Local photo provider shared by the examples.
final ImageProvider _imagePhoto = MemoryImage(base64Decode(_imagePhotoBase64));

/// The placeholder and error slots, and the theme legs.
Widget _imageSlots(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Picture(
        image: _imagePhoto,
        width: 96,
        height: 96,
        aspectRatio: 1,
        placeholder: const Center(
          child: Icon(LucideIcons.loaderCircle, size: 20),
        ),
        errorBuilder: (context, error, stackTrace) =>
            const Center(child: Icon(LucideIcons.imageOff, size: 20)),
      ),
      Gap(spacing.lg),
      Picture(
        image: _imagePhoto,
        width: 96,
        height: 96,
        aspectRatio: 1,
        theme: const ImageTheme(borderRadius: BorderRadius.zero),
      ),
      Gap(spacing.lg),
      ComponentTheme<ImageTheme>(
        data: const ImageTheme(
          background: ThemedColor.ref(ColorRef.accent, alpha: 0.5),
        ),
        child: Picture(
          image: _imagePhoto,
          width: 96,
          height: 96,
          aspectRatio: 1,
        ),
      ),
    ],
  );
}
''',
    ),
  ],
  'markdown': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code:
          'import \'package:flutter/widgets.dart\';\nimport \'package:<your_app>/ui/dashcn/theme/theme.dart\';\nimport \'package:<your_app>/ui/dashcn/components/markdown/markdown.dart\';\n\nconst String _sample = \'\'\'\n## Release notes\n\nBuild 482 ships **faster cold start** and a *smaller bundle*.\n\n- faster cold start\n- smaller bundle\n\n> Quoted from the changelog.\n\n![build graph](https://example.com/graph.png "Build graph")\n\'\'\';\n\n/// Headings, emphasis, a list, a quote and a local image placeholder.\nWidget _default(BuildContext context) {\n  final ThemeData theme = Theme.of(context);\n  return SizedBox(\n    width: 320,\n    child: Markdown(\n      data: _sample,\n      imageBuilder: (imageContext, url, alt) => SizedBox(\n        height: 64,\n        child: DecoratedBox(\n          decoration: BoxDecoration(\n            color: theme.colors.muted,\n            // P7-TH1: image stand-ins use the card radius token.\n            borderRadius: theme.borderRadiusLg,\n          ),\n          child: Center(\n            child: Text(\n              alt,\n              style: TextStyle(\n                color: theme.colors.mutedForeground,\n                fontSize: 12,\n              ),\n            ),\n          ),\n        ),\n      ),\n    ),\n  );\n}\n',
    ),
    DocsExampleSource(
      name: 'Streaming tail',
      builder: '_streamingTail',
      code:
          'import \'package:flutter/widgets.dart\';\nimport \'package:<your_app>/ui/dashcn/theme/theme.dart\';\nimport \'package:<your_app>/ui/dashcn/components/markdown/markdown.dart\';\n\n/// A mid-stream snapshot: only the stable prefix parses, followed by the\n/// streaming cursor. No timers; the settled text is derived with\n/// `computeStableMarkdownPrefixLength`, the helper the streaming\n/// `text_animate` component shares with this parser.\nconst String _streamSource = \'\'\'\nDrafting the release notes:\n\n- faster cold start\n- smaller bundle\n\n```dart\nvoid main() => print(\'\'\';\n\nWidget _streamingTail(BuildContext context) {\n  final String settled = _streamSource.substring(\n    0,\n    computeStableMarkdownPrefixLength(_streamSource),\n  );\n  final ThemeData theme = Theme.of(context);\n  return SizedBox(\n    width: 320,\n    child: Column(\n      mainAxisSize: MainAxisSize.min,\n      crossAxisAlignment: CrossAxisAlignment.start,\n      children: <Widget>[\n        Markdown(data: settled),\n        Text(\'▍\', style: TextStyle(color: theme.colors.primary)),\n      ],\n    ),\n  );\n}\n',
    ),
  ],
  'qr_code': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';
import 'package:<your_app>/ui/dashcn/components/qr_code/qr_code.dart';

/// A fixed-size code for a URL.
Widget _default(BuildContext context) {
  return const QrCode(data: 'https://example.com', size: 200);
}
''',
    ),
    DocsExampleSource(
      name: 'Live URL',
      builder: '_liveUrl',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';
import 'package:<your_app>/ui/dashcn/components/qr_code/qr_code.dart';

/// A code that re-encodes as the URL field changes.
class _LiveUrl extends StatefulWidget {
  const _LiveUrl();

  @override
  State<_LiveUrl> createState() => _LiveUrlState();
}

class _LiveUrlState extends State<_LiveUrl> {
  final TextEditingController _controller = TextEditingController(
    text: 'https://example.com',
  );
  String _url = 'https://example.com';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Input(
            controller: _controller,
            hintText: 'https://…',
            onChanged: (String value) => setState(() => _url = value),
          ),
          Gap(theme.spacing.md),
          QrCode(
            data: _url,
            size: 200,
            semanticsLabel: 'QR code for the typed URL',
          ),
        ],
      ),
    );
  }
}

Widget _liveUrl(BuildContext context) => const _LiveUrl();
''',
    ),
    DocsExampleSource(
      name: 'Shapes',
      builder: '_shapes',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/input/input.dart';
import 'package:<your_app>/ui/dashcn/components/qr_code/qr_code.dart';

/// The three module shapes, plus a logo cleared into the centre.
class _Shapes extends StatelessWidget {
  const _Shapes();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    Widget cell(String label, QrModuleShape shape) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          QrCode(data: 'dashcn', size: 120, moduleShape: shape),
          Gap(theme.spacing.xs),
          Text(label, style: theme.typography.small),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Wrap, not Row: three 120 px codes overflow a phone-width preview.
        Wrap(
          alignment: WrapAlignment.center,
          spacing: theme.spacing.md,
          runSpacing: theme.spacing.md,
          children: <Widget>[
            cell('Square', QrModuleShape.square),
            cell('Rounded', QrModuleShape.rounded),
            cell('Dot', QrModuleShape.dot),
          ],
        ),
        Gap(theme.spacing.md),
        QrCode(
          data: 'https://example.com',
          size: 160,
          errorCorrectLevel: QrErrorCorrectionLevel.high,
          center: ColoredBox(
            color: theme.colors.background,
            child: Center(child: Text('D', style: theme.typography.large)),
          ),
        ),
      ],
    );
  }
}

Widget _shapes(BuildContext context) => const _Shapes();
''',
    ),
  ],
  'video_player': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/video_player/video_player.dart';

/// Caps [child] at [maxWidth] but shrinks to the stage when narrower.
///
/// `PreviewStage` hands a bounded `maxWidth` (phone ~295, desktop ~560);
/// a fixed `SizedBox(width: 640)` would overflow the phone stage by ~300.
/// `LayoutBuilder` reads the available width and picks the smaller, so the
/// same example fits at 375 and 1280 with no overflow.
Widget _capped(double maxWidth, Widget child) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final double avail = constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : maxWidth;
      final double width = avail < maxWidth ? avail : maxWidth;
      return SizedBox(width: width, child: child);
    },
  );
}

/// Gradient frame used by the previews (the live app plugs the texture).
Widget _frame(List<Color> colors, String label) {
  return Container(
    alignment: Alignment.topCenter,
    padding: const EdgeInsets.only(top: 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// Default player: online MP4 with title and subtitle header.
class _DefaultVideo extends StatefulWidget {
  const _DefaultVideo();

  @override
  State<_DefaultVideo> createState() => _DefaultVideoState();
}

class _DefaultVideoState extends State<_DefaultVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController(
    sourceLabel: demoVideoSources[0].detail,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      640,
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: 'For Bigger Blazes',
          subtitle: 'Season 3 episode 6',
          content: _frame(const <Color>[
            Color(0xFF312E81),
            Color(0xFF0EA5E9),
          ], 'Online MP4'),
        ),
      ),
    );
  }
}

Widget _default(BuildContext context) => const _DefaultVideo();
''',
    ),
    DocsExampleSource(
      name: 'Live stream',
      builder: '_live',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/video_player/video_player.dart';

/// Caps [child] at [maxWidth] but shrinks to the stage when narrower.
///
/// `PreviewStage` hands a bounded `maxWidth` (phone ~295, desktop ~560);
/// a fixed `SizedBox(width: 640)` would overflow the phone stage by ~300.
/// `LayoutBuilder` reads the available width and picks the smaller, so the
/// same example fits at 375 and 1280 with no overflow.
Widget _capped(double maxWidth, Widget child) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final double avail = constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : maxWidth;
      final double width = avail < maxWidth ? avail : maxWidth;
      return SizedBox(width: width, child: child);
    },
  );
}

/// Gradient frame used by the previews (the live app plugs the texture).
Widget _frame(List<Color> colors, String label) {
  return Container(
    alignment: Alignment.topCenter,
    padding: const EdgeInsets.only(top: 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// Live stream source: LIVE badge, no total duration.
class _LiveVideo extends StatefulWidget {
  const _LiveVideo();

  @override
  State<_LiveVideo> createState() => _LiveVideoState();
}

class _LiveVideoState extends State<_LiveVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController(
    isPlaying: true,
    isLive: demoVideoSources[1].isLive,
    sourceLabel: demoVideoSources[1].detail,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      640,
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: 'Live stream',
          subtitle: 'HLS test stream',
          content: _frame(const <Color>[
            Color(0xFF7F1D1D),
            Color(0xFFDC2626),
          ], 'LIVE'),
        ),
      ),
    );
  }
}

Widget _live(BuildContext context) => const _LiveVideo();
''',
    ),
    DocsExampleSource(
      name: 'Camera fallback',
      builder: '_camera',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/video_player/video_player.dart';

/// Caps [child] at [maxWidth] but shrinks to the stage when narrower.
///
/// `PreviewStage` hands a bounded `maxWidth` (phone ~295, desktop ~560);
/// a fixed `SizedBox(width: 640)` would overflow the phone stage by ~300.
/// `LayoutBuilder` reads the available width and picks the smaller, so the
/// same example fits at 375 and 1280 with no overflow.
Widget _capped(double maxWidth, Widget child) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final double avail = constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : maxWidth;
      final double width = avail < maxWidth ? avail : maxWidth;
      return SizedBox(width: width, child: child);
    },
  );
}

/// Live camera feed: fallback message when permission is denied.
class _CameraVideo extends StatefulWidget {
  const _CameraVideo();

  @override
  State<_CameraVideo> createState() => _CameraVideoState();
}

class _CameraVideoState extends State<_CameraVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController(
    isLive: demoVideoSources[2].isLive,
    sourceLabel: demoVideoSources[2].detail,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      640,
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: 'Live feed',
          subtitle: 'Camera',
          content: Container(
            color: const Color(0xFF18181B),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(LucideIcons.cameraOff, size: 32, color: Color(0xFFFFFFFF)),
                SizedBox(height: 8),
                Text(
                  'Camera unavailable — permission denied',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _camera(BuildContext context) => const _CameraVideo();
''',
    ),
    DocsExampleSource(
      name: 'Speed menu open',
      builder: '_speedMenuOpen',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/video_player/video_player.dart';

/// Caps [child] at [maxWidth] but shrinks to the stage when narrower.
///
/// `PreviewStage` hands a bounded `maxWidth` (phone ~295, desktop ~560);
/// a fixed `SizedBox(width: 640)` would overflow the phone stage by ~300.
/// `LayoutBuilder` reads the available width and picks the smaller, so the
/// same example fits at 375 and 1280 with no overflow.
Widget _capped(double maxWidth, Widget child) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final double avail = constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : maxWidth;
      final double width = avail < maxWidth ? avail : maxWidth;
      return SizedBox(width: width, child: child);
    },
  );
}

/// Gradient frame used by the previews (the live app plugs the texture).
Widget _frame(List<Color> colors, String label) {
  return Container(
    alignment: Alignment.topCenter,
    padding: const EdgeInsets.only(top: 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// Player with the more (speed) menu opened.
class _SpeedMenuOpenVideo extends StatefulWidget {
  const _SpeedMenuOpenVideo();

  @override
  State<_SpeedMenuOpenVideo> createState() => _SpeedMenuOpenVideoState();
}

class _SpeedMenuOpenVideoState extends State<_SpeedMenuOpenVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController(
    playbackSpeed: 1.25,
    sourceLabel: demoVideoSources[0].detail,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      640,
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: 'For Bigger Blazes',
          subtitle: 'Season 3 episode 6',
          controlsBuilder: (context, c, defaults) => VideoControlsBar(
            controller: c,
            style: videoPlayerDefaults,
            fg: const Color(0xFFFFFFFF),
            fade: Duration.zero,
            title: 'For Bigger Blazes',
            subtitle: 'Season 3 episode 6',
            initialSpeedOpen: true,
          ),
          content: _frame(const <Color>[
            Color(0xFF4C1D95),
            Color(0xFF7C3AED),
          ], 'Speed menu open'),
        ),
      ),
    );
  }
}

Widget _speedMenuOpen(BuildContext context) => const _SpeedMenuOpenVideo();
''',
    ),
    DocsExampleSource(
      name: 'Captions on',
      builder: '_captions',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/video_player/video_player.dart';

/// Caps [child] at [maxWidth] but shrinks to the stage when narrower.
///
/// `PreviewStage` hands a bounded `maxWidth` (phone ~295, desktop ~560);
/// a fixed `SizedBox(width: 640)` would overflow the phone stage by ~300.
/// `LayoutBuilder` reads the available width and picks the smaller, so the
/// same example fits at 375 and 1280 with no overflow.
Widget _capped(double maxWidth, Widget child) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final double avail = constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : maxWidth;
      final double width = avail < maxWidth ? avail : maxWidth;
      return SizedBox(width: width, child: child);
    },
  );
}

/// Gradient frame used by the previews (the live app plugs the texture).
Widget _frame(List<Color> colors, String label) {
  return Container(
    alignment: Alignment.topCenter,
    padding: const EdgeInsets.only(top: 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// Player with captions on (WebVTT-style cues).
class _CaptionsVideo extends StatefulWidget {
  const _CaptionsVideo();

  @override
  State<_CaptionsVideo> createState() => _CaptionsVideoState();
}

class _CaptionsVideoState extends State<_CaptionsVideo> {
  late final FakeVideoPlaybackController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FakeVideoPlaybackController(
      position: const Duration(seconds: 12),
      areCaptionsEnabled: true,
      cues: <VideoCaptionCue>[
        VideoCaptionCue(
          start: Duration(seconds: 10),
          end: Duration(seconds: 15),
          text: 'Hello, world',
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      640,
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: 'Captioned premiere',
          subtitle: 'English subtitles',
          content: _frame(const <Color>[
            Color(0xFF0F172A),
            Color(0xFF334155),
          ], 'Captions on'),
        ),
      ),
    );
  }
}

Widget _captions(BuildContext context) => const _CaptionsVideo();
''',
    ),
    DocsExampleSource(
      name: 'Bar hidden',
      builder: '_barHidden',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/video_player/video_player.dart';

/// Caps [child] at [maxWidth] but shrinks to the stage when narrower.
///
/// `PreviewStage` hands a bounded `maxWidth` (phone ~295, desktop ~560);
/// a fixed `SizedBox(width: 640)` would overflow the phone stage by ~300.
/// `LayoutBuilder` reads the available width and picks the smaller, so the
/// same example fits at 375 and 1280 with no overflow.
Widget _capped(double maxWidth, Widget child) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final double avail = constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : maxWidth;
      final double width = avail < maxWidth ? avail : maxWidth;
      return SizedBox(width: width, child: child);
    },
  );
}

/// Gradient frame used by the previews (the live app plugs the texture).
Widget _frame(List<Color> colors, String label) {
  return Container(
    alignment: Alignment.topCenter,
    padding: const EdgeInsets.only(top: 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// Player with the control bar hidden (auto-hide state while playing).
class _BarHiddenVideo extends StatefulWidget {
  const _BarHiddenVideo();

  @override
  State<_BarHiddenVideo> createState() => _BarHiddenVideoState();
}

class _BarHiddenVideoState extends State<_BarHiddenVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController(
    isPlaying: true,
    sourceLabel: demoVideoSources[0].detail,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      640,
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          controlsVisible: false,
          title: 'For Bigger Blazes',
          subtitle: 'Season 3 episode 6',
          content: _frame(const <Color>[
            Color(0xFF047857),
            Color(0xFF10B981),
          ], 'Bar hidden'),
        ),
      ),
    );
  }
}

Widget _barHidden(BuildContext context) => const _BarHiddenVideo();
''',
    ),
    DocsExampleSource(
      name: 'Phone width',
      builder: '_phone',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/video_player/video_player.dart';

/// Caps [child] at [maxWidth] but shrinks to the stage when narrower.
///
/// `PreviewStage` hands a bounded `maxWidth` (phone ~295, desktop ~560);
/// a fixed `SizedBox(width: 640)` would overflow the phone stage by ~300.
/// `LayoutBuilder` reads the available width and picks the smaller, so the
/// same example fits at 375 and 1280 with no overflow.
Widget _capped(double maxWidth, Widget child) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final double avail = constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : maxWidth;
      final double width = avail < maxWidth ? avail : maxWidth;
      return SizedBox(width: width, child: child);
    },
  );
}

/// Gradient frame used by the previews (the live app plugs the texture).
Widget _frame(List<Color> colors, String label) {
  return Container(
    alignment: Alignment.topCenter,
    padding: const EdgeInsets.only(top: 12),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// Player scaled for phone width.
class _PhoneVideo extends StatefulWidget {
  const _PhoneVideo();

  @override
  State<_PhoneVideo> createState() => _PhoneVideoState();
}

class _PhoneVideoState extends State<_PhoneVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController(
    sourceLabel: demoVideoSources[0].detail,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      320,
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: 'For Bigger Blazes',
          subtitle: 'Season 3 episode 6',
          content: _frame(const <Color>[
            Color(0xFF1E1B4B),
            Color(0xFF4338CA),
          ], 'Phone width'),
        ),
      ),
    );
  }
}

Widget _phone(BuildContext context) => const _PhoneVideo();
''',
    ),
    DocsExampleSource(
      name: 'Customized',
      builder: '_custom',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/components/video_player/video_player.dart';

/// Caps [child] at [maxWidth] but shrinks to the stage when narrower.
///
/// `PreviewStage` hands a bounded `maxWidth` (phone ~295, desktop ~560);
/// a fixed `SizedBox(width: 640)` would overflow the phone stage by ~300.
/// `LayoutBuilder` reads the available width and picks the smaller, so the
/// same example fits at 375 and 1280 with no overflow.
Widget _capped(double maxWidth, Widget child) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      final double avail = constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : maxWidth;
      final double width = avail < maxWidth ? avail : maxWidth;
      return SizedBox(width: width, child: child);
    },
  );
}

/// Customized theme and custom play button.
class _CustomVideo extends StatefulWidget {
  const _CustomVideo();

  @override
  State<_CustomVideo> createState() => _CustomVideoState();
}

class _CustomVideoState extends State<_CustomVideo> {
  final FakeVideoPlaybackController _controller = FakeVideoPlaybackController(
    playbackSpeed: 1.5,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _capped(
      640,
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: VideoPlayer(
          controller: _controller,
          title: 'Custom theme',
          subtitle: 'Rose accent',
          content: const ColoredBox(color: Color(0xFF3F3F46)),
          theme: const VideoPlayerTheme(
            accent: ThemedColor.value(Color(0xFFE11D48)),
            controlSize: 56,
          ),
          playButtonBuilder: (context, c) => GestureDetector(
            onTap: c.toggle,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFFE11D48),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(
                c.isPlaying ? LucideIcons.pause : LucideIcons.play,
                color: const Color(0xFFFFFFFF),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _custom(BuildContext context) => const _CustomVideo();
''',
    ),
    DocsExampleSource(
      name: 'Live playback',
      description: 'Real plugin playback: MP4, live HLS and camera sources.',
      builder: '_liveVideo',
      code:
          'import \'package:docs/media/video_adapter.dart\';\nimport \'package:docs/ui/dashcn/components/video_player/video_player.dart\';\nimport \'package:docs/ui/dashcn/foundation/icons/lucide_icons.dart\';\nimport \'package:docs/web_bridge.dart\';\nimport \'package:flutter/widgets.dart\';\nimport \'package:video_player/video_player.dart\';\n\n/// Inline WebVTT sample for the captions toggle.\nconst String _sampleVtt = \'\'\'\nWEBVTT\n\n00:00.000 --> 00:05.000\nHello, world\n\n00:05.000 --> 00:12.000\nButterfly wings at 24 frames\n\'\'\';\n\n/// Minimal WebVTT parser (cues with `start --> end` headers).\nList<VideoCaptionCue> parseWebVtt(String source) {\n  final List<VideoCaptionCue> cues = <VideoCaptionCue>[];\n  final List<String> lines = source.replaceAll(\'\\r\\n\', \'\\n\').split(\'\\n\');\n  int i = 0;\n  if (lines.isNotEmpty && lines.first.trim() == \'WEBVTT\') i = 1;\n  final RegExp stamp = RegExp(\n    r\'(?:(\\d+):)?([0-5]?\\d):([0-5]\\d)[.,](\\d{3})\\s*-->\\s*(?:(\\d+):)?([0-5]?\\d):([0-5]\\d)[.,](\\d{3})\',\n  );\n  Duration? toDuration(Match m, int h, int min, int s, int ms) {\n    final int hours = m.group(h) == null ? 0 : int.parse(m.group(h)!);\n    return Duration(\n      hours: hours,\n      minutes: int.parse(m.group(min)!),\n      seconds: int.parse(m.group(s)!),\n      milliseconds: int.parse(m.group(ms)!),\n    );\n  }\n\n  while (i < lines.length) {\n    final String line = lines[i].trim();\n    i++;\n    if (line.isEmpty) continue;\n    final Match? m = stamp.firstMatch(line);\n    if (m == null) continue;\n    final Duration start = toDuration(m, 1, 2, 3, 4)!;\n    final Duration end = toDuration(m, 5, 6, 7, 8)!;\n    final StringBuffer text = StringBuffer();\n    while (i < lines.length && lines[i].trim().isNotEmpty) {\n      if (text.isNotEmpty) text.write(\'\\n\');\n      text.write(lines[i].trim());\n      i++;\n    }\n    if (text.isNotEmpty) {\n      cues.add(VideoCaptionCue(start: start, end: end, text: text.toString()));\n    }\n  }\n  return cues;\n}\n\n/// Live video docs example: source switcher over real plugin playback.\nclass _LiveVideo extends StatefulWidget {\n  const _LiveVideo();\n\n  @override\n  State<_LiveVideo> createState() => _LiveVideoState();\n}\n\nclass _LiveVideoState extends State<_LiveVideo> {\n  int _sourceIndex = 0;\n  plugin.VideoPlayerController? _inner;\n  PluginVideoAdapter? _adapter;\n  bool _cameraGranted = false;\n  bool _cameraAsked = false;\n  Object? _loadError;\n\n  @override\n  void initState() {\n    super.initState();\n    _openSource(0);\n  }\n\n  @override\n  void dispose() {\n    _adapter?.dispose();\n    // See live_audio.dart: plugin dispose throws where plugins are absent.\n    _inner?.dispose().then((_) {}, onError: (_) {});\n    super.dispose();\n  }\n\n  Future<void> _openSource(int index) async {\n    final VideoSource source = demoVideoSources[index];\n    final plugin.VideoPlayerController? oldInner = _inner;\n    final PluginVideoAdapter? oldAdapter = _adapter;\n    oldAdapter?.dispose();\n    if (mounted) {\n      setState(() {\n        _sourceIndex = index;\n        _inner = null;\n        _adapter = null;\n        _loadError = null;\n        _cameraAsked = source.isCamera;\n      });\n    }\n    if (source.isCamera) {\n      final bool granted = await webRequestCamera();\n      if (!mounted) return;\n      setState(() => _cameraGranted = granted);\n      try {\n        await oldInner?.dispose();\n      } catch (_) {}\n      return;\n    }\n    final String? uri = source.uri;\n    if (uri == null) {\n      if (!mounted) return;\n      setState(() => _loadError = StateError(\'No playable URL\'));\n      try {\n        await oldInner?.dispose();\n      } catch (_) {}\n      return;\n    }\n    final plugin.VideoPlayerController inner =\n        plugin.VideoPlayerController.networkUrl(Uri.parse(uri));\n    final PluginVideoAdapter adapter = PluginVideoAdapter(inner);\n    adapter.setSource(isLive: source.isLive, label: source.detail);\n    adapter.setCues(parseWebVtt(_sampleVtt));\n    if (source.isLive) {\n      await adapter.setCaptionsEnabled(false);\n    } else {\n      // Demo default: captions on so the WebVTT sample shows; the bar and\n      // menu toggles turn them off.\n      await adapter.setCaptionsEnabled(true);\n    }\n    try {\n      await inner.initialize();\n    } catch (error) {\n      if (!mounted) {\n        adapter.dispose();\n        await inner.dispose();\n        return;\n      }\n      setState(() {\n        _inner = inner;\n        _adapter = adapter;\n        _loadError = error;\n      });\n      try {\n        await oldInner?.dispose();\n      } catch (_) {}\n      return;\n    }\n    if (!mounted) {\n      adapter.dispose();\n      await inner.dispose();\n      return;\n    }\n    setState(() {\n      _inner = inner;\n      _adapter = adapter;\n    });\n    await oldInner?.dispose();\n  }\n\n  @override\n  Widget build(BuildContext context) {\n    return LayoutBuilder(\n      builder: (BuildContext context, BoxConstraints constraints) {\n        final double width = constraints.maxWidth.isFinite\n            ? constraints.maxWidth.clamp(320.0, 640.0)\n            : 640.0;\n        return SizedBox(\n          width: width,\n          child: Column(\n            mainAxisSize: MainAxisSize.min,\n            children: <Widget>[\n              _SourceSwitcher(current: _sourceIndex, onSelect: _openSource),\n              const SizedBox(height: 8),\n              _stage(width),\n            ],\n          ),\n        );\n      },\n    );\n  }\n\n  Widget _stage(double width) {\n    final VideoSource source = demoVideoSources[_sourceIndex];\n    if (source.isCamera) {\n      return AspectRatio(\n        aspectRatio: 16 / 9,\n        child: Container(\n          decoration: BoxDecoration(\n            color: const Color(0xFF18181B),\n            borderRadius: BorderRadius.circular(18),\n            border: Border.all(color: const Color(0xFF27272A)),\n          ),\n          alignment: Alignment.center,\n          child: !_cameraAsked\n              ? const SizedBox.shrink()\n              : _cameraGranted\n              ? const Column(\n                  mainAxisSize: MainAxisSize.min,\n                  children: <Widget>[\n                    Icon(LucideIcons.video, size: 32, color: Color(0xFFFFFFFF)),\n                    SizedBox(height: 8),\n                    Text(\n                      \'Camera live — feed renders on device browsers\',\n                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13),\n                    ),\n                  ],\n                )\n              : const Column(\n                  mainAxisSize: MainAxisSize.min,\n                  children: <Widget>[\n                    Icon(\n                      LucideIcons.cameraOff,\n                      size: 32,\n                      color: Color(0xFFFFFFFF),\n                    ),\n                    SizedBox(height: 8),\n                    Text(\n                      \'Camera unavailable — permission denied\',\n                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13),\n                    ),\n                  ],\n                ),\n        ),\n      );\n    }\n    final PluginVideoAdapter? adapter = _adapter;\n    final plugin.VideoPlayerController? inner = _inner;\n    if (adapter == null || inner == null) {\n      return AspectRatio(\n        aspectRatio: 16 / 9,\n        child: Container(\n          decoration: BoxDecoration(\n            color: const Color(0xFF000000),\n            borderRadius: BorderRadius.circular(18),\n            border: Border.all(color: const Color(0xFF27272A)),\n          ),\n          alignment: Alignment.center,\n          child: _loadError == null\n              ? const Icon(\n                  LucideIcons.loaderCircle,\n                  size: 32,\n                  color: Color(0xFFFFFFFF),\n                )\n              : Text(\n                  \'Playback failed: \$_loadError\',\n                  style: const TextStyle(\n                    color: Color(0xFFFFFFFF),\n                    fontSize: 12,\n                  ),\n                  textAlign: TextAlign.center,\n                ),\n        ),\n      );\n    }\n    return VideoPlayer(\n      controller: adapter,\n      title: source.label,\n      subtitle: source.detail,\n      content: adapter.buildView(),\n      errorBuilder: (BuildContext context, Object error) => Center(\n        child: Text(\n          \'Playback failed: \$error\',\n          style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 12),\n          textAlign: TextAlign.center,\n        ),\n      ),\n    );\n  }\n}\n\n/// Source switcher chips (docs chrome around the component).\nclass _SourceSwitcher extends StatelessWidget {\n  const _SourceSwitcher({required this.current, required this.onSelect});\n\n  final int current;\n  final ValueChanged<int> onSelect;\n\n  @override\n  Widget build(BuildContext context) {\n    return Wrap(\n      alignment: WrapAlignment.center,\n      runSpacing: 8,\n      children: <Widget>[\n        for (int i = 0; i < demoVideoSources.length; i++)\n          GestureDetector(\n            behavior: HitTestBehavior.opaque,\n            onTap: () => onSelect(i),\n            child: Container(\n              margin: const EdgeInsets.symmetric(horizontal: 4),\n              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),\n              decoration: BoxDecoration(\n                color: current == i\n                    ? const Color(0xFF18181B)\n                    : const Color(0x00000000),\n                borderRadius: BorderRadius.circular(999),\n                border: Border.all(color: const Color(0xFF27272A)),\n              ),\n              child: Text(\n                demoVideoSources[i].label,\n                style: TextStyle(\n                  color: current == i\n                      ? const Color(0xFFFFFFFF)\n                      : const Color(0xFF71717A),\n                  fontSize: 12,\n                  fontWeight: FontWeight.w600,\n                ),\n              ),\n            ),\n          ),\n      ],\n    );\n  }\n}\n\nWidget _liveVideo(BuildContext context) => const _LiveVideo();\n',
    ),
  ],
  'alpha': <DocsExampleSource>[],
  'anchor': <DocsExampleSource>[],
  'app': <DocsExampleSource>[],
  'async': <DocsExampleSource>[],
  'backdrop_transform': <DocsExampleSource>[],
  'color': <DocsExampleSource>[],
  'color_field': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_colorFieldDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/color_field/color_field.dart';

/// A section label above a field.
class _ColorFieldLabel extends StatelessWidget {
  const _ColorFieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: theme.colors.foreground,
        ),
      ),
    );
  }
}

/// The HSV saturation/value field.
Widget _colorFieldDefault(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      _ColorFieldLabel('HSV field'),
      SizedBox(
        width: 240,
        height: 140,
        child: ColorField(
          color: Color(0xFF2563EB),
          saturationAxis: ColorFieldAxis.horizontal,
          valueAxis: ColorFieldAxis.vertical,
        ),
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Hue',
      builder: '_colorFieldHue',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/color_field/color_field.dart';

/// A section label above a field.
class _ColorFieldLabel extends StatelessWidget {
  const _ColorFieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: theme.colors.foreground,
        ),
      ),
    );
  }
}

/// The hue strip.
Widget _colorFieldHue(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      _ColorFieldLabel('Hue strip'),
      SizedBox(
        width: 240,
        height: 24,
        child: ColorField(
          color: Color(0xFF2563EB),
          hueAxis: ColorFieldAxis.horizontal,
        ),
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'HSL',
      builder: '_colorFieldHsl',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/color_field/color_field.dart';

/// A section label above a field.
class _ColorFieldLabel extends StatelessWidget {
  const _ColorFieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: theme.colors.foreground,
        ),
      ),
    );
  }
}

/// The HSL lightness field.
Widget _colorFieldHsl(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      _ColorFieldLabel('HSL field'),
      SizedBox(
        width: 240,
        height: 140,
        child: ColorField(
          color: Color(0x8022C55E),
          mode: ColorFieldMode.hsl,
          saturationAxis: ColorFieldAxis.horizontal,
          lightnessAxis: ColorFieldAxis.vertical,
        ),
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Alpha',
      builder: '_colorFieldAlpha',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/color_field/color_field.dart';

/// A section label above a field.
class _ColorFieldLabel extends StatelessWidget {
  const _ColorFieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: theme.colors.foreground,
        ),
      ),
    );
  }
}

/// The alpha ramp.
Widget _colorFieldAlpha(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      _ColorFieldLabel('Alpha ramp'),
      SizedBox(
        width: 240,
        height: 24,
        child: ColorField(
          color: Color(0xFF2563EB),
          alphaAxis: ColorFieldAxis.horizontal,
        ),
      ),
    ],
  );
}
''',
    ),
  ],
  'color_input': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_colorInputDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/primitives/form_core/object_form_field.dart';
import 'package:<your_app>/ui/dashcn/components/color/color.dart';
import 'package:<your_app>/ui/dashcn/components/eye_dropper/eye_dropper.dart';
import 'package:<your_app>/ui/dashcn/components/history/history.dart';
import 'package:<your_app>/ui/dashcn/components/color_input/color_input.dart';

/// One trigger, with the scopes the colour machinery needs.
class _ColorInputColorInputExample extends StatefulWidget {
  const _ColorInputColorInputExample({
    this.mode,
    this.dialogTitle,
    this.showAlpha = false,
    this.showHistory = false,
    this.enabled = true,
  });

  final PromptMode? mode;
  final Widget? dialogTitle;
  final bool showAlpha;
  final bool showHistory;
  final bool enabled;

  @override
  State<_ColorInputColorInputExample> createState() =>
      _ColorInputColorInputExampleState();
}

class _ColorInputColorInputExampleState
    extends State<_ColorInputColorInputExample> {
  ColorDerivative _value = ColorDerivative.fromColor(const Color(0xFF2563EB));

  @override
  Widget build(BuildContext context) {
    return EyeDropperLayer(
      child: RecentColorsScope(
        initialRecentColors: const <Color>[
          Color(0xFF2563EB),
          Color(0xFF22C55E),
          Color(0xFFE11D48),
        ],
        child: SizedBox(
          width: 240,
          child: ColorInput(
            value: _value,
            mode: widget.mode,
            dialogTitle: widget.dialogTitle,
            showAlpha: widget.showAlpha,
            showHistory: widget.showHistory,
            enabled: widget.enabled,
            onChanged: (ColorDerivative next) => setState(() => _value = next),
          ),
        ),
      ),
    );
  }
}

/// The default trigger, with the popover prompt.
Widget _colorInputDefault(BuildContext context) =>
    const _ColorInputColorInputExample();
''',
    ),
    DocsExampleSource(
      name: 'Dialog prompt',
      builder: '_colorInputDialog',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/primitives/form_core/object_form_field.dart';
import 'package:<your_app>/ui/dashcn/components/color/color.dart';
import 'package:<your_app>/ui/dashcn/components/eye_dropper/eye_dropper.dart';
import 'package:<your_app>/ui/dashcn/components/history/history.dart';
import 'package:<your_app>/ui/dashcn/components/color_input/color_input.dart';

/// One trigger, with the scopes the colour machinery needs.
class _ColorInputColorInputExample extends StatefulWidget {
  const _ColorInputColorInputExample({
    this.mode,
    this.dialogTitle,
    this.showAlpha = false,
    this.showHistory = false,
    this.enabled = true,
  });

  final PromptMode? mode;
  final Widget? dialogTitle;
  final bool showAlpha;
  final bool showHistory;
  final bool enabled;

  @override
  State<_ColorInputColorInputExample> createState() =>
      _ColorInputColorInputExampleState();
}

class _ColorInputColorInputExampleState
    extends State<_ColorInputColorInputExample> {
  ColorDerivative _value = ColorDerivative.fromColor(const Color(0xFF2563EB));

  @override
  Widget build(BuildContext context) {
    return EyeDropperLayer(
      child: RecentColorsScope(
        initialRecentColors: const <Color>[
          Color(0xFF2563EB),
          Color(0xFF22C55E),
          Color(0xFFE11D48),
        ],
        child: SizedBox(
          width: 240,
          child: ColorInput(
            value: _value,
            mode: widget.mode,
            dialogTitle: widget.dialogTitle,
            showAlpha: widget.showAlpha,
            showHistory: widget.showHistory,
            enabled: widget.enabled,
            onChanged: (ColorDerivative next) => setState(() => _value = next),
          ),
        ),
      ),
    );
  }
}

/// The dialog prompt with a title.
Widget _colorInputDialog(BuildContext context) => _ColorInputColorInputExample(
  mode: PromptMode.dialog,
  dialogTitle: Text('Select a colour'),
);
''',
    ),
    DocsExampleSource(
      name: 'Alpha + history',
      builder: '_colorInputAlphaHistory',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/primitives/form_core/object_form_field.dart';
import 'package:<your_app>/ui/dashcn/components/color/color.dart';
import 'package:<your_app>/ui/dashcn/components/eye_dropper/eye_dropper.dart';
import 'package:<your_app>/ui/dashcn/components/history/history.dart';
import 'package:<your_app>/ui/dashcn/components/color_input/color_input.dart';

/// One trigger, with the scopes the colour machinery needs.
class _ColorInputColorInputExample extends StatefulWidget {
  const _ColorInputColorInputExample({
    this.mode,
    this.dialogTitle,
    this.showAlpha = false,
    this.showHistory = false,
    this.enabled = true,
  });

  final PromptMode? mode;
  final Widget? dialogTitle;
  final bool showAlpha;
  final bool showHistory;
  final bool enabled;

  @override
  State<_ColorInputColorInputExample> createState() =>
      _ColorInputColorInputExampleState();
}

class _ColorInputColorInputExampleState
    extends State<_ColorInputColorInputExample> {
  ColorDerivative _value = ColorDerivative.fromColor(const Color(0xFF2563EB));

  @override
  Widget build(BuildContext context) {
    return EyeDropperLayer(
      child: RecentColorsScope(
        initialRecentColors: const <Color>[
          Color(0xFF2563EB),
          Color(0xFF22C55E),
          Color(0xFFE11D48),
        ],
        child: SizedBox(
          width: 240,
          child: ColorInput(
            value: _value,
            mode: widget.mode,
            dialogTitle: widget.dialogTitle,
            showAlpha: widget.showAlpha,
            showHistory: widget.showHistory,
            enabled: widget.enabled,
            onChanged: (ColorDerivative next) => setState(() => _value = next),
          ),
        ),
      ),
    );
  }
}

/// Alpha plus the recent-colour history.
Widget _colorInputAlphaHistory(BuildContext context) =>
    const _ColorInputColorInputExample(showAlpha: true, showHistory: true);
''',
    ),
    DocsExampleSource(
      name: 'Disabled',
      builder: '_colorInputDisabled',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/primitives/form_core/object_form_field.dart';
import 'package:<your_app>/ui/dashcn/components/color/color.dart';
import 'package:<your_app>/ui/dashcn/components/eye_dropper/eye_dropper.dart';
import 'package:<your_app>/ui/dashcn/components/history/history.dart';
import 'package:<your_app>/ui/dashcn/components/color_input/color_input.dart';

/// One trigger, with the scopes the colour machinery needs.
class _ColorInputColorInputExample extends StatefulWidget {
  const _ColorInputColorInputExample({
    this.mode,
    this.dialogTitle,
    this.showAlpha = false,
    this.showHistory = false,
    this.enabled = true,
  });

  final PromptMode? mode;
  final Widget? dialogTitle;
  final bool showAlpha;
  final bool showHistory;
  final bool enabled;

  @override
  State<_ColorInputColorInputExample> createState() =>
      _ColorInputColorInputExampleState();
}

class _ColorInputColorInputExampleState
    extends State<_ColorInputColorInputExample> {
  ColorDerivative _value = ColorDerivative.fromColor(const Color(0xFF2563EB));

  @override
  Widget build(BuildContext context) {
    return EyeDropperLayer(
      child: RecentColorsScope(
        initialRecentColors: const <Color>[
          Color(0xFF2563EB),
          Color(0xFF22C55E),
          Color(0xFFE11D48),
        ],
        child: SizedBox(
          width: 240,
          child: ColorInput(
            value: _value,
            mode: widget.mode,
            dialogTitle: widget.dialogTitle,
            showAlpha: widget.showAlpha,
            showHistory: widget.showHistory,
            enabled: widget.enabled,
            onChanged: (ColorDerivative next) => setState(() => _value = next),
          ),
        ),
      ),
    );
  }
}

/// The disabled trigger.
Widget _colorInputDisabled(BuildContext context) =>
    const _ColorInputColorInputExample(enabled: false);
''',
    ),
  ],
  'drawer_container': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_drawerContainerDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/data.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/drawer_container/drawer_container.dart';

/// A framed box that shows the container's bounds.
class _DrawerContainerFrame extends StatelessWidget {
  const _DrawerContainerFrame({required this.child, this.width, this.height});

  final Widget child;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.muted,
        borderRadius: theme.borderRadiusMd,
      ),
      child: Padding(
        padding: EdgeInsetsDensity.pxAll(8),
        child: SizedBox(width: width, height: height, child: child),
      ),
    );
  }
}

/// Drawer chrome at the four edges.
Widget _drawerContainerDefault(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Wrap(
    spacing: spacing.md,
    runSpacing: spacing.md,
    children: <Widget>[
      for (final position in const <OverlayPosition>[
        OverlayPosition.left,
        OverlayPosition.right,
        OverlayPosition.top,
        OverlayPosition.bottom,
      ])
        _DrawerContainerFrame(
          child: DrawerRawContainer(
            position: position,
            constraints: const BoxConstraints(maxWidth: 140, maxHeight: 120),
            child: const Center(child: Text('Drawer')),
          ),
        ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'With handle',
      builder: '_drawerContainerWithHandle',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/data.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/drawer_container/drawer_container.dart';

/// A framed box that shows the container's bounds.
class _DrawerContainerFrame extends StatelessWidget {
  const _DrawerContainerFrame({required this.child, this.width, this.height});

  final Widget child;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.muted,
        borderRadius: theme.borderRadiusMd,
      ),
      child: Padding(
        padding: EdgeInsetsDensity.pxAll(8),
        child: SizedBox(width: width, height: height, child: child),
      ),
    );
  }
}

/// The sheet form, expanded along the cross axis.
Widget _drawerContainerWithHandle(BuildContext context) {
  return Wrap(
    spacing: Theme.of(context).spacing.md,
    runSpacing: Theme.of(context).spacing.md,
    children: <Widget>[
      _DrawerContainerFrame(
        width: 220,
        height: 140,
        child: DrawerRawContainer(
          position: OverlayPosition.bottom,
          isSheet: true,
          expands: true,
          child: Center(child: Text('Sheet')),
        ),
      ),
      _DrawerContainerFrame(
        width: 240,
        height: 120,
        child: DrawerRawContainer(
          position: OverlayPosition.bottom,
          isSheet: true,
          crossAxisSize: FractionAxisSize(0.5),
          crossAxisAlignment: 0,
          child: Center(child: Text('Half width')),
        ),
      ),
      _DrawerContainerFrame(
        width: 240,
        height: 120,
        child: DrawerRawContainer(
          position: OverlayPosition.bottom,
          isSheet: true,
          fadeAnimation: AlwaysStoppedAnimation<double>(1),
          child: Center(child: Text('With barrier')),
        ),
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Data-driven',
      builder: '_drawerContainerDataDriven',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/data.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/drawer_container/drawer_container.dart';

/// A framed box that shows the container's bounds.
class _DrawerContainerFrame extends StatelessWidget {
  const _DrawerContainerFrame({required this.child, this.width, this.height});

  final Widget child;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.muted,
        borderRadius: theme.borderRadiusMd,
      ),
      child: Padding(
        padding: EdgeInsetsDensity.pxAll(8),
        child: SizedBox(width: width, height: height, child: child),
      ),
    );
  }
}

/// A container driven by the ambient data scope.
Widget _drawerContainerDataDriven(BuildContext context) {
  return _DrawerContainerFrame(
    width: 240,
    height: 140,
    child: Data<DrawerContainerData>.inherit(
      data: DrawerContainerData(
        position: OverlayPosition.right,
        isSheet: true,
        padding: EdgeInsetsDensity.pxAll(12),
      ),
      child: DrawerContainer(
        size: FractionAxisSize(0.6),
        child: Center(child: Text('Data-driven')),
      ),
    ),
  );
}
''',
    ),
  ],
  'error_system': <DocsExampleSource>[],
  'eye_dropper': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_eyeDropperDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/eye_dropper/eye_dropper.dart';

/// A swatch the example can pick from.
class _EyeDropperSwatch extends StatelessWidget {
  const _EyeDropperSwatch(this.color);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const SizedBox(width: 120, height: 72),
    );
  }
}

/// The picker, with the live result echoed as text and a swatch.
class _EyeDropperPicker extends StatefulWidget {
  const _EyeDropperPicker({this.inline = false});

  final bool inline;

  @override
  State<_EyeDropperPicker> createState() => _EyeDropperPickerState();
}

class _EyeDropperPickerState extends State<_EyeDropperPicker> {
  Color? _picked;
  Color? _live;
  bool _sampling = false;

  void _eyeDropperPick() async {
    setState(() {
      _sampling = true;
      _live = null;
    });
    final Color? color = await pickColorFromScreen(context, null, (
      Color sample,
    ) {
      if (mounted) setState(() => _live = sample);
    });
    if (mounted) {
      setState(() {
        _picked = color;
        _live = null;
        _sampling = false;
      });
    }
  }

  String _eyeDropperHex(Color color) {
    String byte(double channel) =>
        ((channel * 255).round() & 0xFF).toRadixString(16).padLeft(2, '0');
    return '${byte(color.r)}${byte(color.g)}${byte(color.b)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color? shown = _live ?? _picked;
    return EyeDropperLayer(
      previewAlignment: Alignment.topLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (!widget.inline)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const _EyeDropperSwatch(Color(0xFF2563EB)),
                Gap(theme.spacing.sm),
                const _EyeDropperSwatch(Color(0xFF22C55E)),
              ],
            ),
          if (!widget.inline) Gap(theme.spacing.lg),
          GestureDetector(
            onTap: _eyeDropperPick,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colors.primary,
                borderRadius: theme.borderRadiusMd,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: theme.spacing.md,
                  vertical: theme.spacing.sm,
                ),
                child: Text(
                  _sampling
                      ? 'Sampling… move to pick'
                      : _picked == null
                      ? 'Pick a colour'
                      : 'Pick again',
                  style: TextStyle(color: theme.colors.primaryForeground),
                ),
              ),
            ),
          ),
          Gap(theme.spacing.lg),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(
                  color: shown ?? theme.colors.muted,
                  border: Border.all(color: theme.colors.border),
                  borderRadius: theme.borderRadiusSm,
                ),
                child: SizedBox(
                  width: theme.spacing.xl,
                  height: theme.spacing.xl,
                ),
              ),
              Gap(theme.spacing.sm),
              Text(
                shown == null
                    ? 'no colour picked'
                    : '#${_eyeDropperHex(shown)}',
                style: TextStyle(color: theme.colors.mutedForeground),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// The default picker.
Widget _eyeDropperDefault(BuildContext context) => const _EyeDropperPicker();
''',
    ),
    DocsExampleSource(
      name: 'Inline value',
      builder: '_eyeDropperInline',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/eye_dropper/eye_dropper.dart';

/// A swatch the example can pick from.
class _EyeDropperSwatch extends StatelessWidget {
  const _EyeDropperSwatch(this.color);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const SizedBox(width: 120, height: 72),
    );
  }
}

/// The picker, with the live result echoed as text and a swatch.
class _EyeDropperPicker extends StatefulWidget {
  const _EyeDropperPicker({this.inline = false});

  final bool inline;

  @override
  State<_EyeDropperPicker> createState() => _EyeDropperPickerState();
}

class _EyeDropperPickerState extends State<_EyeDropperPicker> {
  Color? _picked;
  Color? _live;
  bool _sampling = false;

  void _eyeDropperPick() async {
    setState(() {
      _sampling = true;
      _live = null;
    });
    final Color? color = await pickColorFromScreen(context, null, (
      Color sample,
    ) {
      if (mounted) setState(() => _live = sample);
    });
    if (mounted) {
      setState(() {
        _picked = color;
        _live = null;
        _sampling = false;
      });
    }
  }

  String _eyeDropperHex(Color color) {
    String byte(double channel) =>
        ((channel * 255).round() & 0xFF).toRadixString(16).padLeft(2, '0');
    return '${byte(color.r)}${byte(color.g)}${byte(color.b)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color? shown = _live ?? _picked;
    return EyeDropperLayer(
      previewAlignment: Alignment.topLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (!widget.inline)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const _EyeDropperSwatch(Color(0xFF2563EB)),
                Gap(theme.spacing.sm),
                const _EyeDropperSwatch(Color(0xFF22C55E)),
              ],
            ),
          if (!widget.inline) Gap(theme.spacing.lg),
          GestureDetector(
            onTap: _eyeDropperPick,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colors.primary,
                borderRadius: theme.borderRadiusMd,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: theme.spacing.md,
                  vertical: theme.spacing.sm,
                ),
                child: Text(
                  _sampling
                      ? 'Sampling… move to pick'
                      : _picked == null
                      ? 'Pick a colour'
                      : 'Pick again',
                  style: TextStyle(color: theme.colors.primaryForeground),
                ),
              ),
            ),
          ),
          Gap(theme.spacing.lg),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(
                  color: shown ?? theme.colors.muted,
                  border: Border.all(color: theme.colors.border),
                  borderRadius: theme.borderRadiusSm,
                ),
                child: SizedBox(
                  width: theme.spacing.xl,
                  height: theme.spacing.xl,
                ),
              ),
              Gap(theme.spacing.sm),
              Text(
                shown == null
                    ? 'no colour picked'
                    : '#${_eyeDropperHex(shown)}',
                style: TextStyle(color: theme.colors.mutedForeground),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// The picker with the swatches hidden.
Widget _eyeDropperInline(BuildContext context) =>
    const _EyeDropperPicker(inline: true);
''',
    ),
  ],
  'formatter': <DocsExampleSource>[],
  'group': <DocsExampleSource>[],
  'history': <DocsExampleSource>[],
  'hsl': <DocsExampleSource>[],
  'hsv': <DocsExampleSource>[],
  'icon': <DocsExampleSource>[],
  'locale_utils': <DocsExampleSource>[],
  'media_query': <DocsExampleSource>[],
  'multiple_choice': <DocsExampleSource>[],
  'outlined_container': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_outlinedContainerDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/outlined_container/outlined_container.dart';

/// Token look: the theme border and card surface at the default radius.
Widget _outlinedContainerDefault(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return SizedBox(
    width: 320,
    child: OutlinedContainer(
      padding: EdgeInsets.all(spacing.lg),
      child: const Text('Outlined container'),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Rounded',
      builder: '_outlinedContainerRounded',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/outlined_container/outlined_container.dart';

/// A wider radius and denser padding.
Widget _outlinedContainerRounded(BuildContext context) {
  return SizedBox(
    width: 320,
    child: OutlinedContainer(
      padding: EdgeInsetsDensity.pxAll(20),
      borderRadius: BorderRadius.all(Radius.circular(24)),
      child: Text('Rounded corners'),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Translucent',
      builder: '_outlinedContainerTranslucent',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/outlined_container/outlined_container.dart';

/// A translucent fill and a backdrop-blurred surface.
Widget _outlinedContainerTranslucent(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      SizedBox(
        width: 320,
        child: OutlinedContainer(
          padding: EdgeInsetsDensity.pxAll(16),
          backgroundColor: ThemedColor.ref(ColorRef.primary),
          surfaceOpacity: 0.12,
          child: Text('Translucent primary fill'),
        ),
      ),
      Gap(spacing.lg),
      SizedBox(
        width: 320,
        child: OutlinedContainer(
          padding: EdgeInsetsDensity.pxAll(16),
          surfaceBlur: 12,
          surfaceOpacity: 0.6,
          child: Text('Backdrop blur'),
        ),
      ),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Dashed',
      builder: '_outlinedContainerDashed',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/density.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/outlined_container/outlined_container.dart';

/// The dashed outline form.
Widget _outlinedContainerDashed(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return SizedBox(
    width: 320,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DashedContainer(
          child: Padding(
            padding: EdgeInsetsDensity.pxAll(16),
            child: Text('Dashed container'),
          ),
        ),
        Gap(spacing.lg),
        const DashedLine(),
      ],
    ),
  );
}
''',
    ),
  ],
  'overlay_configuration': <DocsExampleSource>[],
  'page_route': <DocsExampleSource>[],
  'patch': <DocsExampleSource>[],
  'scrollable': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/scrollable/scrollable.dart';

/// A horizontal strip with edge fades.
Widget _default(BuildContext context) {
  return SizedBox(
    width: 320,
    height: 72,
    child: FadedScrollableViewport(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.all(12),
          child: Text('Item ${index + 1}'),
        ),
      ),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Vertical',
      builder: '_vertical',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/scrollable/scrollable.dart';

/// A vertical list with edge fades.
Widget _vertical(BuildContext context) {
  return SizedBox(
    width: 280,
    height: 160,
    child: FadedScrollableViewport(
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.all(8),
          child: Text('Row ${index + 1}'),
        ),
      ),
    ),
  );
}
''',
    ),
  ],
  'scrollable_client': <DocsExampleSource>[],
  'scrollview': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/scrollview/scrollview.dart';

/// A list wrapped in the middle-button autoscroll interceptor.
Widget _default(BuildContext context) {
  final theme = Theme.of(context);
  return SizedBox(
    width: 360,
    height: 220,
    child: ScrollViewInterceptor(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (int index = 1; index <= 30; index++)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text('Drag with the middle button · $index'),
              ),
            Gap(theme.spacing.lg),
          ],
        ),
      ),
    ),
  );
}
''',
    ),
  ],
  'selectable': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/selectable/selectable.dart';

/// Plain selectable text.
Widget _default(BuildContext context) {
  return SizedBox(
    width: 320,
    child: SelectableText(
      'Select this text to see the custom selection styling.',
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Long text',
      builder: '_longText',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/selectable/selectable.dart';

/// A wrapping paragraph showing selection across lines.
Widget _longText(BuildContext context) {
  return const SizedBox(
    width: 320,
    child: SelectableText(
      'Flutter widgets are built from smaller pieces until the whole screen reads as one surface. Drag across this paragraph to select words, '
      'lines, or the entire block with the custom caret and highlight.',
    ),
  );
}
''',
    ),
  ],
  'spell_check_suggestions_toolbar': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/spell_check_suggestions_toolbar/spell_check_suggestions_toolbar.dart';

void _noop() {}

/// Anchored toolbar with three replacement rows, one disabled.
Widget _default(BuildContext context) {
  return SizedBox(
    width: 280,
    height: 140,
    child: SpellCheckSuggestionsToolbar(
      anchors: TextSelectionToolbarAnchors(primaryAnchor: Offset(12, 12)),
      buttonItems: <ContextMenuButtonItem>[
        ContextMenuButtonItem(label: 'receipt', onPressed: _noop),
        ContextMenuButtonItem(label: 'receipts', onPressed: _noop),
        ContextMenuButtonItem(label: 'deceit', onPressed: null),
      ],
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'No suggestions',
      builder: '_noSuggestions',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/components/spell_check_suggestions_toolbar/spell_check_suggestions_toolbar.dart';

/// The placeholder row shown when the service has no suggestion.
Widget _noSuggestions(BuildContext context) {
  return SizedBox(
    width: 280,
    height: 80,
    child: SpellCheckSuggestionsToolbar(
      anchors: TextSelectionToolbarAnchors(primaryAnchor: Offset(12, 12)),
      buttonItems: <ContextMenuButtonItem>[
        ContextMenuButtonItem(onPressed: null),
      ],
    ),
  );
}
''',
    ),
  ],
  'stage_container': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/stage_container/stage_container.dart';

/// The content the stage wraps; prints the resolved outer padding.
class _StageContent extends StatelessWidget {
  const _StageContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return StageContainer(
      builder: (BuildContext context, EdgeInsets padding) {
        return Container(
          padding: padding,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: theme.colors.muted,
            border: Border.all(color: theme.colors.border),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            color: theme.colors.card,
            child: Text(
              'padding: ${padding.left.toStringAsFixed(0)} / ${padding.right.toStringAsFixed(0)}',
              style: TextStyle(color: theme.colors.mutedForeground),
            ),
          ),
        );
      },
    );
  }
}

/// The stage at the available width.
Widget _default(BuildContext context) {
  return const _StageContent();
}
''',
    ),
    DocsExampleSource(
      name: 'Narrow',
      builder: '_narrow',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/stage_container/stage_container.dart';

/// The content the stage wraps; prints the resolved outer padding.
class _StageContent extends StatelessWidget {
  const _StageContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return StageContainer(
      builder: (BuildContext context, EdgeInsets padding) {
        return Container(
          padding: padding,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: theme.colors.muted,
            border: Border.all(color: theme.colors.border),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            color: theme.colors.card,
            child: Text(
              'padding: ${padding.left.toStringAsFixed(0)} / ${padding.right.toStringAsFixed(0)}',
              style: TextStyle(color: theme.colors.mutedForeground),
            ),
          ),
        );
      },
    );
  }
}

/// The stage inside a narrow column.
Widget _narrow(BuildContext context) {
  return const Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[SizedBox(width: 320, child: _StageContent())],
  );
}
''',
    ),
  ],
  'swipe_actions': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/motion/motion_spec.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/card/card.dart';
import 'package:<your_app>/ui/dashcn/components/list_tile/list_tile.dart';
import 'package:<your_app>/ui/dashcn/components/swipe_actions/swipe_actions.dart';

// List-tile row padding: 8 px horizontal (sizing scale). Vertical 4 px so
// the rendered rows land exactly on the list-tile heights under both the
// test font and real fonts (Geist runs ~1.3 line height: single-line content
// ~26 clamps to the 32 minimum; two-line ~47 clamps to the 48 minimum).
const EdgeInsets _rowPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);

/// 1 px divider between rows inside the shared surface.
Widget _rowDivider(ThemeData appTheme) => Container(
  height: 1,
  color: ThemedColor.ref(ColorRef.border).resolve(appTheme.colors),
);

/// One surface holding the swipeable rows (never a card per row).
Widget _listSurface(ThemeData appTheme, List<Widget> rows) => Card(
  padding: EdgeInsets.zero,
  clipBehavior: Clip.antiAlias,
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      for (int i = 0; i < rows.length; i++) ...<Widget>[
        rows[i],
        if (i < rows.length - 1) _rowDivider(appTheme),
      ],
    ],
  ),
);

/// Single-line 32 px list-tile row. Uses the list tile's own token
/// typography (natural line heights) with an explicit foreground pair so the
/// text stays readable on the card surface under bare-Theme harnesses.
Widget _singleRow(ThemeData appTheme, String label) => ListTile(
  contentPadding: _rowPadding,
  textColor: ThemedColor.ref(ColorRef.foreground),
  title: Text(label),
);

/// Three inbox rows; Archive and Delete both file the row away, Delete by
/// button or by full swipe, with a live inbox count 8 px below the list.
class _SwipeActionsDemo extends StatefulWidget {
  const _SwipeActionsDemo();

  @override
  State<_SwipeActionsDemo> createState() => _SwipeActionsDemoState();
}

class _SwipeActionsDemoState extends State<_SwipeActionsDemo> {
  final List<String> _rows = <String>[
    'Design review at 10',
    'Your invoice is ready',
    'Weekend trip photos',
  ];

  void _remove(String row) {
    setState(() => _rows.remove(row));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    // Explicit background surface: standalone harnesses (scorecard,
    // preview boxes) stage examples on transparency, and text needs an
    // opaque token pair to measure contrast against.
    return ColoredBox(
      color: appTheme.colors.background,
      child: Padding(
        padding: EdgeInsets.all(appTheme.spacing.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _listSurface(appTheme, <Widget>[
              for (final String row in _rows)
                SwipeActions(
                  actions: <SwipeAction>[
                    SwipeAction(
                      label: 'Archive',
                      onPressed: () => _remove(row),
                    ),
                    SwipeAction(
                      label: 'Delete',
                      destructive: true,
                      onPressed: () => _remove(row),
                    ),
                  ],
                  onDismissed: () => _remove(row),
                  child: _singleRow(appTheme, row),
                ),
            ]),
            // Caption sits 8 px (sm) below the list.
            Gap(appTheme.spacing.sm),
            Text(
              'Inbox: ${_rows.length}',
              // Foreground, not muted: muted small text lands just under
              // the 4.5 contrast bar in the fallback theme
              // (scorecard-measured).
              style: appTheme.typography.textSmall.copyWith(
                color: appTheme.colors.foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _default(BuildContext context) => const _SwipeActionsDemo();
''',
    ),
    DocsExampleSource(
      name: 'Compact',
      builder: '_compact',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/motion/motion_spec.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/card/card.dart';
import 'package:<your_app>/ui/dashcn/components/list_tile/list_tile.dart';
import 'package:<your_app>/ui/dashcn/components/swipe_actions/swipe_actions.dart';

// List-tile row padding: 8 px horizontal (sizing scale). Vertical 4 px so
// the rendered rows land exactly on the list-tile heights under both the
// test font and real fonts (Geist runs ~1.3 line height: single-line content
// ~26 clamps to the 32 minimum; two-line ~47 clamps to the 48 minimum).
const EdgeInsets _rowPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);

/// 1 px divider between rows inside the shared surface.
Widget _rowDivider(ThemeData appTheme) => Container(
  height: 1,
  color: ThemedColor.ref(ColorRef.border).resolve(appTheme.colors),
);

/// One surface holding the swipeable rows (never a card per row).
Widget _listSurface(ThemeData appTheme, List<Widget> rows) => Card(
  padding: EdgeInsets.zero,
  clipBehavior: Clip.antiAlias,
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      for (int i = 0; i < rows.length; i++) ...<Widget>[
        rows[i],
        if (i < rows.length - 1) _rowDivider(appTheme),
      ],
    ],
  ),
);

/// Single-line 32 px list-tile row. Uses the list tile's own token
/// typography (natural line heights) with an explicit foreground pair so the
/// text stays readable on the card surface under bare-Theme harnesses.
Widget _singleRow(ThemeData appTheme, String label) => ListTile(
  contentPadding: _rowPadding,
  textColor: ThemedColor.ref(ColorRef.foreground),
  title: Text(label),
);

Widget _compact(BuildContext context) {
  final ThemeData appTheme = Theme.of(context);
  return ColoredBox(
    color: appTheme.colors.background,
    child: Padding(
      padding: EdgeInsets.all(appTheme.spacing.sm),
      child: _listSurface(appTheme, <Widget>[
        // Dense file list: single-line rows, compact action tiles.
        for (final String file in const <String>[
          'Q3 budget.xlsx',
          'Team offsite notes.docx',
          'Logo final.png',
        ])
          SwipeActions(
            densityTokens: DensityTokens.compact,
            actions: <SwipeAction>[
              SwipeAction(
                label: 'Archive',
                onPressed: () {},
              ),
              SwipeAction(
                label: 'Delete',
                destructive: true,
                onPressed: () {},
              ),
            ],
            onDismissed: () {},
            // List-tile single-line row (32); the action tiles stretch to
            // this full row height.
            child: _singleRow(appTheme, file),
          ),
      ]),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Comfortable',
      builder: '_comfortable',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/motion/motion_spec.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/card/card.dart';
import 'package:<your_app>/ui/dashcn/components/list_tile/list_tile.dart';
import 'package:<your_app>/ui/dashcn/components/swipe_actions/swipe_actions.dart';

// List-tile row padding: 8 px horizontal (sizing scale). Vertical 4 px so
// the rendered rows land exactly on the list-tile heights under both the
// test font and real fonts (Geist runs ~1.3 line height: single-line content
// ~26 clamps to the 32 minimum; two-line ~47 clamps to the 48 minimum).
const EdgeInsets _rowPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);

/// 1 px divider between rows inside the shared surface.
Widget _rowDivider(ThemeData appTheme) => Container(
  height: 1,
  color: ThemedColor.ref(ColorRef.border).resolve(appTheme.colors),
);

/// One surface holding the swipeable rows (never a card per row).
Widget _listSurface(ThemeData appTheme, List<Widget> rows) => Card(
  padding: EdgeInsets.zero,
  clipBehavior: Clip.antiAlias,
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      for (int i = 0; i < rows.length; i++) ...<Widget>[
        rows[i],
        if (i < rows.length - 1) _rowDivider(appTheme),
      ],
    ],
  ),
);

/// Two-line 48 px list-tile row. Plain [Text] children so the tile's token
/// title/subtitle styles (and their natural line heights) apply; explicit
/// foreground pairs keep contrast on the card surface.
Widget _twoLineRow(ThemeData appTheme, String title, String subtitle) =>
    ListTile(
      contentPadding: _rowPadding,
      textColor: ThemedColor.ref(ColorRef.foreground),
      subtitleColor: ThemedColor.ref(ColorRef.foreground),
      title: Text(title),
      subtitle: Text(subtitle),
    );

Widget _comfortable(BuildContext context) {
  final ThemeData appTheme = Theme.of(context);
  return ColoredBox(
    color: appTheme.colors.background,
    child: Padding(
      padding: EdgeInsets.all(appTheme.spacing.sm),
      child: _listSurface(appTheme, <Widget>[
        // Two-line inbox rows: sender as title, preview as subtitle.
        for (final (String, String) mail in const <(String, String)>[
          ('Priya Shah', 'Design review moved to 10:30 tomorrow'),
          ('Ops alerts', 'Build 418 passed on main, deploy is ready'),
        ])
          SwipeActions(
            densityTokens: DensityTokens.comfortable,
            actions: <SwipeAction>[
              SwipeAction(
                label: 'Archive',
                onPressed: () {},
              ),
              SwipeAction(
                label: 'Delete',
                destructive: true,
                onPressed: () {},
              ),
            ],
            onDismissed: () {},
            // List-tile two-line row (48); the action tiles stretch to
            // this full row height.
            child: _twoLineRow(appTheme, mail.$1, mail.$2),
          ),
      ]),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Right to left',
      builder: '_rightToLeft',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/motion/motion_spec.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/card/card.dart';
import 'package:<your_app>/ui/dashcn/components/list_tile/list_tile.dart';
import 'package:<your_app>/ui/dashcn/components/swipe_actions/swipe_actions.dart';

// List-tile row padding: 8 px horizontal (sizing scale). Vertical 4 px so
// the rendered rows land exactly on the list-tile heights under both the
// test font and real fonts (Geist runs ~1.3 line height: single-line content
// ~26 clamps to the 32 minimum; two-line ~47 clamps to the 48 minimum).
const EdgeInsets _rowPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);

/// 1 px divider between rows inside the shared surface.
Widget _rowDivider(ThemeData appTheme) => Container(
  height: 1,
  color: ThemedColor.ref(ColorRef.border).resolve(appTheme.colors),
);

/// One surface holding the swipeable rows (never a card per row).
Widget _listSurface(ThemeData appTheme, List<Widget> rows) => Card(
  padding: EdgeInsets.zero,
  clipBehavior: Clip.antiAlias,
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      for (int i = 0; i < rows.length; i++) ...<Widget>[
        rows[i],
        if (i < rows.length - 1) _rowDivider(appTheme),
      ],
    ],
  ),
);

/// Single-line 32 px list-tile row. Uses the list tile's own token
/// typography (natural line heights) with an explicit foreground pair so the
/// text stays readable on the card surface under bare-Theme harnesses.
Widget _singleRow(ThemeData appTheme, String label) => ListTile(
  contentPadding: _rowPadding,
  textColor: ThemedColor.ref(ColorRef.foreground),
  title: Text(label),
);

/// Three inbox rows; Archive and Delete both file the row away, Delete by
/// button or by full swipe, with a live inbox count 8 px below the list.
class _SwipeActionsDemo extends StatefulWidget {
  const _SwipeActionsDemo();

  @override
  State<_SwipeActionsDemo> createState() => _SwipeActionsDemoState();
}

class _SwipeActionsDemoState extends State<_SwipeActionsDemo> {
  final List<String> _rows = <String>[
    'Design review at 10',
    'Your invoice is ready',
    'Weekend trip photos',
  ];

  void _remove(String row) {
    setState(() => _rows.remove(row));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    // Explicit background surface: standalone harnesses (scorecard,
    // preview boxes) stage examples on transparency, and text needs an
    // opaque token pair to measure contrast against.
    return ColoredBox(
      color: appTheme.colors.background,
      child: Padding(
        padding: EdgeInsets.all(appTheme.spacing.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _listSurface(appTheme, <Widget>[
              for (final String row in _rows)
                SwipeActions(
                  actions: <SwipeAction>[
                    SwipeAction(
                      label: 'Archive',
                      onPressed: () => _remove(row),
                    ),
                    SwipeAction(
                      label: 'Delete',
                      destructive: true,
                      onPressed: () => _remove(row),
                    ),
                  ],
                  onDismissed: () => _remove(row),
                  child: _singleRow(appTheme, row),
                ),
            ]),
            // Caption sits 8 px (sm) below the list.
            Gap(appTheme.spacing.sm),
            Text(
              'Inbox: ${_rows.length}',
              // Foreground, not muted: muted small text lands just under
              // the 4.5 contrast bar in the fallback theme
              // (scorecard-measured).
              style: appTheme.typography.textSmall.copyWith(
                color: appTheme.colors.foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _rightToLeft(BuildContext context) => const Directionality(
  textDirection: TextDirection.rtl,
  child: _SwipeActionsDemo(),
);
''',
    ),
    DocsExampleSource(
      name: 'Custom builders',
      builder: '_customBuilders',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/motion/motion_spec.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/card/card.dart';
import 'package:<your_app>/ui/dashcn/components/list_tile/list_tile.dart';
import 'package:<your_app>/ui/dashcn/components/swipe_actions/swipe_actions.dart';

// List-tile row padding: 8 px horizontal (sizing scale). Vertical 4 px so
// the rendered rows land exactly on the list-tile heights under both the
// test font and real fonts (Geist runs ~1.3 line height: single-line content
// ~26 clamps to the 32 minimum; two-line ~47 clamps to the 48 minimum).
const EdgeInsets _rowPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);

/// 1 px divider between rows inside the shared surface.
Widget _rowDivider(ThemeData appTheme) => Container(
  height: 1,
  color: ThemedColor.ref(ColorRef.border).resolve(appTheme.colors),
);

/// One surface holding the swipeable rows (never a card per row).
Widget _listSurface(ThemeData appTheme, List<Widget> rows) => Card(
  padding: EdgeInsets.zero,
  clipBehavior: Clip.antiAlias,
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      for (int i = 0; i < rows.length; i++) ...<Widget>[
        rows[i],
        if (i < rows.length - 1) _rowDivider(appTheme),
      ],
    ],
  ),
);

/// Single-line 32 px list-tile row. Uses the list tile's own token
/// typography (natural line heights) with an explicit foreground pair so the
/// text stays readable on the card surface under bare-Theme harnesses.
Widget _singleRow(ThemeData appTheme, String label) => ListTile(
  contentPadding: _rowPadding,
  textColor: ThemedColor.ref(ColorRef.foreground),
  title: Text(label),
);

/// Custom action builders: each button scales/fades in with its own reveal
/// progress, so callers can paint anything behind the row.
Widget _customBuilders(BuildContext context) {
  final ThemeData appTheme = Theme.of(context);
  return ColoredBox(
    color: appTheme.colors.background,
    child: Padding(
      padding: EdgeInsets.all(appTheme.spacing.sm),
      child: _listSurface(appTheme, <Widget>[
        SwipeActions(
          actions: <SwipeAction>[
            SwipeAction(
              label: 'Pin',
              builder: (BuildContext context, double progress) => Opacity(
                opacity: progress,
                child: Transform.scale(
                  scale: 0.6 + 0.4 * progress,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: appTheme.colors.primary,
                    ),
                    child: Center(
                      child: Text(
                        'Pin',
                        style: appTheme.typography.textSmall.copyWith(
                          color: appTheme.colors.primaryForeground,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              onPressed: () {},
            ),
            SwipeAction(
              label: 'Delete',
              destructive: true,
              onPressed: () {},
            ),
          ],
          onDismissed: () {},
          // List-tile single-line row (32); the custom builders above
          // center in its full height.
          child: _singleRow(appTheme, 'Travel packing list'),
        ),
      ]),
    ),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Motion override',
      builder: '_motionOverride',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/primitives/motion/motion_spec.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/density_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/card/card.dart';
import 'package:<your_app>/ui/dashcn/components/list_tile/list_tile.dart';
import 'package:<your_app>/ui/dashcn/components/swipe_actions/swipe_actions.dart';

// List-tile row padding: 8 px horizontal (sizing scale). Vertical 4 px so
// the rendered rows land exactly on the list-tile heights under both the
// test font and real fonts (Geist runs ~1.3 line height: single-line content
// ~26 clamps to the 32 minimum; two-line ~47 clamps to the 48 minimum).
const EdgeInsets _rowPadding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);

/// 1 px divider between rows inside the shared surface.
Widget _rowDivider(ThemeData appTheme) => Container(
  height: 1,
  color: ThemedColor.ref(ColorRef.border).resolve(appTheme.colors),
);

/// One surface holding the swipeable rows (never a card per row).
Widget _listSurface(ThemeData appTheme, List<Widget> rows) => Card(
  padding: EdgeInsets.zero,
  clipBehavior: Clip.antiAlias,
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      for (int i = 0; i < rows.length; i++) ...<Widget>[
        rows[i],
        if (i < rows.length - 1) _rowDivider(appTheme),
      ],
    ],
  ),
);

/// Single-line 32 px list-tile row. Uses the list tile's own token
/// typography (natural line heights) with an explicit foreground pair so the
/// text stays readable on the card surface under bare-Theme harnesses.
Widget _singleRow(ThemeData appTheme, String label) => ListTile(
  contentPadding: _rowPadding,
  textColor: ThemedColor.ref(ColorRef.foreground),
  title: Text(label),
);

/// Per-instance motion override: a slower settle and collapse for this row
/// only; the rest of the app keeps the theme timing.
Widget _motionOverride(BuildContext context) {
  final ThemeData appTheme = Theme.of(context);
  return ColoredBox(
    color: appTheme.colors.background,
    child: Padding(
      padding: EdgeInsets.all(appTheme.spacing.sm),
      child: _listSurface(appTheme, <Widget>[
        SwipeActions(
          motion: const MotionSpec(
            enterDuration: Duration(milliseconds: 450),
            exitDuration: Duration(milliseconds: 450),
          ),
          actions: <SwipeAction>[
            SwipeAction(
              label: 'Archive',
              onPressed: () {},
            ),
            SwipeAction(
              label: 'Delete',
              destructive: true,
              onPressed: () {},
            ),
          ],
          onDismissed: () {},
          // List-tile single-line row (32).
          child: _singleRow(appTheme, 'Team offsite agenda'),
        ),
      ]),
    ),
  );
}
''',
    ),
  ],
  'swiper': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_drawer',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/swiper/swiper.dart';

/// Drag towards the panel edge to reveal a drawer.
Widget _drawer(BuildContext context) {
  return SizedBox(
    width: 320,
    height: 200,
    child: Swiper(
      position: OverlayPosition.left,
      builder: (BuildContext context) => _Panel(
        title: 'Drawer',
        hint: 'Swipe it away to dismiss',
      ),
      child: _SwipeSurface('Swipe right for a drawer'),
    ),
  );
}

/// A tappable-looking surface that carries the swipe hint.
class _SwipeSurface extends StatelessWidget {
  const _SwipeSurface(this.hint);

  final String hint;

  @override
  Widget build(BuildContext context) {
    final ThemeColors colors = Theme.of(context).colors;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.muted,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(hint, style: TextStyle(color: colors.mutedForeground)),
    );
  }
}

/// The overlay body used by both variants.
class _Panel extends StatelessWidget {
  const _Panel({required this.title, required this.hint});

  final String title;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final ThemeColors colors = Theme.of(context).colors;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Gap(Theme.of(context).spacing.sm),
          Text(hint, style: TextStyle(color: colors.mutedForeground)),
        ],
      ),
    );
  }
}
''',
    ),
    DocsExampleSource(
      name: 'Sheet',
      builder: '_sheet',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/foundation/gap.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/swiper/swiper.dart';

/// Drag up to reveal a sheet.
Widget _sheet(BuildContext context) {
  return SizedBox(
    width: 320,
    height: 200,
    child: Swiper(
      position: OverlayPosition.bottom,
      variant: SwiperVariant.sheet,
      builder: (BuildContext context) => _Panel(
        title: 'Sheet',
        hint: 'Drag down to dismiss',
      ),
      child: _SwipeSurface('Swipe up for a sheet'),
    ),
  );
}

/// A tappable-looking surface that carries the swipe hint.
class _SwipeSurface extends StatelessWidget {
  const _SwipeSurface(this.hint);

  final String hint;

  @override
  Widget build(BuildContext context) {
    final ThemeColors colors = Theme.of(context).colors;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.muted,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(hint, style: TextStyle(color: colors.mutedForeground)),
    );
  }
}

/// The overlay body used by both variants.
class _Panel extends StatelessWidget {
  const _Panel({required this.title, required this.hint});

  final String title;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final ThemeColors colors = Theme.of(context).colors;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Gap(Theme.of(context).spacing.sm),
          Text(hint, style: TextStyle(color: colors.mutedForeground)),
        ],
      ),
    );
  }
}
''',
    ),
  ],
  'switcher': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/switcher/switcher.dart';

/// Horizontal pager driven by buttons; owns its index.
class _HorizontalSwitcher extends StatefulWidget {
  const _HorizontalSwitcher();

  @override
  State<_HorizontalSwitcher> createState() => _HorizontalSwitcherState();
}

class _HorizontalSwitcherState extends State<_HorizontalSwitcher> {
  int _index = 0;
  final List<int> _reported = <int>[];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 240,
          height: 120,
          child: Switcher(
            index: _index,
            direction: AxisDirection.right,
            onIndexChanged: (int value) {
              _reported.add(value);
              setState(() => _index = value);
            },
            children: <Widget>[
              for (int i = 0; i < 3; i++)
                ColoredBox(
                  color: i.isEven ? theme.colors.muted : theme.colors.accent,
                  child: Center(child: Text('page $i')),
                ),
            ],
          ),
        ),
        SizedBox(height: theme.spacing.md),
        Wrap(
          spacing: theme.spacing.sm,
          children: <Widget>[
            for (int i = 0; i < 3; i++)
              Button(
                size: ButtonSize.sm,
                variant: i == _index
                    ? ButtonVariant.primary
                    : ButtonVariant.outline,
                onPressed: () => setState(() => _index = i),
                child: Text('$i'),
              ),
          ],
        ),
        SizedBox(height: theme.spacing.sm),
        Text('reported: $_reported'),
      ],
    );
  }
}

Widget _default(BuildContext context) => const _HorizontalSwitcher();
''',
    ),
    DocsExampleSource(
      name: 'Vertical',
      builder: '_vertical',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/button/button.dart';
import 'package:<your_app>/ui/dashcn/components/switcher/switcher.dart';

/// Vertical pager with a slower scoped curve.
Widget _vertical(BuildContext context) {
  final theme = Theme.of(context);
  return ComponentTheme<SwitcherTheme>(
    data: const SwitcherTheme(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    ),
    child: SizedBox(
      width: 240,
      height: 100,
      child: Switcher(
        direction: AxisDirection.down,
        children: <Widget>[
          for (int i = 0; i < 2; i++)
            ColoredBox(
              color: i.isEven ? theme.colors.muted : theme.colors.accent,
              child: Center(child: Text('v$i')),
            ),
        ],
      ),
    ),
  );
}
''',
    ),
  ],
  'timeline_animation': <DocsExampleSource>[],
  'triple_dots': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_tripleDotsDefault',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/triple_dots/triple_dots.dart';

/// Counts, sizes and strokes in one row.
Widget _tripleDotsDefault(BuildContext context) {
  final spacing = Theme.of(context).spacing;
  return Wrap(
    spacing: spacing.xxl,
    runSpacing: spacing.md,
    alignment: WrapAlignment.center,
    children: const <Widget>[
      TripleDots(),
      TripleDots(count: 4, spacing: 4),
      TripleDots(size: 6),
    ],
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Vertical',
      builder: '_tripleDotsVertical',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/triple_dots/triple_dots.dart';

/// The dots stacked vertically.
Widget _tripleDotsVertical(BuildContext context) {
  return const Align(
    alignment: AlignmentDirectional.centerStart,
    child: TripleDots(direction: Axis.vertical),
  );
}
''',
    ),
    DocsExampleSource(
      name: 'Themed dots',
      builder: '_tripleDotsThemed',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/color_tokens.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/triple_dots/triple_dots.dart';

/// A scoped theme leg: coloured, smaller dots.
Widget _tripleDotsThemed(BuildContext context) {
  return ComponentTheme<TripleDotsTheme>(
    data: const TripleDotsTheme(
      color: ThemedColor.ref(ColorRef.primary),
      size: 5,
    ),
    child: const TripleDots(),
  );
}
''',
    ),
  ],
  'window': <DocsExampleSource>[
    DocsExampleSource(
      name: 'Default',
      builder: '_default',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/window/window.dart';

/// One draggable, resizable window; owns its controller.
class _SingleWindow extends StatefulWidget {
  const _SingleWindow();

  @override
  State<_SingleWindow> createState() => _SingleWindowState();
}

class _SingleWindowState extends State<_SingleWindow> {
  final WindowController _notes = WindowController(
    bounds: const Rect.fromLTWH(24, 20, 280, 190),
  );

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      height: 300,
      child: WindowNavigator(
        initialWindows: <Window>[
          Window(
            controller: _notes,
            title: Text('Notes'),
            content: Padding(
              padding: EdgeInsets.all(Theme.of(context).spacing.md),
              child: Text(
                'Drag the title bar; resize from any edge.',
              ),
            ),
          ),
        ],
        child: const SizedBox.expand(),
      ),
    );
  }
}

Widget _default(BuildContext context) => const _SingleWindow();
''',
    ),
    DocsExampleSource(
      name: 'Maximized',
      builder: '_maximized',
      code: r'''import 'package:flutter/widgets.dart';
import 'package:<your_app>/ui/dashcn/theme/theme.dart';
import 'package:<your_app>/ui/dashcn/components/window/window.dart';

/// A maximized window next to a floating one; owns its controllers.
class _MaximizedWindow extends StatefulWidget {
  const _MaximizedWindow();

  @override
  State<_MaximizedWindow> createState() => _MaximizedWindowState();
}

class _MaximizedWindowState extends State<_MaximizedWindow> {
  final WindowController _main = WindowController(
    bounds: const Rect.fromLTWH(24, 20, 280, 190),
    maximized: const Rect.fromLTWH(0, 0, 1, 1),
  );
  final WindowController _inspector = WindowController(
    bounds: const Rect.fromLTWH(60, 60, 220, 150),
    alwaysOnTop: true,
  );

  @override
  void dispose() {
    _main.dispose();
    _inspector.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      height: 300,
      child: WindowNavigator(
        initialWindows: <Window>[
          Window(
            controller: _main,
            title: Text('Editor'),
            content: Padding(
              padding: EdgeInsets.all(Theme.of(context).spacing.md),
              child: Text(
                'Maximized; restore from the title bar.',
              ),
            ),
          ),
          Window(
            controller: _inspector,
            title: Text('Inspector'),
            content: Padding(
              padding: EdgeInsets.all(Theme.of(context).spacing.md),
              child: Text('Always on top.'),
            ),
          ),
        ],
        child: const SizedBox.expand(),
      ),
    );
  }
}

Widget _maximized(BuildContext context) => const _MaximizedWindow();
''',
    ),
  ],
};
