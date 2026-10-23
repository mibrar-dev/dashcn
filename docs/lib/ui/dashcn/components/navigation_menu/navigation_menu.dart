// The `navigation_menu` component: bar of entries with anchored dropdown
// panels sized to their content, like upstream's navigation menu.

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/data.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/layout.dart';
import '../../primitives/overlay.dart';
import '../../primitives/popover_controller.dart';
import '../../primitives/popover_layout.dart';
import '../../primitives/text/text_extension.dart';
import '../../theme/color_tokens.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import '../outlined_container/outlined_container.dart';
import 'navigation_menu_style.dart';

export 'navigation_menu_style.dart';

/// Hover delay before an entry opens (upstream `delay`).
const Duration _openDelay = Duration(milliseconds: 80);

/// Grace before the panel closes after the pointer leaves.
const Duration _closeDelay = Duration(milliseconds: 150);

/// Panel cap when the theme leaves `maxWidth` unset.
const double _fallbackMaxWidth = 480;

/// Accent fill while an entry's panel is open.
const ButtonVariantStyle _activeRow = ButtonVariantStyle(
  background: StateValue(rest: ThemedColor.ref(ColorRef.muted, alpha: 0.8)),
);

/// Panel margin for placement and for panel sizing (single definition).
EdgeInsets _panelMargin(
  NavigationMenuTheme style,
  ThemeData ambient,
  TextDirection direction,
) {
  final EdgeInsetsGeometry raw =
      style.margin ?? EdgeInsets.all(ambient.density.baseGap * ambient.scaling);
  return raw.resolve(direction);
}

/// Horizontal bar of entries with dropdown content.
class NavigationMenu extends StatefulWidget {
  const NavigationMenu({
    super.key,
    this.surfaceOpacity,
    this.surfaceBlur,
    required this.children,
    this.theme,
  });

  final double? surfaceOpacity;
  final double? surfaceBlur;
  final List<Widget> children;

  /// Widget-leg theme override, merged over the other legs.
  final NavigationMenuTheme? theme;

  @override
  State<NavigationMenu> createState() => NavigationMenuState();
}

/// State of [NavigationMenu]; items reach it for activation and closing.
class NavigationMenuState extends State<NavigationMenu> {
  final PopoverController _popovers = PopoverController();
  final ValueNotifier<int> _version = ValueNotifier<int>(0);
  final Map<NavigationMenuItemState, WidgetBuilder> _content = {};
  final List<NavigationMenuItemState> _items = <NavigationMenuItemState>[];
  final FocusNode _panelFocus = FocusNode(debugLabel: 'NavigationMenuPanel');
  NavigationMenuItemState? _activeItem;
  FocusNode? _returnFocus;
  Timer? _openTimer;
  Timer? _closeTimer;

  NavigationMenuTheme _resolve(BuildContext context) =>
      resolveComponentStyle<NavigationMenuTheme, NavigationMenuTheme>(
        context,
        widget: widget.theme,
        select: (t) => t,
        defaults: navigationMenuDefaults,
      );

  /// Whether any entry's panel is open.
  bool get isOpen => _popovers.hasOpenPopover;

  bool isActive(NavigationMenuItemState item) {
    return _popovers.hasOpenPopover && identical(_activeItem, item);
  }

  void _register(NavigationMenuItemState item) {
    if (!_items.contains(item)) _items.add(item);
  }

  void _unregister(NavigationMenuItemState item) {
    _items.remove(item);
    _content.remove(item);
    if (identical(_activeItem, item)) _activeItem = null;
  }

  void _cancelTimers() {
    _openTimer?.cancel();
    _openTimer = null;
    _closeTimer?.cancel();
    _closeTimer = null;
  }

  /// Pointer re-entered the bar or panel: drop a pending close.
  void keepOpen() {
    _closeTimer?.cancel();
    _closeTimer = null;
  }

