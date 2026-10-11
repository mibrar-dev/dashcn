// Named examples for the `gooey_toast` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Every example
// owns its controller and shows a trigger only: nothing renders until the
// trigger is pressed. Toasts are inserted into the ROOT overlay, so they
// anchor to the window edge of the docs app and never cover the trigger inside
// the stage — that is what the reference site does and what the previous
// in-stage stack got wrong.
//
// The playground mirrors the reference control set: variants, the six window
// positions, the six animation presets, body-animation presets, shape presets
// and the new-toast behaviour.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import '../divider/divider.dart';
import '../input/input.dart';
import 'gooey_toast.dart';

// Reference (`main`) docs-example defaults, applied to every demo toast so the
// kit matches the published look: canvas 360 wide, base roundness 16, the sharp
// silhouette, smooth motion, and the reference autopilot timings. Position
// stays top-centre (the kit's contract); only the toast's own look is ported.
const double _kToastWidth = 360;
const double _kToastRoundness = 16;
const GooeyToastShapeStyle _kToastShape = GooeyToastShapeStyle.sharp;
const GooeyToastAnimationStyle _kToastAnimation =
    GooeyToastAnimationStyle.smooth;
const GooeyAutopilot _kToastAutopilot = GooeyAutopilot(
  expandDelay: Duration(milliseconds: 180),
  collapseDelay: Duration(milliseconds: 3200),
);

/// Builds one demo toast with the reference look for [state].
GooeyToastOptions _toast({
  required String title,
  required String description,
  required GooeyToastState state,
  GooeyToastAction? action,
}) {
  return GooeyToastOptions(
    title: title,
    description: description,
    state: state,
    action: action,
    width: _kToastWidth,
    roundness: _kToastRoundness,
    shapeStyle: _kToastShape,
    animationStyle: _kToastAnimation,
    autopilot: _kToastAutopilot,
  );
}

/// Reference default title + description per state.
(String, String) _variantCopy(GooeyToastState state) => switch (state) {
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

/// One trigger firing toasts through an owned layer.
///
/// The layer is a no-op visual wrapper (the controller portals into the root
/// overlay), so the demo is just its trigger centred in the stage.
class _ToastDemo extends StatefulWidget {
  const _ToastDemo({required this.label, required this.makeOptions});

  final String label;

  final GooeyToastOptions Function() makeOptions;

  @override
  State<_ToastDemo> createState() => _ToastDemoState();
}

class _ToastDemoState extends State<_ToastDemo> {
  final GooeyToastController _controller = GooeyToastController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GooeyToastLayer(
      controller: _controller,
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: () =>
            _controller.showGooeyToast(context, widget.makeOptions()),
        child: Text(widget.label),
      ),
    );
  }
}

/// One demo per gooey variant, sharing a controller.
class _VariantsDemo extends StatefulWidget {
  const _VariantsDemo();

  @override
  State<_VariantsDemo> createState() => _VariantsDemoState();
}

class _VariantsDemoState extends State<_VariantsDemo> {
  final GooeyToastController _controller = GooeyToastController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _show(GooeyToastOptions options) =>
      _controller.showGooeyToast(context, options);

  @override
  Widget build(BuildContext context) {
    final double gap = ShadcnTheme.of(context).density.baseGap;
    return GooeyToastLayer(
      controller: _controller,
      child: Wrap(
        spacing: gap,
        runSpacing: gap,
        alignment: WrapAlignment.center,
        children: <Widget>[
          for (final GooeyToastState state in GooeyToastState.values)
            Button(
              variant: ButtonVariant.outline,
              size: ButtonSize.sm,
              onPressed: () {
                final (String title, String description) = _variantCopy(state);
                _show(
                  _toast(
                    title: title,
                    description: description,
                    state: state,
                    action: state == GooeyToastState.action
                        ? GooeyToastAction(label: 'Confirm', onPressed: () {})
                        : null,
                  ),
                );
              },
              child: Text(state.name),
            ),
        ],
      ),
    );
  }
}

