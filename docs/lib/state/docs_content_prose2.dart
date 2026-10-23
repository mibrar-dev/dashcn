// Website content strings: docs prose part 2 (theming/dark/i18n/cli/score).
// Per-locale tables with English fallback. Every key must exist in every locale.

import 'package:flutter/widgets.dart';

import 'docs_strings.dart';

const List<String> kDocsContentProseKeys2 = <String>[
  'proseThemeP1',
  'proseThemeH1',
  'proseThemeConv',
  'proseThemeTokensH',
  'proseThemeRadiusH',
  'proseThemeRadiusP',
  'proseThemePresetsH',
  'proseThemePresetsP',
  'proseThemeCompH',
  'proseThemeCompP',
  'proseThemeSizeH',
  'proseThemeSizeP',
  'proseThemeGlassH',
  'proseThemeGlassP',
  'proseThemeAnimH',
  'proseThemeAnimP',
  'proseThemeMotionH',
  'proseThemeMotionP',
  'proseDarkP1',
  'proseDarkH1',
  'proseDarkP2a',
  'proseDarkP2b',
  'proseDarkH2',
  'proseDarkP3a',
  'proseDarkP3b',
  'proseDarkH3',
  'proseDarkP4',
  'proseDarkH4',
  'proseDarkP5a',
  'proseDarkP5b',
  'proseI18nP1',
  'proseI18nP2',
  'proseI18nH1',
  'proseI18nP3',
  'proseI18nH2',
  'proseI18nP4',
  'proseI18nH3',
  'proseI18nP5',
  'proseI18nH4',
  'proseI18nP6',
  'proseI18nP7',
  'proseCliP1',
  'proseScoreP1',
  'proseScoreH1',
  'proseScoreMetrics',
  'proseScoreHowH',
  'proseScoreHowP',
  'proseScoreLimH',
  'proseScoreLimP',
  'proseScoreAllH',
  'proseScoreAllP',
];

String docsProse2(Locale locale, String key) {
  final String tag = docsLocaleTag(locale);
  final Map<String, String>? table = _values[tag];
  final String? value = table?[key];
  if (value != null) return value;
  return _values['en']![key] ?? key;
}

