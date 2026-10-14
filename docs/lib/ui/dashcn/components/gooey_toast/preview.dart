// Named examples for the `gooey_toast` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Every example
// owns its controller and shows a trigger only: nothing renders until the
// trigger is pressed. Toasts are inserted into the ROOT overlay, so they
// anchor to the window edge of the docs app and never cover the trigger.
//
// P7-WA: ONE shared theme config across all gooey examples. The Playground
// (first example) hosts a small controls bar — shape sharp/soft, animation
// preset, position, fill — and changing it updates EVERY example on the page:
// all demos resolve shape/animation/position/fill from the same `_shared`
// notifier at show time (fill flows through each layer's theme, rebuilt by a
// `ValueListenableBuilder`). No example uses a divergent style.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import '../input/input.dart';
import 'gooey_toast.dart';

/// Shared playground config: the single source of look for every demo.
class _Shared {
  const _Shared({
    this.shape = GooeyToastShapeStyle.sharp,
    this.animation = GooeyToastAnimationStyle.smooth,
    this.position = GooeyToastPosition.center,
    this.fill = const ThemedColor.value(gooeySurfaceFill),
  });

  final GooeyToastShapeStyle shape;
  final GooeyToastAnimationStyle animation;
  final GooeyToastPosition position;
  final ThemedColor fill;

  _Shared copyWith({
    GooeyToastShapeStyle? shape,
    GooeyToastAnimationStyle? animation,
    GooeyToastPosition? position,
    ThemedColor? fill,
  }) {
    return _Shared(
      shape: shape ?? this.shape,
      animation: animation ?? this.animation,
      position: position ?? this.position,
      fill: fill ?? this.fill,
    );
  }
}

/// The one shared config; the Playground mutates it, every demo reads it.
final ValueNotifier<_Shared> _shared = ValueNotifier<_Shared>(const _Shared());

const double _kWidth = 360;
const double _kRoundness = 16;
const GooeyAutopilot _kAutopilot = GooeyAutopilot(
  expandDelay: Duration(milliseconds: 180),
  collapseDelay: Duration(milliseconds: 3200),
);

/// One demo toast in the shared look for [state].
GooeyToastOptions _toast({
  required String title,
  required String description,
  required GooeyToastState state,
  GooeyToastAction? action,
}) {
  final _Shared shared = _shared.value;
  return GooeyToastOptions(
    title: title,
    description: description,
    state: state,
    action: action,
    position: shared.position,
    width: _kWidth,
    roundness: _kRoundness,
    shapeStyle: shared.shape,
    animationStyle: shared.animation,
    autopilot: _kAutopilot,
  );
}

/// Layer whose fill follows the shared config.
class _Layer extends StatefulWidget {
  const _Layer({required this.child, required this.controller});

  final Widget child;
  final GooeyToastController controller;

  @override
  State<_Layer> createState() => _LayerState();
}

class _LayerState extends State<_Layer> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<_Shared>(
      valueListenable: _shared,
      builder: (context, shared, _) => GooeyToastLayer(
        controller: widget.controller,
        theme: GooeyToastTheme(fill: shared.fill),
        child: widget.child,
      ),
    );
  }
}

/// Small option chip used by the controls bar.
Widget _chip({
  required String label,
  required bool selected,
  required VoidCallback onPressed,
}) {
  return Button(
    variant: selected ? ButtonVariant.primary : ButtonVariant.outline,
    size: ButtonSize.sm,
    onPressed: onPressed,
    child: Text(label),
  );
}

/// The Playground: shared controls plus one trigger per variant.
class _Playground extends StatefulWidget {
  const _Playground();

