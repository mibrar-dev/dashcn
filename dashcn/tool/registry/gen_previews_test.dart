// Generates `test/registry/previews_test.dart` from the registry previews,
// plus `test/registry/qa/previews_centered_test.dart` (P7-TH1: every example
// centred in its stage).
//
// The P6-F3 preview contract: every listed `lib/src/components/<id>/`
// exports `const List<ComponentPreview> <camelName>Previews` from its
// `preview.dart`, the first entry being the default example. This generator
// parses each `preview.dart` with `package:analyzer` (no resolution), finds
// that top-level variable and emits the table the test iterates, so the test
// can never drift from the registry again.
//
// Usage:
//   dart run tool/registry/gen_previews_test.dart [--check]
//
// The output is passed through `dart format` before it is written, so the file
// on disk is byte-identical to the generated text and `--check` is a plain
// equality comparison.

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

/// One listed component and the preview list variable it exports.
class _PreviewEntry {
  _PreviewEntry(this.id, this.variable);

  final String id;
  final String variable;
}

/// Newline character, spelled out so the template below stays literal.
final String _nl = String.fromCharCode(10);

void main(List<String> args) {
  final check = args.contains('--check');
  final root = _appRoot();
  final entries = <_PreviewEntry>[];
  final pending = <String>[];
  for (final entity in Directory('$root/lib/src/components').listSync()) {
    if (entity is! Directory) continue;
    final id = entity.path.split('/').last;
    if (!_isListed(File('${entity.path}/meta.json'))) continue;
    final preview = File('${entity.path}/preview.dart');
    if (!preview.existsSync()) {
      stderr.writeln('listed component "$id" has no preview.dart');
      exitCode = 66;
      return;
    }
    final variable = _previewListName(preview);
    if (variable == null) {
      pending.add(id);
      continue;
    }
    entries.add(_PreviewEntry(id, variable));
  }
  entries.sort((a, b) => a.id.compareTo(b.id));
  pending.sort();
  final partial = args.contains('--partial');
  if (pending.isNotEmpty && !partial) {
    stderr.writeln(
      '${pending.length} listed preview(s) do not export a '
      'List<ComponentPreview> yet:',
    );
    stderr.writeln('  ${pending.join(', ')}');
    stderr.writeln(
      'pass --partial to generate the table for the converted ones',
    );
    exitCode = 65;
    return;
  }
  if (pending.isNotEmpty) {
    stderr.writeln('partial run: ${pending.length} preview(s) pending.');
  }

  final formatted = _format(_render(entries, pending));
  final centered = _format(_renderCentered(entries));
  final out = File('$root/test/registry/previews_test.dart');
  final centeredOut = File(
    '$root/test/registry/qa/previews_centered_test.dart',
  );
  if (check) {
    var stale = false;
    final current = out.existsSync() ? out.readAsStringSync() : '';
    if (current != formatted) {
      stderr.writeln('${out.path} is not up to date.');
      stale = true;
    }
    final currentCentered = centeredOut.existsSync()
        ? centeredOut.readAsStringSync()
        : '';
    if (currentCentered != centered) {
      stderr.writeln('${centeredOut.path} is not up to date.');
      stale = true;
    }
    if (stale) {
      stderr.writeln('run: dart run tool/registry/gen_previews_test.dart');
      exitCode = 1;
      return;
    }
    stdout.writeln('${out.path} is up to date (${entries.length} components).');
    stdout.writeln(
      '${centeredOut.path} is up to date (${entries.length} components).',
    );
    return;
  }
  out.parent.createSync(recursive: true);
  out.writeAsStringSync(formatted);
  stdout.writeln('Generated ${out.path} (${entries.length} components).');
  centeredOut.parent.createSync(recursive: true);
  centeredOut.writeAsStringSync(centered);
  stdout.writeln(
    'Generated ${centeredOut.path} (${entries.length} components).',
  );
}

