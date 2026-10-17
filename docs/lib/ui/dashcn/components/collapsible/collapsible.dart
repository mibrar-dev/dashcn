// The `collapsible` component: an expandable section that keeps its own
// open/close state by default.
//
// `Collapsible` provides the expansion state through `foundation/data.dart`;
// `CollapsibleTrigger` toggles it and `CollapsibleContent` hides or shows its
// child. The trigger icon is the component's `Button` (ghost, icon size).

import 'package:flutter/widgets.dart';

import '../../foundation/data.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/clickable.dart';
import '../../primitives/motion/motion_chevron.dart';
import '../../primitives/motion/motion_scope.dart';
import '../../primitives/text/text_extension.dart';
import '../../primitives/touch_hit_area.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import 'collapsible_style.dart';

export 'collapsible_style.dart';

/// Expansion state shared with the trigger and content widgets.
class _CollapsibleData {
  const _CollapsibleData({required this.isExpanded, required this.toggle});

  final bool isExpanded;
  final VoidCallback toggle;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _CollapsibleData &&
          other.isExpanded == isExpanded &&
          other.toggle == toggle;

  @override
  int get hashCode => Object.hash(isExpanded, toggle);
}

/// An expandable section.
///
/// ```dart
/// Collapsible(
///   children: <Widget>[
///     const CollapsibleTrigger(child: Text('Recent activity')),
///     CollapsibleContent(child: activityList),
///   ],
/// );
/// ```
class Collapsible extends StatefulWidget {
  /// Creates a collapsible section.
  const Collapsible({
    super.key,
    required this.children,
    this.isExpanded,
    this.onExpansionChanged,
    this.theme,
  });

  /// Usually one [CollapsibleTrigger] followed by [CollapsibleContent]s.
  final List<Widget> children;

  /// Expanded state. Non-null makes the widget controlled; null lets it keep
  /// its own state.
  final bool? isExpanded;

  /// Called with the **new** expansion state when the trigger is tapped.
  final ValueChanged<bool>? onExpansionChanged;

  /// Widget-leg style override, merged on top of the other resolver legs.
  final CollapsibleTheme? theme;

  @override
  State<Collapsible> createState() => CollapsibleState();
}

/// State of [Collapsible]: owns the uncontrolled flag and the toggle action.
class CollapsibleState extends State<Collapsible> {
  bool _uncontrolledExpanded = false;

  bool get _isExpanded => widget.isExpanded ?? _uncontrolledExpanded;

  /// Flips the section and reports the new state.
  void toggle() {
    final bool next = !_isExpanded;
    if (widget.isExpanded == null) {
      setState(() {
        _uncontrolledExpanded = next;
      });
    }
    widget.onExpansionChanged?.call(next);
  }

  @override
  Widget build(BuildContext context) {
    final CollapsibleTheme resolved =
        resolveComponentStyle<CollapsibleTheme, CollapsibleTheme>(
          context,
          widget: widget.theme,
          select: (t) => t,
          defaults: collapsibleDefaults,
        );
    return Data<_CollapsibleData>.inherit(
      data: _CollapsibleData(isExpanded: _isExpanded, toggle: toggle),
      child: IntrinsicWidth(
        child: Column(
          // P7-TH1: shrink-wrap so a staged collapsible centres instead of
          // pinning its trigger to the top of a tall parent.
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              resolved.crossAxisAlignment ?? CrossAxisAlignment.stretch,
          mainAxisAlignment:
              resolved.mainAxisAlignment ?? MainAxisAlignment.start,
          children: widget.children,
        ),
      ),
    );
  }
}

/// The tappable header of a [Collapsible].
class CollapsibleTrigger extends StatelessWidget {
  /// Creates a trigger with [child] as its label.
  const CollapsibleTrigger({super.key, required this.child, this.theme});

  /// Content shown next to the expand/collapse icon.
  final Widget child;

  /// Widget-leg style override, merged on top of the other resolver legs.
  final CollapsibleTheme? theme;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final CollapsibleTheme resolved =
        resolveComponentStyle<CollapsibleTheme, CollapsibleTheme>(
          context,
          widget: theme,
          select: (t) => t,
          defaults: collapsibleDefaults,
        );
    final _CollapsibleData data = Data.of<_CollapsibleData>(context);
    final double padding =
        resolved.padding ??
        (resolved.themeDensity ?? ambient.density).baseContentPadding *
            ambient.scaling;
    final double iconGap = resolved.iconGap ?? 16 * ambient.scaling;
    // The trigger icon swaps and rotates 180 degrees on expand, so the
    // trigger matches the accordion motion. The end states are unchanged.
    final IconData icon = data.isExpanded
        ? resolved.iconExpanded ?? LucideIcons.chevronsDownUp
        : resolved.iconCollapsed ?? LucideIcons.chevronsUpDown;
    final IconThemeData iconTheme = IconThemeData(
      size:
          ambient.iconTheme.xSmall.size ??
          ambient.iconTheme.small.size ??
          16 * ambient.scaling,
      color: ambient.colors.mutedForeground,
    );

    return Semantics(
      button: true,
      expanded: data.isExpanded,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // The whole label toggles, like upstream's `CollapsibleTrigger`;
            // the icon `Button` stays a sibling (never nested), so a tap
            // lands on exactly one of the two controls.
            Expanded(
              // The label line is 14px tall: touch platforms pad it to the
              // 48px minimum (transparent, visuals unchanged).
              child: TouchHitArea(
                vertical: 17,
                child: Clickable(
                  onPressed: data.toggle,
                  child: child.small.semiBold,
                ),
              ),
            ),
            Gap(iconGap),
            // The outer node already announces the button and its expanded
            // state; the icon control is excluded so it never reports a
            // second, unlabeled tap target for the same action.
            ExcludeSemantics(
              child: Button(
                variant: ButtonVariant.ghost,
                size: ButtonSize.icon,
                onPressed: data.toggle,
                child: MotionChevron(
                  expanded: data.isExpanded,
                  child: IconTheme(data: iconTheme, child: Icon(icon)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The content pane of a [Collapsible].
class CollapsibleContent extends StatelessWidget {
  /// Creates a content pane.
  const CollapsibleContent({
    super.key,
    this.collapsible = true,
    required this.child,
  });

  /// Whether this pane follows the section's expansion state.
  final bool collapsible;

  /// The widget shown while expanded.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final _CollapsibleData data = Data.of<_CollapsibleData>(context);
    final bool show = !collapsible || data.isExpanded;
    // AnimatedSize cannot run a zero-duration animation (it mutates itself
    // mid-layout), so reduced motion keeps the plain offstage swap.
    if (motionReduced(context)) {
      return Offstage(offstage: !show, child: child);
    }
    final ThemeData motionTheme = Theme.of(context);
    // Size plus fade with the accordion timing: the offstage child reports
    // zero size while collapsed, and `AnimatedSize` bridges the gap.
    return AnimatedSize(
      duration: motionTheme.motion.durations.base,
      alignment: Alignment.topCenter,
      child: AnimatedOpacity(
        duration: motionTheme.motion.durations.base,
        opacity: show ? 1.0 : 0.0,
        child: Offstage(offstage: !show, child: child),
      ),
    );
  }
}
