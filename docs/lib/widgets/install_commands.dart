// Single source of truth for install command strings (P8-4).
//
// Every install surface — the getting-started tabs, the component install
// block and the "Package or own the code?" page — builds its snippets from
// these constants, so the commands can never drift apart.

/// Adds the published package from any Flutter project.
const String kPackageAddCommand = 'flutter pub add dashcn';

/// Barrel import used by package-mode apps.
const String kPackageImport = "import 'package:dashcn/dashcn.dart';";

/// Per-component import keeping builds lean.
String packageComponentImport(String id) =>
    "import 'package:dashcn/components/$id.dart';";

/// Per-flow import of the published package (the hyphenated id maps to the
/// underscored library stem, matching `gen_exports`).
String packageFlowImport(String id) =>
    "import 'package:dashcn/flows/${id.replaceAll('-', '_')}.dart';";

/// Activates the CLI globally (own-the-code mode).
const String kCliActivateCommand = 'dart pub global activate dashcn_cli';

/// Installs the layer core into a project.
const String kInitCommand = 'dashcn init';

/// Copies one component (plus its closure) into the app.
String ownAddCommand(String id) => 'dashcn add $id';

/// Copies one flow (plus its components/blocks closure) into the app.
String ownFlowAddCommand(String id) => 'dashcn add flow:$id';

/// Turns a package-mode component into owned sources.
String ejectCommand(String id) => 'dashcn eject $id';

/// One-line note shown under every install block.
String ejectNote(String id) =>
    'Switch later with `${ejectCommand(id)}` — '
    'turns a package import into owned sources.';

/// Package-tab snippet for one component (add + import).
String packageSnippet(String id) =>
    '$kPackageAddCommand\n${packageComponentImport(id)}';

/// Own-the-code snippet for one component (init + add).
String ownCodeSnippet(String id) => '$kInitCommand\n${ownAddCommand(id)}';

/// Package-tab snippet for one flow (add + per-flow import).
String packageFlowSnippet(String id) =>
    '$kPackageAddCommand\n${packageFlowImport(id)}';

/// Own-the-code snippet for one flow (init + add).
String ownFlowCodeSnippet(String id) =>
    '$kInitCommand\n${ownFlowAddCommand(id)}';

/// Base `create` command for one starter (`dashcn create <id> my_app`).
String starterCreateCommand(String id) => 'dashcn create $id my_app';

/// Package-tab snippet for one starter (own the theme via the package).
String starterPackageSnippet(String id) =>
    '${starterCreateCommand(id)} --mode package';

/// Own-the-code snippet for one starter (copy sources into the app).
String starterCopySnippet(String id) =>
    '${starterCreateCommand(id)} --mode copy';

/// Theme file for package-mode starters (single barrel import).
const String kStarterPackageThemeFile = 'lib/app_theme.dart';

/// Theme file for copy-mode starters (owned sources).
const String kStarterCopyThemeFile = 'lib/ui/dashcn/theme/app_theme.dart';

/// Own-the-code snippet for the getting-started page (full flow).
const String kOwnCodeGettingStarted =
    '$kCliActivateCommand\n$kInitCommand\ndashcn add button';

/// Package snippet for the getting-started page (add + import).
const String kPackageGettingStarted = '$kPackageAddCommand\n$kPackageImport';
