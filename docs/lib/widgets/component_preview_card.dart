// The component page's main demo card (P7-D1): the first named example
// ("Default") in its own Preview | Code card.
//
// The remaining examples render below Usage in `ComponentExamplesSection` —
// one `### <Name>` + card each (the upstream docs layout). Components without
// named examples (building blocks with a gallery preview class) keep a
// bare stage with no toolbar.
//
// The stage inherits the site theme (no nested default `DashcnApp`/
// `Theme`), so preset and mode switches re-theme it. The deferred
// chunk loads once per component and is shared by every card on the page.
//
// Split out of `pages/component_page.dart` for the ~400-line rule.

import 'package:flutter/widgets.dart';

import '../routing/docs_router.dart';
import '../state/docs_strings.dart';

import '../generated/docs_example_sources.dart';
import '../previews/component_previews.dart';

import '../state/docs_state.dart';
import '../ui/dashcn/theme/theme.dart';
import 'device_frame/all_frames.dart';
import 'device_frame/device_frame.dart';
import 'device_frame/device_spec.dart';
import 'device_frame/framed_preview.dart';
import 'device_frame/framed_screen.dart';
import 'docs_tokens.dart';
import 'example_preview_card.dart';
import 'preview_stage.dart';

/// The main demo card: the first example of [componentId].
class ComponentPreviewCard extends StatelessWidget {
  /// Creates the card for [componentId].
  const ComponentPreviewCard({super.key, required this.componentId});

  /// The registry component id.
  final String componentId;

  @override
  Widget build(BuildContext context) {
    final List<DocsExampleSource> sources =
        kExampleSources[componentId] ?? const <DocsExampleSource>[];
    // P9-Z: the frame bar reads/writes the ambient DocsState, so `?frame=`
    // survives reload. F1: the bar renders here but the device frame itself
    // renders inside the example card, so the Preview|Code toolbar stays
    // outside the device screen.
    if (sources.isEmpty) {
      return FramedPreview(
        id: componentId,
        bodyBuilder:
            (
              DeviceFrameId frame,
              DeviceOrientation orientation,
              Widget child,
            ) => child,
        child: _BareExamplePreview(componentId: componentId),
      );
    }
    return FramedPreview(
      id: componentId,
      bodyBuilder:
          (DeviceFrameId frame, DeviceOrientation orientation, Widget child) =>
              child,
      child: ExamplePreviewCard(
        componentId: componentId,
        exampleIndex: 0,
        source: sources.first,
        isMain: true,
      ),
    );
  }
}

/// The bare stage for components without named examples (F1: framed per the
/// shared frame choice, like the example cards, but with no toolbar).
class _BareExamplePreview extends StatelessWidget {
  /// Creates the bare preview for [componentId].
  const _BareExamplePreview({required this.componentId});

  /// The registry component id.
  final String componentId;

  @override
  Widget build(BuildContext context) {
    // The parent `FramedPreview` rebuilds this subtree whenever the shared
    // frame choice changes, so a plain read stays fresh. `maybeOf` keeps
    // standalone widget tests working (they default to unframed).
    final DocsState? state = DocsRouterScope.maybeOf(context)?.state;
    final DeviceFrameId frame = state?.frame ?? DeviceFrameId.none;
    final DeviceOrientation orientation =
        state?.orientation ?? DeviceOrientation.portrait;
    if (frame == DeviceFrameId.none) {
      return PreviewFrame(
        child: PreviewStage(
          child: PreviewExampleLoader(
            componentId: componentId,
            exampleIndex: 0,
          ),
        ),
      );
    }
    final Widget screen = FramedScreen(
      componentId: componentId,
      child: PreviewExampleLoader(componentId: componentId, exampleIndex: 0),
    );
    if (frame == DeviceFrameId.all) {
      return AllFrames(orientation: orientation, child: screen);
    }
    final DeviceSpec spec = specForFrame(frame)!;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size total = spec.totalFor(orientation);
        final Widget framed = DeviceFrame(
          key: ValueKey<String>('framed-$componentId-${spec.id.queryValue}'),
          spec: spec,
          orientation: orientation,
          child: screen,
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

/// Loads one deferred preview example and rebuilds when it arrives.
///
/// The future is cached per `(componentId, exampleIndex)` so theme switches
/// (which rebuild through `DocsState`) reuse the loaded widget and only
/// re-theme it instead of refetching the chunk.
class PreviewExampleLoader extends StatefulWidget {
  /// Creates the loader for one example.
  const PreviewExampleLoader({
    super.key,
    required this.componentId,
    required this.exampleIndex,
  });

  /// The registry component id.
  final String componentId;

  /// Index into the exported `const List<ComponentPreview>`.
  final int exampleIndex;

  @override
  State<PreviewExampleLoader> createState() => PreviewExampleLoaderState();
}

/// State of [PreviewExampleLoader] (public for the ~400-line rule: the
/// widget file stays small while the state class is discoverable).
class PreviewExampleLoaderState extends State<PreviewExampleLoader> {
  Future<Widget>? _future;
  String? _key;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _maybeLoad();
  }

  @override
  void didUpdateWidget(covariant PreviewExampleLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    _maybeLoad();
  }

  void _maybeLoad() {
    final String key = '${widget.componentId}@${widget.exampleIndex}';
    if (_key != key) {
      _key = key;
      _future = loadComponentPreview(widget.componentId, widget.exampleIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!;
        }
        if (snapshot.hasError) {
          return Text(
            docsChrome(
              DocsRouterScope.maybeOf(context)?.state.locale ??
                  const Locale('en'),
              'cmpPreviewFailed',
            ),
            style: docsText(
              context,
              size: 13,
              color: Theme.of(context).colors.mutedForeground,
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