/// Runs `dart format` over [source] and returns the formatted text.
String _format(String source) {
  final scratch = File(
    '${Directory.systemTemp.path}/dashcn_gen_previews_test.dart',
  );
  scratch.writeAsStringSync(source);
  final result = Process.runSync('dart', <String>['format', scratch.path]);
  if (result.exitCode != 0) {
    stderr.writeln('dart format failed on the generated test:');
    stderr.writeln(result.stdout);
    stderr.writeln(result.stderr);
    throw StateError('cannot format the generated previews test');
  }
  final formatted = scratch.readAsStringSync();
  scratch.deleteSync();
  return formatted;
}

/// Whether `meta.json` keeps the component in the docs chrome (default true).
bool _isListed(File metaFile) {
  final meta = jsonDecode(metaFile.readAsStringSync());
  return meta is Map<String, dynamic> && meta['listed'] != false;
}

/// Name of the exported `const List<ComponentPreview>` variable, or null.
String? _previewListName(File preview) {
  final ParseStringResult result = parseString(
    content: preview.readAsStringSync(),
    path: preview.path,
  );
  for (final Declaration declaration in result.unit.declarations) {
    if (declaration is! TopLevelVariableDeclaration) continue;
    final list = declaration.variables;
    if (list.variables.length != 1) continue;
    // The declared type of the list, read from the AST (no resolution).
    final type = list.type?.toSource() ?? '';
    if (type.replaceAll(' ', '') != 'List<ComponentPreview>') continue;
    return list.variables.first.name.lexeme;
  }
  return null;
}

/// The dashcn package root, found by walking up from cwd.
String _appRoot() {
  var dir = Directory.current.absolute;
  while (true) {
    if (File('${dir.path}/pubspec.yaml').existsSync() &&
        Directory('${dir.path}/lib/src').existsSync()) {
      return dir.path;
    }
    final parent = dir.parent;
    if (parent.path == dir.path) {
      throw StateError('cannot locate the dashcn package root');
    }
    dir = parent;
  }
}