  /// Hover entry: plain entries close, dropdowns open after [_openDelay].
  void scheduleOpen(NavigationMenuItemState item) {
    _closeTimer?.cancel();
    _closeTimer = null;
    if (item.widget.content == null) {
      close();
      return;
    }
    if (isActive(item)) return;
    _openTimer?.cancel();
    _openTimer = Timer(_openDelay, () {
      if (mounted) openItem(item);
    });
  }

  /// Hover exit: closes after [_closeDelay] unless re-entered.
  void scheduleClose() {
    _openTimer?.cancel();
    _openTimer = null;
    _closeTimer?.cancel();
    _closeTimer = Timer(_closeDelay, () {
      if (mounted) close();
    });
  }

  /// Opens [item]'s content (or closes when it has none).
  void openItem(NavigationMenuItemState item) {
    if (item.widget.content == null) {
      close();
      return;
    }
    _cancelTimers();
    _activeItem = item;
    _returnFocus = item.focusNode;
    _version.value++;
    _show(item.context);
  }

  /// Closes the panel, optionally returning focus to its trigger.
  void close({bool returnFocus = false}) {
    _cancelTimers();
    _activeItem = null;
    _version.value++;
    _popovers.close();
    if (returnFocus) _returnFocus?.requestFocus();
  }

  /// Arrow walk across triggers; the panel follows the landing entry.
  void move(NavigationMenuItemState from, int delta) {
    if (_items.length < 2) return;
    final bool rtl = Directionality.of(from.context) == TextDirection.rtl;
    final int step = rtl ? -delta : delta;
    final int start = _items.indexOf(from);
    if (start < 0) return;
    for (int i = 1; i <= _items.length; i++) {
      int next = (start + step * i) % _items.length;
      if (next < 0) next += _items.length;
      final NavigationMenuItemState candidate = _items[next];
      if (!candidate._enabled) continue;
      if (candidate.widget.content != null) {
        openItem(candidate);
      } else {
        close();
      }
      candidate.focusNode.requestFocus();
      return;
    }
  }

  void _show(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final NavigationMenuTheme style = _resolve(context);
    final double scale = ambient.scaling;
    if (_popovers.hasOpenPopover) {
      _popovers.anchorContext = context;
      return;
    }
    final TextDirection direction = Directionality.of(context);
    _popovers.show<void>(
      context: context,
      alignment: AlignmentDirectional.topStart,
      anchorAlignment: AlignmentDirectional.bottomStart,
      regionGroupId: this,
      offset: style.offset ?? Offset(0, ambient.density.baseGap * scale * 0.5),
      modal: false,
      dismissBackdropFocus: false,
      margin: _panelMargin(style, ambient, direction),
      allowInvertHorizontal: true,
      allowInvertVertical: true,
      builder: (context) => _MenuPopover(menu: this, style: style),
    );
  }

  @override
  void dispose() {
    _cancelTimers();
    _version.dispose();
    _panelFocus.dispose();
    _popovers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      hitTestBehavior: HitTestBehavior.translucent,
      onEnter: (_) => keepOpen(),
      onExit: (_) => scheduleClose(),
      child: IntrinsicHeight(
        child: Data<NavigationMenuState>.inherit(
          data: this,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: widget.children,
          ),
        ),
      ),
    );
  }
}

/// Popover surface of the open entry: popover tokens, hugged to the content
/// and capped by the theme (never the window width).
class _MenuPopover extends StatelessWidget {
  const _MenuPopover({required this.menu, required this.style});

