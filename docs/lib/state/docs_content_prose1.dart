// Website content strings: docs prose (part 1: intro/install/package/material).
//
// Per-locale tables with English fallback. Code spans/commands stay English;
// surrounding prose is translated. Every key must exist in every locale.

import 'package:flutter/widgets.dart';

import 'docs_strings.dart';

const List<String> kDocsContentProseKeys1 = <String>[
  'proseIntroP1',
  'proseIntroP2',
  'proseIntroH1',
  'proseIntroP3',
  'proseIntroB1t',
  'proseIntroB1b',
  'proseIntroB2t',
  'proseIntroB2b',
  'proseIntroB3t',
  'proseIntroB3b',
  'proseIntroH2',
  'proseIntroP4a',
  'proseIntroP4b',
  'proseIntroH3',
  'proseIntroP5',
  'proseIntroP6',
  'proseInstallP1',
  'proseInstallS1',
  'proseInstallS2',
  'proseInstallS3',
  'proseInstallS4',
  'proseInstallVerify',
  'proseInstallP2',
  'proseInstallB1t',
  'proseInstallB1b',
  'proseInstallB2t',
  'proseInstallB2b',
  'proseInstallB3t',
  'proseInstallB3b',
  'proseInstallTplA',
  'proseInstallTplB',
  'proseInstallEjectA',
  'proseInstallEjectB',
  'prosePackageP1',
  'prosePackageH1',
  'prosePackageP2',
  'prosePackageP3',
  'prosePackageH2',
  'prosePackageEjectA',
  'prosePackageEjectB',
  'prosePackageEjectC',
  'prosePackageH3',
  'prosePackageB1t',
  'prosePackageB1b',
  'prosePackageB2t',
  'prosePackageB2b',
  'prosePackageH4',
  'prosePackageP4',
  'proseMaterialP1',
  'proseMaterialH1',
  'proseMaterialP2',
  'proseMaterialH2',
  'proseMaterialP3',
  'proseMaterialH3',
  'proseMaterialP4',
  'proseMaterialH4',
  'proseMaterialP5',
  'proseMaterialH5',
  'proseMaterialP6',
];

String docsProse1(Locale locale, String key) {
  final String tag = docsLocaleTag(locale);
  final Map<String, String>? table = _values[tag];
  final String? value = table?[key];
  if (value != null) return value;
  return _values['en']![key] ?? key;
}