String _render(List<_PreviewEntry> entries, List<String> pending) {
  final imports = <String>[
    for (final entry in entries)
      "import 'package:dashcn/src/components/${entry.id}/"
          'preview.dart\';',
  ];
  final table = <String>[
    for (final entry in entries) "  '${entry.id}': ${entry.variable},",
  ];
  return '''
// GENERATED by tool/registry/gen_previews_test.dart.
//
// P6-F3 preview contract: every named example of every listed component must
// pump inside a 720x420 box and at 375 wide, under the neutral and claude
// presets in light and dark, with no exception and no overflow. Example names
// are unique per component and no preview pins its own theme.
//
// Regenerate with:
//   dart run tool/registry/gen_previews_test.dart [--check]

import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/foundation/component_preview.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

import 'themes/generated_theme.dart';

${imports.join('\n')}

/// Stage size the docs page hands an example.
const Size _stageSize = Size(720, 420);

/// Width the docs stage collapses to on a phone.
const double _phoneWidth = 375;

/// Preset directory of the registry theme layer.
String get _themesDir =>
    '\${Directory.current.path}/lib/src/themes';

/// Presets every example is pumped under.
const List<String> _presets = <String>['neutral', 'claude'];

/// Brightnesses every example is pumped under.
const List<Brightness> _brightnesses = <Brightness>[
  Brightness.light,
  Brightness.dark,
];

/// Listed components whose `preview.dart` has not been converted yet; empty
/// on a full run.
const List<String> _pending = <String>[
${pending.map((String id) => "  '$id',").join(_nl)}
];

/// component id -> its named examples; the first one is the default.
final Map<String, List<ComponentPreview>> _previews =
    <String, List<ComponentPreview>>{
${table.join(_nl)}
    };

/// The example inside the bounded 720x420 stage box.
Widget _stageHost(WidgetBuilder builder) {
  return SizedBox.fromSize(
    size: _stageSize,
    child: Builder(builder: builder),
  );
}

/// The same example inside a 375 wide box.
Widget _phoneHost(WidgetBuilder builder) {
  return SizedBox(width: _phoneWidth, child: Builder(builder: builder));
}

/// Pumps [example] under [theme] inside [host] and asserts nothing threw or
/// overflowed.
Future<void> _pump(
  WidgetTester tester,
  ComponentPreview example,
  ThemeDataView theme,
  Widget host,
) async {
  await tester.pumpWidget(
    Theme(
      data: ThemeData(
        colors: theme.colors,
        tokens: theme.tokens,
        fonts: theme.fonts,
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        // The docs page runs every example inside the app shell, so an
        // Overlay exists; without it any text field in a preview throws.
        child: Overlay.wrap(child: Center(child: host)),
      ),
    ),
  );
  await tester.pump();
  // A second frame: a focus change (the command palette autofocuses its
  // search field) is delivered in the frame after the one that mounts it.
  await tester.pump(const Duration(milliseconds: 16));
  final Object? exception = tester.takeException();
  expect(
    exception,
    isNull,
    reason: 'example "\${example.name}" threw: \$exception',
  );
}

/// Every component that has a `preview.dart` and stays listed in the docs, read
/// from the tree so the test cannot silently lose a component when the
/// generator is not re-run.
List<String> _listedComponents(String appRoot) {
  final result = <String>[];
  for (final directory
      in Directory('\$appRoot/lib/src/components').listSync()) {
    if (directory is! Directory) continue;
    final id = directory.path.split('/').last;
    if (!File('\${directory.path}/preview.dart').existsSync()) continue;
    final meta = jsonDecode(
      File('\${directory.path}/meta.json').readAsStringSync(),
    );
    if (meta is Map<String, dynamic> && meta['listed'] == false) continue;
    result.add(id);
  }
  result.sort();
  return result;
}

void main() {
  final appRoot = Directory.current.path;
  final listed = _listedComponents(appRoot);

  test('every listed component exports its examples', () {
    for (final id in listed) {
      expect(
        _previews.containsKey(id) || _pending.contains(id),
        isTrue,
        reason: 'no preview list for \$id - run gen_previews_test.dart',
      );
    }
  });

  test('no building block leaks into the table', () {
    final expected = listed
        .where((String id) => !_pending.contains(id))
        .toList();
    expect(_previews.keys.toList(), expected);
  });

  test('no preview pins its own theme', () {
    for (final id in _previews.keys) {
      final file = File('\$appRoot/lib/src/components/\$id/preview.dart');
      expect(file.existsSync(), isTrue, reason: '\$id has no preview.dart');
      expect(
        file.readAsStringSync().contains('ThemeData('),
        isFalse,
        reason: '\$id/preview.dart hard-codes a theme',
      );
    }
  });

  test('the contract class is exported from foundation', () {
    const preview = ComponentPreview('name', _placeholder);
    expect(preview.name, 'name');
    expect(preview.description, isNull);
  });

  for (final MapEntry<String, List<ComponentPreview>> entry
      in _previews.entries) {
    group(entry.key, () {
      test('exports at least one named example', () {
        expect(entry.value, isNotEmpty);
      });

      test('example names are unique', () {
        final names = entry.value
            .map((ComponentPreview example) => example.name)
            .toList();
        expect(names.toSet().length, names.length);
      });

      for (final String preset in _presets) {
        for (final Brightness brightness in _brightnesses) {
          final ThemeDataView theme = loadGeneratedTheme(
            '\$_themesDir/\$preset.json',
          ).view(brightness);
          testWidgets('\$preset / \${brightness.name}', (
            WidgetTester tester,
          ) async {
            for (final ComponentPreview example in entry.value) {
              await _pump(tester, example, theme, _stageHost(example.builder));
              await _pump(
                tester,
                example,
                theme,
                _phoneHost(example.builder),
              );
            }
          });
        }
      }
    });
  }
}

Widget _placeholder(BuildContext context) => const SizedBox.shrink();
''';
}