  final NavigationMenuState menu;
  final NavigationMenuTheme style;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final double opacity =
        menu.widget.surfaceOpacity ??
        style.surfaceOpacity ??
        ambient.surfaceOpacity ??
        1;
    final double blur =
        menu.widget.surfaceBlur ??
        style.surfaceBlur ??
        ambient.surfaceBlur ??
        0;
    final EdgeInsets margin = _panelMargin(
      style,
      ambient,
      Directionality.of(context),
    );
    return MouseRegion(
      hitTestBehavior: HitTestBehavior.translucent,
      onEnter: (_) => menu.keepOpen(),
      onExit: (_) => menu.scheduleClose(),
      child: Shortcuts(
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.escape): DismissIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            DismissIntent: CallbackAction<DismissIntent>(
              onInvoke: (_) {
                menu.close(returnFocus: true);
                return null;
              },
            ),
          },
          child: PopoverHugWidth(
            maxWidth: style.maxWidth ?? _fallbackMaxWidth,
            gutter: margin.horizontal,
            child: OutlinedContainer(
              surfaceOpacity: opacity,
              surfaceBlur: blur,
              theme: OutlinedContainerTheme(
                backgroundColor: const ThemedColor.ref(ColorRef.popover),
                borderColor: const ThemedColor.ref(ColorRef.border),
                borderRadius: ambient.borderRadiusMd,
                boxShadow: ambient.tokens.shadows.shadowMd,
              ),
              padding: resolveEdgeInsets(
                style.padding ?? EdgeInsets.zero,
                ambient.density.baseContentPadding * ambient.scaling,
              ),
              child: Focus(
                focusNode: menu._panelFocus,
                child: AnimatedBuilder(
                  animation: menu._version,
                  builder: (context, _) {
                    final NavigationMenuItemState? item = menu._activeItem;
                    final WidgetBuilder? content = item == null
                        ? null
                        : menu._content[item];
                    // Block the outer menu scope inside popover content.
                    return Data<NavigationMenuState>.boundary(
                      child: content?.call(context) ?? const SizedBox.shrink(),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// One menu entry: action button, content trigger, or both.
class NavigationMenuItem extends StatefulWidget {
  const NavigationMenuItem({
    super.key,
    this.onPressed,
    this.content,
    required this.child,
  });

  final VoidCallback? onPressed;

  final Widget? content;
  final Widget child;

  @override
  State<NavigationMenuItem> createState() => NavigationMenuItemState();
}

class NavigationMenuItemState extends State<NavigationMenuItem> {
  NavigationMenuState? _menu;
  late final FocusNode _node = FocusNode(
    debugLabel: 'NavigationMenuItem',
    onKeyEvent: _handleKey,
  );

  /// This entry's focus node, for keyboard traversal and focus return.
  FocusNode get focusNode => _node;

  bool get _enabled => widget.onPressed != null || widget.content != null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _menu?._unregister(this);
    _menu = Data.maybeOf<NavigationMenuState>(context);
    assert(
      _menu != null,
      'NavigationMenuItem must descend from NavigationMenu',
    );
    _menu!._register(this);
    if (widget.content != null) {
      _menu!._content[this] = (context) => widget.content!;
    }
  }

  @override
  void didUpdateWidget(covariant NavigationMenuItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.content != oldWidget.content && _menu != null) {
      if (widget.content != null) {
        _menu!._content[this] = (context) => widget.content!;
      } else {
        _menu!._content.remove(this);
      }
    }
  }

  @override
  void dispose() {
    _menu?._unregister(this);
    _node.dispose();
    super.dispose();
  }

  /// Arrow/Down/Escape handling, ahead of the button's own key bindings.
  KeyEventResult _handleKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    final NavigationMenuState? menu = _menu;
    if (menu == null) return KeyEventResult.ignored;
    final LogicalKeyboardKey key = event.logicalKey;
    final bool rtl = Directionality.of(context) == TextDirection.rtl;
    if (key == LogicalKeyboardKey.arrowLeft) {
      menu.move(this, rtl ? 1 : -1);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowRight) {
      menu.move(this, rtl ? -1 : 1);
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowDown) {
      if (widget.content != null) {
        menu.openItem(this);
        // The entry mounts on the next frame; focus then lands in the panel.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) menu._panelFocus.requestFocus();
        });
      }
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.escape) {
      if (!menu.isOpen) return KeyEventResult.ignored;
      menu.close(returnFocus: true);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final NavigationMenuState menu = _menu!;
    return AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[menu._version, menu._popovers]),
      builder: (context, _) {
        final bool active = menu.isActive(this);
        // MouseRegion, not Button.onHover: the Clickable hover callback is
        // strategy-gated and never fires in widget tests.
        return MouseRegion(
          hitTestBehavior: HitTestBehavior.translucent,
          onEnter: (_) => menu.scheduleOpen(this),
          child: Button(
            variant: ButtonVariant.ghost,
            focusNode: _node,
            theme: active ? _activeRow : null,
            trailing: widget.content != null
                ? AnimatedRotation(
                    duration: const Duration(milliseconds: 150),
                    turns: active ? 0.5 : 0,
                    child: const Icon(LucideIcons.chevronDown, size: 12),
                  )
                : null,
            onPressed: _enabled
                ? () {
                    widget.onPressed?.call();
                    if (widget.content != null) {
                      if (menu.isActive(this)) {
                        menu.close();
                      } else {
                        menu.openItem(this);
                      }
                    }
                  }
                : null,
            child: widget.child,
          ),
        );
      },
    );
  }
}

class NavigationMenuContent extends StatelessWidget {
  const NavigationMenuContent({
    super.key,
    required this.title,
    this.content,
    this.leading,
    this.trailing,
    this.onPressed,
  });

