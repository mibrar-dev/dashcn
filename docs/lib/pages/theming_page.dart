// `/docs/theming` (spec §1/§2.6): the token system, the token convention, the
// generated token table, the radius scale, presets, per-component theme
// resolution and animated theming. Structure mirrors the reference page;
// every fact (token names, preset count) comes from the generated registry
// data and the registry theme layer.

import 'package:flutter/widgets.dart';

import '../generated/docs_data.dart';
import '../routing/docs_nav.dart';
import '../routing/docs_router.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../widgets/code_figure.dart';
import '../widgets/density_demos.dart';
import '../widgets/docs_article.dart';
import '../widgets/docs_samples.dart';
import '../widgets/docs_shell.dart';
import '../widgets/heading_anchor.dart';
import '../widgets/motion_demos.dart';
import '../widgets/theme_token_table.dart';
import '../widgets/typeset.dart';

/// `/docs/theming`.
class ThemingPage extends StatelessWidget {
  /// Creates the theming page.
  const ThemingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ({DocsNavLink? previous, DocsNavLink? next}) neighbors =
        docsPageNeighbors('/docs/theming');
    return DocsLayout(
      child: DocsArticle(
        title: 'Theming',
        description: 'Tokens, presets and per-component theme overrides.',
        previous: neighbors.previous,
        next: neighbors.next,
        children: <Widget>[
          const TypesetParagraph(
            'Build your theme from tokens. Every colour, radius, font and '
            'shadow a component reads comes from the active ThemeData, '
            'so a preset switch re-themes the whole app without touching '
            'component code.',
          ),
          const HeadingAnchor(id: 'tokens', title: 'Tokens'),
          TypesetParagraph.rich(<InlineSpan>[
            const TextSpan(
              text: 'Each colour token is named after the dashcn ',
            ),
            typesetInlineCodeSpan('CSS'),
            const TextSpan(text: ' variable in camelCase: '),
            typesetInlineCodeSpan('--background'),
            const TextSpan(text: ' becomes '),
            typesetInlineCodeSpan('background'),
            const TextSpan(text: ', and '),
            typesetInlineCodeSpan('--card-foreground'),
            const TextSpan(text: ' becomes '),
            typesetInlineCodeSpan('cardForeground'),
            const TextSpan(
              text:
                  '. The tokens live on ThemeColors; the resolved theme is '
                  'ThemeData, read with ',
            ),
            typesetInlineCodeSpan('Theme.of(context)'),
            const TextSpan(text: '.'),
          ]),
          DocsCodeFigure(
            code: kThemingSamples['token-read']!.code,
            language: 'dart',
          ),
          const HeadingAnchor(
            id: 'token-convention',
            title: 'Token Convention',
          ),
          const TypesetParagraph(
            'Tokens come in semantic background/foreground pairs. The base '
            'token controls the surface colour and the -foreground token '
            'controls the text and icons that sit on that surface, so a '
            'component never hard-codes a contrast colour.',
          ),
          DocsCodeFigure(
            code: kThemingSamples['token-pair']!.code,
            language: 'dart',
          ),
          const HeadingAnchor(id: 'theme-tokens', title: 'Theme Tokens'),
          TypesetParagraph(
            'These ${kThemeTokens.length} tokens are defined for both '
            'brightnesses in every preset, plus the radius factor.',
          ),
          const Gap(16),
          const ThemeTokenTable(),
          const HeadingAnchor(id: 'radius-scale', title: 'Radius Scale'),
          const TypesetParagraph(
            'radius is the base radius factor: the unitless rem number a '
            'preset stores. The component radius steps derive from it, so a '
            'single value updates every rounded surface.',
          ),
          DocsCodeFigure(
            code: kThemingSamples['radius']!.code,
            language: 'dart',
          ),
          const HeadingAnchor(id: 'presets', title: 'Presets'),
          TypesetParagraph.rich(<InlineSpan>[
            TextSpan(text: 'The kit ships '),
            TextSpan(
              text: '${kStats.presets} presets',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const TextSpan(
              text:
                  ' across light and dark. The CLI uses the neutral preset by '
                  'default; apply another one with ',
            ),
            typesetInlineCodeSpan('dashcn theme apply <preset>'),
            const TextSpan(text: '. Try them on the '),
            typesetLinkSpan(
              'Themes page',
              () => DocsRouterScope.of(context).go(context, '/themes'),
            ),
            const TextSpan(text: '.'),
          ]),
          DocsCodeFigure(
            code: kThemingSamples['preset-apply']!.code,
            language: 'bash',
          ),
          const HeadingAnchor(
            id: 'component-themes',
            title: 'Component Themes',
          ),
          const TypesetParagraph(
            'Every component resolves its style through four legs, from '
            'highest to lowest priority: a widget argument, the nearest '
            'ComponentTheme in the tree, the app overrides registered at the '
            'root, then the token-derived defaults.',
          ),
          const TypesetParagraph(
            'The app leg is the user-owned <name>_theme.dart file the CLI '
            'writes next to each component. CLI updates never overwrite it, '
            'so your overrides survive an upgrade.',
          ),
          DocsCodeFigure(
            code: kThemingSamples['component-theme']!.code,
            language: 'dart',
          ),
          const HeadingAnchor(
            id: 'sizing-and-density',
            title: 'Sizing and density',
          ),
          const TypesetParagraph(
            'Density tokens set the default look: compact is the default '
            'everywhere (control 32, icon 16, row 32-36), comfortable steps '
            'up (control 40, icon 20, row 40-44), and touch targets phone '
            'widths automatically (control 48, icon 24, row 48-56). The '
            'spacing scale is a 4 px base (4, 8, 12, 16, 24, 32) with no '
            'ad-hoc values; button and list tile are the reference '
            'components that follow these tokens. Override any token per '
            'instance or in the theme.',
          ),
          DocsCodeFigure(
            code: kThemingSamples['sizing']!.code,
            language: 'dart',
          ),
          const Gap(16),
          const DensityDemos(),
          const Gap(16),
          const HeadingAnchor(id: 'glass-surfaces', title: 'Glass Surfaces'),
          const TypesetParagraph(
            'Two optional mode-independent tokens make floating surfaces '
            'frosted: surfaceOpacity (0..1) multiplies every surface fill, '
            'and surfaceBlur (logical px) blurs the backdrop behind it. '
            'Cards, dialogs, popovers, menus, tooltips, toasts, sheets, the '
            'navigation bar and the scaffold app bar all read them, so one '
            'preset change frosts the whole app. The defaults stay opaque '
            '(no extra layer), and a component theme value wins over the '
            'global when both are set.',
          ),
          DocsCodeFigure(
            code: kThemingSamples['glass']!.code,
            language: 'dart',
          ),
          const HeadingAnchor(
            id: 'animated-theming',
            title: 'Animated Theming',
          ),
          const TypesetParagraph(
            'AnimatedTheme animates ThemeData changes over the '
            'duration and curve you pass. Colours tween; layout does not, so '
            'a preset or mode switch never reflows the page.',
          ),
          DocsCodeFigure(
            code: kThemingSamples['animated']!.code,
            language: 'dart',
          ),
          const HeadingAnchor(id: 'motion', title: 'Motion'),
          const TypesetParagraph(
            'Every component animation resolves through the motion tokens, '
            'read as Theme.of(context).motion. Durations stay in the subtle '
            'band — instant 100 ms, fast 150 ms, base 200 ms, slow 300 ms — '
            'and curves stay restrained, except the spring overshoot used for '
            'press-release and pop-in effects. Motion is transform and '
            'opacity only, so it never changes layout or a final state.',
          ),
          const TypesetParagraph(
            'Intensity scales the whole kit from one place: Subtle (0.75x '
            'durations, 0.98 press, 4 px enter), Standard (today\'s values, '
            'the default), Expressive (1.5x, 0.94, 12 px) and Custom '
            '(explicit press scale, enter offset, duration multiplier and '
            'curve choice). The Theme Studio Intensity row picks one; Custom '
            'reveals its four numeric rows. Custom legs persist in the theme '
            'document, export with Get Code and round-trip through import.',
          ),
          const TypesetParagraph(
            'Reduced motion collapses everything: when the platform reports '
            'MediaQuery.disableAnimations, or the Theme Studio Motion row '
            'switches motion.enabled off, every animation resolves to zero '
            'duration and its end value, with no tickers or timers running.',
          ),
          DocsCodeFigure(
            code: kThemingSamples['motion']!.code,
            language: 'dart',
          ),
          const HeadingAnchor(
            id: 'motion-categories',
            title: 'Motion Categories',
          ),
          const TypesetParagraph(
            'Three category legs retime one animation family from a single '
            'place, without touching the per-component defaults: '
            'overlayEnterDuration and overlayExitDuration (popovers, dialogs, '
            'toasts, sheets), stateDuration (toggles, checks, tabs, progress, '
            'badge and chip paint, error show and hide), plus the matching '
            'overlayEnterCurve, overlayExitCurve and stateCurve. A null leg '
            'keeps the component default, so setting a leg only changes the '
            'family it names. Every leg scales with the intensity multiplier.',
          ),
          DocsCodeFigure(
            code: kThemingSamples['motion-categories']!.code,
            language: 'dart',
          ),
          const HeadingAnchor(
            id: 'motion-presence',
            title: 'Exits and Per-Instance Overrides',
          ),
          const TypesetParagraph(
            'Inline content that appears conditionally — banners, error '
            'messages, chips, list rows — exits through two primitives. '
            'MotionPresence keeps the child mounted while the exit plays, '
            'then unmounts it and reports onExited; MotionCollapse adds the '
            'height shrink, so siblings slide up underneath. Both accept a '
            'MotionSpec override (durations, curves, delay, custom enter and '
            'exit builders, disabled for an instant snap) that wins over the '
            'theme for that instance only.',
          ),
          DocsCodeFigure(
            code: kThemingSamples['motion-presence']!.code,
            language: 'dart',
          ),
          const Gap(16),
          const MotionDemos(),
          const Gap(16),
          const HeadingAnchor(
            id: 'responsive-popups',
            title: 'Responsive popups',
          ),
          const TypesetParagraph(
            'Menus, selects, dropdowns, popovers, date/time and color '
            'pickers, autocomplete, context menus and item pickers anchor to '
            'their trigger at 768 px and above (flipping above/below and '
            'clamping to the viewport so they never leave the screen). Below '
            '768 px they become an edge-anchored bottom sheet — full width '
            'minus 12 px gutters, max height 70%, same content, with a drag '
            'handle and tap-outside to dismiss. Tooltips stay anchored on '
            'all widths. The choice is the popupAdaptive theme token '
            '(anchored | sheet | auto, default auto by width), overridable '
            'per component through the adaptive parameter.',
          ),
          DocsCodeFigure(
            code: kThemingSamples['responsive']!.code,
            language: 'dart',
          ),
        ],
      ),
    );
  }
}
