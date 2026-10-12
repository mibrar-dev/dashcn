// Named examples for the `drawer` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// Drawers and sheets push over the WHOLE app (root navigator). The background
// scale demo hosts its own navigator + `DrawerScaleObserver`, so the
// ≈0.95 scale, rounded corners and dim read inside the stage.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import 'drawer.dart';

/// Panel body used by the drawer examples.
class _DrawerContent extends StatelessWidget {
  const _DrawerContent();

  @override
  Widget build(BuildContext context) {
    final theme = ShadcnTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Drawer content',
          style: TextStyle(
            color: theme.colors.foreground,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          'Slides in from the edge over the whole app.',
          style: TextStyle(color: theme.colors.mutedForeground),
        ),
        Gap(theme.spacing.lg),
        Button(
          size: ButtonSize.sm,
          onPressed: () => closeDrawer(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

/// Sheet body used by the sheet example.
class _SheetContent extends StatelessWidget {
  const _SheetContent();

  @override
  Widget build(BuildContext context) {
    final theme = ShadcnTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Sheet content',
          style: TextStyle(
            color: theme.colors.foreground,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(theme.spacing.md),
        Text(
          'An expanding bottom sheet with a drag handle.',
          style: TextStyle(color: theme.colors.mutedForeground),
        ),
        Gap(theme.spacing.lg),
        Button(
          variant: ButtonVariant.outline,
          size: ButtonSize.sm,
          onPressed: () => closeSheet(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}

/// Opens a drawer at [position].
class _DrawerTrigger extends StatelessWidget {
  const _DrawerTrigger({required this.position, required this.label});

  final OverlayPosition position;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Button(
      variant: ButtonVariant.outline,
      size: ButtonSize.sm,
      onPressed: () => openDrawer<void>(
        context: context,
        position: position,
        builder: (BuildContext context) => const _DrawerContent(),
      ),
      child: Text(label),
    );
  }
}

/// Side drawers, one row (shadcn shows the four edges together).
Widget _default(BuildContext context) {
  final spacing = ShadcnTheme.of(context).spacing;
  return Center(
    child: Wrap(
      spacing: spacing.sm,
      runSpacing: spacing.sm,
      alignment: WrapAlignment.center,
      children: const <Widget>[
        _DrawerTrigger(position: OverlayPosition.start, label: 'Open left'),
        _DrawerTrigger(position: OverlayPosition.end, label: 'Open right'),
        _DrawerTrigger(position: OverlayPosition.top, label: 'Open top'),
        _DrawerTrigger(position: OverlayPosition.bottom, label: 'Open bottom'),
      ],
    ),
  );
}

/// The bottom sheet form.
Widget _sheet(BuildContext context) {
  return Center(
    child: Button(
      variant: ButtonVariant.secondary,
      size: ButtonSize.sm,
      onPressed: () => openSheet<void>(
        context: context,
        draggable: true,
        builder: (BuildContext context) => const _SheetContent(),
      ),
      child: const Text('Open sheet'),
    ),
  );
}

/// Background-scale demo: its own navigator + observer, so the scale reads
/// inside the stage. Opening the drawer scales the mock app to ≈0.95 with
/// rounded corners and a dim.
class _ScaleDemo extends StatefulWidget {
  const _ScaleDemo();

  @override
  State<_ScaleDemo> createState() => _ScaleDemoState();
}

class _ScaleDemoState extends State<_ScaleDemo> {
  final DrawerScaleObserver _observer = DrawerScaleObserver();
  final GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final theme = ShadcnTheme.of(context);
    // A fixed box is inherent: the scale needs a mock app viewport to
    // transform, like toasts need a layer stage.
    return Center(
      child: SizedBox(
        width: 340,
        height: 300,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: theme.colors.border),
            borderRadius: theme.borderRadiusLg,
          ),
          child: ClipRRect(
            borderRadius: theme.borderRadiusLg,
            child: Navigator(
              key: _key,
              observers: <NavigatorObserver>[_observer],
              onGenerateRoute: (RouteSettings settings) =>
                  PageRouteBuilder<void>(
                    settings: settings,
                    pageBuilder: (_, _, _) => DrawerBackgroundScale(
                      observer: _observer,
                      child: ColoredBox(
                        color: theme.colors.background,
                        child: Center(
                          child: Builder(
                            builder: (BuildContext context) => Button(
                              variant: ButtonVariant.outline,
                              size: ButtonSize.sm,
                              onPressed: () => openDrawer<void>(
                                context: context,
                                useRootNavigator: false,
                                builder: (_) => const _DrawerContent(),
                              ),
                              child: const Text('Open scaled drawer'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _scale(BuildContext context) => const _ScaleDemo();

/// A drawer themed from the widget leg.
Widget _themed(BuildContext context) {
  return Center(
    child: Button(
      variant: ButtonVariant.secondary,
      size: ButtonSize.sm,
      onPressed: () => openDrawer<void>(
        context: context,
        theme: const DrawerTheme(
          maxSize: 280,
          background: ThemedColor.ref(ColorRef.card),
        ),
        builder: (BuildContext context) => const _DrawerContent(),
      ),
      child: const Text('Open themed drawer'),
    ),
  );
}

/// Named docs examples for `drawer`; the first entry is the default.
const List<ComponentPreview> drawerPreviews = <ComponentPreview>[
  ComponentPreview('Default', _default),
  ComponentPreview('Sheet', _sheet),
  ComponentPreview('Background scale', _scale),
  ComponentPreview('Themed', _themed),
];
