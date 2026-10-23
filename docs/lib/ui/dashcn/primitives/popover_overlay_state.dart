// State of `PopoverOverlayWidget`: anchor tracking, scroll/region handling,
// live configuration setters and the positioned build.
//
// Ported from `shared/primitives/_impl/state/popover_overlay_widget_state.dart`.

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../foundation/data.dart';
import '../foundation/geometry.dart';
import '../foundation/tween_utils.dart';
import '../theme/theme.dart';
import 'motion/motion_scope.dart';
import 'overlay.dart';
import 'popover_layout.dart';
import 'popover_overlay_widget.dart';

/// Framework-internal state of [PopoverOverlayWidget], the `onTickFollow` payload.
class PopoverOverlayWidgetState extends State<PopoverOverlayWidget>
    with SingleTickerProviderStateMixin, OverlayHandlerStateMixin {
  late BuildContext _anchorContext;
  late Offset? _position;
  late Offset? _offset;
  late AlignmentGeometry _alignment;
  late AlignmentGeometry _anchorAlignment;
  late PopoverConstraint _widthConstraint;
  late PopoverConstraint _heightConstraint;
  late EdgeInsetsGeometry? _margin;
  Size? _anchorSize;
  late bool _follow;
  late bool _allowInvertHorizontal;
  late bool _allowInvertVertical;
  PopupAdaptive? _adaptive;
  late Ticker _ticker;
  late LayerLink? _layerLink;
  Offset? _followAnchorDelta;
  ScrollableState? _scrollable;
  ScrollPosition? _scrollPosition;
  bool _isClosingForRegionLoss = false;

  @override
  void initState() {
    super.initState();
    _offset = widget.offset;
    _position = widget.position;
    _alignment = widget.alignment;
    _anchorSize = widget.anchorSize;
    _anchorAlignment = widget.anchorAlignment;
    _widthConstraint = widget.widthConstraint;
    _heightConstraint = widget.heightConstraint;
    _margin = widget.margin;
    _follow = widget.follow;
    _anchorContext = widget.anchorContext;
    _allowInvertHorizontal = widget.allowInvertHorizontal;
    _allowInvertVertical = widget.allowInvertVertical;
    _adaptive = widget.adaptive;
    _layerLink = widget.layerLink;
    _followAnchorDelta = null;
    _isClosingForRegionLoss = false;
    _ticker = createTicker((_) => _updatePosition());
    if (_follow && _layerLink == null) {
      _ticker.start();
    }
    _attachScrollListener();
    if (_follow) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _updatePosition();
        }
      });
    }
  }

  @override
  Future<void> close([bool immediate = false]) {
    if (!immediate) {
      return widget.onClose?.call() ?? Future.value();
    } else {
      widget.onImmediateClose?.call();
    }
    return Future.value();
  }

  @override
  void closeLater() {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          widget.onClose?.call();
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant PopoverOverlayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _alignment = widget.alignment;
    _anchorSize = widget.anchorSize;
    _anchorAlignment = widget.anchorAlignment;
    _widthConstraint = widget.widthConstraint;
    _heightConstraint = widget.heightConstraint;
    _offset = widget.offset;
    _margin = widget.margin;
    _follow = widget.follow;
    _adaptive = widget.adaptive;
    _layerLink = widget.layerLink;
    final shouldRunTicker = _follow && _layerLink == null;
    if (shouldRunTicker && !_ticker.isActive) {
      _ticker.start();
    } else if (!shouldRunTicker && _ticker.isActive) {
      _ticker.stop();
    }
    if (oldWidget.anchorContext != widget.anchorContext) {
      _anchorContext = widget.anchorContext;
      _attachScrollListener();
    }
    _allowInvertHorizontal = widget.allowInvertHorizontal;
    _allowInvertVertical = widget.allowInvertVertical;
    if (_follow) {
      _attachScrollListener();
      if (oldWidget.position != widget.position ||
          oldWidget.anchorAlignment != widget.anchorAlignment ||
          oldWidget.anchorContext != widget.anchorContext) {
        _followAnchorDelta = null;
      }
      _updatePosition();
    } else {
      _detachScrollListener();
    }
    if (oldWidget.position != widget.position && !_follow) {
      _position = widget.position;
    }
  }

  Size? get anchorSize => _anchorSize;

  AlignmentGeometry get anchorAlignment => _anchorAlignment;

  Offset? get position => _position;

  AlignmentGeometry get alignment => _alignment;

  PopoverConstraint get widthConstraint => _widthConstraint;

  PopoverConstraint get heightConstraint => _heightConstraint;

  Offset? get offset => _offset;

  EdgeInsetsGeometry? get margin => _margin;

  bool get follow => _follow;

  BuildContext get anchorContext => _anchorContext;

  bool get allowInvertHorizontal => _allowInvertHorizontal;

  bool get allowInvertVertical => _allowInvertVertical;

  PopupAdaptive? get adaptive => _adaptive;

  LayerLink? get layerLink => _layerLink;

  void _applyIfChanged(bool changed, VoidCallback apply) {
    if (changed) setState(apply);
  }

  set layerLink(LayerLink? value) {
    if (_layerLink != value) {
      setState(() {
        _layerLink = value;
        if (_follow && _layerLink == null) {
          if (!_ticker.isActive) {
            _ticker.start();
          }
        } else {
          _ticker.stop();
        }
      });
    }
  }

  @override
  set alignment(AlignmentGeometry value) {
    _applyIfChanged(_alignment != value, () => _alignment = value);
  }

  set position(Offset? value) {
    _applyIfChanged(_position != value, () => _position = value);
  }

  @override
  set anchorAlignment(AlignmentGeometry value) {
    _applyIfChanged(_anchorAlignment != value, () => _anchorAlignment = value);
  }

  @override
  set widthConstraint(PopoverConstraint value) {
    _applyIfChanged(_widthConstraint != value, () => _widthConstraint = value);
  }

  @override
  set heightConstraint(PopoverConstraint value) {
    _applyIfChanged(
      _heightConstraint != value,
      () => _heightConstraint = value,
    );
  }

  @override
  set margin(EdgeInsetsGeometry? value) {
    _applyIfChanged(_margin != value, () => _margin = value);
  }

  @override
  set follow(bool value) {
    if (_follow != value) {
      setState(() {
        _follow = value;
      });
      if (_follow) {
        if (_layerLink == null && !_ticker.isActive) {
          _ticker.start();
        }
        _attachScrollListener();
        _followAnchorDelta = null;
        _updatePosition();
      } else {
        if (_ticker.isActive) {
          _ticker.stop();
        }
        _detachScrollListener();
      }
    }
  }

  @override
  set anchorContext(BuildContext value) {
    if (_anchorContext != value) {
      setState(() {
        _anchorContext = value;
      });
      _attachScrollListener();
      if (_follow) {
        _followAnchorDelta = null;
        _updatePosition();
      }
    }
  }

  @override
  set allowInvertHorizontal(bool value) {
    _applyIfChanged(
      _allowInvertHorizontal != value,
      () => _allowInvertHorizontal = value,
    );
  }

  @override
  set allowInvertVertical(bool value) {
    _applyIfChanged(
      _allowInvertVertical != value,
      () => _allowInvertVertical = value,
    );
  }

  @override
  set adaptive(PopupAdaptive? value) {
    _applyIfChanged(_adaptive != value, () => _adaptive = value);
  }

  @override
  void dispose() {
    _detachScrollListener();
    _ticker.dispose();
    super.dispose();
  }

  Rect _globalRectForRenderBox(RenderBox box) =>
      box.localToGlobal(Offset.zero) & box.size;

  Rect? _resolveVisibleRegionRect() {
    final scrollableRenderObject = _scrollable?.context.findRenderObject();
    if (scrollableRenderObject is RenderBox && scrollableRenderObject.hasSize) {
      return _globalRectForRenderBox(scrollableRenderObject);
    }
    final overlayRenderObject = context.findRenderObject();
    if (overlayRenderObject is RenderBox && overlayRenderObject.hasSize) {
      return _globalRectForRenderBox(overlayRenderObject);
    }
    return null;
  }

  void _updatePosition() {
    if (!mounted || !anchorContext.mounted) return;
    final renderObject = anchorContext.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return;
    final anchorRect = _globalRectForRenderBox(renderObject);
    final visibleRegionRect = _resolveVisibleRegionRect();
    if (_follow &&
        visibleRegionRect != null &&
        !visibleRegionRect.overlaps(anchorRect)) {
      if (!_isClosingForRegionLoss) {
        _isClosingForRegionLoss = true;
        closeLater();
      }
      return;
    }
    _isClosingForRegionLoss = false;

    final pos = renderObject.localToGlobal(Offset.zero);
    final size = renderObject.size;
    final resolvedAnchorAlignment = _anchorAlignment.optionallyResolve(context);
    final anchorPosition = Offset(
      pos.dx + size.width / 2 + size.width / 2 * resolvedAnchorAlignment.x,
      pos.dy + size.height / 2 + size.height / 2 * resolvedAnchorAlignment.y,
    );
    Offset newPos = anchorPosition;
    if (_follow && widget.position != null) {
      _followAnchorDelta ??= widget.position! - anchorPosition;
      newPos = anchorPosition + _followAnchorDelta!;
    }
    if (_position != newPos || _anchorSize != size) {
      setState(() {
        _anchorSize = size;
        _position = newPos;
        widget.onTickFollow?.call(this);
      });
    }
  }

  void _attachScrollListener() {
    if (!_follow || !mounted || !anchorContext.mounted) return;
    final scrollable = Scrollable.maybeOf(anchorContext);
    if (scrollable == _scrollable && scrollable?.position == _scrollPosition) {
      return;
    }
    _detachScrollListener();
    _scrollable = scrollable;
    _scrollPosition = scrollable?.position;
    _scrollPosition?.addListener(_updatePosition);
  }

  void _detachScrollListener() {
    _scrollPosition?.removeListener(_updatePosition);
    _scrollPosition = null;
    _scrollable = null;
  }

  @override
  Widget build(BuildContext context) {
    Widget childWidget = Data<OverlayHandlerStateMixin>.inherit(
      data: this,
      child: TapRegion(
        onTapOutside: widget.onTapOutside != null
            ? (event) {
                widget.onTapOutside?.call();
              }
            : null,
        groupId: widget.regionGroupId,
        child: MediaQuery.removePadding(
          context: context,
          removeBottom: true,
          removeLeft: true,
          removeRight: true,
          removeTop: true,
          child: Builder(
            builder: (context) {
              final theme = Theme.of(context);
              final scaling = theme.scaling;
              if (_usesSheet(context, theme)) {
                return _buildSheet(context, theme);
              }
              return PopoverLayout(
                alignment: _alignment.optionallyResolve(context),
                position: _position,
                anchorSize: _anchorSize,
                anchorAlignment: _anchorAlignment.optionallyResolve(context),
                widthConstraint: _widthConstraint,
                heightConstraint: _heightConstraint,
                offset: _offset,
                margin:
                    _margin?.optionallyResolve(context) ??
                    (const EdgeInsets.all(8) * scaling),
                // Enter: scale 0.95 to 1 from the anchor side. Exit and
                // reduced motion: fade only (the scale holds at 1).
                scale:
                    widget.closing ||
                        motionReduced(context) ||
                        !widget.scaleOnEnter
                    ? 1.0
                    : tweenValue(0.95, 1.0, widget.animation),
                scaleAlignment: (widget.transitionAlignment ?? _alignment)
                    .optionallyResolve(context),
                allowInvertVertical: _allowInvertVertical,
                allowInvertHorizontal: _allowInvertHorizontal,
                child: _enterSlide(
                  context,
                  FadeTransition(
                    opacity: AlwaysStoppedAnimation<double>(widget.animation),
                    child: Builder(
                      builder: (context) => widget.builder(context),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
    if (widget.themes != null) {
      childWidget = widget.themes!.wrap(childWidget);
    }
    if (widget.data != null) {
      childWidget = widget.data!.wrap(childWidget);
    }
    return childWidget;
  }

  /// Tooltips (no scale) travel 4 px from the anchor side while they enter;
  /// the offset is the popover alignment times 4 px, so it starts closest to
  /// the anchor and settles at zero. Exits and reduced motion do not move.
  Widget _enterSlide(BuildContext context, Widget child) {
    if (widget.scaleOnEnter || widget.closing || motionReduced(context)) {
      return child;
    }
    final Alignment side = _alignment.optionallyResolve(context);
    return Transform.translate(
      offset: Offset(side.x * 4, side.y * 4) * (1 - widget.animation),
      child: child,
    );
  }

  bool _usesSheet(BuildContext context, ThemeData theme) {
    final PopupAdaptive effective =
        _adaptive ?? widget.adaptive ?? theme.popupAdaptive;
    if (effective == PopupAdaptive.anchored) return false;
    if (effective == PopupAdaptive.sheet) return true;
    final double anchorWidth = _anchorContext.mounted
        ? (MediaQuery.maybeSizeOf(_anchorContext)?.width ??
              MediaQuery.sizeOf(context).width)
        : MediaQuery.sizeOf(context).width;
    // Empty MediaQueryData (size 0, used by existing tests) means
    // unspecified: keep the desktop anchored default.
    if (anchorWidth <= 0) return false;
    return popupUsesSheet(anchorWidth, PopupAdaptive.auto);
  }

  Rect _viewportRect(BuildContext context) {
    final Size viewport = _anchorContext.mounted
        ? (MediaQuery.maybeSizeOf(_anchorContext) ?? MediaQuery.sizeOf(context))
        : MediaQuery.sizeOf(context);
    final RenderObject? anchorBox = _anchorContext.mounted
        ? _anchorContext.findRenderObject()
        : null;
    if (anchorBox is RenderBox && anchorBox.hasSize) {
      RenderObject? cur = anchorBox.parent;
      while (cur != null) {
        if (cur is RenderBox &&
            cur.hasSize &&
            (cur.size.width - viewport.width).abs() < 0.5 &&
            (cur.size.height - viewport.height).abs() < 0.5) {
          final Offset origin = cur.localToGlobal(Offset.zero);
          return origin & cur.size;
        }
        cur = cur.parent;
      }
    }
    // Faked MediaQuery sizes (tests) have no matching RenderBox: trust the
    // MediaQuery size and position at the overlay origin. Only when the
    // MediaQuery is empty (size 0, unspecified) fall back to the real
    // overlay box so sheets still have a size.
    if (viewport.width > 0 && viewport.height > 0) {
      return Offset.zero & viewport;
    }
    final RenderObject? overlayBox = context.findRenderObject();
    if (overlayBox is RenderBox && overlayBox.hasSize) {
      return Offset.zero & overlayBox.size;
    }
    final Size overlay = MediaQuery.sizeOf(context);
    return Offset.zero & overlay;
  }

  Widget _buildSheet(BuildContext context, ThemeData theme) {
    final Rect viewport = _viewportRect(context);
    final double sheetWidth = (viewport.width - kPopupSheetGutter * 2).clamp(
      0.0,
      viewport.width,
    );
    final double sheetMaxHeight =
        viewport.height * kPopupSheetMaxHeightFraction;
    final Color handleColor = theme.colors.muted;
    final Widget content = ConstrainedBox(
      constraints: BoxConstraints(minWidth: sheetWidth, maxWidth: sheetWidth),
      child: FadeTransition(
        opacity: AlwaysStoppedAnimation<double>(widget.animation),
        child: Builder(builder: (context) => widget.builder(context)),
      ),
    );
    final Widget handle = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta != null && details.primaryDelta! > 12) {
          widget.onClose?.call();
        }
      },
      onVerticalDragEnd: (details) {
        final double velocity = details.primaryVelocity ?? 0;
        if (velocity > 300) {
          widget.onClose?.call();
        }
      },
      child: Center(
        child: Container(
          key: const ValueKey<String>('dashcn.popup.sheet.handle'),
          width: 36,
          height: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: handleColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
    final Widget sheet = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[handle, content],
    );
    final double left = viewport.left + kPopupSheetGutter;
    final double bottom = MediaQuery.sizeOf(context).height - viewport.bottom;
    final double bottomOffset = (bottom > 0 ? bottom : 0) + kPopupSheetGutter;
    return Stack(
      children: <Widget>[
        Positioned(
          left: left,
          width: sheetWidth,
          bottom: bottomOffset,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: sheetMaxHeight),
            child: SingleChildScrollView(child: sheet),
          ),
        ),
      ],
    );
  }

  @override
  Future<void> closeWithResult<X>([X? value]) {
    return widget.onCloseWithResult?.call(value) ?? Future.value();
  }
}