const Map<String, Map<String, String>> _values = <String, Map<String, String>>{
  'en': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network. Each component records the strings it reads, including those of the components it depends on, so installing a component installs its translations too: component installs the English base and the strings one component needs for every locale the project already has; add installs a language for every component already in the project, and components added later receive it automatically. Running either command again changes nothing.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings. The public API is backward compatible: ComponentLocalizations is still the lookup, DashcnLocalizations is its alias.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'de': <String, String>{
    'proseThemeP1':
        'Baue dein Theme aus Tokens: Farben, Radius, Fonts und Schatten aus ThemeData.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens als Hintergrund/Vordergrund-Paare.',
    'proseThemeTokensH': 'Theme-Tokens',
    'proseThemeRadiusH': 'Radius-Skala',
    'proseThemeRadiusP': 'radius ist der Basis-Faktor für alle runden Flächen.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'Presets für hell und dunkel; per CLI anwenden, auf Themes testen.',
    'proseThemeCompH': 'Komponenten-Themes',
    'proseThemeCompP':
        'Jede Komponente löst Stil über vier Beine; App-Bein nie überschrieben.',
    'proseThemeSizeH': 'Größen und Dichte',
    'proseThemeSizeP': 'Kompakt als Standard; Spacing auf 4-px-Basis.',
    'proseThemeGlassH': 'Glasflächen',
    'proseThemeGlassP': 'surfaceOpacity und surfaceBlur machen Flächen matt.',
    'proseThemeAnimH': 'Animiertes Theming',
    'proseThemeAnimP': 'AnimatedTheme animiert Theme-Wechsel.',
    'proseThemeMotionH': 'Bewegung',
    'proseThemeMotionP': 'Animationen über Motion-Tokens in dezentem Band.',
    'proseDarkP1':
        'Jedes Preset hat helle und dunkle Tokens; kein Filter, sondern zweiter Satz.',
    'proseDarkH1': 'Wie es funktioniert',
    'proseDarkP2a': 'ThemeColors trägt die Helligkeit; lesen mit ',
    'proseDarkP2b': '. Nur für Verhalten, nie für Farben.',
    'proseDarkH2': 'Modus setzen',
    'proseDarkP3a': 'Theme pro Helligkeit plus ',
    'proseDarkP3b': ' an DashcnApp; system, light oder dark.',
    'proseDarkH3': 'Modus wechseln',
    'proseDarkP4':
        'Toggle speichert expliziten Modus und folgt nicht mehr dem System.',
    'proseDarkH4': 'System folgen',
    'proseDarkP5a': 'Diese Seite folgt dem System und speichert nach ',
    'proseDarkP5b': ' im Header. Gleiches Muster nutzen.',
    'proseI18nP1': 'Jeder String aus Locale-Tabelle mit Englisch-Fallback.',
    'proseI18nP2': 'Sechzehn Locales vollständig, darunter ar/he/fa/ur (RTL).',
    'proseI18nH1': 'Sprachumschalter',
    'proseI18nP3':
        'Zwischen Englisch, Arabisch und Deutsch wechseln; Arabisch spiegelt.',
    'proseI18nH2': 'RTL-Beispiel',
    'proseI18nP4': 'Locale impliziert Richtung; Code bleibt LTR.',
    'proseI18nH3': 'Pro-Instanz-Override',
    'proseI18nP5': 'Subtree wickeln für einzelne übersetzte Fläche.',
    'proseI18nH4': 'Locale installieren',
    'proseI18nP6': 'Offline-Installer ohne Paste und Netzwerk.',
    'proseI18nP7': 'Generierte Datei einmal in DashcnApp verdrahten.',
    'proseCliP1': 'CLI verwaltet Lifecycle: Core, Add, Update und Validate.',
    'proseScoreP1':
        'Jede Seite zeigt Scorecard: A11y, RTL, Frame-Zeit und Tests.',
    'proseScoreH1': 'Metriken',
    'proseScoreMetrics':
        'A11y prüft Kontrast und Targets; RTL pumpt Vorschau; Frame p50/p90.',
    'proseScoreHowH': 'So entsteht sie',
    'proseScoreHowP': 'Generator-Harness mit JSON-Reporter erzeugt die Daten.',
    'proseScoreLimH': 'Grenzen',
    'proseScoreLimP': 'Testfont, Timing und Schwellen begrenzen Aussage.',
    'proseScoreAllH': 'Alle Komponenten',
    'proseScoreAllP':
        'Alle gemessenen Komponenten mit Badge; nach Fehlern sortieren.',
  },
  'zh_Hant': <String, String>{
    'proseThemeP1': '以 token 建主題：色、圓角、字體與陰影皆自 ThemeData，換 preset 即全站換膚。',
    'proseThemeH1': 'Token',
    'proseThemeConv': 'Token 為背景/前景語意成對。',
    'proseThemeTokensH': '主題 Token',
    'proseThemeRadiusH': '圓角尺度',
    'proseThemeRadiusP': 'radius 為基準係數，衍生所有圓角。',
    'proseThemePresetsH': '預設主題',
    'proseThemePresetsP': '橫跨淺深色的預設，以 CLI 套用，至 Themes 試用。',
    'proseThemeCompH': '元件主題',
    'proseThemeCompP': '每元件經四腿解析，App 腿自有檔永不覆寫。',
    'proseThemeSizeH': '尺寸與密度',
    'proseThemeSizeP': '預設緊湊，間距以 4px 為基。',
    'proseThemeGlassH': '毛玻璃面',
    'proseThemeGlassP': 'surfaceOpacity 與 surfaceBlur 造就霧面。',
    'proseThemeAnimH': '動畫換膚',
    'proseThemeAnimP': 'AnimatedTheme 動畫化主題變更。',
    'proseThemeMotionH': '動效',
    'proseThemeMotionP': '動畫經 motion token，時長收斂細膩帶。',
    'proseDarkP1': '每預設皆有淺深兩套 token，深色非濾鏡而是第二套。',
    'proseDarkH1': '原理',
    'proseDarkP2a': 'ThemeColors 攜帶亮度，以 ',
    'proseDarkP2b': ' 讀取，僅作行為不選色。',
    'proseDarkH2': '設定模式',
    'proseDarkP3a': '為兩亮度各給主題加 ',
    'proseDarkP3b': ' 予 DashcnApp。',
    'proseDarkH3': '切換模式',
    'proseDarkP4': '開關存顯式模式，不再跟隨系統並持久化。',
    'proseDarkH4': '跟隨系統',
    'proseDarkP5a': '本站預設跟隨系統，用過 ',
    'proseDarkP5b': ' 即記住，同模式套用。',
    'proseI18nP1': '所有字串皆自語系表，無代理即英文備援。',
    'proseI18nP2': '十六語系完備，含 ar/he/fa/ur（RTL）。',
    'proseI18nH1': '語言切換器',
    'proseI18nP3': '英阿德間切換，阿語亦翻轉方向。',
    'proseI18nH2': 'RTL 範例',
    'proseI18nP4': '語系蘊含方向，程式碼保持 LTR。',
    'proseI18nH3': '單例覆寫',
    'proseI18nP5': '包裹子樹預覽單一譯面。',
    'proseI18nH4': '安裝語系',
    'proseI18nP6': '離線安裝器，無貼上無網路。',
    'proseI18nP7': '生成檔接一次 DashcnApp 即可。',
    'proseCliP1': 'CLI 管生命週期：裝 core、加元件、更新與驗證。',
    'proseScoreP1': '每頁記分卡：無障礙、RTL、幀時與測試。',
    'proseScoreH1': '指標',
    'proseScoreMetrics': '無障礙查對比與觸控，RTL 泵預覽，幀報 p50/p90。',
    'proseScoreHowH': '如何產生',
    'proseScoreHowP': '生成器 harness 以 JSON 產出資料。',
    'proseScoreLimH': '限制',
    'proseScoreLimP': '測試字體、時序與閾值限制解讀。',
    'proseScoreAllH': '所有元件',
    'proseScoreAllP': '全部量測與徽章，依失敗排序。',
  },
  'ar': <String, String>{
    'proseThemeP1': 'ابنِ السمة من الرموز: كل لون ونصف قطر وخط من ThemeData.',
    'proseThemeH1': 'الرموز',
    'proseThemeConv': 'الرموز أزواج خلفية/مقدمة دلالية.',
    'proseThemeTokensH': 'رموز السمة',
    'proseThemeRadiusH': 'مقياس الانحناء',
    'proseThemeRadiusP': 'radius عامل أساس لكل الأسطح المستديرة.',
    'proseThemePresetsH': 'الإعدادات',
    'proseThemePresetsP': 'إعدادات للفاتح والداكن تطبق بالأمر وتجرب في Themes.',
    'proseThemeCompH': 'سمات المكونات',
    'proseThemeCompP': 'كل مكون عبر أربع أرجل؛ رجل التطبيق لا تُمس.',
    'proseThemeSizeH': 'الأحجام والكثافة',
    'proseThemeSizeP': 'المضغوط افتراضي؛ التباعد أساس 4px.',
    'proseThemeGlassH': 'أسطح زجاجية',
    'proseThemeGlassP': 'surfaceOpacity وsurfaceBlur للصقيع.',
    'proseThemeAnimH': 'سمة متحركة',
    'proseThemeAnimP': 'AnimatedTheme يحرك تغير السمة.',
    'proseThemeMotionH': 'الحركة',
    'proseThemeMotionP': 'الحركة عبر رموز بمدد خفيفة.',
    'proseDarkP1': 'كل إعداد بطقمين فاتح وداكن؛ الداكن طقم ثانٍ لا مرشح.',
    'proseDarkH1': 'كيف يعمل',
    'proseDarkP2a': 'ThemeColors تحمل السطوع وتُقرأ بـ ',
    'proseDarkP2b': '. للسلوك لا للألوان.',
    'proseDarkH2': 'ضبط الوضع',
    'proseDarkP3a': 'مرر سمة لكل سطوع مع ',
    'proseDarkP3b': ' إلى DashcnApp.',
    'proseDarkH3': 'تبديل الوضع',
    'proseDarkP4': 'المبدل يخزن وضعًا صريحًا ويتوقف عن التبعية.',
    'proseDarkH4': 'اتباع النظام',
    'proseDarkP5a': 'الموقع يتبع النظام ويحفظ بعد ',
    'proseDarkP5b': ' في الترويسة.',
    'proseI18nP1': 'كل نص من جدول لغة مع إنجليزية بديلة.',
    'proseI18nP2': 'ست عشرة لغة كاملة منها RTL.',
    'proseI18nH1': 'مبدل اللغة',
    'proseI18nP3': 'بدل بين الإنجليزية والعربية والألمانية؛ العربية تعكس.',
    'proseI18nH2': 'مثال RTL',
    'proseI18nP4': 'اللغة تقتضي الاتجاه؛ الكود يبقى LTR.',
    'proseI18nH3': 'تجاوز مفرد',
    'proseI18nP5': 'لف subtree لمعاينة سطح مترجم.',
    'proseI18nH4': 'تثبيت لغة',
    'proseI18nP6': 'مثبت دون لصق أو شبكة.',
    'proseI18nP7': 'اربط الملف المولد مرة في DashcnApp.',
    'proseCliP1': 'CLI يدير الدورة: نواة وإضافة وتحديث وتحقق.',
    'proseScoreP1': 'كل صفحة بطاقة: إتاحة وRTL وزمن إطار واختبارات.',
    'proseScoreH1': 'المقاييس',
    'proseScoreMetrics': 'الإتاحة تباين وأهداف؛ RTL يضخ؛ الإطار p50/p90.',
    'proseScoreHowH': 'كيف تُنتج',
    'proseScoreHowP': 'المولد harness بـ JSON ينتج البيانات.',
    'proseScoreLimH': 'الحدود',
    'proseScoreLimP': 'الخط والتوقيت والعتبات تقيد المعنى.',
    'proseScoreAllH': 'كل المكونات',
    'proseScoreAllP': 'كل المقاس مع شارة؛ رتب بالفشل.',
  },
  'bg': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'bn': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'cs': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'da': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'el': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'es': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'fa': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'fi': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'fil': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'fr': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'he': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'hi': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'hu': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'id': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'it': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'ja': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'ko': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'mr': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'ms': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'nb': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'nl': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'zh_Hans': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'pt_BR': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'pl': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'ps': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'pt': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'ro': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'ru': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'sk': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'sv': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'ta': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'te': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'th': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'tr': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'uk': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'ur': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'vi': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
  'zh': <String, String>{
    'proseThemeP1':
        'Build your theme from tokens. Every colour, radius, font and shadow a component reads comes from the active ThemeData, so a preset switch re-themes the whole app without touching component code.',
    'proseThemeH1': 'Tokens',
    'proseThemeConv': 'Tokens come in semantic background/foreground pairs.',
    'proseThemeTokensH': 'Theme Tokens',
    'proseThemeRadiusH': 'Radius Scale',
    'proseThemeRadiusP':
        'radius is the base radius factor: the unitless rem number a preset stores. The component radius steps derive from it.',
    'proseThemePresetsH': 'Presets',
    'proseThemePresetsP':
        'The kit ships theme presets across light and dark. Apply another one with dashcn theme apply. Try them on the Themes page.',
    'proseThemeCompH': 'Component Themes',
    'proseThemeCompP':
        'Every component resolves its style through four legs. The app leg is the user-owned theme file, never overwritten.',
    'proseThemeSizeH': 'Sizing and density',
    'proseThemeSizeP':
        'Density tokens set the default look: compact is the default everywhere. The spacing scale is a 4 px base.',
    'proseThemeGlassH': 'Glass Surfaces',
    'proseThemeGlassP':
        'Two optional tokens make floating surfaces frosted: surfaceOpacity and surfaceBlur.',
    'proseThemeAnimH': 'Animated Theming',
    'proseThemeAnimP': 'AnimatedTheme animates ThemeData changes.',
    'proseThemeMotionH': 'Motion',
    'proseThemeMotionP':
        'Every component animation resolves through the motion tokens. Durations stay in a subtle band.',
    'proseDarkP1':
        'Every preset defines a light and a dark token set. Dark mode is not a filter over the light theme: it is a second set of the same tokens.',
    'proseDarkH1': 'How It Works',
    'proseDarkP2a':
        'ThemeColors carries the resolved brightness, so any widget below the app shell can read the mode with ',
    'proseDarkP2b':
        '. Components use that value only for behaviour, never to pick colours.',
    'proseDarkH2': 'Setting the Mode',
    'proseDarkP3a': 'Pass a theme per brightness and a ',
    'proseDarkP3b': ' to DashcnApp. The mode is system, light or dark.',
    'proseDarkH3': 'Toggling the Mode',
    'proseDarkP4':
        'A toggle stores an explicit mode. Once the user chooses, stop following the platform and persist the choice.',
    'proseDarkH4': 'Following the System',
    'proseDarkP5a':
        'This site itself defaults to the system brightness and persists an explicit choice once you use the ',
    'proseDarkP5b': ' in the header. Use the same pattern.',
    'proseI18nP1':
        'Every user-facing string in the kit comes from a locale table. DashcnLocalizations.of(context) reads the ambient locale and falls back to English.',
    'proseI18nP2':
        'Sixteen locales are complete for every key: ar, he, fa and ur (right-to-left) plus de, fr, es, it, pt-BR, nl, ru, tr, ja, ko, zh-Hans and hi.',
    'proseI18nH1': 'Language Switcher',
    'proseI18nP3':
        'Flip between English, Arabic and German. The pagination labels and chevrons re-string in place; Arabic also flips direction.',
    'proseI18nH2': 'RTL Example',
    'proseI18nP4':
        'A locale implies its text direction: the kit reads Directionality from the locale and keeps code left-to-right.',
    'proseI18nH3': 'Per-Instance Override',
    'proseI18nP5':
        'Wrap one subtree to preview a single translated surface without changing the app locale.',
    'proseI18nH4': 'Installing a Locale',
    'proseI18nP6':
        'The offline installer writes the locale wiring into your project — no pasting, no network.',
    'proseI18nP7':
        'Wire the generated file into DashcnApp once; every component below it re-strings.',
    'proseCliP1':
        'The CLI manages the registry lifecycle: install the layer core, add components, update from upstream, and validate the install.',
    'proseScoreP1':
        'Each component page shows a trust scorecard: accessibility, right-to-left, frame build time and tests.',
    'proseScoreH1': 'Metrics',
    'proseScoreMetrics':
        'Accessibility checks contrast and tap targets. Right-to-left pumps the preview under RTL. Frame time reports p50 and p90. Tests count registry cases.',
    'proseScoreHowH': 'How it is produced',
    'proseScoreHowP':
        'The kit generator runs a harness test with the JSON reporter. The docs generator then emits the scorecard data.',
    'proseScoreLimH': 'Limits',
    'proseScoreLimP':
        'Test font, test-environment timing and guideline thresholds limit what the numbers mean.',
    'proseScoreAllH': 'All components',
    'proseScoreAllP':
        'Every measured component with its overall badge. Sort by failures to surface the most failing checks.',
  },
};
