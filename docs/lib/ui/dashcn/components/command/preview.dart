// Named examples for the `command` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// P7-C2: the palette is live — the search field filters as you type and
// picking a row echoes the command that was run.

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/platform.dart';
import '../../primitives/subfocus_list_item.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import 'command.dart';

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
  docsSample(null, 'Search Emoji'),
  docsSample(null, 'Launch'),
  docsSample(null, 'Profile'),
  docsSample(null, 'Mail'),
  docsSample(null, 'Settings'),
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
                      docsSample(context, 'Suggestions'),
                      docsSample(context, 'Settings'),
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

/// The palette with grouped results.
Widget _commandWithGroups(BuildContext context) =>
    const _CommandPalette(buildGroups: true);

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
      child: Text(docsSample(context, 'Open command palette')),
    );
  }
}

Widget _commandDialog(BuildContext context) => const _CommandDialogTrigger();

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

/// Named docs examples for `command`; the first entry is the default.
List<ComponentPreview> commandPreviews = <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _commandDefault),
  ComponentPreview(docsSample(null, 'With groups'), _commandWithGroups),
  ComponentPreview('Dialog', _commandDialog),
  ComponentPreview(docsSample(null, 'Customized'), _commandCustomized),
];
