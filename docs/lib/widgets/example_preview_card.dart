// One example's Preview | Code card (P7-D1, upstream docs layout).
//
// Every named preview example gets its own framed card: a toolbar row with
// keyboard-accessible Preview/Code tabs on the left (the registry `Tabs`
// strip: roving focus, arrow keys) and a per-card light/dark toggle plus a
// copy button on the right, then the stage or the code pane below.
//
// The stage reserves its minimum height while the deferred chunk loads, so
// swapping tabs or examples never jumps the layout. Examples below the fold
// stay empty until the scroll settles ([_LazyPreview]), keeping long pages
// fast: the deferred chunk itself loads once per component and is shared by
// every card on the page.
//
// While the component page's playground is open, the same playground values
// drive every example on the page (the playground canvas is the single live
// preview): each card renders its registered playground builder from the
// shared `p.*` query instead of its static deferred preview, so the page
// changes together. The Code tab keeps the original per-example source, so
// deliberate per-example overrides stay visible in documentation.

import 'package:flutter/widgets.dart';

import '../generated/docs_controls.dart';
import '../generated/docs_example_sources.dart';
import '../playground/builder.dart';
import '../playground/builders.dart';
import '../playground/ui/scope.dart';
import '../playground/values.dart';
import '../routing/docs_router.dart';
import '../state/docs_content_pages.dart';
import '../state/docs_state.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/tabs/tabs.dart';
import '../ui/dashcn/theme/density_tokens.dart';
import '../ui/dashcn/components/tooltip/tooltip.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/primitives/syntax_highlight/syntax_highlight.dart';
import '../ui/dashcn/theme/theme.dart';
import 'code_teaser.dart';
import 'component_preview_card.dart' show PreviewExampleLoader;
import 'copy_button.dart';
import 'device_frame/all_frames.dart';
import 'device_frame/device_frame.dart';
import 'device_frame/device_spec.dart';
import 'device_frame/framed_screen.dart';
import 'docs_tokens.dart';
import 'preview_stage.dart';
import 'selectable_code.dart';

/// Minimum stage height of the main (first-example) demo card.
const double kMainPreviewMinHeight = 350;

/// Minimum stage height of the per-example cards.
const double kExamplePreviewMinHeight = 200;

/// Components whose inline preview is itself a bordered surface: the outer
/// card stays borderless so the page shows one border, not an outer border
/// with an inner bordered box.
const Set<String> _popupLikeComponents = <String>{
  'popup',
  'dropdown_menu',
  'menu',
  'context_menu',
  'command',
  'menubar',
};

/// One example's card: toolbar (tabs + toggle + copy) over stage/code.
class ExamplePreviewCard extends StatefulWidget {
  /// Creates the card for one example.
  const ExamplePreviewCard({
    super.key,
    required this.componentId,
    required this.exampleIndex,
    required this.source,
    this.isMain = false,
  });

  /// The registry component id.
  final String componentId;

  /// Index into the exported `const List<ComponentPreview>`.
  final int exampleIndex;

  /// The generated display source (label, description, code).
  final DocsExampleSource source;

  /// Whether this is the page's main demo (taller stage).
  final bool isMain;

  @override
  State<ExamplePreviewCard> createState() => _ExamplePreviewCardState();
}

class _ExamplePreviewCardState extends State<ExamplePreviewCard> {
  int _tab = 0;
  bool _inverted = false;

  double get _minHeight =>
      widget.isMain ? kMainPreviewMinHeight : kExamplePreviewMinHeight;

  /// Whether this card currently renders playground-driven (vs static).
  bool _isPlaygroundDriven(DocsState state, bool scopeActive) {
    if (!scopeActive || state.playgroundQuery.isEmpty) {
      return false;
    }
    return kControlSpecs.containsKey(widget.componentId) &&
        kPlaygroundBuilders.containsKey(widget.componentId);
  }

