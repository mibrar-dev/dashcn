// The `breadcrumb` component: a horizontal trail of crumbs with a separator
// between each pair.
//
// Ported from `components/navigation/breadcrumb`. The old tree wrapped each
// crumb in `shared/primitives/text` modifiers (`.medium()`, `.small()`,
// `.muted()`, `.foreground()`); those now come from `primitives/text`. The
// default separator is the upstream chevron; a slash separator is provided too.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/clickable.dart';
import '../../primitives/text/text_extension.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import 'breadcrumb_style.dart';

export 'breadcrumb_style.dart';

/// A horizontal breadcrumb trail, scrollable when it overflows.
///
/// The last crumb is drawn in the body foreground; every earlier crumb and the
/// separators use the muted foreground.
///
/// ```dart
/// const Breadcrumb(
///   children: <Widget>[
///     Text('Home'),
///     Text('Settings'),
///     Text('Profile'),
///   ],
/// );
/// ```
class Breadcrumb extends StatelessWidget {
  /// Creates a breadcrumb trail.
  const Breadcrumb({
    super.key,
    required this.children,
    this.separator,
    this.padding,
    this.theme,
  });

  /// Chevron separator (the upstream default).
  static const Widget arrowSeparator = _BreadcrumbArrowSeparator();

  /// Slash separator.
  static const Widget slashSeparator = _BreadcrumbSlashSeparator();

  /// Crumbs, ordered from root to the current location.
  final List<Widget> children;

  /// Separator override; null resolves [BreadcrumbTheme.separator] and then
  /// [arrowSeparator].
  final Widget? separator;

  /// Padding around the strip; null resolves [BreadcrumbTheme.padding].
  final EdgeInsetsGeometry? padding;

  /// Widget-leg theme override, merged on top of the other legs.
  final BreadcrumbTheme? theme;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final BreadcrumbTheme style =
        resolveComponentStyle<BreadcrumbTheme, BreadcrumbTheme>(
          context,
          widget: theme,
          select: (t) => t,
          defaults: breadcrumbDefaults,
        );
    final Widget effectiveSeparator =
        separator ?? style.separator ?? arrowSeparator;
    final EdgeInsetsGeometry effectivePadding =
        padding ?? style.padding ?? EdgeInsets.zero;
    // Upstream 6 px separator gap: the default-density gap minus 2 px, so it
    // tracks the density scale instead of staying fixed.
    final double spacing =
        (style.spacing ?? ambient.density.baseGap - 2) * ambient.scaling;

    final List<Widget> row = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      if (i > 0) {
        row
          ..add(SizedBox(width: spacing))
          ..add(effectiveSeparator)
          ..add(SizedBox(width: spacing));
      }
      row.add(_crumb(children[i], isLast: i == children.length - 1));
    }

    return ScrollConfiguration(
      // A breadcrumb is not a scroll surface: hide the scrollbar chrome.
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: effectivePadding,
          child: Row(mainAxisSize: MainAxisSize.min, children: row).small.muted,
        ),
      ),
    );
  }

  /// Styles one crumb: medium weight, foreground only for the current one.
  Widget _crumb(Widget child, {required bool isLast}) {
    final Widget styled = child.medium;
    return isLast ? styled.foreground : styled;
  }
}

/// An interactive crumb: muted at rest, foreground with an underline on
/// hover/press/focus, activated by tap, Enter or Space through [Clickable].
///
/// Use for every crumb except the current page (plain `Text`, which
/// [Breadcrumb] already draws in the body foreground and which must stay a
/// non-link).
class BreadcrumbLink extends StatelessWidget {
  /// Creates an interactive crumb.
  const BreadcrumbLink({
    super.key,
    required this.onPressed,
    required this.child,
    this.focusNode,
    this.autofocus = false,
  });

  /// Called on tap, Enter or Space; null disables the link.
  final VoidCallback? onPressed;

  /// Crumb label, usually a `Text`.
  final Widget child;

  /// Focus node of the link.
  final FocusNode? focusNode;

  /// Whether the link requests focus when first built.
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    return Clickable(
      onPressed: onPressed,
      focusNode: focusNode,
      autofocus: autofocus,
      mouseCursor: const StateValue<MouseCursor>(
        rest: SystemMouseCursors.click,
        disabled: SystemMouseCursors.basic,
      ),
      textStyle: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return TextStyle(color: ambient.colors.mutedForeground);
        }
        if (states.contains(WidgetState.hovered) ||
            states.contains(WidgetState.pressed) ||
            states.contains(WidgetState.focused)) {
          return TextStyle(
            color: ambient.colors.foreground,
            decoration: TextDecoration.underline,
          );
        }
        return TextStyle(color: ambient.colors.mutedForeground);
      }),
      child: child,
    );
  }
}

/// The default chevron separator, coloured with `mutedForeground`.
class _BreadcrumbArrowSeparator extends StatelessWidget {
  const _BreadcrumbArrowSeparator();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double size = (theme.iconTheme.xSmall.size ?? 12) * theme.scaling;
    final bool rtl = Directionality.of(context) == TextDirection.rtl;
    return SizedBox.square(
      dimension: size,
      child: Icon(
        rtl ? LucideIcons.chevronLeft : LucideIcons.chevronRight,
        size: size,
        color: theme.colors.mutedForeground,
      ),
    );
  }
}

/// The `/` separator, coloured with `mutedForeground`.
class _BreadcrumbSlashSeparator extends StatelessWidget {
  const _BreadcrumbSlashSeparator();

  @override
  Widget build(BuildContext context) {
    return const Text('/').small.muted;
  }
}