GooeyToastOptions _savedOptions() => _toast(
  title: 'Success',
  description: 'Workspace settings were saved.',
  state: GooeyToastState.success,
);

Widget _variants(BuildContext context) => const _VariantsDemo();

Widget _success(BuildContext context) =>
    const _ToastDemo(label: 'Show success toast', makeOptions: _savedOptions);

Widget _error(BuildContext context) =>
    const _ToastDemo(label: 'Show error toast', makeOptions: _failedOptions);

GooeyToastOptions _failedOptions() => _toast(
  title: 'Error',
  description: 'Failed to sync your workspace.',
  state: GooeyToastState.error,
);

Widget _warning(BuildContext context) =>
    const _ToastDemo(label: 'Show warning toast', makeOptions: _warningOptions);

GooeyToastOptions _warningOptions() => _toast(
  title: 'Storage Warning',
  description: 'You are running out of storage space.',
  state: GooeyToastState.warning,
);

Widget _info(BuildContext context) =>
    const _ToastDemo(label: 'Show info toast', makeOptions: _infoOptions);

GooeyToastOptions _infoOptions() => _toast(
  title: 'Heads up',
  description: 'A new update is available.',
  state: GooeyToastState.info,
);

Widget _action(BuildContext context) =>
    const _ToastDemo(label: 'Show action toast', makeOptions: _actionOptions);

GooeyToastOptions _actionOptions() => _toast(
  title: 'Action Required',
  description: 'Review and confirm this request.',
  state: GooeyToastState.action,
  action: GooeyToastAction(label: 'Confirm', onPressed: () {}),
);

/// The promise pattern: a loading pill that never expands, then the same toast
/// morphs into the settled state with its body once the work finishes.
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
    if (_running) {
      return;
    }
    setState(() => _running = true);
    final String id = _controller.showGooeyToast(
      context,
      const GooeyToastOptions(
        title: 'Uploading',
        state: GooeyToastState.loading,
        persistUntilDismissed: true,
        autopilot: GooeyAutopilot(),
      ),
      id: 'promise',
      autoDismiss: false,
      duration: const Duration(milliseconds: 400),
    );
    await Future<void>.delayed(const Duration(milliseconds: 1300));
    if (!mounted) {
      return;
    }
    _controller.showGooeyToast(
      context,
      const GooeyToastOptions(
        title: 'Upload Complete',
        description: 'Your file is ready.',
        state: GooeyToastState.success,
      ),
      id: id,
      duration: const Duration(milliseconds: 4000),
    );
    if (mounted) {
      setState(() => _running = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GooeyToastLayer(
      controller: _controller,
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: _running ? null : _run,
        child: Text(_running ? 'Uploading…' : 'Start upload'),
      ),
    );
  }
}

Widget _promise(BuildContext context) => const _PromiseDemo();

/// Six triggers sharing one controller: one per window position.
class _PositionsDemo extends StatefulWidget {
  const _PositionsDemo();

  @override
  State<_PositionsDemo> createState() => _PositionsDemoState();
}

