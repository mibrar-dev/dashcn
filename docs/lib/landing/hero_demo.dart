// The landing hero demo (P9-Z): the same flow on every platform at once.
//
// `LandingHeroDemo` runs the docs `auth-01` demo flow (see
// `flows/flow_demo_data.dart`) live inside the P9-1 iPhone, Android and
// desktop frames side by side — the same `DeviceFrame` building blocks as
// the "All" layout, minus the browser frame. Each frame owns its subtree
// (and its own nested navigator), so the three demos run independently.
//
// Wide screens (≥ [kHeroWideWidth]) show all three, scaled to fit; narrow
// screens show one frame plus a device switcher. There is no autoplay and
// no entrance animation — every transition is tap-driven — so the demo is
// inherently reduced-motion safe.
//
// The landing page imports this library deferred (see `main.dart` deferred
// patterns): the flow widgets and frame painters stay out of the initial
// chunk and the hero slot shows a fixed-height placeholder until the chunk
// arrives.

import 'package:flutter/widgets.dart';

import '../flows/flow_demo_data.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/theme/theme.dart';
import '../widgets/device_frame/device_frame.dart';
import '../widgets/device_frame/device_spec.dart';

/// Viewport width at/above which all three frames show side by side.
const double kHeroWideWidth = 700;

/// Fixed demo heights (the frames scale to fit via [FittedBox]).
const double kHeroWideHeight = 560;
const double kHeroNarrowHeight = 520;

/// The three hero frames, in display order.
const List<DeviceFrameId> kHeroFrames = <DeviceFrameId>[
  DeviceFrameId.iphone,
  DeviceFrameId.android,
  DeviceFrameId.desktop,
];

/// The landing hero demo: `auth-01` live in three device frames.
class LandingHeroDemo extends StatefulWidget {
  /// Creates the demo.
  const LandingHeroDemo({super.key});

  @override
  State<LandingHeroDemo> createState() => _LandingHeroDemoState();
}

class _LandingHeroDemoState extends State<LandingHeroDemo> {
  DeviceFrameId _narrowFrame = DeviceFrameId.iphone;

  /// Whether the nested flow navigators have finished installing.
  ///
  /// Each demo flow owns a nested `Navigator`, and every `Navigator`
  /// autofocuses on mount plus requests its enclosing scope on route push —
  /// without this gate, installing the three hero frames would steal
  /// primary focus on page load, so the first Tab would start inside the
  /// hero instead of the header (D5 audit). While [_installed] is false the
  /// scope refuses descendant focus requests (both vectors fail silently);
  /// flipping it after install restores full keyboard access, and nothing
  /// re-fires afterwards (both requests are mount one-shots).
  ///
  /// The gate cannot block the install bookkeeping (`setFirstFocus`
  /// registers the nested scopes up the ancestor chain unconditionally),
  /// so [_repairFocusLineage] re-requests the current external focus once
  /// the gate opens: a no-op visually (focus does not move) that refreshes
  /// the ancestor `focusedChild` stacks the install clobbered.
  bool _installed = false;

  @override
  void initState() {
    super.initState();
    // Two post-frames cover the mount requests and the route-push
    // microtasks; both fire while the gate is closed.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        setState(() => _installed = true);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _repairFocusLineage();
        });
      });
    });
  }

  /// Re-requests the current focus when it sits outside the hero, refreshing
  /// ancestor focus bookkeeping without moving focus.
  void _repairFocusLineage() {
    if (!mounted) {
      return;
    }
    final FocusNode? focus = FocusManager.instance.primaryFocus;
    final Element? focused = focus?.context as Element?;
    final Element? self = context as Element?;
    if (focus == null || focused == null || self == null) {
      return;
    }
    bool inside = false;
    focused.visitAncestorElements((Element ancestor) {
      if (identical(ancestor, self)) {
        inside = true;
        return false;
      }
      return true;
    });
    if (!inside) {
      focus.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      canRequestFocus: _installed,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double width = constraints.maxWidth;
          if (!width.isFinite || width < kHeroWideWidth) {
            return _NarrowHero(
              frame: _narrowFrame,
              onFrame: (DeviceFrameId frame) =>
                  setState(() => _narrowFrame = frame),
            );
          }
          return SizedBox(
            height: kHeroWideHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for (final DeviceFrameId id in kHeroFrames)
                  Expanded(
                    flex: id == DeviceFrameId.desktop ? 2 : 1,
                    child: _ScaledFrame(id: id),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// One frame plus the device switcher (narrow screens).
class _NarrowHero extends StatelessWidget {
  /// Creates the narrow hero around [frame].
  const _NarrowHero({required this.frame, required this.onFrame});

  /// The visible frame.
  final DeviceFrameId frame;

  /// Called with the newly selected frame.
  final ValueChanged<DeviceFrameId> onFrame;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (final DeviceFrameId id in kHeroFrames) ...<Widget>[
              Button(
                key: ValueKey<String>('hero-device-${id.queryValue}'),
                variant: id == frame
                    ? ButtonVariant.secondary
                    : ButtonVariant.ghost,
                size: ButtonSize.sm,
                onPressed: () => onFrame(id),
                child: Text(_heroLabel(id)),
              ),
              Gap(theme.spacing.xs),
            ],
          ],
        ),
        Gap(theme.spacing.sm),
        SizedBox(
          height: kHeroNarrowHeight,
          child: _ScaledFrame(id: frame),
        ),
      ],
    );
  }
}

/// One device frame, scaled to fit its slot.
class _ScaledFrame extends StatelessWidget {
  /// Creates the scaled frame for [id].
  const _ScaledFrame({required this.id});

  /// The frame spec to render.
  final DeviceFrameId id;

  @override
  Widget build(BuildContext context) {
    final DeviceSpec spec = specForFrame(id)!;
    const DeviceOrientation orientation = DeviceOrientation.portrait;
    final Size total = spec.totalFor(orientation);
    return KeyedSubtree(
      key: ValueKey<String>('hero-frame-${id.queryValue}'),
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox.fromSize(
          size: total,
          child: DeviceFrame(
            spec: spec,
            orientation: orientation,
            child: demoAuthFlow(),
          ),
        ),
      ),
    );
  }
}

/// Short switcher label per frame.
String _heroLabel(DeviceFrameId id) {
  return switch (id) {
    DeviceFrameId.iphone => 'iPhone',
    DeviceFrameId.android => 'Android',
    DeviceFrameId.desktop => 'Desktop',
    _ => id.queryValue,
  };
}