  /// The preview body: playground-driven when the page playground is open
  /// for this component and the shared query is non-empty, else the static
  /// deferred preview.
  Widget _playgroundDrivenBody(DocsState state, bool scopeActive) {
    if (_isPlaygroundDriven(state, scopeActive)) {
      final ComponentControls spec = kControlSpecs[widget.componentId]!;
      final PlaygroundBuilder builder =
          kPlaygroundBuilders[widget.componentId]!;
      final PlaygroundValues values = PlaygroundValues.fromQuery(
        spec,
        state.playgroundQuery,
      );
      return Builder(
        builder: (BuildContext context) => builder(context, values),
      );
    }
    return PreviewExampleLoader(
      componentId: widget.componentId,
      exampleIndex: widget.exampleIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final DocsState state = DocsRouterScope.of(context).state;
    // Popup-like previews render a bordered surface inline (MenuPopup,
    // Command, Menubar bar): the outer card stays borderless so the page
    // never shows an outer border with an inner bordered box.
    final bool popupLike = _popupLikeComponents.contains(widget.componentId);
    // Playground-driven examples: when the page playground is open for this
    // component and the shared `p.*` query is non-empty, every card renders
    // the registered playground builder from the same values (the page
    // changes together). The Code tab below keeps the original source, so
    // deliberate per-example overrides stay documented. When closed or at
    // defaults (empty query) the static deferred previews render as today.
    final bool playgroundScopeActive =
        PlaygroundScope.maybeOf(context)?.drives(widget.componentId) ?? false;
    // F1: the card also rebuilds when the shared frame choice changes, so
    // every example on the page follows the one frame bar.
    return ListenableBuilder(
      listenable: state.themeModel,
      builder: (BuildContext context, Widget? _) {
        return ListenableBuilder(
          listenable: state,
          builder: (BuildContext context, Widget? _) {
            final Brightness site = state.brightness;
            final Brightness stageBrightness = _inverted
                ? (site == Brightness.dark ? Brightness.light : Brightness.dark)
                : site;
            final _ExampleToolbar toolbar = _ExampleToolbar(
              exampleIndex: widget.exampleIndex,
              tab: _tab,
              onTab: (int tab) => setState(() => _tab = tab),
              stageBrightness: stageBrightness,
              inverted: _inverted,
              onToggle: () => setState(() => _inverted = !_inverted),
              copyText: widget.source.code,
            );
            // The Code tab always shows the code as today: no frame.
            if (_tab == 1) {
              return PreviewFrame(
                showBorder: !popupLike,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    toolbar,
                    Column(
                      children: <Widget>[
                        const CodePaneDivider(),
                        CodeTeaser(
                          code: ExampleSnippetCode(code: widget.source.code),
                          copyText: widget.source.code,
                          language: 'dart',
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            final bool driven = _isPlaygroundDriven(
              state,
              playgroundScopeActive,
            );
            final Widget exampleBody = _playgroundDrivenBody(
              state,
              playgroundScopeActive,
            );
            // Playground-driven cards bypass the lazy gate so every example
            // updates the moment a control changes (no scroll needed).
            final Widget stage = PreviewStage(
              minHeight: _minHeight,
              child: driven
                  ? exampleBody
                  : _LazyPreview(minHeight: _minHeight, child: exampleBody),
            );
            final ThemeData? themeOverride = PlaygroundScope.maybeOf(
              context,
            )?.themeOverride;
            final ThemeData baseStageTheme =
                themeOverride ?? state.themeModel.themeFor(stageBrightness);
            final Widget previewBody = _inverted
                ? Theme(
                    data: baseStageTheme.copyWith(
                      colors: () =>
                          state.themeModel.themeFor(stageBrightness).colors,
                    ),
                    child: stage,
                  )
                : (themeOverride != null
                      ? Theme(data: themeOverride, child: stage)
                      : stage);
            // `None` keeps today's card exactly.
            if (state.frame == DeviceFrameId.none) {
              return PreviewFrame(
                showBorder: !popupLike,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[toolbar, previewBody],
                ),
              );
            }
            // F1 framed mode: the toolbar stays outside/above the frame and the
            // device screen shows only the placed preview on the app background.
            Widget framed = _FramedBody(
              frame: state.frame,
              orientation: state.orientation,
              componentId: widget.componentId,
              child: _playgroundDrivenBody(state, playgroundScopeActive),
            );
            if (_inverted) {
              framed = Theme(
                data: baseStageTheme.copyWith(
                  colors: () =>
                      state.themeModel.themeFor(stageBrightness).colors,
                ),
                child: framed,
              );
            } else if (themeOverride != null) {
              framed = Theme(data: themeOverride, child: framed);
            }
            return Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[toolbar, const Gap(12), framed],
              ),
            );
          },
        );
      },
    );
  }
}

/// The F1 framed body: the raw preview placed on the device screen.
///
/// One framed spec shows a single `DeviceFrame` (horizontally scrollable
/// when the article is narrower than the frame); `All` shows every spec.
class _FramedBody extends StatelessWidget {
  /// Creates the framed body for [componentId].
  const _FramedBody({
    required this.frame,
    required this.orientation,
    required this.componentId,
    required this.child,
  });

  /// The selected frame.
  final DeviceFrameId frame;

  /// Portrait or landscape.
  final DeviceOrientation orientation;

  /// The registry component id (placement + test keys).
  final String componentId;

  /// The raw preview widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (frame == DeviceFrameId.all) {
      return AllFrames(
        orientation: orientation,
        child: FramedScreen(componentId: componentId, child: child),
      );
    }
    final DeviceSpec spec = specForFrame(frame)!;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size total = spec.totalFor(orientation);
        final Widget framed = DeviceFrame(
          key: ValueKey<String>('framed-$componentId-${spec.id.queryValue}'),
          spec: spec,
          orientation: orientation,
          child: FramedScreen(componentId: componentId, child: child),
        );
        if (constraints.maxWidth.isFinite &&
            constraints.maxWidth < total.width) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: framed,
          );
        }
        return Align(alignment: Alignment.topCenter, child: framed);
      },
    );
  }
}

