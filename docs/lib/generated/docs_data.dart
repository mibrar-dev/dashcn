// GENERATED CODE - DO NOT MODIFY BY HAND.
//
// Sources:
//   * dashcn/lib/src/manifests/registry.json
//   * dashcn/lib/src/themes/index.json
//
// Regenerate: dart run tool/gen_docs_data.dart
//
// Every component, preset, category and stat is derived from the
// registry manifest; docs pages never hard-code registry facts.

/// One installable component, generated from the registry manifest.
class DocsComponent {
  /// Creates a component entry.
  const DocsComponent({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.install,
    required this.import,
    required this.fileCount,
    required this.stability,
    required this.listed,
    required this.placement,
  });

  /// Registry id / directory name.
  final String id;

  /// Display name.
  final String name;

  /// Manifest category (`form`, `overlay`, `display`, …).
  final String category;

  /// One-line description from the manifest.
  final String description;

  /// `dashcn add <id>` from the manifest.
  final String install;

  /// Corrected import line for the installed layout.
  final String import;

  /// Installed Dart files: manifest `files` + user-owned theme file.
  final int fileCount;

  /// `stable` for every component — the manifest has no stability
  /// field yet; this is a docs-site presentation constant.
  final String stability;

  /// Whether the docs site lists this component (sidebar, index,
  /// palette). `listed: false` marks the building blocks: installable
  /// and reachable through API links, but not browsable.
  final bool listed;

  /// Device-frame preview placement (F1): `center`, `top`,
  /// `bottom`, `fill` or `leading`, from `preview.placement`.
  final String placement;
}

/// One theme preset, generated from `themes/index.json`.
class DocsPreset {
  /// Creates a preset entry.
  const DocsPreset({required this.id, required this.name, required this.modes});

  /// Preset id (`modern-minimal`).
  final String id;

  /// Display name (`Modern Minimal`).
  final String name;

  /// Supported modes in declaration order (`light`, `dark`).
  final List<String> modes;
}

/// A catalog category with its component count.
class DocsCategory {
  /// Creates a category entry.
  const DocsCategory({required this.id, required this.count});

  /// Category id (`form`).
  final String id;

  /// Number of components in the category.
  final int count;
}

/// Compact link-grid row: id + name only (components index).
class DocsComponentLink {
  /// Creates a link row.
  const DocsComponentLink({required this.id, required this.name});

  /// Registry id / route segment (`/docs/components/<id>`).
  final String id;

  /// Display name.
  final String name;
}

/// Landing stats band values, each derived from the registry.
class DocsStats {
  /// Creates the stats block.
  const DocsStats({
    required this.components,
    required this.listedComponents,
    required this.presets,
    required this.materialImports,
    required this.modes,
  });

  /// Installable component count: manifest `components` entries.
  final int components;

  /// Listed component count: entries with `listed: true` (the docs
  /// site, sidebar, palette and hero badge count these; hidden building
  /// blocks are installable but not browsable).
  final int listedComponents;

  /// Preset count: `themes/index.json` entries.
  final int presets;

  /// Material/Cupertino import directives found across the
  /// registry Dart files (must be 0).
  final int materialImports;

  /// Distinct preset modes (2: light + dark).
  final int modes;
}

/// One global theme token: the dashcn CSS variable name in camelCase.
class DocsThemeToken {
  /// Creates a token entry.
  const DocsThemeToken({required this.name, required this.cssVar});

  /// camelCase token name (`cardForeground`).
  final String name;

  /// dashcn CSS variable (`--card-foreground`).
  final String cssVar;
}