  @override
  State<_Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<_Playground> {
  final GooeyToastController _controller = GooeyToastController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _show(GooeyToastState state) {
    final (String title, String description) = _copy(state);
    _controller.showGooeyToast(
      context,
      _toast(
        title: title,
        description: description,
        state: state,
        action: state == GooeyToastState.action
            ? GooeyToastAction(label: 'Confirm', onPressed: () {})
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double gap = Theme.of(context).density.baseGap;
    return _Layer(
      controller: _controller,
      child: ValueListenableBuilder<_Shared>(
        valueListenable: _shared,
        builder: (context, shared, _) => Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Wrap(
              spacing: gap,
              runSpacing: gap,
              alignment: WrapAlignment.center,
              children: <Widget>[
                _chip(
                  label: 'sharp',
                  selected: shared.shape == GooeyToastShapeStyle.sharp,
                  onPressed: () => _shared.value = shared.copyWith(
                    shape: GooeyToastShapeStyle.sharp,
                  ),
                ),
                _chip(
                  label: 'soft',
                  selected: shared.shape == GooeyToastShapeStyle.soft,
                  onPressed: () => _shared.value = shared.copyWith(
                    shape: GooeyToastShapeStyle.soft,
                  ),
                ),
              ],
            ),
            SizedBox(height: gap),
            Wrap(
              spacing: gap,
              runSpacing: gap,
              alignment: WrapAlignment.center,
              children: <Widget>[
                for (final GooeyToastAnimationStyle style
                    in GooeyToastAnimationStyle.values)
                  _chip(
                    label: style.name,
                    selected: shared.animation == style,
                    onPressed: () =>
                        _shared.value = shared.copyWith(animation: style),
                  ),
              ],
            ),
            SizedBox(height: gap),
            Wrap(
              spacing: gap,
              runSpacing: gap,
              alignment: WrapAlignment.center,
              children: <Widget>[
                for (final GooeyToastPosition position
                    in GooeyToastPosition.values)
                  _chip(
                    label: position.name,
                    selected: shared.position == position,
                    onPressed: () =>
                        _shared.value = shared.copyWith(position: position),
                  ),
              ],
            ),
            SizedBox(height: gap),
            Wrap(
              spacing: gap,
              runSpacing: gap,
              alignment: WrapAlignment.center,
              children: <Widget>[
                _chip(
                  label: 'light fill',
                  selected:
                      shared.fill == const ThemedColor.value(gooeySurfaceFill),
                  onPressed: () => _shared.value = shared.copyWith(
                    fill: const ThemedColor.value(gooeySurfaceFill),
                  ),
                ),
                _chip(
                  label: 'dark fill',
                  selected:
                      shared.fill == const ThemedColor.value(Color(0xFF232326)),
                  onPressed: () => _shared.value = shared.copyWith(
                    fill: const ThemedColor.value(Color(0xFF232326)),
                  ),
                ),
                _chip(
                  label: 'popover fill',
                  selected:
                      shared.fill == const ThemedColor.ref(ColorRef.popover),
                  onPressed: () => _shared.value = shared.copyWith(
                    fill: const ThemedColor.ref(ColorRef.popover),
                  ),
                ),
              ],
            ),
            SizedBox(height: gap * 2),
            Wrap(
              spacing: gap,
              runSpacing: gap,
              alignment: WrapAlignment.center,
              children: <Widget>[
                for (final GooeyToastState state in GooeyToastState.values)
                  Button(
                    variant: ButtonVariant.outline,
                    size: ButtonSize.sm,
                    onPressed: () => _show(state),
                    child: Text(state.name),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

(String, String) _copy(GooeyToastState state) => switch (state) {
  GooeyToastState.success => ('Success', 'Workspace settings were saved.'),
  GooeyToastState.loading => ('Processing', 'Please wait while we process.'),
  GooeyToastState.error => ('Error', 'Failed to sync your workspace.'),
  GooeyToastState.warning => (
    'Storage Warning',
    'You are running out of storage space.',
  ),
  GooeyToastState.info => ('Heads up', 'A new update is available.'),
  GooeyToastState.action => (
    'Action Required',
    'Review and confirm this request.',
  ),
};

Widget _playground(BuildContext context) => const _Playground();

/// Promise flow in the shared look.
class _PromiseDemo extends StatefulWidget {
  const _PromiseDemo();

  @override
  State<_PromiseDemo> createState() => _PromiseDemoState();
}

class _PromiseDemoState extends State<_PromiseDemo> {
  final GooeyToastController _controller = GooeyToastController();
  bool _running = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _run() async {
    if (_running) return;
    setState(() => _running = true);
    final _Shared shared = _shared.value;
    final String id = _controller.showGooeyToast(
      context,
      GooeyToastOptions(
        title: 'Uploading',
        state: GooeyToastState.loading,
        persistUntilDismissed: true,
        autopilot: const GooeyAutopilot(),
        position: shared.position,
        shapeStyle: shared.shape,
        animationStyle: shared.animation,
      ),
      id: 'promise',
      autoDismiss: false,
      duration: const Duration(milliseconds: 400),
    );
    await Future<void>.delayed(const Duration(milliseconds: 1300));
    if (!mounted) return;
    _controller.showGooeyToast(
      context,
      _toast(
        title: 'Upload Complete',
        description: 'Your file is ready.',
        state: GooeyToastState.success,
      ),
      id: id,
      duration: const Duration(milliseconds: 4000),
    );
    if (mounted) setState(() => _running = false);
  }

  @override
  Widget build(BuildContext context) {
    return _Layer(
      controller: _controller,
      child: Center(
        child: Button(
          variant: ButtonVariant.outline,
          size: ButtonSize.sm,
          onPressed: _running ? null : _run,
          child: Text(_running ? 'Uploading…' : 'Start upload'),
        ),
      ),
    );
  }
}

Widget _promise(BuildContext context) => const _PromiseDemo();

/// Interactive reply in the shared look.
class _ReplyDemo extends StatefulWidget {
  const _ReplyDemo();

  @override
  State<_ReplyDemo> createState() => _ReplyDemoState();
}

class _ReplyDemoState extends State<_ReplyDemo> {
  final GooeyToastController _controller = GooeyToastController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _show() {
    final _Shared shared = _shared.value;
    _controller.showGooeyToast(
      context,
      GooeyToastOptions(
        title: 'Thread Reply',
        state: GooeyToastState.action,
        position: shared.position,
        shapeStyle: shared.shape,
        animationStyle: shared.animation,
        expandedChild: _ReplyForm(
          onSend: (String message) => _controller.showGooeyToast(
            context,
            _toast(
              title: 'Message Sent',
              description: 'Your reply was sent. "$message"',
              state: GooeyToastState.success,
            ),
            id: 'demo-reply',
            behavior: GooeyToastNewToastBehavior.transition,
          ),
        ),
      ),
      id: 'demo-reply',
    );
  }

  @override
  Widget build(BuildContext context) {
    return _Layer(
      controller: _controller,
      child: Center(
        child: Button(
          variant: ButtonVariant.outline,
          size: ButtonSize.sm,
          onPressed: _show,
          child: const Text('Interactive Reply Demo'),
        ),
      ),
    );
  }
}

class _ReplyForm extends StatefulWidget {
  const _ReplyForm({required this.onSend});

  final ValueChanged<String> onSend;

  @override
  State<_ReplyForm> createState() => _ReplyFormState();
}

class _ReplyFormState extends State<_ReplyForm> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final String message = _controller.text.trim();
    if (message.length < 3) return;
    _controller.clear();
    widget.onSend(message);
  }

  @override
  Widget build(BuildContext context) {
    final double gap = Theme.of(context).density.baseGap;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Input(
          controller: _controller,
          placeholder: const Text('Type your reply...'),
          minLines: 2,
          maxLines: 3,
          onSubmitted: (_) => _submit(),
        ),
        SizedBox(height: gap),
        Button(
          variant: ButtonVariant.primary,
          size: ButtonSize.sm,
          onPressed: _submit,
          child: const Text('Send Reply'),
        ),
      ],
    );
  }
}

Widget _reply(BuildContext context) => const _ReplyDemo();

/// Named docs examples for `gooey_toast`; the first entry is the default.
const List<ComponentPreview> gooeyToastPreviews = <ComponentPreview>[
  ComponentPreview('Playground', _playground),
  ComponentPreview('Promise', _promise),
  ComponentPreview('Interactive Reply', _reply),
];