  final Widget title;
  final Widget? content;
  final Widget? leading;
  final Widget? trailing;

  /// Action on press (closes the menu first).
  final VoidCallback? onPressed;

  /// Clamps plain-text descriptions to two lines (upstream `line-clamp-2`).
  static Widget? _clamped(Widget? content) {
    if (content is Text && content.maxLines == null) {
      return Text.rich(
        content.textSpan ?? TextSpan(text: content.data),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        softWrap: content.softWrap,
        textAlign: content.textAlign,
        textDirection: content.textDirection,
        locale: content.locale,
        textScaler: content.textScaler,
        semanticsLabel: content.semanticsLabel,
      );
    }
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Button(
      variant: ButtonVariant.ghost,
      onPressed: onPressed == null
          ? null
          : () {
              closeOverlay(context);
              onPressed!();
            },
      leading: leading,
      trailing: trailing,
      // SIZING.md: the title and the description sit 4 px apart inside one
      // item (the Basic default); the list below spaces items 8 px apart.
      child: Basic(
        title: title.medium(),
        content: _clamped(content)?.muted(),
        titleSpacing: 4,
        mainAxisAlignment: MainAxisAlignment.start,
      ),
    );
  }
}

/// Grid of content entries; rows share equal-width columns.
class NavigationMenuContentList extends StatelessWidget {
  const NavigationMenuContentList({
    super.key,
    required this.children,
    this.crossAxisCount = 3,
    this.spacing,
    this.runSpacing,
    this.reverse = false,
  });

  final List<Widget> children;
  final int crossAxisCount;
  final double? spacing;
  final double? runSpacing;

  /// Whether to reverse the order (for RTL).
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final double scale = ambient.scaling;
    final double gap = spacing ?? ambient.density.baseGap * scale;
    // SIZING.md: 8 px between items (the 4 px scale), in both directions.
    final double rowGap = runSpacing ?? 8 * scale;
    final List<Widget> ordered = reverse
        ? children.reversed.toList()
        : children;
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < ordered.length; i += crossAxisCount) {
      final List<Widget> cells = ordered
          .skip(i)
          .take(crossAxisCount)
          .map((Widget cell) => Expanded(child: cell))
          .toList();
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _spaced(cells, SizedBox(width: gap)),
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: _spaced(rows, SizedBox(height: rowGap)),
    );
  }

  static List<Widget> _spaced(List<Widget> widgets, Widget separator) {
    final List<Widget> out = <Widget>[];
    for (int i = 0; i < widgets.length; i++) {
      if (i > 0) out.add(separator);
      out.add(widgets[i]);
    }
    return out;
  }
}
