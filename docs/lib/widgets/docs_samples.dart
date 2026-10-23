// Hand-written code samples for the theming, dark-mode and
// internationalization pages.
//
// Each sample is a source string so the page renders exactly what the
// analyzer test (`test/theming_page_test.dart`) verifies parses without
// errors; the API names are exercised in the same test's widget tree so the
// samples stay true to the registry theme layer.

/// One docs code sample: a fence language and its source.
class DocsSample {
  /// Creates a sample.
  const DocsSample(this.language, this.raw);

  /// Fence language (`dart`, `bash`).
  final String language;

  /// The source text as written (with the blank lines around the literal).
  final String raw;

  /// The source with the surrounding blank lines removed.
  String get code => raw.trim();
}

/// Theming-page samples, keyed by stable id.
const Map<String, DocsSample> kThemingSamples = <String, DocsSample>{
  'token-read': DocsSample('dart', r'''
import 'package:your_app/ui/dashcn/theme/theme.dart';

// Every colour token is a field on ThemeColors.
final ThemeData theme = Theme.of(context);
final Color surface = theme.colors.background;
final Color ink = theme.colors.foreground;
final Color brand = theme.colors.primary;
'''),
  'token-pair': DocsSample('dart', r'''
// Semantic background/foreground pairs: the base token paints the surface,
// the `-foreground` token paints the content that sits on it.
final BoxDecoration panel = BoxDecoration(
  color: theme.colors.card,
  border: Border.all(color: theme.colors.border),
  borderRadius: theme.borderRadiusLg,
);
final TextStyle onCard = TextStyle(color: theme.colors.cardForeground);
'''),
  'radius': DocsSample('dart', r'''
// `radius` is a unitless factor: the preset's rem number.
final double base = theme.tokens.radius; // e.g. 0.625
final double lg = theme.radiusLg; // base * 16 px
final double sm = theme.radiusSm; // lg - 4 px, clamped at 0
final double md = theme.radiusMd; // lg - 2 px, clamped at 0
final double xl = theme.radiusXl; // lg + 4 px (0 stays square)
'''),
  'preset-apply': DocsSample('bash', 'dashcn theme apply neutral'),
  'component-theme': DocsSample('dart', r'''
import 'package:your_app/ui/dashcn/components/button/button.dart';
import 'package:your_app/ui/dashcn/theme/theme.dart';

// 1. A widget argument wins over every other leg.
final Widget primary = Button(
  variant: ButtonVariant.primary,
  theme: const ButtonVariantStyle(padding: EdgeInsets.zero),
  child: const Text('Save'),
);

// 2. A tree-scoped ComponentTheme<ButtonTheme>.
final Widget scoped = ComponentTheme<ButtonTheme>(
  data: const ButtonTheme(primary: ButtonVariantStyle()),
  child: const Button(child: Text('Save')),
);

// 3. The app leg: the user-owned button_theme.dart registered at the root
//    through DashcnApp(componentThemes: appComponentThemes).
'''),
  'sizing': DocsSample('dart', r'''
import 'package:your_app/ui/dashcn/components/button/button.dart';
import 'package:your_app/ui/dashcn/components/list_tile/list_tile.dart';
import 'package:your_app/ui/dashcn/theme/density_tokens.dart';
import 'package:your_app/ui/dashcn/theme/theme.dart';

// Compact is the default everywhere: control 32, icon 16, row 32-36.
final ThemeData compact = const ThemeData(); // densityTokens is compact

// Comfortable steps up: control 40, icon 20, row 40-44.
final ThemeData comfortable = compact.copyWith(
  densityTokens: () => DensityTokens.comfortable,
);

// Phone widths (< 600) use touch automatically: control 48, icon 24,
// row 48-56. An explicit override still wins on phones.
final DensityTokens tokens = resolveDensityTokens(context);
final double icon = resolveIconSize(tokens); // 16 / 20 / 24
final double capped = buttonIconSize(tokens); // <= control * 0.6

// Per instance (button + list_tile are the reference components):
final Widget touchButton = Button(
  densityTokens: DensityTokens.touch,
  onPressed: () {},
  child: const Text('Save changes'),
);
final Widget comfyTile = ListTile(
  densityTokens: DensityTokens.comfortable,
  title: const Text('Title truncates, never grows the row'),
);

// Spacing scale: 4 px base (4, 8, 12, 16, 24, 32). No ad-hoc values.
'''),
  'animated': DocsSample('dart', r'''
import 'package:your_app/ui/dashcn/theme/theme.dart';

// AnimatedTheme tweens ThemeData changes (colour-only lerp).
final Widget app = AnimatedTheme(
  data: next,
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeOutCubic,
  child: const MyApp(),
);
'''),
  'glass': DocsSample('dart', r'''
import 'package:your_app/ui/dashcn/primitives/surface.dart';
import 'package:your_app/ui/dashcn/theme/theme.dart';

// Frosted glass: the fill carries surfaceOpacity, the blur sits behind it.
// Null/1.0 opacity and null/0 blur render exactly opaque (no extra layer).
final ThemeData frosted = theme.copyWith(
  surfaceOpacity: () => 0.8,
  surfaceBlur: () => 8,
);
final Color fill = surfaceColor(theme.colors.popover, frosted.surfaceOpacity);
final Widget surface = GlassSurface(
  surfaceBlur: frosted.surfaceBlur,
  borderRadius: theme.borderRadiusMd,
  child: DecoratedBox(
    decoration: BoxDecoration(color: fill),
    child: content,
  ),
);
'''),
  'motion': DocsSample('dart', r'''
import 'package:your_app/ui/dashcn/theme/theme.dart';

// Motion tokens: durations in the subtle band, restrained curves.
final ThemeData theme = Theme.of(context);
final Duration press = theme.motion.durations.instant; // 100 ms
final Duration enter = theme.motion.durations.base; // 200 ms
final Curve spring = theme.motion.curves.spring; // press-release overshoot

// Intensity scales the whole kit from one place: subtle, standard
// (today's values, the default), expressive and custom.
final ThemeData expressive = theme.copyWith(
  motion: () => const MotionTokens(intensity: MotionIntensity.expressive),
);
final ThemeData custom = theme.copyWith(
  motion: () => const MotionTokens(
    intensity: MotionIntensity.custom,
    customDurationMultiplier: 1.25,
    customPressScale: 0.95,
    customEnterOffset: 10.0,
    customCurve: MotionCurveName.spring,
  ),
);

// The Theme Studio Motion row writes motion.enabled; off collapses every
// component animation to its end value. Reduced motion
// (MediaQuery.disableAnimations) does the same automatically.
final ThemeData still = theme.copyWith(
  motion: () => const MotionTokens(enabled: false),
);
'''),
  'motion-categories': DocsSample('dart', r'''
import 'package:your_app/ui/dashcn/theme/theme.dart';

// Category legs: retime one animation family from one place. Null keeps
// the component default, so unset legs reproduce today's timing exactly.
final ThemeData motion = Theme.of(context).copyWith(
  motion: () => const MotionTokens(
    overlayEnterDuration: Duration(milliseconds: 150),
    overlayExitDuration: Duration(milliseconds: 120),
    stateDuration: Duration(milliseconds: 180),
    stateCurve: Curves.easeOut,
  ),
);

// Per-phase resolution inside a component: per-instance, category, default.
final Duration enter = theme.motion.resolveOverlayEnterDuration(
  theme.motion.durations.base,
);
final Duration state = theme.motion.resolveStateDuration(
  theme.motion.durations.fast,
);
'''),
  'motion-presence': DocsSample('dart', r'''
import 'package:your_app/ui/dashcn/primitives/motion/motion_collapse.dart';
import 'package:your_app/ui/dashcn/primitives/motion/motion_presence.dart';
import 'package:your_app/ui/dashcn/primitives/motion/motion_spec.dart';

// Presence: the banner exits before it unmounts.
Widget buildBanner(bool show) {
  return MotionPresence(
    visible: show,
    onExited: () => debugPrint('exit finished'),
    child: const Text('Saved.'),
  );
}

// Collapse: the error shrinks away; siblings slide up underneath.
Widget buildError(String? error) {
  return MotionCollapse(
    visible: error != null,
    child: Text(error ?? ''),
  );
}

// Per-instance override: slow exit, custom transition, or instant snap.
const MotionSpec slowExit = MotionSpec(
  exitDuration: Duration(milliseconds: 450),
  exit: fadeMotionTransition,
  disabled: false,
);
'''),
  'responsive': DocsSample('dart', r'''
import 'package:your_app/ui/dashcn/theme/theme.dart';

// Responsive popups: anchored at >= 768, bottom sheet below.
final ThemeData theme = Theme.of(context);
final PopupAdaptive mode = theme.popupAdaptive; // auto by default

// Force one presentation for a single component.
final Widget anchored = Select<String>(
  adaptive: PopupAdaptive.anchored, // always anchors to the trigger
  value: value,
  onChanged: onChanged,
  itemBuilder: (context, v) => Text(v),
  items: const <Widget>[SelectItem(value: 'a', child: Text('a'))],
);

// Narrow widths use a bottom sheet: full width minus 12px gutters,
// max height 70%, same content, drag handle, tap-outside to dismiss.
// Tooltips stay anchored on all widths.
'''),
};