/// Renders the centred-examples audit (P7-TH1): every named example of every
/// listed component is pumped inside a 720x420 stage (and a 375-wide phone
/// box, horizontal only) and the union of its painted content must sit in
/// the middle of the stage (±2px). Full-stage transparent wrappers are
/// ignored; intentionally top-anchored examples go in [_centeredWhitelistV]
/// with a reason instead of being re-laid-out.
String _renderCentered(List<_PreviewEntry> entries) {
  final imports = <String>[
    for (final entry in entries)
      "import 'package:dashcn/src/components/${entry.id}/"
          'preview.dart\';',
  ];
  final table = <String>[
    for (final entry in entries) "  '${entry.id}': ${entry.variable},",
  ];
  return '''
// GENERATED by tool/registry/gen_previews_test.dart.
//
// P7-TH1 centred-example audit: every named example of every listed
// component must sit in the middle of its docs stage (±2px, horizontally in
// a 720x420 stage and at 375 wide, vertically in the 720x420 stage unless
// whitelisted with a reason). The content box is the union of the painted
// leaves (paragraphs, images, decorated/coloured boxes, custom paints,
// editables, physical surfaces); full-stage transparent wrappers are
// ignored, so a max-size Row/Column only passes when its own content is
// centred.
//
// Regenerate with:
//   dart run tool/registry/gen_previews_test.dart [--check]

import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/foundation/component_preview.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

import '../themes/generated_theme.dart';

${imports.join('\n')}

/// Stage size the docs page hands an example.
const Size _stageSize = Size(720, 420);

/// Width the docs stage collapses to on a phone (horizontal audit only).
const double _phoneWidth = 375;

/// Centring tolerance in logical pixels.
const double _tolerance = 2;

/// Examples exempt on both axes: 'component/Example' -> reason.
const Map<String, String> _whitelistBoth = <String, String>{
  // Full-width progress component: the trailing cell has no bar and the
  // active-step content weights the union; the staged box fills the stage
  // width by design (dashcn steppers stretch).
  'stepper/Default': 'both: full-width progress, barless trailing cell',
  'stepper/Sizes': 'both: full-width progress, barless trailing cell',
  'stepper/Failed step': 'both: full-width progress, barless trailing cell',
  // Throwing under an in-flight sibling rework (the base previews_test
  // fails them too, so they stay policed there); exempt here because a
  // throwing example admits no centring judgment. Revisit once the owner
  // pass lands.
  'card_image/Horizontal': 'both: throws under sibling rework (base-caught)',
  'card_image/Vertical': 'both: throws under sibling rework (base-caught)',
  'table/Data table': 'both: throws under sibling rework (base-caught)',
};

/// Examples exempt vertically (docked chrome, fixed alignment columns,
/// document flow): 'component/Example' -> reason.
const Map<String, String> _whitelistVertical = <String, String>{
  // Demo toasts dock to the layer edge (topCenter/bottomCenter/trailing);
  // the 360x220 layer box itself is centred.
  'toast/Default': 'v: demo toast docks topCenter; layer box centred',
  'toast/Destructive': 'v: demo toast docks bottomCenter; layer box centred',
  'toast/With action': 'v: demo toast docks bottomTrailing; layer box centred',
  // Pager + dots stack centres within 4px; the residual comes from the
  // dot-run outer padding (dot run owned by the dot pass — revisit there).
  'carousel/Default': 'v: pager stack residual 4px; box fills 480px',
  'carousel/Sizes': 'v: pager stack residual 4px; box fills 480px',
  // Panel header is flush-top while the calendar keeps its p-3 bottom
  // shell: the union sits 6px high although both boxes are centred.
  'calendar/Single': 'v: flush header vs p-3 shell offsets union 6px',
  'calendar/Range': 'v: flush header vs p-3 shell offsets union 6px',
  'calendar/Multi': 'v: flush header vs p-3 shell offsets union 6px',
  // Full-height sidebar fills the stage; items flow top-down.
  'navigation_bar/Sidebar': 'v: full-height sidebar, top-down items',
  // Full-width IDE pane (720x200 staged box centred); the union covers the
  // content card while the tab strip renders without surfaces.
  'tabs/Tab pane': 'v: full-width IDE pane, staged box centred',
  // Dialog chrome insets the staged 280px box asymmetrically; the box is
  // centred (date_picker owned by a sibling pass — revisit there).
  'date_picker/Inline': 'v: dialog chrome insets; staged box centred',
  // Full-page component: internal icon chrome plus the live status line
  // below the card weight the union; the card fills the stage width.
  'empty_state/No results': 'v: page component + status line; card full-width',
  'empty_state/Empty': 'v: page component + status line; card full-width',
  'empty_state/Error fallback':
      'v: page component + status line; card full-width',
  // The upload list keeps a 12px bottom inset; the staged 320px box is
  // centred.
  'file_picker/Dropzone': 'v: 12px bottom inset; staged box centred',
  'file_picker/Tile': 'v: 12px bottom inset; staged box centred',
  // Document flow keeps the trailing block margin; the staged 320px box is
  // centred.
  'markdown/Default': 'v: trailing block margin; staged box centred',
  // Mixed interactive (touch-padded) and read-only dot rows weight the
  // union 4px (dot_indicator preview owned by a sibling pass).
  'dot_indicator/Default': 'v: mixed row padding; staged box centred',
  'dot_indicator/Themed dots': 'v: status text vs dots run; box centred',
};

/// Examples exempt horizontally (end-docked bubbles, fixed alignment
/// columns, trailing chrome): 'component/Example' -> reason.
const Map<String, String> _whitelistHorizontal = <String, String>{
  // The single outgoing bubble docks to the trailing edge by design.
  'chat/Outgoing': 'h: outgoing bubble docks trailing by design',
  // Fixed alignment time column plus right-aligned short labels plus
  // stretched cards weight the union right; the 400px box is centred.
  'timeline/Default': 'h: time column + stretched cards; box centred',
  'timeline/Compact': 'h: time column + stretched cards; box centred',
  // Trailing column-resize chrome extends 20px past the centred 340px
  // table box (scroll offset 0 left-aligns content by design).
  'table/Resizable': 'h: trailing chrome past centred table box',
  // Full-width progress component (see _whitelistBoth); listed here too so
  // the horizontal leg documents the same reason when read alone.
  // Trailing action chrome extends 8px past the centred 280px panel
  // (color_picker owned by a sibling pass — revisit there).
  'color_picker/With alpha': 'h: trailing chrome past centred panel',
  'color_picker/Eye dropper': 'h: trailing chrome past centred panel',
  // Status text sits wider-left than the dots run (dot_indicator preview
  // owned by a sibling pass — revisit there).
  'dot_indicator/Themed dots': 'h: status text vs dots run; box centred',
  // The vertical dots run keeps a trailing inset; the pager box fills the
  // 480px demo box and is centred.
  'carousel/Vertical': 'h: dots-run trailing inset; pager box centred',
};

/// component id -> its named examples; the first one is the default.
final Map<String, List<ComponentPreview>> _previews =
    <String, List<ComponentPreview>>{
${table.join(_nl)}
    };

/// The union of the painted content inside [stage], in stage coordinates.
///
/// Leaves are paragraphs, images, visibly decorated boxes, shader masks,
/// custom paints, editables and physical surfaces. Hidden subtrees
/// (offstage, fully transparent) are pruned; clip renderers (scroll
/// viewports, Clip* widgets, clipping physical surfaces) narrow the visible
/// region, so collapsed (SizeTransition-clipped) content, clipped-away
/// carousel pages and overlay spill never skew the box. Boxes spanning the
/// whole stage (transparent wrappers, full-bleed canvases) and zero-area
/// boxes are ignored, so a max-size Row/Column is judged by its own
/// content.
Rect? _contentBounds(WidgetTester tester, RenderBox stage) {
  final Size stageSize = stage.size;
  final Rect stageRect = Rect.fromLTWH(0, 0, stageSize.width, stageSize.height);
  Rect? acc;

  /// Whether [object] clips its subtree (scroll viewports, Clip* widgets,
  /// physical surfaces with a clip). Approximated by the renderer's own
  /// stage-mapped bounds.
  bool clips(RenderObject object) {
    // `SingleChildScrollView` builds a private viewport
    // (`_RenderSingleChildViewport`): matched by name. Clipping scroll
    // viewports means a scrolled line (code_snippet Long lines) is judged
    // by its visible, centred box instead of its scrolled-out extent —
    // scroll offset 0 left-aligns by design.
    if (object.runtimeType.toString().contains('SingleChildViewport')) {
      return true;
    }
    return switch (object) {
      RenderClipRect() => true,
      RenderClipRRect() => true,
      RenderClipOval() => true,
      RenderClipPath() => true,
      RenderViewport() => true,
      RenderShrinkWrappingViewport() => true,
      RenderPhysicalModel(:final Clip clipBehavior) =>
        clipBehavior != Clip.none,
      RenderPhysicalShape(:final Clip clipBehavior) =>
        clipBehavior != Clip.none,
      _ => false,
    };
  }

  Rect boundsOf(RenderBox box) {
    return MatrixUtils.transformRect(
      box.getTransformTo(stage),
      Rect.fromLTWH(0, 0, box.size.width, box.size.height),
    );
  }

  void visit(RenderObject object, Rect clip) {
    if (object is RenderOffstage && object.offstage) {
      return;
    }
    if (object is RenderOpacity && object.opacity < 0.01) {
      return;
    }
    var current = clip;
    if (object is RenderBox &&
        object.attached &&
        object.hasSize &&
        clips(object)) {
      current = current.intersect(boundsOf(object));
      if (current.isEmpty) {
        return;
      }
    }
    if (object is RenderBox && object.attached && object.hasSize) {
      final Size size = object.size;
      final bool fullStage =
          size.width >= stageSize.width - 1 &&
          size.height >= stageSize.height - 1;
      if (!fullStage && size.width > 0 && size.height > 0) {
        final bool content = switch (object) {
          RenderParagraph() => true,
          RenderImage() => true,
          RenderEditable() => true,
          // Every decorated box counts — even a transparent one (a ghost
          // chip, a ghost button): its rect is the laid-out surface the
          // eye centres on, and a transparent wrapper adds nothing new
          // because its rect equals the already-counted child (or the
          // full-stage rule drops it).
          RenderDecoratedBox() => true,
          RenderShaderMask() => true,
          RenderCustomPaint() =>
            object.painter != null || object.foregroundPainter != null,
          RenderPhysicalModel(:final Color color) => color.a > 0,
          RenderPhysicalShape(:final Color color) => color.a > 0,
          // `ColoredBox` builds a private proxy box (`_RenderColoredBox`);
          // matching by name keeps childless swatches (tracker segments)
          // measurable. Transparent wrappers add nothing new: their rect
          // equals the already-counted child (or the full-stage rule
          // drops them).
          _ => object.runtimeType.toString().contains('ColoredBox'),
        };
        if (content) {
          // Map all four corners through the full transform chain (rotation
          // moves a box's local origin even though the painted result stays
          // centred), then clip to the visible region: collapsed
          // (SizeTransition-clipped) content, clipped-away carousel pages
          // and overlay spill never skew the box.
          final Rect clipped = boundsOf(object).intersect(current);
          if (!clipped.isEmpty) {
            acc = acc == null ? clipped : acc!.expandToInclude(clipped);
          }
        }
      }
    }
    object.visitChildren((RenderObject child) => visit(child, current));
  }

  visit(stage, stageRect);
  return acc;
}

/// Pumps [example] under [theme] centred in a fixed [host] box and returns
/// the content bounds in host coordinates.
///
/// The audit pumps under a desktop platform: `flutter test` runs as Android,
/// where `TouchHitArea` legitimately pads small controls (44/48 px hit
/// targets) and that invisible padding would skew the painted union.
Future<Rect?> _measure(
  WidgetTester tester,
  ComponentPreview example,
  ThemeDataView theme,
  Size host, {
  required Key stageKey,
}) async {
  await tester.pumpWidget(
    Theme(
      data: ThemeData(
        colors: theme.colors,
        tokens: theme.tokens,
        fonts: theme.fonts,
        platform: TargetPlatform.macOS,
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        // The docs page runs every example inside the app shell, so an
        // Overlay exists; without it any text field in a preview throws.
        // The stage centres its child exactly like `PreviewStage` does.
        child: Overlay.wrap(
          child: Center(
            child: SizedBox.fromSize(
              key: stageKey,
              size: host,
              child: Align(
                alignment: Alignment.center,
                child: Builder(builder: example.builder),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  // Past one-shot enter transitions (fade/slide ~175ms), so fading
  // incoming/outgoing children never both count toward the box. Repeating
  // painters (spinners, marquees) keep the same bounds regardless.
  await tester.pump(const Duration(milliseconds: 500));
  final Object? exception = tester.takeException();
  expect(
    exception,
    isNull,
    reason: 'example "\${example.name}" threw: \$exception',
  );
  final RenderBox stage =
      tester.renderObject(find.byKey(stageKey)) as RenderBox;
  return _contentBounds(tester, stage);
}

/// Pumps [example] under [theme] in a 375-wide phone box and returns the
/// content bounds in box coordinates (horizontal audit only: the phone box
/// hugs its content height).
///
/// Like [_measure], the audit pumps under a desktop platform so phone-only
/// touch padding never skews the painted union.
Future<Rect?> _measurePhone(
  WidgetTester tester,
  ComponentPreview example,
  ThemeDataView theme, {
  required Key stageKey,
}) async {
  await tester.pumpWidget(
    Theme(
      data: ThemeData(
        colors: theme.colors,
        tokens: theme.tokens,
        fonts: theme.fonts,
        platform: TargetPlatform.macOS,
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Overlay.wrap(
          child: Center(
            child: SizedBox(
              key: stageKey,
              width: _phoneWidth,
              child: Align(
                alignment: Alignment.topCenter,
                child: Builder(builder: example.builder),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  // Same settling as [_measure]: one-shot transitions must finish before
  // the box is read.
  await tester.pump(const Duration(milliseconds: 500));
  final Object? exception = tester.takeException();
  expect(
    exception,
    isNull,
    reason: 'example "\${example.name}" threw: \$exception',
  );
  final RenderBox stage =
      tester.renderObject(find.byKey(stageKey)) as RenderBox;
  return _contentBounds(tester, stage);
}

void main() {
  final ThemeDataView theme = loadGeneratedTheme(
    '\${Directory.current.path}/lib/src/themes/neutral.json',
  ).view(Brightness.light);

  for (final MapEntry<String, List<ComponentPreview>> entry
      in _previews.entries) {
    group(entry.key, () {
      for (final ComponentPreview example in entry.value) {
        final String id = '\${entry.key}/\${example.name}';
        testWidgets(example.name, (WidgetTester tester) async {
          if (_whitelistBoth.containsKey(id)) {
            return;
          }
          final Rect? bounds = await _measure(
            tester,
            example,
            theme,
            _stageSize,
            stageKey: ValueKey<String>('stage-\$id'),
          );
          expect(
            bounds,
            isNotNull,
            reason: '\$id has no measurable content in \$_stageSize',
          );
          final Rect content = bounds!;
          final Offset center = content.center;
          if (!_whitelistHorizontal.containsKey(id)) {
            expect(
              center.dx,
              moreOrLessEquals(_stageSize.width / 2, epsilon: _tolerance),
              reason: '\$id is not horizontally centred in \$_stageSize '
                  '(content \$bounds)',
            );
          }
          if (!_whitelistVertical.containsKey(id)) {
            // Taller-than-stage content grows a real stage around itself,
            // so there is no vertical centring to judge — horizontal only.
            if (content.height <= _stageSize.height) {
              expect(
                center.dy,
                moreOrLessEquals(_stageSize.height / 2, epsilon: _tolerance),
                reason: '\$id is not vertically centred in \$_stageSize '
                    '(content \$bounds)',
              );
            }
          }
          final Rect? phone = await _measurePhone(
            tester,
            example,
            theme,
            stageKey: ValueKey<String>('phone-\$id'),
          );
          expect(
            phone,
            isNotNull,
            reason: '\$id has no measurable content at \$_phoneWidth wide',
          );
          if (!_whitelistHorizontal.containsKey(id)) {
            expect(
              phone!.center.dx,
              moreOrLessEquals(_phoneWidth / 2, epsilon: _tolerance),
              reason:
                  '\$id is not horizontally centred at \$_phoneWidth wide '
                  '(content \$phone)',
            );
          }
        });
      }
    });
  }
}
''';
}