/// The toolbar row: Preview/Code tabs left, toggle + copy right.
///
/// Always a single row at 320 px and up (P7-D1b): the light/dark toggle is a
/// compact icon-only button with a tooltip, so the tab strip plus the two
/// icon buttons fit the ~295 px the 375 px article leaves for this row. There
/// is no wrapping branch: tabs left, toggle + copy right, separated by a
/// spacer.
class _ExampleToolbar extends StatelessWidget {
  /// Creates the toolbar.
  const _ExampleToolbar({
    required this.exampleIndex,
    required this.tab,
    required this.onTab,
    required this.stageBrightness,
    required this.inverted,
    required this.onToggle,
    required this.copyText,
  });

  /// Example index (disambiguates widget-test keys per card).
  final int exampleIndex;

  /// Selected tab (0 preview, 1 code).
  final int tab;

  /// Called with the new tab index.
  final ValueChanged<int> onTab;

  /// The brightness the stage currently shows.
  final Brightness stageBrightness;

  /// Whether the stage is inverted to the opposite brightness.
  final bool inverted;

  /// Flips the stage brightness override.
  final VoidCallback onToggle;

  /// The example code the copy button writes.
  final String copyText;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Locale tabLocale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    final Widget tabs = Tabs(
      key: ValueKey<String>('example-tabs-$exampleIndex'),
      index: tab,
      onChanged: onTab,
      children: <TabItem>[
        TabItem(child: Text(docsContentPage(tabLocale, 'pagePreview'))),
        TabItem(child: Text(docsContentPage(tabLocale, 'pageCode'))),
      ],
    );
    final bool narrow = MediaQuery.widthOf(context) < kPhoneWidthBreakpoint;
    final Widget actions = Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Tooltip(
          tooltip: (BuildContext context) => Text(
            stageBrightness == Brightness.dark
                ? 'Switch to light'
                : 'Switch to dark',
          ),
          child: Button(
            key: ValueKey<String>('preview-theme-toggle-$exampleIndex'),
            variant: ButtonVariant.outline,
            // Narrow phones (touch density) use xs actions so the tab strip
            // + actions stay on one row at 320 px.
            size: narrow ? ButtonSize.xs : ButtonSize.sm,
            onPressed: onToggle,
            child: Icon(
              stageBrightness == Brightness.dark
                  ? LucideIcons.moon
                  : LucideIcons.sun,
              size: 14,
            ),
          ),
        ),
        // P7-TH1: gap-2 between the toggle and the copy button.
        Gap(narrow ? theme.spacing.xs : theme.spacing.sm),
        CopyButton(
          key: ValueKey<String>('example-copy-$exampleIndex'),
          text: copyText,
          variant: ButtonVariant.ghost,
          size: narrow ? ButtonSize.xs : ButtonSize.sm,
        ),
      ],
    );
    return Padding(
      // P7-TH1: toolbar insets follow the theme (lg/md).
      padding: EdgeInsets.fromLTRB(
        theme.spacing.lg,
        theme.spacing.md,
        theme.spacing.lg,
        theme.spacing.md,
      ),
      child: Row(
        children: <Widget>[
          // Tabs hug left, actions pin right: the tab strip is tight
          // (`Expanded`) so the trailing gap lives between the strip and the
          // actions, not after the actions. The strip scrolls internally on
          // 320 px phones instead of overflowing the row.
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: tabs,
            ),
          ),
          Gap(theme.spacing.sm),
          actions,
        ],
      ),
    );
  }
}