const Map<String, Map<String, String>> _values = <String, Map<String, String>>{
  'en': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'de': <String, String>{
    'proseIntroP1':
        'Jede Komponente wird in deine App kopiert: Quelle zum Lesen, Bearbeiten und Erweitern. Die Registry definiert jede Komponente einmal mit Manifest für den CLI.',
    'proseIntroP2':
        'Genau eine Implementierung pro Komponente. Keine Wrapper, keine Material-Widgets; gebaut aus Primitives und Theme-Tokens.',
    'proseIntroH1': 'Quelle, die dir gehört',
    'proseIntroP3':
        'Eine Komponente landet als Ordner. Die Theme-Datei gehört dir: Updates überschreiben nie deine Overrides.',
    'proseIntroB1t': 'Open Source: ',
    'proseIntroB1b': 'plain Flutter-Widgets zum Diffen und Committen.',
    'proseIntroB2t': 'Vorhersehbare APIs: ',
    'proseIntroB2b': 'ein Konstruktor plus Enums, einmal lernen.',
    'proseIntroB3t': 'Generierte Docs: ',
    'proseIntroB3b': 'die {count} Seiten stammen aus dem Manifest.',
    'proseIntroH2': 'Installation mit einem Befehl',
    'proseIntroP4a': 'Komponente hinzufügen mit ',
    'proseIntroP4b':
        '. Der CLI schreibt Komponente, Deps und Theme-Datei mit Lock-Hashes.',
    'proseIntroH3': 'Presets inklusive',
    'proseIntroP5':
        'Das Kit liefert {presets} Presets in {modes} Modi: Farb-Tokens, Radius und Fonts.',
    'proseIntroP6': 'Probiere sie auf der Themes-Seite oder lies Theming.',
    'proseInstallP1':
        'Zwei Wege aus einer Quelle: Paket per Semver oder kopierte Quellen. Die Schritte zeigen Own-the-Code.',
    'proseInstallS1': 'Flutter-Projekt erstellen',
    'proseInstallS2': 'Layer-Core installieren',
    'proseInstallS3': 'Komponenten hinzufügen',
    'proseInstallS4': 'Preset wählen',
    'proseInstallVerify': 'Prüfen',
    'proseInstallP2':
        'Nach der Installation hast du Layer-Core plus Komponenten. Starte die App.',
    'proseInstallB1t': 'Layer-Core: ',
    'proseInstallB1b': 'Foundation, Theme und Primitives zuerst.',
    'proseInstallB2t': 'Lock-Datei: ',
    'proseInstallB2b': 'dashcn.lock v2 hält Hashes für Reviews.',
    'proseInstallB3t': 'Eigene Themes: ',
    'proseInstallB3b': '*_theme.dart wird nie überschrieben.',
    'proseInstallTplA': 'Ab Vorlage starten: ',
    'proseInstallTplB': ' — ein Befehl erzeugt eine App aus Flows und Blöcken.',
    'proseInstallEjectA': 'Own-the-Code bleibt paketfähig: ',
    'proseInstallEjectB': ' macht daraus später eigene Quellen.',
    'prosePackageP1':
        'Jede Komponente zweimal aus einer Quelle: als Paket und als kopierbare Dateien mit gleichen Tokens.',
    'prosePackageH1': 'Welche?',
    'prosePackageP2':
        'Paket für Semver-Updates; Own-the-Code zum Lesen und Committen.',
    'prosePackageP3': 'Pro-Komponenten-Imports halten Paket-Builds schlank.',
    'prosePackageH2': 'So funktioniert Eject',
    'prosePackageEjectA': 'Aus dem Paket herausgewachsen? ',
    'prosePackageEjectB': ' kopiert die Komponente in deine App. ',
    'prosePackageEjectC': ' zieht transitive Deps mit.',
    'prosePackageH3': 'Updates im Vergleich',
    'prosePackageB1t': 'Paket: ',
    'prosePackageB1b': 'per Paketmanager; Breaking als Major.',
    'prosePackageB2t': 'Own-the-Code: ',
    'prosePackageB2b': 'dashcn update; eigene *_theme.dart nie angefasst.',
    'prosePackageH4': 'Die Lock-Datei',
    'prosePackageP4':
        'dashcn.lock (v2) hält Referenz, Pfade und Modus. Committe beide.',
    'proseMaterialP1':
        'dashcn ist widgets-only und koexistiert per Prefix mit Material.',
    'proseMaterialH1': 'Kollidierende Namen',
    'proseMaterialP2':
        'Theme, Card, Dialog u.a. gibt es beidseitig; eine Seite mit Prefix importieren.',
    'proseMaterialH2': 'Gemischtes Beispiel',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one build method: Material owns the scaffold, dashcn owns the action.',
    'proseMaterialH3': 'Die Insel themen',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve even when the root app is Material-owned:',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app (localizations, theme mode and navigation come from the kit) and MaterialApp when Material owns the shell with dashcn islands inside. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch-Targets',
    'proseMaterialP6':
        'Auf Phones transparente Hit-Paddings (iOS 44, Android 48).',
  },
  'zh_Hant': <String, String>{
    'proseIntroP1': '每個元件都複製進你的 App，原始碼可讀可改。登錄檔定義每個元件一次，供 CLI 安裝。',
    'proseIntroP2': '每個元件恰一種實作，無包裝、無 Material，皆由 primitives 與主題 token 打造。',
    'proseIntroH1': '屬於你的原始碼',
    'proseIntroP3': '元件以資料夾抵達，其主題檔屬於你：CLI 更新永不覆寫你的覆寫。',
    'proseIntroB1t': '開源：',
    'proseIntroB1b': '純 Flutter widget，可 diff 與提交。',
    'proseIntroB2t': '可預測介面：',
    'proseIntroB2b': '一個建構子加列舉，學一次即可。',
    'proseIntroB3t': '生成文件：',
    'proseIntroB3b': '{count} 參考頁皆由 manifest 生成。',
    'proseIntroH2': '一道指令安裝',
    'proseIntroP4a': '以 ',
    'proseIntroP4b': ' 新增元件，CLI 寫入相依與主題檔並記錄 hash。',
    'proseIntroH3': '內含預設主題',
    'proseIntroP5': '內建 {presets} 預設、{modes} 模式：色 token、圓角與字體。',
    'proseIntroP6': '至 Themes 頁試用，或讀 Theming 了解 token 對映。',
    'proseInstallP1': '同一來源兩種用法：依賴套件或擁有原始碼，下述為後者流程。',
    'proseInstallS1': '建立 Flutter 專案',
    'proseInstallS2': '安裝 layer core',
    'proseInstallS3': '加入元件',
    'proseInstallS4': '選擇預設主題',
    'proseInstallVerify': '驗證',
    'proseInstallP2': '安裝後即有 layer core 與元件，執行 App 查看。',
    'proseInstallB1t': 'Layer core：',
    'proseInstallB1b': '先裝 foundation、主題與primitives。',
    'proseInstallB2t': '鎖定檔：',
    'proseInstallB2b': 'dashcn.lock v2 記錄 hash 以利審查。',
    'proseInstallB3t': '自有主題：',
    'proseInstallB3b': '*_theme.dart 永不被覆寫。',
    'proseInstallTplA': '從模板開始：',
    'proseInstallTplB': '——一道指令從流程與區塊鷹架 App。',
    'proseInstallEjectA': 'Own-the-code 仍可走套件路：執行 ',
    'proseInstallEjectB': ' 轉為自有原始碼。',
    'prosePackageP1': '同一來源雙重出貨：發佈套件與可複製檔，渲染相同，僅擁有者不同。',
    'prosePackageH1': '選哪個？',
    'prosePackageP2': '要 semver 選套件；要逐行擁有選原始碼。',
    'prosePackageP3': '逐元件 import 保持套件構建精簡。',
    'prosePackageH2': 'Eject 如何運作',
    'prosePackageEjectA': '從套件畢業？',
    'prosePackageEjectB': '將該元件複製進 App 並改寫 import。',
    'prosePackageEjectC': '亦連帶搬移傳遞相依。',
    'prosePackageH3': '更新差異',
    'prosePackageB1t': '套件：',
    'prosePackageB1b': '以套件管理器更新，大版為 breaking。',
    'prosePackageB2t': '自有碼：',
    'prosePackageB2b': 'dashcn update；自有 *_theme.dart 永不動。',
    'prosePackageH4': '鎖定檔',
    'prosePackageP4': 'dashcn.lock (v2) 記錄來源與模式，兩者皆提交。',
    'proseMaterialP1': 'dashcn 為 widgets-only，以 prefix 與 Material 共存。',
    'proseMaterialH1': '衝突名稱',
    'proseMaterialP2': 'Theme、Card 等兩邊皆有，一側以 prefix 引入。',
    'proseMaterialH2': '混合範例',
    'proseMaterialP3': 'prefix 下兩套可在同一樹使用。',
    'proseMaterialH3': '孤島主題',
    'proseMaterialP4': '以其 Theme 包住 dashcn 子樹。',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5': '一個根擁有 App，切勿互嵌。',
    'proseMaterialH5': '觸控目標',
    'proseMaterialP6': '手機以透明 hit padding 放大（iOS 44、Android 48）。',
  },
  'ar': <String, String>{
    'proseIntroP1':
        'كل مكون يُنسخ في تطبيقك لتقرأه وتعدله. يعرف السجل كل مكون مرة للتثبيت.',
    'proseIntroP2':
        'تنفيذ واحد لكل مكون بلا أغلفة ولا Material؛ مبني من الأوليات والرموز.',
    'proseIntroH1': 'مصدر تملكه',
    'proseIntroP3': 'يصل المكون كمجلد وملف السمة لك: لا كتابة فوق تجاوزاتك.',
    'proseIntroB1t': 'مفتوح: ',
    'proseIntroB1b': 'ودجات Flutter للمراجعة والالتزام.',
    'proseIntroB2t': 'واجهات متوقعة: ',
    'proseIntroB2b': 'باني واحد plus enums.',
    'proseIntroB3t': 'مستندات مولدة: ',
    'proseIntroB3b': 'صفحات {count} من البيان.',
    'proseIntroH2': 'تثبيت بأمر واحد',
    'proseIntroP4a': 'أضف مكونًا بـ ',
    'proseIntroP4b': '. يكتب CLI المكون والاعتماديات والقفل.',
    'proseIntroH3': 'إعدادات مضمنة',
    'proseIntroP5': 'يشحن {presets} إعدادًا عبر {modes}: ألوان ونصف قطر وخطوط.',
    'proseIntroP6': 'جربها في Themes أو اقرأ Theming.',
    'proseInstallP1': 'طريقتان من مصدر واحد: حزمة أو نسخ. الخطوات للثانية.',
    'proseInstallS1': 'أنشئ مشروع Flutter',
    'proseInstallS2': 'ثبت النواة',
    'proseInstallS3': 'أضف مكونات',
    'proseInstallS4': 'اختر إعدادًا',
    'proseInstallVerify': 'تحقق',
    'proseInstallP2': 'بعد التثبيت لديك النواة والمكونات. شغل التطبيق.',
    'proseInstallB1t': 'النواة: ',
    'proseInstallB1b': 'الأساس والسمة أولًا.',
    'proseInstallB2t': 'القفل: ',
    'proseInstallB2b': 'dashcn.lock يسجل البصمات.',
    'proseInstallB3t': 'سماتك: ',
    'proseInstallB3b': 'لا كتابة فوق *_theme.dart.',
    'proseInstallTplA': 'ابدأ من قالب: ',
    'proseInstallTplB': ' — أمر يبني تطبيقًا من التدفقات.',
    'proseInstallEjectA': 'يبقى مسار الحزمة: نفذ ',
    'proseInstallEjectB': ' للتحويل لمصادر مملوكة.',
    'prosePackageP1': 'كل مكون مرتين من مصدر واحد: حزمة وملفات بنفس الرموز.',
    'prosePackageH1': 'أي واحد؟',
    'prosePackageP2': 'الحزمة للتحديثات؛ النسخ للقراءة والالتزام.',
    'prosePackageP3': 'استيراد مفرد يبقي البناء نحيفًا.',
    'prosePackageH2': 'كيف يعمل eject',
    'prosePackageEjectA': 'كبرت على الحزمة؟ ',
    'prosePackageEjectB': ' ينسخ المكون ويعيد كتابة الاستيراد. ',
    'prosePackageEjectC': ' يسحب الاعتماديات أيضًا.',
    'prosePackageH3': 'فرق التحديث',
    'prosePackageB1t': 'الحزمة: ',
    'prosePackageB1b': 'بمدير الحزم؛ الكاسر كإصدار رئيسي.',
    'prosePackageB2t': 'النسخ: ',
    'prosePackageB2b': 'dashcn update؛ لا مساس بسماتك.',
    'prosePackageH4': 'ملف القفل',
    'prosePackageP4': 'dashcn.lock يسجل المرجع والمسار. التزم بالاثنين.',
    'proseMaterialP1': 'dashcn خالص ويتعايش بالبادئة مع Material.',
    'proseMaterialH1': 'الأسماء المتعارضة',
    'proseMaterialP2': 'Theme وCard في الجهتين؛ استورد جهة ببادئة.',
    'proseMaterialH2': 'مثال مختلط',
    'proseMaterialP3': 'بالبادئة يعمل الاثنان في شجرة واحدة.',
    'proseMaterialH3': 'سمة الجزيرة',
    'proseMaterialP4': 'لف subtree بسمة dashcn.',
    'proseMaterialH4': 'DashcnApp مقابل MaterialApp',
    'proseMaterialP5': 'جذر واحد يملك التطبيق؛ لا تداخل.',
    'proseMaterialH5': 'أهداف اللمس',
    'proseMaterialP6': 'على الهواتف حشو شفاف (iOS 44 وAndroid 48).',
  },
  'bg': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'bn': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'cs': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'da': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'el': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'es': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'fa': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'fi': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'fil': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'fr': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'he': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'hi': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'hu': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'id': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'it': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'ja': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'ko': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'mr': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'ms': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'nb': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'nl': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'zh_Hans': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'pt_BR': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'pl': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'ps': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'pt': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'ro': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'ru': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'sk': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'sv': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'ta': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'te': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'th': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'tr': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'uk': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'ur': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'vi': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
  'zh': <String, String>{
    'proseIntroP1':
        'Every component in this kit is copied into your app, so the source is yours to read, edit and extend. The registry defines each component once: its widget file, its style file, its theme overrides and a generated manifest the CLI installs from.',
    'proseIntroP2':
        'There is exactly one implementation per component. No variant wrappers, no per-style subclasses and no Material widgets under the hood; the components are built from the kit primitives and the active theme tokens.',
    'proseIntroH1': 'Source you own',
    'proseIntroP3':
        'A component arrives as a folder under your UI directory. The theme file inside it is user-owned: CLI updates never overwrite your overrides, so you can change any token-driven value without forking the registry.',
    'proseIntroB1t': 'Open source: ',
    'proseIntroB1b':
        'the component files are plain Flutter widgets you can diff, review and commit.',
    'proseIntroB2t': 'Predictable interfaces: ',
    'proseIntroB2b':
        'one constructor plus enums, so examples and AI tools can learn the pattern once.',
    'proseIntroB3t': 'Generated docs: ',
    'proseIntroB3b':
        'the {count} reference pages are built from the registry manifest, never hand-written.',
    'proseIntroH2': 'One command install',
    'proseIntroP4a': 'Add a component with ',
    'proseIntroP4b':
        '. The CLI writes the component, its shared dependencies and a user-owned theme file, and records the exact hashes in a lock file so updates stay reviewable.',
    'proseIntroH3': 'Presets included',
    'proseIntroP5':
        'The kit ships {presets} theme presets across {modes} modes. A preset is data: colour tokens, radius and fonts, resolved through the same theme layer the components read at build time.',
    'proseIntroP6':
        'Try them on the Themes page, or read the Theming page to see how a preset maps onto the token names.',
    'proseInstallP1':
        'Use the components two ways, from the same source: depend on the published package and update via semver, or copy the sources into your project and own them. Pick a tab — the steps below walk the own-the-code flow.',
    'proseInstallS1': 'Create a Flutter project',
    'proseInstallS2': 'Install the layer core',
    'proseInstallS3': 'Add components',
    'proseInstallS4': 'Choose a preset',
    'proseInstallVerify': 'Verify',
    'proseInstallP2':
        'After installation, your project has the registry layer core (foundation + theme) and the components you added. Run the app to see the components in action.',
    'proseInstallB1t': 'Layer core: ',
    'proseInstallB1b':
        'foundation, theme and primitives install first; components depend on them.',
    'proseInstallB2t': 'Lock file: ',
    'proseInstallB2b':
        'dashcn.lock v2 records the exact hashes so updates stay reviewable.',
    'proseInstallB3t': 'User-owned themes: ',
    'proseInstallB3b':
        '*_theme.dart files are never overwritten by CLI updates.',
    'proseInstallTplA': 'Start from a template: ',
    'proseInstallTplB':
        ' — one command scaffolds a runnable app from flows and blocks.',
    'proseInstallEjectA':
        'Own-the-code apps stay on the package path too: run ',
    'proseInstallEjectB': ' later to turn a package import into owned sources.',
    'prosePackageP1':
        'Every component ships twice from the same source: as the published dashcn package and as copyable files the CLI installs into your app. Both render the same widgets from the same theme tokens; they differ only in who owns the bytes.',
    'prosePackageH1': 'Which one?',
    'prosePackageP2':
        'Choose the package when you want semver updates and lean imports. Choose own-the-code when you want to read, edit and commit every line.',
    'prosePackageP3':
        'Per-component imports keep package-mode builds lean; only the components you import are compiled in.',
    'prosePackageH2': 'How eject works',
    'prosePackageEjectA': 'Started on the package and outgrew it? ',
    'prosePackageEjectB':
        ' copies that component (plus its closure) into your app and rewrites the app imports to match. ',
    'prosePackageEjectC': ' also ejects its transitive component dependencies.',
    'prosePackageH3': 'How updates differ',
    'prosePackageB1t': 'Package: ',
    'prosePackageB1b':
        'update with the package manager; breaking changes arrive as new major versions.',
    'prosePackageB2t': 'Own the code: ',
    'prosePackageB2b':
        'run dashcn update. Unchanged files are overwritten, locally edited files are reported and skipped, and user-owned *_theme.dart files are never touched.',
    'prosePackageH4': 'The lock file',
    'prosePackageP4':
        'dashcn.lock (v2) records the registry reference, the install root, the theme selection and — per component — whether it is a package dependency or owned sources. .dashcn/config.json holds the install path and registry source. Commit both.',
    'proseMaterialP1':
        'dashcn is widgets-only: no Material widgets under the hood, no MaterialApp required. In a mixed app the two sets coexist behind import prefixes.',
    'proseMaterialH1': 'The clashing names',
    'proseMaterialP2':
        'Theme, ThemeData, Card, Chip, Dialog, Slider, Switch, Checkbox, Tooltip, showDialog and showMenu exist in both libraries. Import one side with a prefix so both stay usable.',
    'proseMaterialH2': 'A mixed example',
    'proseMaterialP3':
        'With the prefix, both sets stay usable in one tree: Material scaffolding outside, dashcn components inside.',
    'proseMaterialH3': 'Theming the island',
    'proseMaterialP4':
        'Wrap the dashcn subtree in its Theme so tokens resolve below the boundary.',
    'proseMaterialH4': 'DashcnApp vs MaterialApp',
    'proseMaterialP5':
        'One root owns the app: use DashcnApp for a full dashcn app, MaterialApp for a Material app. Never nest one root inside the other.',
    'proseMaterialH5': 'Touch targets',
    'proseMaterialP6':
        'On phones dashcn grows desktop-density controls with transparent hit padding (iOS 44, Android 48) without changing the painted visuals. Dense rows and joined groups can opt out per app with ThemeData(touchTargets: TouchTargets.shrinkWrap).',
  },
};