/// All 132 installable components, ordered by category then id.
const List<DocsComponent> kComponents = <DocsComponent>[
  DocsComponent(
    id: 'border_loading',
    name: 'Border Loading',
    category: 'Animation & Effects',
    description:
        'Animated gradient border around a child: sweep ring, travelling tracers, determinate progress or a static outline.',
    install: 'dashcn add border_loading',
    import:
        "import 'package:<your_app>/ui/dashcn/components/border_loading/border_loading.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'dot_indicator',
    name: 'Dot Indicator',
    category: 'Animation & Effects',
    description:
        'Animated row or column of dots showing the active index of a carousel, stepper or pager.',
    install: 'dashcn add dot_indicator',
    import:
        "import 'package:<your_app>/ui/dashcn/components/dot_indicator/dot_indicator.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'text_animate',
    name: 'Text Animate',
    category: 'Animation & Effects',
    description:
        'Stream-aware animated text renderer for incremental updates, plus a streaming markdown tail.',
    install: 'dashcn add text_animate',
    import:
        "import 'package:<your_app>/ui/dashcn/components/text_animate/text_animate.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'button',
    name: 'Button',
    category: 'Buttons & Actions',
    description:
        'Pressable action control with seven variants, five fixed sizes, an async idle/loading/success/failure status machine, plus a connected ButtonGroup.',
    install: 'dashcn add button',
    import:
        "import 'package:<your_app>/ui/dashcn/components/button/button.dart';",
    fileCount: 11,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'fab',
    name: 'Fab',
    category: 'Buttons & Actions',
    description:
        'Floating action button in three sizes plus an extended pill shape, with a speed dial, a positions helper, hide-on-scroll and a tooltip.',
    install: 'dashcn add fab',
    import: "import 'package:<your_app>/ui/dashcn/components/fab/fab.dart';",
    fileCount: 9,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'toggle',
    name: 'Toggle',
    category: 'Buttons & Actions',
    description:
        'On/off button with a controlled and a controller-driven mode, plus form participation.',
    install: 'dashcn add toggle',
    import:
        "import 'package:<your_app>/ui/dashcn/components/toggle/toggle.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'toolbar',
    name: 'Toolbar',
    category: 'Buttons & Actions',
    description:
        'Row or column of actions, toggles, separators and groups, with a responsive overflow menu and arrow-key roving focus.',
    install: 'dashcn add toolbar',
    import:
        "import 'package:<your_app>/ui/dashcn/components/toolbar/toolbar.dart';",
    fileCount: 12,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'color_picker',
    name: 'Color Picker',
    category: 'Color',
    description:
        'Full colour picker: HSV/HSL pad, hue/alpha bars, RGB/HSL/HSV/HEX fields, optional alpha, colour history and screen sampling.',
    install: 'dashcn add color_picker',
    import:
        "import 'package:<your_app>/ui/dashcn/components/color_picker/color_picker.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'avatar',
    name: 'Avatar',
    category: 'Data Display',
    description:
        'Image or initials tile with an optional badge and overlapping group.',
    install: 'dashcn add avatar',
    import:
        "import 'package:<your_app>/ui/dashcn/components/avatar/avatar.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'badge',
    name: 'Badge',
    category: 'Data Display',
    description:
        'Small rounded label or status dot with four variants, optionally pressable.',
    install: 'dashcn add badge',
    import:
        "import 'package:<your_app>/ui/dashcn/components/badge/badge.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'carousel',
    name: 'Carousel',
    category: 'Data Display',
    description:
        'Paged carousel with a sliding or fading transition, drag, autoplay and a controller that drives the dot row.',
    install: 'dashcn add carousel',
    import:
        "import 'package:<your_app>/ui/dashcn/components/carousel/carousel.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'fill',
  ),
  DocsComponent(
    id: 'chart',
    name: 'Chart',
    category: 'Data Display',
    description:
        'Line, area, bar, donut/pie, radar, sparkline and scatter charts with streaming and accessibility, painted with CustomPaint.',
    install: 'dashcn add chart',
    import:
        "import 'package:<your_app>/ui/dashcn/components/chart/chart.dart';",
    fileCount: 12,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'chat',
    name: 'Chat',
    category: 'Data Display',
    description:
        'Chat bubbles and groups: plain, tailed or sharp-corner bubbles aligned to their side of the row, with optional avatars.',
    install: 'dashcn add chat',
    import: "import 'package:<your_app>/ui/dashcn/components/chat/chat.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'fill',
  ),
  DocsComponent(
    id: 'chip',
    name: 'Chip',
    category: 'Data Display',
    description:
        'Compact deletable-token control plus the borderless control embedded inside a chip.',
    install: 'dashcn add chip',
    import: "import 'package:<your_app>/ui/dashcn/components/chip/chip.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'country_flag',
    name: 'Country Flag',
    category: 'Data Display',
    description:
        'Flag tile for a country looked up by ISO code, currency or dial prefix, with an emoji fallback.',
    install: 'dashcn add country_flag',
    import:
        "import 'package:<your_app>/ui/dashcn/components/country_flag/country_flag.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'divider',
    name: 'Divider',
    category: 'Data Display',
    description:
        'Themed rule in either orientation, optionally carrying a centred label.',
    install: 'dashcn add divider',
    import:
        "import 'package:<your_app>/ui/dashcn/components/divider/divider.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'empty_state',
    name: 'Empty State',
    category: 'Data Display',
    description:
        'A block that stands in for missing content: muted icon, title, description and up to three actions, in an inline or route-level scale.',
    install: 'dashcn add empty_state',
    import:
        "import 'package:<your_app>/ui/dashcn/components/empty_state/empty_state.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'feature_carousel',
    name: 'Feature Carousel',
    category: 'Data Display',
    description:
        'Animated feature-card carousel with autoplay, swipe, keyboard navigation, nav arrows and a call to action.',
    install: 'dashcn add feature_carousel',
    import:
        "import 'package:<your_app>/ui/dashcn/components/feature_carousel/feature_carousel.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'fill',
  ),
  DocsComponent(
    id: 'file_diff_viewer',
    name: 'File Diff Viewer',
    category: 'Data Display',
    description:
        'Renders unified or split file diffs with line gutters, coloured additions/deletions, collapsible unchanged hunks and a copy-patch action.',
    install: 'dashcn add file_diff_viewer',
    import:
        "import 'package:<your_app>/ui/dashcn/components/file_diff_viewer/file_diff_viewer.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'fill',
  ),
  DocsComponent(
    id: 'keyboard_shortcut',
    name: 'Keyboard Shortcut',
    category: 'Data Display',
    description:
        'Renders a keyboard shortcut as a row of small key caps, from explicit keys or from a ShortcutActivator, with an optional app-wide label override.',
    install: 'dashcn add keyboard_shortcut',
    import:
        "import 'package:<your_app>/ui/dashcn/components/keyboard_shortcut/keyboard_shortcut.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'list_tile',
    name: 'List Tile',
    category: 'Data Display',
    description:
        'A single-line to three-line list row with leading, title, subtitle and trailing slots, dense/comfortable sizing, selected and disabled states, tap and long-press, plus a grouped list helper.',
    install: 'dashcn add list_tile',
    import:
        "import 'package:<your_app>/ui/dashcn/components/list_tile/list_tile.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'number_ticker',
    name: 'Number Ticker',
    category: 'Data Display',
    description:
        'Animated number with a formatter or custom builder, plus flip-clock character rollers.',
    install: 'dashcn add number_ticker',
    import:
        "import 'package:<your_app>/ui/dashcn/components/number_ticker/number_ticker.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'pinned_sheet',
    name: 'Pinned Sheet',
    category: 'Data Display',
    description:
        'In-tree sheet that slides in from an edge, drags, and snaps between snap stages.',
    install: 'dashcn add pinned_sheet',
    import:
        "import 'package:<your_app>/ui/dashcn/components/pinned_sheet/pinned_sheet.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: true,
    placement: 'bottom',
  ),
  DocsComponent(
    id: 'table',
    name: 'Table',
    category: 'Data Display',
    description:
        'Themed data grid with span-aware cells, frozen rows/columns, scrolling and optional column/row resizing.',
    install: 'dashcn add table',
    import:
        "import 'package:<your_app>/ui/dashcn/components/table/table.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'fill',
  ),
  DocsComponent(
    id: 'timeline',
    name: 'Timeline',
    category: 'Data Display',
    description:
        'Vertical three-column event timeline: time label, indicator dot with connector, title and content.',
    install: 'dashcn add timeline',
    import:
        "import 'package:<your_app>/ui/dashcn/components/timeline/timeline.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'tracker',
    name: 'Tracker',
    category: 'Data Display',
    description:
        'A row of coloured activity segments, each with a hover tooltip.',
    install: 'dashcn add tracker',
    import:
        "import 'package:<your_app>/ui/dashcn/components/tracker/tracker.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'tree',
    name: 'Tree',
    category: 'Data Display',
    description:
        'Immutable hierarchical list with expand/collapse, selection and themed indent guides.',
    install: 'dashcn add tree',
    import: "import 'package:<your_app>/ui/dashcn/components/tree/tree.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'calendar',
    name: 'Calendar',
    category: 'Date & Time',
    description:
        'Date, month and year grids with single, range and multi selection, roving-tabindex keyboard navigation and per-day semantic dates; the selection value types live in the date_math primitive.',
    install: 'dashcn add calendar',
    import:
        "import 'package:<your_app>/ui/dashcn/components/calendar/calendar.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'date_picker',
    name: 'Date Picker',
    category: 'Date & Time',
    description:
        'Single-date and date-span fields opening a calendar sheet (DatePickerDialog with month/year stepper) in a dialog or a popover, wired into the form system.',
    install: 'dashcn add date_picker',
    import:
        "import 'package:<your_app>/ui/dashcn/components/date_picker/date_picker.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'time_picker',
    name: 'Time Picker',
    category: 'Date & Time',
    description:
        'Clock-time and duration fields opening digit-field sheets (hour/minute/second plus AM/PM, day/hour/minute/second) in a dialog or a popover, wired into the form system.',
    install: 'dashcn add time_picker',
    import:
        "import 'package:<your_app>/ui/dashcn/components/time_picker/time_picker.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'alert',
    name: 'Alert',
    category: 'Feedback',
    description:
        'Bordered callout banner with base and destructive variants, a leading slot, title, content and trailing slot.',
    install: 'dashcn add alert',
    import:
        "import 'package:<your_app>/ui/dashcn/components/alert/alert.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'top',
  ),
  DocsComponent(
    id: 'progress',
    name: 'Progress',
    category: 'Feedback',
    description:
        'Determinate and indeterminate linear progress bar, widgets-only.',
    install: 'dashcn add progress',
    import:
        "import 'package:<your_app>/ui/dashcn/components/progress/progress.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'skeleton',
    name: 'Skeleton',
    category: 'Feedback',
    description:
        'Widgets-only loading placeholder with a repeating shimmer sweep; replaces the banned skeletonizer package.',
    install: 'dashcn add skeleton',
    import:
        "import 'package:<your_app>/ui/dashcn/components/skeleton/skeleton.dart';",
    fileCount: 8,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'spinner',
    name: 'Spinner',
    category: 'Feedback',
    description:
        'Indeterminate circular indicator with a rotating arc, widgets-only.',
    install: 'dashcn add spinner',
    import:
        "import 'package:<your_app>/ui/dashcn/components/spinner/spinner.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'toast',
    name: 'Toast',
    category: 'Feedback',
    description:
        'Transient, non-blocking notifications anchored to a screen edge.',
    install: 'dashcn add toast',
    import:
        "import 'package:<your_app>/ui/dashcn/components/toast/toast.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'autocomplete',
    name: 'Autocomplete',
    category: 'Forms & Inputs',
    description:
        'Input feature that turns the field text into a popover-backed suggestion list with keyboard navigation and three replacement modes.',
    install: 'dashcn add autocomplete',
    import:
        "import 'package:<your_app>/ui/dashcn/components/autocomplete/autocomplete.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'checkbox',
    name: 'Checkbox',
    category: 'Forms & Inputs',
    description:
        'Tri-state form checkbox with controlled and controller-driven modes, keyboard activation and form participation.',
    install: 'dashcn add checkbox',
    import:
        "import 'package:<your_app>/ui/dashcn/components/checkbox/checkbox.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'chip_input',
    name: 'Chip Input',
    category: 'Forms & Inputs',
    description:
        'Token field: a widgets-only input whose values render as removable chips, with suggestion, validation and clipboard round-trips.',
    install: 'dashcn add chip_input',
    import:
        "import 'package:<your_app>/ui/dashcn/components/chip_input/chip_input.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'dropzone',
    name: 'Dropzone',
    category: 'Forms & Inputs',
    description:
        'An upload surface: outline, upload icon, localized status line, optional hint and a browse button. Presentational — it takes a state, it does not listen to a drag stream.',
    install: 'dashcn add dropzone',
    import:
        "import 'package:<your_app>/ui/dashcn/components/dropzone/dropzone.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'file_picker',
    name: 'File Picker',
    category: 'Forms & Inputs',
    description:
        'File selection surface (dropzone, tile or compact trigger) with validation, a concurrent upload queue and the FileUploadRow list — list or grid layout, caller-keyed groups, per-file icons.',
    install: 'dashcn add file_picker',
    import:
        "import 'package:<your_app>/ui/dashcn/components/file_picker/file_picker.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'form',
    name: 'Form',
    category: 'Forms & Inputs',
    description:
        'FormScope scope, labelled field layouts, validators, controller and submission flow.',
    install: 'dashcn add form',
    import: "import 'package:<your_app>/ui/dashcn/components/form/form.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'formatted_input',
    name: 'Formatted Input',
    category: 'Forms & Inputs',
    description:
        'Masked/segmented field (phone, date, card) built from static separators and small editable parts.',
    install: 'dashcn add formatted_input',
    import:
        "import 'package:<your_app>/ui/dashcn/components/formatted_input/formatted_input.dart';",
    fileCount: 4,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'input',
    name: 'Input',
    category: 'Forms & Inputs',
    description:
        'Widgets-only text field wrapping EditableText, with a pluggable feature system, form participation and a widgets-only selection menu.',
    install: 'dashcn add input',
    import:
        "import 'package:<your_app>/ui/dashcn/components/input/input.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'input_otp',
    name: 'Input OTP',
    category: 'Forms & Inputs',
    description:
        'One-time-password input: one hidden field drives a row of character slots, with separators, obscuring, validation and form participation.',
    install: 'dashcn add input_otp',
    import:
        "import 'package:<your_app>/ui/dashcn/components/input_otp/input_otp.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'item_picker',
    name: 'Item Picker',
    category: 'Forms & Inputs',
    description:
        'Field that edits a value by picking one item from a grid or list, in a dialog or popover.',
    install: 'dashcn add item_picker',
    import:
        "import 'package:<your_app>/ui/dashcn/components/item_picker/item_picker.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'multi_select',
    name: 'Multi Select',
    category: 'Forms & Inputs',
    description:
        'A multi-selection dropdown built on select: checkbox popup rows (menu MenuCheckboxItem) that stay open while toggling, and removable chips in the trigger.',
    install: 'dashcn add multi_select',
    import:
        "import 'package:<your_app>/ui/dashcn/components/multi_select/multi_select.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'object_input',
    name: 'Object Input',
    category: 'Forms & Inputs',
    description:
        'Typed date, time and duration fields: locale-ordered numeric segments with a calendar dialog behind the date field.',
    install: 'dashcn add object_input',
    import:
        "import 'package:<your_app>/ui/dashcn/components/object_input/object_input.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'phone_input',
    name: 'Phone Input',
    category: 'Forms & Inputs',
    description:
        'Searchable country selector (flag + dial code) with a national-number field, wired into the form system.',
    install: 'dashcn add phone_input',
    import:
        "import 'package:<your_app>/ui/dashcn/components/phone_input/phone_input.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'radio_group',
    name: 'Radio Group',
    category: 'Forms & Inputs',
    description:
        'Single-select group with controlled and controller-driven modes, row and card item shapes, roving arrow-key traversal and form participation.',
    install: 'dashcn add radio_group',
    import:
        "import 'package:<your_app>/ui/dashcn/components/radio_group/radio_group.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'search_bar',
    name: 'Search Bar',
    category: 'Forms & Inputs',
    description:
        'A search field with a ranked result list: tiered fuzzy matching with highlighted matches, keyboard navigation, clear and cancel actions, and optional groups.',
    install: 'dashcn add search_bar',
    import:
        "import 'package:<your_app>/ui/dashcn/components/search_bar/search_bar.dart';",
    fileCount: 5,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'segmented_control',
    name: 'Segmented Control',
    category: 'Forms & Inputs',
    description:
        'Row of mutually exclusive (or multi-select) choices with a sliding thumb, icons or labels, disabled segments and intrinsic or full-width sizing.',
    install: 'dashcn add segmented_control',
    import:
        "import 'package:<your_app>/ui/dashcn/components/segmented_control/segmented_control.dart';",
    fileCount: 10,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'select',
    name: 'Select',
    category: 'Forms & Inputs',
    description:
        "A single-selection dropdown picker. The trigger reuses the button variant table and the popover primitive; the popup is the menu component's surface and rows; the search field is the input component.",
    install: 'dashcn add select',
    import:
        "import 'package:<your_app>/ui/dashcn/components/select/select.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'signature_pad',
    name: 'Signature Pad',
    category: 'Forms & Inputs',
    description:
        'Freehand signature capture with smoothed strokes, speed-based width, undo/redo/clear and PNG/SVG export.',
    install: 'dashcn add signature_pad',
    import:
        "import 'package:<your_app>/ui/dashcn/components/signature_pad/signature_pad.dart';",
    fileCount: 4,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'slider',
    name: 'Slider',
    category: 'Forms & Inputs',
    description:
        'Single- and range-value sliders with snap strategies, four visual variants, and keyboard/form support. Built on widgets gestures and CustomPaint — no Material Slider.',
    install: 'dashcn add slider',
    import:
        "import 'package:<your_app>/ui/dashcn/components/slider/slider.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'star_rating',
    name: 'Star Rating',
    category: 'Forms & Inputs',
    description:
        'Interactive star rating with half-star snapping, keyboard stepping, drag preview and form participation.',
    install: 'dashcn add star_rating',
    import:
        "import 'package:<your_app>/ui/dashcn/components/star_rating/star_rating.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'switch',
    name: 'Switch',
    category: 'Forms & Inputs',
    description:
        'Boolean form switch with controlled and controller-driven modes, sliding thumb, keyboard activation and form participation.',
    install: 'dashcn add switch',
    import:
        "import 'package:<your_app>/ui/dashcn/components/switch/switch.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'text_area',
    name: 'Text Area',
    category: 'Forms & Inputs',
    description:
        'Multi-line text input: an Input with three-line defaults, a multiline keyboard and vertically centred content.',
    install: 'dashcn add text_area',
    import:
        "import 'package:<your_app>/ui/dashcn/components/text_area/text_area.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'wheel_picker',
    name: 'Wheel Picker',
    category: 'Forms & Inputs',
    description:
        'A scrolling wheel picker with one or more columns, item snapping, a centred selection band, an optional 3D cylinder look, optional infinite looping, and a haptic-free selection callback. Drag, mouse wheel, keyboard arrows and tap-to-select all work.',
    install: 'dashcn add wheel_picker',
    import:
        "import 'package:<your_app>/ui/dashcn/components/wheel_picker/wheel_picker.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'accordion',
    name: 'Accordion',
    category: 'Layout',
    description:
        'Single-expansion accordion with animated items, themed dividers and a keyboard-accessible trigger.',
    install: 'dashcn add accordion',
    import:
        "import 'package:<your_app>/ui/dashcn/components/accordion/accordion.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'card',
    name: 'Card',
    category: 'Layout',
    description:
        'Rounded bordered surface with the dashcn header, title, description, content and footer slots.',
    install: 'dashcn add card',
    import: "import 'package:<your_app>/ui/dashcn/components/card/card.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'card_image',
    name: 'Card Image',
    category: 'Layout',
    description:
        'A pressable card pairing an image with a leading/title/subtitle/trailing text block.',
    install: 'dashcn add card_image',
    import:
        "import 'package:<your_app>/ui/dashcn/components/card_image/card_image.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'collapsible',
    name: 'Collapsible',
    category: 'Layout',
    description:
        'Expandable section with a trigger, hidden content panes and controlled or uncontrolled expansion.',
    install: 'dashcn add collapsible',
    import:
        "import 'package:<your_app>/ui/dashcn/components/collapsible/collapsible.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'filter_bar',
    name: 'Filter Bar',
    category: 'Layout',
    description:
        'Search, sort, date-range, custom filters and chips in one bar, with a clear action and a mobile sheet presentation; backed by a typed filter engine.',
    install: 'dashcn add filter_bar',
    import:
        "import 'package:<your_app>/ui/dashcn/components/filter_bar/filter_bar.dart';",
    fileCount: 12,
    stability: 'stable',
    listed: true,
    placement: 'top',
  ),
  DocsComponent(
    id: 'overflow_marquee',
    name: 'Overflow Marquee',
    category: 'Layout',
    description:
        'Continuous auto-scrolling content loop, horizontally or vertically, with soft edge fades, hover/focus pause, and reduced-motion support.',
    install: 'dashcn add overflow_marquee',
    import:
        "import 'package:<your_app>/ui/dashcn/components/overflow_marquee/overflow_marquee.dart';",
    fileCount: 5,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'resizable',
    name: 'Resizable',
    category: 'Layout',
    description:
        'Split panes with draggable dividers, absolute or flexible sizing, min/max constraints, collapse and external controllers.',
    install: 'dashcn add resizable',
    import:
        "import 'package:<your_app>/ui/dashcn/components/resizable/resizable.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'fill',
  ),
  DocsComponent(
    id: 'scaffold',
    name: 'Scaffold',
    category: 'Layout',
    description:
        'App screen shell with header/footer bars, a loading bar and keyboard avoidance, plus the AppBar title bar.',
    install: 'dashcn add scaffold',
    import:
        "import 'package:<your_app>/ui/dashcn/components/scaffold/scaffold.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'fill',
  ),
  DocsComponent(
    id: 'scrollbar',
    name: 'Scrollbar',
    category: 'Layout',
    description:
        "Themeable scrollbar wrapper around Flutter's RawScrollbar with token-derived thumb, thickness and radius.",
    install: 'dashcn add scrollbar',
    import:
        "import 'package:<your_app>/ui/dashcn/components/scrollbar/scrollbar.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'fill',
  ),
  DocsComponent(
    id: 'sortable',
    name: 'Sortable',
    category: 'Layout',
    description:
        'Drag-and-drop reordering primitives: a SortableLayer coordinates pan-driven sessions and renders the ghost, while Sortable<T> reports per-edge drop intents.',
    install: 'dashcn add sortable',
    import:
        "import 'package:<your_app>/ui/dashcn/components/sortable/sortable.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'steps',
    name: 'Steps',
    category: 'Layout',
    description: 'Vertical numbered step list joined by a connector line.',
    install: 'dashcn add steps',
    import:
        "import 'package:<your_app>/ui/dashcn/components/steps/steps.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'command',
    name: 'Command',
    category: 'Menus',
    description:
        'Command palette with a debounced async result stream, keyboard navigation and a dialog entry point.',
    install: 'dashcn add command',
    import:
        "import 'package:<your_app>/ui/dashcn/components/command/command.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'context_menu',
    name: 'Context Menu',
    category: 'Menus',
    description:
        'A menu shown at the pointer on right-click (long-press on touch platforms), plus the showContextMenu helper. Rows, traversal and the popup surface come from the menu component.',
    install: 'dashcn add context_menu',
    import:
        "import 'package:<your_app>/ui/dashcn/components/context_menu/context_menu.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'dropdown_menu',
    name: 'Dropdown Menu',
    category: 'Menus',
    description:
        'A menu surface anchored below the widget that opened it, plus the showDropdown helper. Rows, traversal and the popup surface come from the menu component.',
    install: 'dashcn add dropdown_menu',
    import:
        "import 'package:<your_app>/ui/dashcn/components/dropdown_menu/dropdown_menu.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'menu',
    name: 'Menu',
    category: 'Menus',
    description:
        'Keyboard-navigable menu family: MenuGroup with roving focus and typeahead; MenuButton, MenuCheckboxItem, MenuRadioItem, MenuLabel, MenuShortcut, MenuSeparator and MenuSub rows; showMenu helper; MenuPopup surface. Owns MenuPopupTheme and MenubarTheme for the wave-D menu consumers.',
    install: 'dashcn add menu',
    import: "import 'package:<your_app>/ui/dashcn/components/menu/menu.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'menubar',
    name: 'Menubar',
    category: 'Menus',
    description:
        "A horizontal bar of menu triggers whose submenus open below the bar. Rows, keyboard traversal and popup surfaces are the menu component's; MenubarTheme is owned by menu and resolved here.",
    install: 'dashcn add menubar',
    import:
        "import 'package:<your_app>/ui/dashcn/components/menubar/menubar.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: true,
    placement: 'top',
  ),
  DocsComponent(
    id: 'breadcrumb',
    name: 'Breadcrumb',
    category: 'Navigation',
    description:
        'Horizontal trail of crumbs with a chevron or slash separator.',
    install: 'dashcn add breadcrumb',
    import:
        "import 'package:<your_app>/ui/dashcn/components/breadcrumb/breadcrumb.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'top',
  ),
  DocsComponent(
    id: 'navigation_bar',
    name: 'Navigation Bar',
    category: 'Navigation',
    description:
        'Navigation container for bars, rails and sidebars: selectable items with labels, groups, collapsibles, dividers, slots and arrow-key roving.',
    install: 'dashcn add navigation_bar',
    import:
        "import 'package:<your_app>/ui/dashcn/components/navigation_bar/navigation_bar.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'bottom',
  ),
  DocsComponent(
    id: 'navigation_menu',
    name: 'Navigation Menu',
    category: 'Navigation',
    description:
        'Horizontal navigation bar whose entries open themed popover content on hover or press.',
    install: 'dashcn add navigation_menu',
    import:
        "import 'package:<your_app>/ui/dashcn/components/navigation_menu/navigation_menu.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'top',
  ),
  DocsComponent(
    id: 'pagination',
    name: 'Pagination',
    category: 'Navigation',
    description:
        'Previous/next controls with a clamped window of page buttons.',
    install: 'dashcn add pagination',
    import:
        "import 'package:<your_app>/ui/dashcn/components/pagination/pagination.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'stepper',
    name: 'Stepper',
    category: 'Navigation',
    description:
        'Multi-step flow with numbered indicators and connectors, horizontal or vertical, controlled or controller-driven.',
    install: 'dashcn add stepper',
    import:
        "import 'package:<your_app>/ui/dashcn/components/stepper/stepper.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'top',
  ),
  DocsComponent(
    id: 'tabs',
    name: 'Tabs',
    category: 'Navigation',
    description:
        'Pill tab strip with roving arrow-key navigation, plus a sortable IDE-style tab pane over a content card.',
    install: 'dashcn add tabs',
    import: "import 'package:<your_app>/ui/dashcn/components/tabs/tabs.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'top',
  ),
  DocsComponent(
    id: 'action_sheet',
    name: 'Action Sheet',
    category: 'Overlays',
    description:
        'A bottom sheet of actions with title and message, destructive and cancel actions, icons, scrollable list, drag to dismiss, and a centered dialog variant on wide screens.',
    install: 'dashcn add action_sheet',
    import:
        "import 'package:<your_app>/ui/dashcn/components/action_sheet/action_sheet.dart';",
    fileCount: 6,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'alert_dialog',
    name: 'Alert Dialog',
    category: 'Overlays',
    description:
        'A confirmation dialog with an icon, a title, a description and actions, shown over the whole app.',
    install: 'dashcn add alert_dialog',
    import:
        "import 'package:<your_app>/ui/dashcn/components/alert_dialog/alert_dialog.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'dialog',
    name: 'Dialog',
    category: 'Overlays',
    description: 'Modal dialog route and themed card shell.',
    install: 'dashcn add dialog',
    import:
        "import 'package:<your_app>/ui/dashcn/components/dialog/dialog.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'drawer',
    name: 'Drawer',
    category: 'Overlays',
    description:
        'Modal panel that slides in from a screen edge, plus an expanding sheet variant.',
    install: 'dashcn add drawer',
    import:
        "import 'package:<your_app>/ui/dashcn/components/drawer/drawer.dart';",
    fileCount: 4,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'gooey_toast',
    name: 'Gooey Toast',
    category: 'Overlays',
    description:
        'Gooey-style transient notifications: a compact tab-shaped pill that grows a wider body below it through concave shoulders, anchored to the window edge.',
    install: 'dashcn add gooey_toast',
    import:
        "import 'package:<your_app>/ui/dashcn/components/gooey_toast/gooey_toast.dart';",
    fileCount: 7,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'hover_card',
    name: 'Hover Card',
    category: 'Overlays',
    description:
        'Rich preview card shown while the pointer rests on its child, presented through the popover machinery with themed timing and placement.',
    install: 'dashcn add hover_card',
    import:
        "import 'package:<your_app>/ui/dashcn/components/hover_card/hover_card.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'image_lightbox',
    name: 'Image Lightbox',
    category: 'Overlays',
    description:
        "A full-screen image viewer opened from a thumbnail with a hero-like scale+fade transition. Pinch or scroll to zoom, drag to pan, double-tap to toggle zoom, swipe between images, and close on Escape, the backdrop or the × button. Captions, a counter and a thumbnail strip are optional chrome. Images render through the image component's Picture.",
    install: 'dashcn add image_lightbox',
    import:
        "import 'package:<your_app>/ui/dashcn/components/image_lightbox/image_lightbox.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'popup',
    name: 'Popup',
    category: 'Overlays',
    description:
        "An anchored floating surface for arbitrary content: the menu component's MenuPopup (re-exported) plus showPopup, a generic helper with Escape/outside-tap dismissal.",
    install: 'dashcn add popup',
    import:
        "import 'package:<your_app>/ui/dashcn/components/popup/popup.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'refresh_trigger',
    name: 'Refresh Trigger',
    category: 'Overlays',
    description:
        'Pull-to-refresh wrapper for any scrollable, with a themed indicator pill and programmatic refresh.',
    install: 'dashcn add refresh_trigger',
    import:
        "import 'package:<your_app>/ui/dashcn/components/refresh_trigger/refresh_trigger.dart';",
    fileCount: 5,
    stability: 'stable',
    listed: true,
    placement: 'fill',
  ),
  DocsComponent(
    id: 'tooltip',
    name: 'Tooltip',
    category: 'Overlays',
    description:
        'Delayed hover label presented through the popover machinery, plus the themed TooltipContainer surface and the tooltip overlay handler.',
    install: 'dashcn add tooltip',
    import:
        "import 'package:<your_app>/ui/dashcn/components/tooltip/tooltip.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'audio_player',
    name: 'Audio Player',
    category: 'Typography & Media',
    description:
        'SPEC compact pill and expanded playlist card sharing one dependency-free controller (tracks, shuffle, repeat, speed cycling, volume slider, download).',
    install: 'dashcn add audio_player',
    import:
        "import 'package:<your_app>/ui/dashcn/components/audio_player/audio_player.dart';",
    fileCount: 14,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'code_snippet',
    name: 'Code Snippet',
    category: 'Typography & Media',
    description:
        'Scrollable code block with syntax colouring, copy button and selectable text.',
    install: 'dashcn add code_snippet',
    import:
        "import 'package:<your_app>/ui/dashcn/components/code_snippet/code_snippet.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'image',
    name: 'Image',
    category: 'Typography & Media',
    description:
        'Themed rounded image slot with a placeholder while loading and a caller-supplied error slot on failure.',
    install: 'dashcn add image',
    import:
        "import 'package:<your_app>/ui/dashcn/components/image/image.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'markdown',
    name: 'Markdown',
    category: 'Typography & Media',
    description:
        'Text-only markdown renderer with a dashcn theme, tap callbacks and an image preview overlay.',
    install: 'dashcn add markdown',
    import:
        "import 'package:<your_app>/ui/dashcn/components/markdown/markdown.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'qr_code',
    name: 'Qr Code',
    category: 'Typography & Media',
    description:
        'QR code display for a string or URL with error-correction levels, quiet zone, module shapes and an optional centre logo.',
    install: 'dashcn add qr_code',
    import:
        "import 'package:<your_app>/ui/dashcn/components/qr_code/qr_code.dart';",
    fileCount: 4,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'video_player',
    name: 'Video Player',
    category: 'Typography & Media',
    description:
        'SPEC glass control bar (title header, 10s skips, speed/captions more-menu, auto-hide), 64px centre button, live badge and camera fallback.',
    install: 'dashcn add video_player',
    import:
        "import 'package:<your_app>/ui/dashcn/components/video_player/video_player.dart';",
    fileCount: 13,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'alpha',
    name: 'Alpha',
    category: 'Utilities (building blocks)',
    description: 'Checkerboard painter for transparency indicators.',
    install: 'dashcn add alpha',
    import:
        "import 'package:<your_app>/ui/dashcn/components/alpha/alpha.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'anchor',
    name: 'Anchor',
    category: 'Utilities (building blocks)',
    description:
        'Describes the point an overlay positions itself against and tracks it while it moves.',
    install: 'dashcn add anchor',
    import:
        "import 'package:<your_app>/ui/dashcn/components/anchor/anchor.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'app',
    name: 'App',
    category: 'Utilities (building blocks)',
    description:
        'App shell over WidgetsApp that installs Theme, ComponentThemes, the overlay manager and dashcn localizations, plus the default text/icon scope.',
    install: 'dashcn add app',
    import: "import 'package:<your_app>/ui/dashcn/components/app/app.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: false,
    placement: 'fill',
  ),
  DocsComponent(
    id: 'async',
    name: 'Async',
    category: 'Utilities (building blocks)',
    description:
        'Renders a value that may already be available or may still be loading through one builder.',
    install: 'dashcn add async',
    import:
        "import 'package:<your_app>/ui/dashcn/components/async/async.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'backdrop_transform',
    name: 'Backdrop Transform',
    category: 'Utilities (building blocks)',
    description:
        'Strategy describing how the content behind a sheet or drawer is transformed while it opens.',
    install: 'dashcn add backdrop_transform',
    import:
        "import 'package:<your_app>/ui/dashcn/components/backdrop_transform/backdrop_transform.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'color',
    name: 'Color',
    category: 'Utilities (building blocks)',
    description:
        'The ColorDerivative colour model shared by the colour components: space-preserving RGB/HSV/HSL edits and hex parsing.',
    install: 'dashcn add color',
    import:
        "import 'package:<your_app>/ui/dashcn/components/color/color.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'color_field',
    name: 'Color Field',
    category: 'Utilities (building blocks)',
    description:
        'Custom-painted HSV/HSL gradient area with an optional transparency checkerboard and a themed ring.',
    install: 'dashcn add color_field',
    import:
        "import 'package:<your_app>/ui/dashcn/components/color_field/color_field.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'color_input',
    name: 'Color Input',
    category: 'Utilities (building blocks)',
    description:
        'Compact colour field: a colour well plus an editable hex text input that opens the full color_picker in a popover (desktop) or dialog.',
    install: 'dashcn add color_input',
    import:
        "import 'package:<your_app>/ui/dashcn/components/color_input/color_input.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'drawer_container',
    name: 'Drawer Container',
    category: 'Utilities (building blocks)',
    description:
        'Reusable drawer/sheet chrome (edge border, outer corners, drag handle, barrier wash) for pinned sheets and drawer overlays.',
    install: 'dashcn add drawer_container',
    import:
        "import 'package:<your_app>/ui/dashcn/components/drawer_container/drawer_container.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'error_system',
    name: 'Error System',
    category: 'Utilities (building blocks)',
    description:
        'Structured error models, rule-based mapping, app/screen error channels and the matching UI surfaces.',
    install: 'dashcn add error_system',
    import:
        "import 'package:<your_app>/ui/dashcn/components/error_system/error_system.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: false,
    placement: 'fill',
  ),
  DocsComponent(
    id: 'eye_dropper',
    name: 'Eye Dropper',
    category: 'Utilities (building blocks)',
    description:
        'Samples any pixel of the wrapped subtree with a magnified preview and reports the picked colour (optionally into a colour history).',
    install: 'dashcn add eye_dropper',
    import:
        "import 'package:<your_app>/ui/dashcn/components/eye_dropper/eye_dropper.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'formatter',
    name: 'Formatter',
    category: 'Utilities (building blocks)',
    description:
        'Reusable text input formatters (uppercase/lowercase, numeric, math, HEX, time) plus selection clipping helpers.',
    install: 'dashcn add formatter',
    import:
        "import 'package:<your_app>/ui/dashcn/components/formatter/formatter.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'group',
    name: 'Group',
    category: 'Utilities (building blocks)',
    description:
        'Absolute-position layout surface that places children at explicit offsets and sizes.',
    install: 'dashcn add group',
    import:
        "import 'package:<your_app>/ui/dashcn/components/group/group.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'history',
    name: 'History',
    category: 'Utilities (building blocks)',
    description: 'Recent-colour storage plus the swatch grid that reuses them.',
    install: 'dashcn add history',
    import:
        "import 'package:<your_app>/ui/dashcn/components/history/history.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'hsl',
    name: 'HSL',
    category: 'Utilities (building blocks)',
    description:
        'Gradient slider that controls hue, saturation, lightness, or alpha for HSL colours.',
    install: 'dashcn add hsl',
    import: "import 'package:<your_app>/ui/dashcn/components/hsl/hsl.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'hsv',
    name: 'HSV',
    category: 'Utilities (building blocks)',
    description:
        'Gradient slider that controls hue, saturation, value, or alpha for HSV colours.',
    install: 'dashcn add hsv',
    import: "import 'package:<your_app>/ui/dashcn/components/hsv/hsv.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'icon',
    name: 'Icon',
    category: 'Utilities (building blocks)',
    description:
        'Theme-driven icon size/colour modifiers and a filled icon container.',
    install: 'dashcn add icon',
    import: "import 'package:<your_app>/ui/dashcn/components/icon/icon.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'locale_utils',
    name: 'Locale Utils',
    category: 'Utilities (building blocks)',
    description:
        'Byte-size formatting against a configurable unit table (decimal, binary or custom).',
    install: 'dashcn add locale_utils',
    import:
        "import 'package:<your_app>/ui/dashcn/components/locale_utils/locale_utils.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'media_query',
    name: 'Media Query',
    category: 'Utilities (building blocks)',
    description:
        'Shows one child while the viewport width is inside a range and another when it is not.',
    install: 'dashcn add media_query',
    import:
        "import 'package:<your_app>/ui/dashcn/components/media_query/media_query.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'multiple_choice',
    name: 'Multiple Choice',
    category: 'Utilities (building blocks)',
    description:
        'Selection scopes for single-choice and multi-choice trees, controlled or controller-driven.',
    install: 'dashcn add multiple_choice',
    import:
        "import 'package:<your_app>/ui/dashcn/components/multiple_choice/multiple_choice.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'outlined_container',
    name: 'Outlined Container',
    category: 'Utilities (building blocks)',
    description:
        'Animated outlined surface with token-derived border, optional translucency and backdrop blur, plus dashed border helpers.',
    install: 'dashcn add outlined_container',
    import:
        "import 'package:<your_app>/ui/dashcn/components/outlined_container/outlined_container.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'overlay_configuration',
    name: 'Overlay Configuration',
    category: 'Utilities (building blocks)',
    description:
        'Describe what overlay to show and how (popover, drawer, sheet, dialog, tooltip) behind one configuration object, plus showOverlay and OverlayController.',
    install: 'dashcn add overlay_configuration',
    import:
        "import 'package:<your_app>/ui/dashcn/components/overlay_configuration/overlay_configuration.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'page_route',
    name: 'Page Route',
    category: 'Utilities (building blocks)',
    description:
        'Widgets-only page route and declarative Page with the dashcn fade + slide transition.',
    install: 'dashcn add page_route',
    import:
        "import 'package:<your_app>/ui/dashcn/components/page_route/page_route.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'patch',
    name: 'Patch',
    category: 'Utilities (building blocks)',
    description:
        'Counts consecutive taps inside a time and distance window for double/triple-click gestures.',
    install: 'dashcn add patch',
    import:
        "import 'package:<your_app>/ui/dashcn/components/patch/patch.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'scrollable',
    name: 'Scrollable',
    category: 'Utilities (building blocks)',
    description:
        'Notification-driven edge-fade viewport for any scrollable subtree.',
    install: 'dashcn add scrollable',
    import:
        "import 'package:<your_app>/ui/dashcn/components/scrollable/scrollable.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: false,
    placement: 'fill',
  ),
  DocsComponent(
    id: 'scrollable_client',
    name: 'Scrollable Client',
    category: 'Utilities (building blocks)',
    description:
        'Two-dimensional scroll surface with a builder that receives the current offset and viewport size.',
    install: 'dashcn add scrollable_client',
    import:
        "import 'package:<your_app>/ui/dashcn/components/scrollable_client/scrollable_client.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: false,
    placement: 'fill',
  ),
  DocsComponent(
    id: 'scrollview',
    name: 'Scrollview',
    category: 'Utilities (building blocks)',
    description:
        'Middle-button drag-to-scroll interceptor for desktop and web pointer devices.',
    install: 'dashcn add scrollview',
    import:
        "import 'package:<your_app>/ui/dashcn/components/scrollview/scrollview.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: false,
    placement: 'fill',
  ),
  DocsComponent(
    id: 'selectable',
    name: 'Selectable',
    category: 'Utilities (building blocks)',
    description:
        'Read-only selectable text with widgets-only selection controls.',
    install: 'dashcn add selectable',
    import:
        "import 'package:<your_app>/ui/dashcn/components/selectable/selectable.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'spell_check_suggestions_toolbar',
    name: 'Spell Check Suggestions Toolbar',
    category: 'Utilities (building blocks)',
    description:
        'Menu-backed toolbar for the spell check replacements of the misspelled word under an editable text cursor: up to three suggestion rows in the menu popup surface.',
    install: 'dashcn add spell_check_suggestions_toolbar',
    import:
        "import 'package:<your_app>/ui/dashcn/components/spell_check_suggestions_toolbar/spell_check_suggestions_toolbar.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'stage_container',
    name: 'Stage Container',
    category: 'Utilities (building blocks)',
    description:
        'Responsive container that snaps content to breakpoint widths.',
    install: 'dashcn add stage_container',
    import:
        "import 'package:<your_app>/ui/dashcn/components/stage_container/stage_container.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: false,
    placement: 'fill',
  ),
  DocsComponent(
    id: 'swipe_actions',
    name: 'Swipe Actions',
    category: 'Utilities (building blocks)',
    description:
        'Swipe a row to reveal trailing actions; dismiss-to-delete; RTL-aware with a keyboard/semantics alternative.',
    install: 'dashcn add swipe_actions',
    import:
        "import 'package:<your_app>/ui/dashcn/components/swipe_actions/swipe_actions.dart';",
    fileCount: 5,
    stability: 'stable',
    listed: true,
    placement: 'center',
  ),
  DocsComponent(
    id: 'swiper',
    name: 'Swiper',
    category: 'Utilities (building blocks)',
    description: 'Swipe-to-open wrapper that reveals a drawer or sheet panel.',
    install: 'dashcn add swiper',
    import:
        "import 'package:<your_app>/ui/dashcn/components/swiper/swiper.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'switcher',
    name: 'Switcher',
    category: 'Utilities (building blocks)',
    description:
        'Swipeable view that animates between child widgets along a chosen axis.',
    install: 'dashcn add switcher',
    import:
        "import 'package:<your_app>/ui/dashcn/components/switcher/switcher.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'timeline_animation',
    name: 'Timeline Animation',
    category: 'Utilities (building blocks)',
    description:
        "Typed keyframe timeline: turns an AnimationController's 0..1 progress into values segment by segment.",
    install: 'dashcn add timeline_animation',
    import:
        "import 'package:<your_app>/ui/dashcn/components/timeline_animation/timeline_animation.dart';",
    fileCount: 1,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'triple_dots',
    name: 'Triple Dots',
    category: 'Utilities (building blocks)',
    description: 'Row or column of small round dots, used as an ellipsis.',
    install: 'dashcn add triple_dots',
    import:
        "import 'package:<your_app>/ui/dashcn/components/triple_dots/triple_dots.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: false,
    placement: 'center',
  ),
  DocsComponent(
    id: 'window',
    name: 'Window',
    category: 'Utilities (building blocks)',
    description:
        'Desktop-style window frame with drag, resize, maximize, close, z-order, focus and edge snapping, hosted by a WindowNavigator.',
    install: 'dashcn add window',
    import:
        "import 'package:<your_app>/ui/dashcn/components/window/window.dart';",
    fileCount: 3,
    stability: 'stable',
    listed: false,
    placement: 'fill',
  ),
];