/// Dark-mode-page samples, keyed by stable id.
const Map<String, DocsSample> kDarkModeSamples = <String, DocsSample>{
  'read-brightness': DocsSample('dart', r'''
// Read the resolved brightness anywhere below the app shell.
final bool dark = Theme.of(context).brightness == Brightness.dark;
'''),
  'app-themes': DocsSample('dart', r'''
import 'package:your_app/ui/dashcn/components/app/app.dart';

// One theme per brightness; ThemeMode picks which one is active.
final Widget app = DashcnApp(
  theme: lightTheme,
  darkTheme: darkTheme,
  themeMode: ThemeMode.system, // system | light | dark
  home: const HomePage(),
);
'''),
  'toggle': DocsSample('dart', r'''
// Toggle the explicit mode and persist the choice.
void toggleMode() {
  setState(() {
    mode = mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  });
}
'''),
};

/// Internationalization-page samples, keyed by stable id.
const Map<String, DocsSample> kI18nSamples = <String, DocsSample>{
  'rtl-override': DocsSample('dart', r'''
import 'package:your_app/ui/dashcn/primitives/localizations/localizations.dart';

// A locale implies its text direction: Arabic flips Directionality,
// mirrors chevrons and keeps numbers LTR.
const Widget rtlCard = DashcnLocaleOverride(
  locale: Locale('ar'),
  child: Pagination(page: 2, totalPages: 20, onPageChanged: _noopPage),
);
'''),
  'per-instance': DocsSample('dart', r'''
import 'package:your_app/ui/dashcn/primitives/localizations/localizations.dart';

// Re-string one subtree — a dialog, a preview, a test — without
// touching the app locale. Missing tables fall back to English.
Widget translatedDialog(Locale locale, Widget child) {
  return DashcnLocaleOverride(locale: locale, child: child);
}
'''),
  'cli-add': DocsSample('sh', r'''
# List every locale the kit ships, with direction and key count.
dart run tool/locale.dart list

# Install the English base and the strings pagination needs.
dart run tool/locale.dart component pagination --dir .

# Install Arabic for every component already in the project.
dart run tool/locale.dart add ar --dir .

# Re-running either command is a byte-identical no-op.
dart run tool/locale.dart add ar --dir .
'''),
  'wiring': DocsSample('dart', r'''
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dashcn_locales/dashcn_locales.dart'; // generated by `locale add`

// The generated barrel lists everything you installed.
final Widget app = DashcnApp(
  supportedLocales: dashcnSupportedLocales,
  localizationsDelegates: <LocalizationsDelegate<dynamic>>[
    ...dashcnLocalesDelegates,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  locale: const Locale('ar'),
  home: const HomePage(),
);
'''),
};

/// Every sample, for the analyzer test.
const Map<String, DocsSample> kAllDocsSamples = <String, DocsSample>{
  ...kThemingSamples,
  ...kDarkModeSamples,
  ...kI18nSamples,
};
