// The P9-1 integration point: toolbar + framed preview in one widget.
//
// `FramedPreview` is what component pages render instead of a bare stage
// (P9-Z wires it with one line — see the P9-1 report). It is controlled when
// [frame] is given, otherwise it reads the initial choice from the ambient
// `DocsState` (via `DocsRouterScope`) and writes every change back, so the
// choice persists and round-trips through the `?frame=` query param.

import 'package:flutter/widgets.dart';

import '../../routing/docs_router.dart';
import '../../state/docs_state.dart';
import '../../ui/dashcn/foundation/gap.dart';
import 'all_frames.dart';
import 'device_frame.dart';
import 'device_spec.dart';
import 'frame_bar.dart';

/// A preview with a frame toolbar above it.
class FramedPreview extends StatefulWidget {
  /// Creates a framed preview around [child].
  const FramedPreview({
    super.key,
    required this.child,
    this.id,
    this.frame,
    this.onFrameChanged,
    this.orientation,
    this.onOrientationChanged,
    this.showBar = true,
  });

  /// The preview content (one subtree per visible frame).
  final Widget child;

  /// Optional identity (namespaces nothing today; carried for P9-Z deep
  /// links and used as a test key).
  final String? id;

  /// Selected frame; null makes the widget read/write the ambient
  /// `DocsState` instead (uncontrolled).
  final DeviceFrameId? frame;

  /// Called with the new frame in controlled mode.
  final ValueChanged<DeviceFrameId>? onFrameChanged;

  /// Portrait/landscape; null is uncontrolled like [frame].
  final DeviceOrientation? orientation;

  /// Called with the new orientation in controlled mode.
  final ValueChanged<DeviceOrientation>? onOrientationChanged;

  /// Whether the toolbar renders (P9-Z may host one bar per page).
  final bool showBar;

  @override
  State<FramedPreview> createState() => _FramedPreviewState();
}

class _FramedPreviewState extends State<FramedPreview> {
  DeviceFrameId _frame = DeviceFrameId.none;
  DeviceOrientation _orientation = DeviceOrientation.portrait;
  DocsState? _state;

  DeviceFrameId get _effectiveFrame => widget.frame ?? _frame;
  DeviceOrientation get _effectiveOrientation =>
      widget.orientation ?? _orientation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final DocsState? next = DocsRouterScope.maybeOf(context)?.state;
    if (!identical(next, _state)) {
      _state?.removeListener(_syncFromState);
      _state = next;
      _state?.addListener(_syncFromState);
      _syncFromState();
    }
  }

  @override
  void dispose() {
    _state?.removeListener(_syncFromState);
    super.dispose();
  }

  void _syncFromState() {
    if (widget.frame != null || _state == null) {
      return;
    }
    final DeviceFrameId frame = _state!.frame;
    final DeviceOrientation orientation = _state!.orientation;
    if (frame != _frame || orientation != _orientation) {
      setState(() {
        _frame = frame;
        _orientation = orientation;
      });
    }
  }

  void _onFrameChanged(DeviceFrameId frame) {
    if (widget.frame != null) {
      widget.onFrameChanged?.call(frame);
      return;
    }
    setState(() => _frame = frame);
    _state?.setFrame(frame);
  }

  void _onOrientationChanged(DeviceOrientation orientation) {
    if (widget.orientation != null) {
      widget.onOrientationChanged?.call(orientation);
      return;
    }
    setState(() => _orientation = orientation);
    _state?.setOrientation(orientation);
  }

  @override
  Widget build(BuildContext context) {
    final DeviceFrameId frame = _effectiveFrame;
    final DeviceOrientation orientation = _effectiveOrientation;
    final Widget body = _Body(
      frame: frame,
      orientation: orientation,
      child: widget.child,
    );
    final Widget keyed = widget.id == null
        ? body
        : KeyedSubtree(
            key: ValueKey<String>('framed-preview-${widget.id}'),
            child: body,
          );
    if (!widget.showBar) {
      return keyed;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        FrameBar(
          frame: frame,
          onFrameChanged: _onFrameChanged,
          orientation: orientation,
          onOrientationChanged: _onOrientationChanged,
          brightness: _state?.brightness,
          onBrightnessChanged: _state == null
              ? null
              : (Brightness brightness) => _state!.setBrightness(brightness),
        ),
        const Gap(12),
        keyed,
      ],
    );
  }
}

/// The framed body: raw child, one scrollable frame, or all four.
class _Body extends StatelessWidget {
  const _Body({
    required this.frame,
    required this.orientation,
    required this.child,
  });

  final DeviceFrameId frame;
  final DeviceOrientation orientation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (frame == DeviceFrameId.none) {
      return child;
    }
    if (frame == DeviceFrameId.all) {
      return AllFrames(orientation: orientation, child: child);
    }
    final DeviceSpec spec = specForFrame(frame)!;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size total = spec.totalFor(orientation);
        final Widget framed = DeviceFrame(
          key: ValueKey<String>('framed-${spec.id.queryValue}'),
          spec: spec,
          orientation: orientation,
          child: child,
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