/// The 43 theme presets in `themes/index.json` order.
const List<DocsPreset> kPresets = <DocsPreset>[
  DocsPreset(
    id: 'amber-minimal',
    name: 'Amber Minimal',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'amethyst-haze',
    name: 'Amethyst Haze',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'bold-tech',
    name: 'Bold Tech',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'bubblegum',
    name: 'Bubblegum',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'caffeine',
    name: 'Caffeine',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'candyland',
    name: 'Candyland',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'catppuccin',
    name: 'Catppuccin',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(id: 'claude', name: 'Claude', modes: <String>['light', 'dark']),
  DocsPreset(
    id: 'claymorphism',
    name: 'Claymorphism',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'clean-slate',
    name: 'Clean Slate',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'cosmic-night',
    name: 'Cosmic Night',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'cyberpunk',
    name: 'Cyberpunk',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'darkmatter',
    name: 'Darkmatter',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(id: 'doom-64', name: 'Doom 64', modes: <String>['light', 'dark']),
  DocsPreset(
    id: 'elegant-luxury',
    name: 'Elegant Luxury',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'graphite',
    name: 'Graphite',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'kodama-grove',
    name: 'Kodama Grove',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'midnight-bloom',
    name: 'Midnight Bloom',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'mocha-mousse',
    name: 'Mocha Mousse',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'modern-minimal',
    name: 'Modern Minimal',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(id: 'mono', name: 'Mono', modes: <String>['light', 'dark']),
  DocsPreset(id: 'nature', name: 'Nature', modes: <String>['light', 'dark']),
  DocsPreset(
    id: 'neo-brutalism',
    name: 'Neo Brutalism',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(id: 'neutral', name: 'Neutral', modes: <String>['light', 'dark']),
  DocsPreset(
    id: 'northern-lights',
    name: 'Northern Lights',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'notebook',
    name: 'Notebook',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'ocean-breeze',
    name: 'Ocean Breeze',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'pastel-dreams',
    name: 'Pastel Dreams',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'perpetuity',
    name: 'Perpetuity',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'quantum-rose',
    name: 'Quantum Rose',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'retro-arcade',
    name: 'Retro Arcade',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'sage-garden',
    name: 'Sage Garden',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'soft-pop',
    name: 'Soft Pop',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'solar-dusk',
    name: 'Solar Dusk',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'starry-night',
    name: 'Starry Night',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'sunset-horizon',
    name: 'Sunset Horizon',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'supabase',
    name: 'Supabase',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(id: 't3-chat', name: 'T3 Chat', modes: <String>['light', 'dark']),
  DocsPreset(
    id: 'tangerine',
    name: 'Tangerine',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(id: 'twitter', name: 'Twitter', modes: <String>['light', 'dark']),
  DocsPreset(id: 'vercel', name: 'Vercel', modes: <String>['light', 'dark']),
  DocsPreset(
    id: 'vintage-paper',
    name: 'Vintage Paper',
    modes: <String>['light', 'dark'],
  ),
  DocsPreset(
    id: 'violet-bloom',
    name: 'Violet Bloom',
    modes: <String>['light', 'dark'],
  ),
];

/// The 33 global theme tokens in registry declaration order (32 colours, then radius).
const List<DocsThemeToken> kThemeTokens = <DocsThemeToken>[
  DocsThemeToken(name: 'background', cssVar: '--background'),
  DocsThemeToken(name: 'foreground', cssVar: '--foreground'),
  DocsThemeToken(name: 'card', cssVar: '--card'),
  DocsThemeToken(name: 'cardForeground', cssVar: '--card-foreground'),
  DocsThemeToken(name: 'popover', cssVar: '--popover'),
  DocsThemeToken(name: 'popoverForeground', cssVar: '--popover-foreground'),
  DocsThemeToken(name: 'primary', cssVar: '--primary'),
  DocsThemeToken(name: 'primaryForeground', cssVar: '--primary-foreground'),
  DocsThemeToken(name: 'secondary', cssVar: '--secondary'),
  DocsThemeToken(name: 'secondaryForeground', cssVar: '--secondary-foreground'),
  DocsThemeToken(name: 'muted', cssVar: '--muted'),
  DocsThemeToken(name: 'mutedForeground', cssVar: '--muted-foreground'),
  DocsThemeToken(name: 'accent', cssVar: '--accent'),
  DocsThemeToken(name: 'accentForeground', cssVar: '--accent-foreground'),
  DocsThemeToken(name: 'destructive', cssVar: '--destructive'),
  DocsThemeToken(
    name: 'destructiveForeground',
    cssVar: '--destructive-foreground',
  ),
  DocsThemeToken(name: 'border', cssVar: '--border'),
  DocsThemeToken(name: 'input', cssVar: '--input'),
  DocsThemeToken(name: 'ring', cssVar: '--ring'),
  DocsThemeToken(name: 'chart1', cssVar: '--chart-1'),
  DocsThemeToken(name: 'chart2', cssVar: '--chart-2'),
  DocsThemeToken(name: 'chart3', cssVar: '--chart-3'),
  DocsThemeToken(name: 'chart4', cssVar: '--chart-4'),
  DocsThemeToken(name: 'chart5', cssVar: '--chart-5'),
  DocsThemeToken(name: 'sidebar', cssVar: '--sidebar'),
  DocsThemeToken(name: 'sidebarForeground', cssVar: '--sidebar-foreground'),
  DocsThemeToken(name: 'sidebarPrimary', cssVar: '--sidebar-primary'),
  DocsThemeToken(
    name: 'sidebarPrimaryForeground',
    cssVar: '--sidebar-primary-foreground',
  ),
  DocsThemeToken(name: 'sidebarAccent', cssVar: '--sidebar-accent'),
  DocsThemeToken(
    name: 'sidebarAccentForeground',
    cssVar: '--sidebar-accent-foreground',
  ),
  DocsThemeToken(name: 'sidebarBorder', cssVar: '--sidebar-border'),
  DocsThemeToken(name: 'sidebarRing', cssVar: '--sidebar-ring'),
  DocsThemeToken(name: 'radius', cssVar: '--radius'),
];

/// All 132 components as index-grid links, alphabetical by name.
const List<DocsComponentLink> kComponentLinks = <DocsComponentLink>[
  DocsComponentLink(id: 'accordion', name: 'Accordion'),
  DocsComponentLink(id: 'action_sheet', name: 'Action Sheet'),
  DocsComponentLink(id: 'alert', name: 'Alert'),
  DocsComponentLink(id: 'alert_dialog', name: 'Alert Dialog'),
  DocsComponentLink(id: 'alpha', name: 'Alpha'),
  DocsComponentLink(id: 'anchor', name: 'Anchor'),
  DocsComponentLink(id: 'app', name: 'App'),
  DocsComponentLink(id: 'async', name: 'Async'),
  DocsComponentLink(id: 'audio_player', name: 'Audio Player'),
  DocsComponentLink(id: 'autocomplete', name: 'Autocomplete'),
  DocsComponentLink(id: 'avatar', name: 'Avatar'),
  DocsComponentLink(id: 'backdrop_transform', name: 'Backdrop Transform'),
  DocsComponentLink(id: 'badge', name: 'Badge'),
  DocsComponentLink(id: 'border_loading', name: 'Border Loading'),
  DocsComponentLink(id: 'breadcrumb', name: 'Breadcrumb'),
  DocsComponentLink(id: 'button', name: 'Button'),
  DocsComponentLink(id: 'calendar', name: 'Calendar'),
  DocsComponentLink(id: 'card', name: 'Card'),
  DocsComponentLink(id: 'card_image', name: 'Card Image'),
  DocsComponentLink(id: 'carousel', name: 'Carousel'),
  DocsComponentLink(id: 'chart', name: 'Chart'),
  DocsComponentLink(id: 'chat', name: 'Chat'),
  DocsComponentLink(id: 'checkbox', name: 'Checkbox'),
  DocsComponentLink(id: 'chip', name: 'Chip'),
  DocsComponentLink(id: 'chip_input', name: 'Chip Input'),
  DocsComponentLink(id: 'code_snippet', name: 'Code Snippet'),
  DocsComponentLink(id: 'collapsible', name: 'Collapsible'),
  DocsComponentLink(id: 'color', name: 'Color'),
  DocsComponentLink(id: 'color_field', name: 'Color Field'),
  DocsComponentLink(id: 'color_input', name: 'Color Input'),
  DocsComponentLink(id: 'color_picker', name: 'Color Picker'),
  DocsComponentLink(id: 'command', name: 'Command'),
  DocsComponentLink(id: 'context_menu', name: 'Context Menu'),
  DocsComponentLink(id: 'country_flag', name: 'Country Flag'),
  DocsComponentLink(id: 'date_picker', name: 'Date Picker'),
  DocsComponentLink(id: 'dialog', name: 'Dialog'),
  DocsComponentLink(id: 'divider', name: 'Divider'),
  DocsComponentLink(id: 'dot_indicator', name: 'Dot Indicator'),
  DocsComponentLink(id: 'drawer', name: 'Drawer'),
  DocsComponentLink(id: 'drawer_container', name: 'Drawer Container'),
  DocsComponentLink(id: 'dropdown_menu', name: 'Dropdown Menu'),
  DocsComponentLink(id: 'dropzone', name: 'Dropzone'),
  DocsComponentLink(id: 'empty_state', name: 'Empty State'),
  DocsComponentLink(id: 'error_system', name: 'Error System'),
  DocsComponentLink(id: 'eye_dropper', name: 'Eye Dropper'),
  DocsComponentLink(id: 'fab', name: 'Fab'),
  DocsComponentLink(id: 'feature_carousel', name: 'Feature Carousel'),
  DocsComponentLink(id: 'file_diff_viewer', name: 'File Diff Viewer'),
  DocsComponentLink(id: 'file_picker', name: 'File Picker'),
  DocsComponentLink(id: 'filter_bar', name: 'Filter Bar'),
  DocsComponentLink(id: 'form', name: 'Form'),
  DocsComponentLink(id: 'formatted_input', name: 'Formatted Input'),
  DocsComponentLink(id: 'formatter', name: 'Formatter'),
  DocsComponentLink(id: 'gooey_toast', name: 'Gooey Toast'),
  DocsComponentLink(id: 'group', name: 'Group'),
  DocsComponentLink(id: 'history', name: 'History'),
  DocsComponentLink(id: 'hover_card', name: 'Hover Card'),
  DocsComponentLink(id: 'hsl', name: 'HSL'),
  DocsComponentLink(id: 'hsv', name: 'HSV'),
  DocsComponentLink(id: 'icon', name: 'Icon'),
  DocsComponentLink(id: 'image', name: 'Image'),
  DocsComponentLink(id: 'image_lightbox', name: 'Image Lightbox'),
  DocsComponentLink(id: 'input', name: 'Input'),
  DocsComponentLink(id: 'input_otp', name: 'Input OTP'),
  DocsComponentLink(id: 'item_picker', name: 'Item Picker'),
  DocsComponentLink(id: 'keyboard_shortcut', name: 'Keyboard Shortcut'),
  DocsComponentLink(id: 'list_tile', name: 'List Tile'),
  DocsComponentLink(id: 'locale_utils', name: 'Locale Utils'),
  DocsComponentLink(id: 'markdown', name: 'Markdown'),
  DocsComponentLink(id: 'media_query', name: 'Media Query'),
  DocsComponentLink(id: 'menu', name: 'Menu'),
  DocsComponentLink(id: 'menubar', name: 'Menubar'),
  DocsComponentLink(id: 'multi_select', name: 'Multi Select'),
  DocsComponentLink(id: 'multiple_choice', name: 'Multiple Choice'),
  DocsComponentLink(id: 'navigation_bar', name: 'Navigation Bar'),
  DocsComponentLink(id: 'navigation_menu', name: 'Navigation Menu'),
  DocsComponentLink(id: 'number_ticker', name: 'Number Ticker'),
  DocsComponentLink(id: 'object_input', name: 'Object Input'),
  DocsComponentLink(id: 'outlined_container', name: 'Outlined Container'),
  DocsComponentLink(id: 'overflow_marquee', name: 'Overflow Marquee'),
  DocsComponentLink(id: 'overlay_configuration', name: 'Overlay Configuration'),
  DocsComponentLink(id: 'page_route', name: 'Page Route'),
  DocsComponentLink(id: 'pagination', name: 'Pagination'),
  DocsComponentLink(id: 'patch', name: 'Patch'),
  DocsComponentLink(id: 'phone_input', name: 'Phone Input'),
  DocsComponentLink(id: 'pinned_sheet', name: 'Pinned Sheet'),
  DocsComponentLink(id: 'popup', name: 'Popup'),
  DocsComponentLink(id: 'progress', name: 'Progress'),
  DocsComponentLink(id: 'qr_code', name: 'Qr Code'),
  DocsComponentLink(id: 'radio_group', name: 'Radio Group'),
  DocsComponentLink(id: 'refresh_trigger', name: 'Refresh Trigger'),
  DocsComponentLink(id: 'resizable', name: 'Resizable'),
  DocsComponentLink(id: 'scaffold', name: 'Scaffold'),
  DocsComponentLink(id: 'scrollable', name: 'Scrollable'),
  DocsComponentLink(id: 'scrollable_client', name: 'Scrollable Client'),
  DocsComponentLink(id: 'scrollbar', name: 'Scrollbar'),
  DocsComponentLink(id: 'scrollview', name: 'Scrollview'),
  DocsComponentLink(id: 'search_bar', name: 'Search Bar'),
  DocsComponentLink(id: 'segmented_control', name: 'Segmented Control'),
  DocsComponentLink(id: 'select', name: 'Select'),
  DocsComponentLink(id: 'selectable', name: 'Selectable'),
  DocsComponentLink(id: 'signature_pad', name: 'Signature Pad'),
  DocsComponentLink(id: 'skeleton', name: 'Skeleton'),
  DocsComponentLink(id: 'slider', name: 'Slider'),
  DocsComponentLink(id: 'sortable', name: 'Sortable'),
  DocsComponentLink(
    id: 'spell_check_suggestions_toolbar',
    name: 'Spell Check Suggestions Toolbar',
  ),
  DocsComponentLink(id: 'spinner', name: 'Spinner'),
  DocsComponentLink(id: 'stage_container', name: 'Stage Container'),
  DocsComponentLink(id: 'star_rating', name: 'Star Rating'),
  DocsComponentLink(id: 'stepper', name: 'Stepper'),
  DocsComponentLink(id: 'steps', name: 'Steps'),
  DocsComponentLink(id: 'swipe_actions', name: 'Swipe Actions'),
  DocsComponentLink(id: 'swiper', name: 'Swiper'),
  DocsComponentLink(id: 'switch', name: 'Switch'),
  DocsComponentLink(id: 'switcher', name: 'Switcher'),
  DocsComponentLink(id: 'table', name: 'Table'),
  DocsComponentLink(id: 'tabs', name: 'Tabs'),
  DocsComponentLink(id: 'text_animate', name: 'Text Animate'),
  DocsComponentLink(id: 'text_area', name: 'Text Area'),
  DocsComponentLink(id: 'time_picker', name: 'Time Picker'),
  DocsComponentLink(id: 'timeline', name: 'Timeline'),
  DocsComponentLink(id: 'timeline_animation', name: 'Timeline Animation'),
  DocsComponentLink(id: 'toast', name: 'Toast'),
  DocsComponentLink(id: 'toggle', name: 'Toggle'),
  DocsComponentLink(id: 'toolbar', name: 'Toolbar'),
  DocsComponentLink(id: 'tooltip', name: 'Tooltip'),
  DocsComponentLink(id: 'tracker', name: 'Tracker'),
  DocsComponentLink(id: 'tree', name: 'Tree'),
  DocsComponentLink(id: 'triple_dots', name: 'Triple Dots'),
  DocsComponentLink(id: 'video_player', name: 'Video Player'),
  DocsComponentLink(id: 'wheel_picker', name: 'Wheel Picker'),
  DocsComponentLink(id: 'window', name: 'Window'),
];

/// Catalog categories, count descending then id.
const List<DocsCategory> kCategories = <DocsCategory>[
  DocsCategory(id: 'Utilities (building blocks)', count: 36),
  DocsCategory(id: 'Forms & Inputs', count: 23),
  DocsCategory(id: 'Data Display', count: 19),
  DocsCategory(id: 'Layout', count: 11),
  DocsCategory(id: 'Overlays', count: 10),
  DocsCategory(id: 'Navigation', count: 6),
  DocsCategory(id: 'Typography & Media', count: 6),
  DocsCategory(id: 'Feedback', count: 5),
  DocsCategory(id: 'Menus', count: 5),
  DocsCategory(id: 'Buttons & Actions', count: 4),
  DocsCategory(id: 'Animation & Effects', count: 3),
  DocsCategory(id: 'Date & Time', count: 3),
  DocsCategory(id: 'Color', count: 1),
];

/// Stats band values, each with its derivation.
const DocsStats kStats = DocsStats(
  components: 132, // manifest entries
  listedComponents: 96, // listed only
  presets: 43, // themes/index.json entries
  materialImports: 0, // registry import directives
  modes: 2, // distinct preset modes
);

/// One component category with its listed components.
class DocsComponentCategory {
  /// Creates a category group.
  const DocsComponentCategory({required this.id, required this.components});

  /// Category name as written in `meta.json` (`Forms & Inputs`).
  final String id;

  /// The category's listed components, alphabetical by name.
  final List<DocsComponentLink> components;

  /// Number of listed components in the category.
  int get count => components.length;
}

/// Route slug of a component category (`forms-inputs`).
String componentCategorySlug(String id) {
  return id
      .toLowerCase()
      .replaceAll(RegExp('[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-|-$'), '');
}

/// The 13 component categories with their listed components,
/// count descending then id — the sidebar groups and the index sections.
const List<DocsComponentCategory> kComponentCategoryGroups =
    <DocsComponentCategory>[
      DocsComponentCategory(
        id: 'Forms & Inputs',
        components: <DocsComponentLink>[
          DocsComponentLink(id: 'autocomplete', name: 'Autocomplete'),
          DocsComponentLink(id: 'checkbox', name: 'Checkbox'),
          DocsComponentLink(id: 'chip_input', name: 'Chip Input'),
          DocsComponentLink(id: 'dropzone', name: 'Dropzone'),
          DocsComponentLink(id: 'file_picker', name: 'File Picker'),
          DocsComponentLink(id: 'form', name: 'Form'),
          DocsComponentLink(id: 'formatted_input', name: 'Formatted Input'),
          DocsComponentLink(id: 'input', name: 'Input'),
          DocsComponentLink(id: 'input_otp', name: 'Input OTP'),
          DocsComponentLink(id: 'item_picker', name: 'Item Picker'),
          DocsComponentLink(id: 'multi_select', name: 'Multi Select'),
          DocsComponentLink(id: 'object_input', name: 'Object Input'),
          DocsComponentLink(id: 'phone_input', name: 'Phone Input'),
          DocsComponentLink(id: 'radio_group', name: 'Radio Group'),
          DocsComponentLink(id: 'search_bar', name: 'Search Bar'),
          DocsComponentLink(id: 'segmented_control', name: 'Segmented Control'),
          DocsComponentLink(id: 'select', name: 'Select'),
          DocsComponentLink(id: 'signature_pad', name: 'Signature Pad'),
          DocsComponentLink(id: 'slider', name: 'Slider'),
          DocsComponentLink(id: 'star_rating', name: 'Star Rating'),
          DocsComponentLink(id: 'switch', name: 'Switch'),
          DocsComponentLink(id: 'text_area', name: 'Text Area'),
          DocsComponentLink(id: 'wheel_picker', name: 'Wheel Picker'),
        ],
      ),
      DocsComponentCategory(
        id: 'Data Display',
        components: <DocsComponentLink>[
          DocsComponentLink(id: 'avatar', name: 'Avatar'),
          DocsComponentLink(id: 'badge', name: 'Badge'),
          DocsComponentLink(id: 'carousel', name: 'Carousel'),
          DocsComponentLink(id: 'chat', name: 'Chat'),
          DocsComponentLink(id: 'chip', name: 'Chip'),
          DocsComponentLink(id: 'country_flag', name: 'Country Flag'),
          DocsComponentLink(id: 'divider', name: 'Divider'),
          DocsComponentLink(id: 'empty_state', name: 'Empty State'),
          DocsComponentLink(id: 'feature_carousel', name: 'Feature Carousel'),
          DocsComponentLink(id: 'file_diff_viewer', name: 'File Diff Viewer'),
          DocsComponentLink(id: 'keyboard_shortcut', name: 'Keyboard Shortcut'),
          DocsComponentLink(id: 'list_tile', name: 'List Tile'),
          DocsComponentLink(id: 'number_ticker', name: 'Number Ticker'),
          DocsComponentLink(id: 'pinned_sheet', name: 'Pinned Sheet'),
          DocsComponentLink(id: 'table', name: 'Table'),
          DocsComponentLink(id: 'timeline', name: 'Timeline'),
          DocsComponentLink(id: 'tracker', name: 'Tracker'),
          DocsComponentLink(id: 'tree', name: 'Tree'),
        ],
      ),
      DocsComponentCategory(
        id: 'Layout',
        components: <DocsComponentLink>[
          DocsComponentLink(id: 'accordion', name: 'Accordion'),
          DocsComponentLink(id: 'card', name: 'Card'),
          DocsComponentLink(id: 'card_image', name: 'Card Image'),
          DocsComponentLink(id: 'collapsible', name: 'Collapsible'),
          DocsComponentLink(id: 'filter_bar', name: 'Filter Bar'),
          DocsComponentLink(id: 'overflow_marquee', name: 'Overflow Marquee'),
          DocsComponentLink(id: 'resizable', name: 'Resizable'),
          DocsComponentLink(id: 'scaffold', name: 'Scaffold'),
          DocsComponentLink(id: 'scrollbar', name: 'Scrollbar'),
          DocsComponentLink(id: 'sortable', name: 'Sortable'),
          DocsComponentLink(id: 'steps', name: 'Steps'),
        ],
      ),
      DocsComponentCategory(
        id: 'Overlays',
        components: <DocsComponentLink>[
          DocsComponentLink(id: 'action_sheet', name: 'Action Sheet'),
          DocsComponentLink(id: 'alert_dialog', name: 'Alert Dialog'),
          DocsComponentLink(id: 'dialog', name: 'Dialog'),
          DocsComponentLink(id: 'drawer', name: 'Drawer'),
          DocsComponentLink(id: 'gooey_toast', name: 'Gooey Toast'),
          DocsComponentLink(id: 'hover_card', name: 'Hover Card'),
          DocsComponentLink(id: 'image_lightbox', name: 'Image Lightbox'),
          DocsComponentLink(id: 'popup', name: 'Popup'),
          DocsComponentLink(id: 'refresh_trigger', name: 'Refresh Trigger'),
          DocsComponentLink(id: 'tooltip', name: 'Tooltip'),
        ],
      ),
      DocsComponentCategory(
        id: 'Navigation',
        components: <DocsComponentLink>[
          DocsComponentLink(id: 'breadcrumb', name: 'Breadcrumb'),
          DocsComponentLink(id: 'navigation_bar', name: 'Navigation Bar'),
          DocsComponentLink(id: 'navigation_menu', name: 'Navigation Menu'),
          DocsComponentLink(id: 'pagination', name: 'Pagination'),
          DocsComponentLink(id: 'stepper', name: 'Stepper'),
          DocsComponentLink(id: 'tabs', name: 'Tabs'),
        ],
      ),
      DocsComponentCategory(
        id: 'Typography & Media',
        components: <DocsComponentLink>[
          DocsComponentLink(id: 'audio_player', name: 'Audio Player'),
          DocsComponentLink(id: 'code_snippet', name: 'Code Snippet'),
          DocsComponentLink(id: 'image', name: 'Image'),
          DocsComponentLink(id: 'markdown', name: 'Markdown'),
          DocsComponentLink(id: 'qr_code', name: 'Qr Code'),
          DocsComponentLink(id: 'video_player', name: 'Video Player'),
        ],
      ),
      DocsComponentCategory(
        id: 'Feedback',
        components: <DocsComponentLink>[
          DocsComponentLink(id: 'alert', name: 'Alert'),
          DocsComponentLink(id: 'progress', name: 'Progress'),
          DocsComponentLink(id: 'skeleton', name: 'Skeleton'),
          DocsComponentLink(id: 'spinner', name: 'Spinner'),
          DocsComponentLink(id: 'toast', name: 'Toast'),
        ],
      ),
      DocsComponentCategory(
        id: 'Menus',
        components: <DocsComponentLink>[
          DocsComponentLink(id: 'command', name: 'Command'),
          DocsComponentLink(id: 'context_menu', name: 'Context Menu'),
          DocsComponentLink(id: 'dropdown_menu', name: 'Dropdown Menu'),
          DocsComponentLink(id: 'menu', name: 'Menu'),
          DocsComponentLink(id: 'menubar', name: 'Menubar'),
        ],
      ),
      DocsComponentCategory(
        id: 'Buttons & Actions',
        components: <DocsComponentLink>[
          DocsComponentLink(id: 'button', name: 'Button'),
          DocsComponentLink(id: 'fab', name: 'Fab'),
          DocsComponentLink(id: 'toggle', name: 'Toggle'),
          DocsComponentLink(id: 'toolbar', name: 'Toolbar'),
        ],
      ),
      DocsComponentCategory(
        id: 'Animation & Effects',
        components: <DocsComponentLink>[
          DocsComponentLink(id: 'border_loading', name: 'Border Loading'),
          DocsComponentLink(id: 'dot_indicator', name: 'Dot Indicator'),
          DocsComponentLink(id: 'text_animate', name: 'Text Animate'),
        ],
      ),
      DocsComponentCategory(
        id: 'Date & Time',
        components: <DocsComponentLink>[
          DocsComponentLink(id: 'calendar', name: 'Calendar'),
          DocsComponentLink(id: 'date_picker', name: 'Date Picker'),
          DocsComponentLink(id: 'time_picker', name: 'Time Picker'),
        ],
      ),
      DocsComponentCategory(
        id: 'Color',
        components: <DocsComponentLink>[
          DocsComponentLink(id: 'color_picker', name: 'Color Picker'),
        ],
      ),
      DocsComponentCategory(
        id: 'Utilities (building blocks)',
        components: <DocsComponentLink>[
          DocsComponentLink(id: 'swipe_actions', name: 'Swipe Actions'),
        ],
      ),
    ];