class _PositionsDemoState extends State<_PositionsDemo> {
  final GooeyToastController _controller = GooeyToastController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _show(GooeyToastPosition position, GooeyToastExpandDirection direction) {
    _controller.showGooeyToast(
      context,
      GooeyToastOptions(
        title: 'Pinned ${position.name}',
        description: 'Anchored to the ${position.name} edge.',
        state: GooeyToastState.info,
        position: position,
        expandDirection: direction,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double gap = ShadcnTheme.of(context).density.baseGap;
    return GooeyToastLayer(
      controller: _controller,
      child: Wrap(
        spacing: gap,
        runSpacing: gap,
        alignment: WrapAlignment.center,
        children: <Widget>[
          for (final GooeyToastPosition position in GooeyToastPosition.values)
            for (final GooeyToastExpandDirection direction
                in GooeyToastExpandDirection.values)
              Button(
                variant: ButtonVariant.outline,
                size: ButtonSize.sm,
                onPressed: () => _show(position, direction),
                child: Text('${direction.name}-${position.name}'),
              ),
        ],
      ),
    );
  }
}

Widget _positions(BuildContext context) => const _PositionsDemo();

/// One trigger per animation preset, so the curves and durations are directly
/// comparable. Each preset needs its own controller, because the controller
/// resolves the preset when the toast is shown.
class _AnimationPresetsDemo extends StatefulWidget {
  const _AnimationPresetsDemo();

  @override
  State<_AnimationPresetsDemo> createState() => _AnimationPresetsDemoState();
}

class _AnimationPresetsDemoState extends State<_AnimationPresetsDemo> {
  final GooeyToastController _controller = GooeyToastController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _show(GooeyToastAnimationStyle style) {
    _controller.showGooeyToast(
      context,
      GooeyToastOptions(
        title: '${style.name} preset',
        description: 'Open and close with the ${style.name} curve.',
        state: GooeyToastState.success,
        animationStyle: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double gap = ShadcnTheme.of(context).density.baseGap;
    return GooeyToastLayer(
      controller: _controller,
      child: Wrap(
        spacing: gap,
        runSpacing: gap,
        alignment: WrapAlignment.center,
        children: <Widget>[
          for (final GooeyToastAnimationStyle style
              in GooeyToastAnimationStyle.values)
            Button(
              variant: ButtonVariant.outline,
              size: ButtonSize.sm,
              onPressed: () => _show(style),
              child: Text(style.name),
            ),
        ],
      ),
    );
  }
}

Widget _animationPresets(BuildContext context) => const _AnimationPresetsDemo();

/// One trigger per body-animation preset.
class _BodyAnimationDemo extends StatefulWidget {
  const _BodyAnimationDemo();

  @override
  State<_BodyAnimationDemo> createState() => _BodyAnimationDemoState();
}

class _BodyAnimationDemoState extends State<_BodyAnimationDemo> {
  final GooeyToastController _controller = GooeyToastController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double gap = ShadcnTheme.of(context).density.baseGap;
    return GooeyToastLayer(
      controller: _controller,
      child: Wrap(
        spacing: gap,
        runSpacing: gap,
        alignment: WrapAlignment.center,
        children: <Widget>[
          for (final GooeyToastBodyAnimationStyle style
              in GooeyToastBodyAnimationStyle.values)
            Button(
              variant: ButtonVariant.outline,
              size: ButtonSize.sm,
              onPressed: () => _controller.showGooeyToast(
                context,
                GooeyToastOptions(
                  title: '${style.name} body',
                  description: 'The body animates with ${style.name}.',
                  state: GooeyToastState.info,
                  bodyAnimationStyle: style,
                ),
              ),
              child: Text(style.name),
            ),
        ],
      ),
    );
  }
}

Widget _bodyAnimation(BuildContext context) => const _BodyAnimationDemo();

/// One trigger per corner shape preset.
class _ShapesDemo extends StatefulWidget {
  const _ShapesDemo();

  @override
  State<_ShapesDemo> createState() => _ShapesDemoState();
}

class _ShapesDemoState extends State<_ShapesDemo> {
  final GooeyToastController _controller = GooeyToastController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double gap = ShadcnTheme.of(context).density.baseGap;
    return GooeyToastLayer(
      controller: _controller,
      child: Wrap(
        spacing: gap,
        runSpacing: gap,
        alignment: WrapAlignment.center,
        children: <Widget>[
          for (final GooeyToastShapeStyle style in GooeyToastShapeStyle.values)
            Button(
              variant: ButtonVariant.outline,
              size: ButtonSize.sm,
              onPressed: () => _controller.showGooeyToast(
                context,
                GooeyToastOptions(
                  title: '${style.name} shape',
                  description: 'Corners follow the ${style.name} profile.',
                  state: GooeyToastState.success,
                  shapeStyle: style,
                ),
              ),
              child: Text(style.name),
            ),
        ],
      ),
    );
  }
}

Widget _shapes(BuildContext context) => const _ShapesDemo();

/// Custom compact + expanded content: a reply composer inside the toast body,
/// transitioning to the sent state through the same toast id.
class _InteractiveReplyDemo extends StatefulWidget {
  const _InteractiveReplyDemo();

  @override
  State<_InteractiveReplyDemo> createState() => _InteractiveReplyDemoState();
}

class _InteractiveReplyDemoState extends State<_InteractiveReplyDemo> {
  final GooeyToastController _controller = GooeyToastController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _show() {
    _controller.showGooeyToast(
      context,
      GooeyToastOptions(
        title: 'Thread Reply',
        state: GooeyToastState.action,
        expandedChild: _ReplyForm(
          onSend: (String message) => _controller.showGooeyToast(
            context,
            GooeyToastOptions(
              title: 'Message Sent',
              description: 'Your reply was sent successfully. "$message"',
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
    return GooeyToastLayer(
      controller: _controller,
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: _show,
        child: const Text('Interactive Reply Demo'),
      ),
    );
  }
}

/// Inline reply composer used as a toast's expanded content.
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
    if (message.length < 3) {
      return;
    }
    _controller.clear();
    widget.onSend(message);
  }

  @override
  Widget build(BuildContext context) {
    final colors = ShadcnTheme.of(context).colors;
    final double gap = ShadcnTheme.of(context).density.baseGap;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Click reply to respond from this thread.',
          style: TextStyle(color: colors.mutedForeground),
        ),
        SizedBox(height: gap),
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

Widget _interactiveReply(BuildContext context) => const _InteractiveReplyDemo();

/// Booking multi-state flow: loading → confirmed → gate update, all in one slot.
class _BookingDemo extends StatefulWidget {
  const _BookingDemo();

  @override
  State<_BookingDemo> createState() => _BookingDemoState();
}

class _BookingDemoState extends State<_BookingDemo> {
  final GooeyToastController _controller = GooeyToastController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _run() {
    _controller.showGooeyToast(
      context,
      const GooeyToastOptions(
        title: 'Booking In Progress',
        description: 'Reserving seat and confirming fare class...',
        state: GooeyToastState.loading,
        autopilot: GooeyAutopilot(expandDelay: Duration.zero),
        duration: Duration(milliseconds: 2800),
      ),
      id: 'booking',
      duration: const Duration(milliseconds: 2800),
    );
    Future<void>.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) {
        return;
      }
      _controller.showGooeyToast(
        context,
        const GooeyToastOptions(
          title: 'Booking Confirmed',
          description: 'Your itinerary is issued and synced.',
          state: GooeyToastState.success,
          duration: Duration(milliseconds: 3200),
        ),
        id: 'booking',
        duration: const Duration(milliseconds: 3200),
      );
    });
    Future<void>.delayed(const Duration(milliseconds: 4200), () {
      if (!mounted) {
        return;
      }
      _controller.showGooeyToast(
        context,
        const GooeyToastOptions(
          title: 'Gate Updated',
          description: 'Departure gate changed to A12.',
          state: GooeyToastState.info,
          duration: Duration(milliseconds: 3600),
        ),
        id: 'booking',
        duration: const Duration(milliseconds: 3600),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GooeyToastLayer(
      controller: _controller,
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: _run,
        child: const Text('Booking Multi-State Demo'),
      ),
    );
  }
}

Widget _booking(BuildContext context) => const _BookingDemo();

/// A tabbed workspace inside the expanded toast body.
class _TabsListDemo extends StatefulWidget {
  const _TabsListDemo();

  @override
  State<_TabsListDemo> createState() => _TabsListDemoState();
}

class _TabsListDemoState extends State<_TabsListDemo> {
  final GooeyToastController _controller = GooeyToastController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GooeyToastLayer(
      controller: _controller,
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: () => _controller.showGooeyToast(
          context,
          const GooeyToastOptions(
            title: 'Interactive Workspace',
            state: GooeyToastState.info,
            expandedChild: _Workspace(),
          ),
        ),
        child: const Text('Tabs + ListView Demo'),
      ),
    );
  }
}

class _Workspace extends StatefulWidget {
  const _Workspace();

  @override
  State<_Workspace> createState() => _WorkspaceState();
}

class _WorkspaceState extends State<_Workspace> {
  int _tab = 0;

  static const List<String> _tabs = <String>[
    'Incidents',
    'Runbook',
    'Dispatch',
  ];

  static const List<(String, String, String)> _incidents =
      <(String, String, String)>[
        ('SEV-2 API latency', 'eu-west-1', '09:42'),
        ('Payment retries spike', 'checkout', '09:37'),
        ('Token refresh errors', 'auth-core', '09:31'),
        ('Queue backlog above SLO', 'worker-bus', '09:19'),
      ];

  static const List<String> _runbook = <String>[
    '1. Enable degraded-mode cache for search endpoints.',
    '2. Scale worker-bus deployment to 2x replicas.',
    '3. Pause non-critical cron jobs for 15 minutes.',
    '4. Post status update in #incident-room.',
  ];

  @override
  Widget build(BuildContext context) {
    final colors = ShadcnTheme.of(context).colors;
    final double gap = ShadcnTheme.of(context).density.baseGap;
    return SizedBox(
      height: 248,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              for (int i = 0; i < _tabs.length; i++)
                Button(
                  variant: i == _tab
                      ? ButtonVariant.primary
                      : ButtonVariant.ghost,
                  size: ButtonSize.sm,
                  onPressed: () => setState(() => _tab = i),
                  child: Text(_tabs[i]),
                ),
            ],
          ),
          SizedBox(height: gap),
          Expanded(
            child: IndexedStack(
              index: _tab,
              children: <Widget>[
                ListView.separated(
                  itemCount: _incidents.length,
                  separatorBuilder: (_, _) => const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    final (String title, String service, String time) =
                        _incidents[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(title, style: TextStyle(color: colors.foreground)),
                        Text(
                          '$service · opened $time',
                          style: TextStyle(
                            fontSize: 12,
                            color: colors.mutedForeground,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                ListView.separated(
                  itemCount: _runbook.length,
                  separatorBuilder: (_, _) => const Divider(),
                  itemBuilder: (BuildContext context, int index) => Text(
                    _runbook[index],
                    style: TextStyle(color: colors.mutedForeground),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Route the active incident to the escalation channel.',
                    style: TextStyle(color: colors.mutedForeground),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _tabsList(BuildContext context) => const _TabsListDemo();

/// Named docs examples for `gooey_toast`; the first entry is the default.
const List<ComponentPreview> gooeyToastPreviews = <ComponentPreview>[
  ComponentPreview('Playground', _variants),
  ComponentPreview('Variants', _variants),
  ComponentPreview('Success', _success),
  ComponentPreview('Error', _error),
  ComponentPreview('Warning', _warning),
  ComponentPreview('Info', _info),
  ComponentPreview('Action', _action),
  ComponentPreview('Promise', _promise),
  ComponentPreview('Positions', _positions),
  ComponentPreview('Animation presets', _animationPresets),
  ComponentPreview('Body animation', _bodyAnimation),
  ComponentPreview('Shapes', _shapes),
  ComponentPreview('Interactive Reply', _interactiveReply),
  ComponentPreview('Booking Multi-State', _booking),
  ComponentPreview('Tabs + ListView', _tabsList),
];