/// Defers the preview below the fold until the scroll settles.
///
/// The placeholder keeps the stage's minimum height, so revealing the example
/// never shifts the layout. Above the fold (or when idle) the example shows
/// on the next frame.
class _LazyPreview extends StatefulWidget {
  /// Creates the lazy slot around the real loader.
  const _LazyPreview({required this.minHeight, required this.child});

  /// Stage minimum height (the placeholder matches it).
  final double minHeight;

  /// The real deferred preview loader.
  final Widget child;

  @override
  State<_LazyPreview> createState() => _LazyPreviewState();
}

class _LazyPreviewState extends State<_LazyPreview> {
  bool _revealed = false;

  @override
  Widget build(BuildContext context) {
    if (_revealed) {
      return widget.child;
    }
    if (!Scrollable.recommendDeferredLoadingForContext(context)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_revealed) {
          setState(() => _revealed = true);
        }
      });
    }
    return NotificationListener<ScrollEndNotification>(
      onNotification: (_) {
        if (!_revealed) {
          setState(() => _revealed = true);
        }
        return false;
      },
      child: SizedBox(height: widget.minHeight),
    );
  }
}

/// The highlighted example source inside the card's code teaser.
///
/// Highlighting runs at build time from the generated code string (the spans
/// concatenate back to the plain text, so selection/copy is unchanged); the
/// copy button always copies the plain [code] string.
class ExampleSnippetCode extends StatelessWidget {
  /// Creates the code block for [code].
  const ExampleSnippetCode({super.key, required this.code});

  /// The example source text.
  final String code;

  @override
  Widget build(BuildContext context) {
    final DocsSiteColors site = DocsSiteColors.of(context);
    final ThemeData theme = Theme.of(context);
    final bool dark = site.codeSurface == const Color(0xFF161616);
    final TextStyle style = theme.typography.mono.copyWith(
      fontSize: 14,
      height: 24.5 / 14,
      color: dark ? const Color(0xFFE5E5E5) : const Color(0xFF262626),
    );
    return Container(
      color: site.codeSurface,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SelectableCode(
          child: Text.rich(
            syntaxTextSpan(
              code: code,
              language: SyntaxLanguage.dart,
              base: style,
              colors: theme.syntaxColors,
            ),
          ),
        ),
      ),
    );
  }
}
