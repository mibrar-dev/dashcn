// The object form field: a button-like trigger opening a dialog or popover
// editor for a complex value. The trigger paints itself from tokens (a
// primitive may not import `button`); the dialog prompt is a widgets-only
// `showGeneralDialog` route, the popover prompt reuses `PopoverController`.

import 'package:flutter/widgets.dart';

import '../../foundation/captured_wrapper.dart';
import '../../foundation/data.dart';
import '../../foundation/gap.dart';
import '../../theme/color_tokens.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import '../clickable.dart';
import '../localizations/localizations.dart';
import '../widget_states.dart';
import '../overlay.dart';
import '../popover_controller.dart';
import 'form_value.dart';
import 'object_form_prompt.dart';

/// How an [ObjectFormField] presents its editor.
enum PromptMode {
  /// A centered modal dialog with cancel/save actions.
  dialog,

  /// An anchored popover that reports changes live.
  popover,
}

/// Controls an open object editor from inside `editorBuilder`.
abstract class ObjectFormHandler<T> {
  /// The value the editor is working on.
  T? get value;

  /// Updates the editor's working value.
  set value(T? value);

  /// Opens another prompt with [value].
  void prompt([T? value]);

  /// Closes the editor; completes when its route/overlay is gone.
  Future<void> close();

  /// Nearest handler (`find` returns null instead of asserting).
  static ObjectFormHandler<T> of<T>(BuildContext context) =>
      Data.of<ObjectFormHandler<T>>(context);
  static ObjectFormHandler<T>? find<T>(BuildContext context) =>
      Data.maybeOf<ObjectFormHandler<T>>(context);
}

/// The result a dialog prompt pops with.
/// Object-form trigger padding: upstream `px-3 py-2` (12/8) as density
/// multipliers, resolved at build.
const EdgeInsetsGeometry objectFormPromptPadding =
    EdgeInsetsDensity.pxSymmetric(horizontal: 12, vertical: 8);

/// Minimum trigger height: the upstream input height (h-9, 36) shared with the
/// `input` and `formatted_input` fields. The trigger padding lives inside
/// this height (like `EditableTextShell`), so the total matches text fields.
const double objectFormTriggerMinHeight = 36;

/// Width of the trigger border, painted inside the trigger box.
const double _triggerBorderWidth = 1;

/// Deflates resolved padding by the border width: the painted gap stays
/// `px-3 py-2` and the total stays h-9 at every density.
EdgeInsetsGeometry _triggerPadding(EdgeInsetsGeometry padding) {
  final EdgeInsets resolved = padding.resolve(TextDirection.ltr);
  return EdgeInsets.fromLTRB(
    resolved.left - _triggerBorderWidth,
    resolved.top - _triggerBorderWidth,
    resolved.right - _triggerBorderWidth,
    resolved.bottom - _triggerBorderWidth,
  );
}

class ObjectFormFieldDialogResult<T> {
  /// Creates a dialog result wrapping [value].
  ObjectFormFieldDialogResult(this.value);

  /// The edited value.
  final T? value;
}

/// A form field whose value is edited through a dialog or popover.
class ObjectFormField<T> extends StatefulWidget {
  /// Creates an object form field.
  const ObjectFormField({
    super.key,
    required this.value,
    this.onChanged,
    required this.placeholder,
    required this.builder,
    this.leading,
    this.trailing,
    this.mode = PromptMode.dialog,
    required this.editorBuilder,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.expand = false,
    this.triggerMinWidth = 0,
    this.dialogTitle,
    this.dialogActions,
    this.dialogPadding,
    this.dialogFooterPadding,
    this.enabled,
    this.decorate = true,
    this.immediateValueChange,
    this.adaptive,
  });

  /// The current value.
  final T? value;

  /// Called with the next value.
  final ValueChanged<T?>? onChanged;

  /// Shown while [value] is null.
  final Widget placeholder;

  /// Builds the trigger content from a non-null value.
  final Widget Function(BuildContext context, T value) builder;

  /// Optional widget before the trigger content.
  final Widget? leading;

  /// Optional widget after the trigger content.
  final Widget? trailing;

  /// Dialog or popover presentation.
  final PromptMode mode;

  /// Builds the editor; the handler reads/updates the working value.
  final Widget Function(BuildContext context, ObjectFormHandler<T> handler)
  editorBuilder;

  /// Popover alignment relative to the trigger.
  final AlignmentGeometry? popoverAlignment;

  /// Anchor alignment for popover positioning.
  final AlignmentGeometry? popoverAnchorAlignment;

  /// Padding inside the popover surface.
  final EdgeInsetsGeometry? popoverPadding;

  /// Full-width trigger when true; otherwise hugs its content (at least
  /// [triggerMinWidth]).
  /// A tight parent fills either way.
  final bool expand;

  /// Minimum trigger width in upstream px (240 date, 140 time pickers).
  final double triggerMinWidth;

  /// Title of the dialog prompt.
  final Widget? dialogTitle;

  /// Padding between the dialog card border and the editor (`EdgeInsets.zero`
  /// paints no card padding for editors with their own shell, like pickers).
  /// Null resolves [objectFormDialogPadding].
  final EdgeInsetsGeometry? dialogPadding;

  /// Padding of the dialog footer row (with a hairline top border); null keeps
  /// the footer inside the card padding.
  final EdgeInsetsGeometry? dialogFooterPadding;

  /// Extra dialog actions before Cancel/Save.
  final List<Widget> Function(
    BuildContext context,
    ObjectFormHandler<T> handler,
  )?
  dialogActions;

  /// Overrides the enabled state; null means `onChanged != null`.
  final bool? enabled;

  /// Whether prompt mode paints its own surface around the editor.
  final bool decorate;

  /// Responsive adaptive mode for the popover prompt; null resolves the theme token.
  final PopupAdaptive? adaptive;

  /// Whether edits are reported live (popover default true, dialog false).
  final bool? immediateValueChange;

  @override
  State<ObjectFormField<T>> createState() => _ObjectFormFieldState<T>();
}

class _ObjectFormFieldState<T> extends State<ObjectFormField<T>>
    with FormValueSupplier<T, ObjectFormField<T>> {
  final PopoverController _popoverController = PopoverController();

  bool get _enabled => widget.enabled ?? (widget.onChanged != null);

  @override
  void dispose() {
    _popoverController.dispose();
    super.dispose();
  }

  void _setValue(T? value) {
    widget.onChanged?.call(value);
    formValue = value;
  }

  @override
  void didReplaceFormValue(T value) => _setValue(value);

  void prompt([T? value]) {
    if (widget.mode == PromptMode.dialog) {
      _showDialog(value);
    } else {
      _showPopover(value);
    }
  }

  void _showDialog([T? initial]) {
    final T? value = initial ?? formValue;
    final NavigatorState navigator = Navigator.of(context, rootNavigator: true);
    final CapturedThemes themes = InheritedTheme.capture(
      from: context,
      to: navigator.context,
    );
    final CapturedData data = Data.capture(
      from: context,
      to: navigator.context,
    );
    showGeneralDialog<ObjectFormFieldDialogResult<T>>(
      context: context,
      barrierDismissible: true,
      barrierLabel: ComponentLocalizations.of(context).dialogDismiss,
      barrierColor: const Color(0x80000000),
      transitionDuration: const Duration(milliseconds: 150),
      pageBuilder: (context, animation, secondaryAnimation) {
        return CapturedWrapper(
          themes: themes,
          data: data,
          child: ObjectFormPromptDialog<T>(
            initialValue: value,
            editorBuilder: widget.editorBuilder,
            dialogTitle: widget.dialogTitle,
            dialogActions: widget.dialogActions,
            padding: widget.dialogPadding,
            footerPadding: widget.dialogFooterPadding,
            decorate: widget.decorate,
            onPrompt: prompt,
            onChanged: (changed) {
              if (widget.immediateValueChange == true) {
                _setValue(changed);
              }
            },
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final Animation<double> curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.7, end: 1).animate(curved),
            child: child,
          ),
        );
      },
    ).then((result) {
      if (!mounted) {
        return;
      }
      if (result is ObjectFormFieldDialogResult<T> &&
          widget.immediateValueChange != true) {
        _setValue(result.value);
      }
    });
  }

  void _showPopover([T? initial]) {
    final T? value = initial ?? formValue;
    T? delayed = value;
    final ThemeData theme = Theme.of(context);
    _popoverController
        .show<void>(
          context: context,
          adaptive: widget.adaptive,
          alignment: widget.popoverAlignment ?? Alignment.topLeft,
          anchorAlignment:
              widget.popoverAnchorAlignment ?? Alignment.bottomLeft,
          offset: Offset(0, theme.spacing.xs),
          // Picker popovers are `w-auto`: the surface hugs the editor.
          widthConstraint: PopoverConstraint.intrinsic,
          modal: true,
          overlayBarrier: OverlayBarrier(borderRadius: theme.borderRadiusLg),
          builder: (context) {
            return ObjectFormPromptPopup<T>(
              initialValue: value,
              editorBuilder: widget.editorBuilder,
              popoverPadding: widget.popoverPadding,
              decorate: widget.decorate,
              onPrompt: prompt,
              onChanged: (changed) {
                if (widget.immediateValueChange != false) {
                  _setValue(changed);
                } else {
                  delayed = changed;
                }
              },
            );
          },
        )
        .then((_) {
          if (mounted && widget.immediateValueChange == false) {
            _setValue(delayed);
          }
        });
  }

  /// Fixed 16px (`size-4`) icon box sharing the label's centre row: a fixed
  /// box (not a zero-height wrapper) aligns visual centres in every font
  /// (the old one sat ~6-8px low on web/Geist while Ahem tests passed).
  static Widget _adornment(Widget child) =>
      SizedBox.square(dimension: 16, child: Center(child: child));

  @override
  Widget build(BuildContext context) {
    formValue = widget.value;
    final ThemeData theme = Theme.of(context);
    final bool enabled = _enabled;
    final Color foreground = theme.colors.foreground;
    // Placeholders sit on the translucent `input` trigger fill: the raw
    // `mutedForeground` token falls just short of AA on it, so the derived
    // `onMuted` is used instead.
    final Color muted = theme.colors.onMuted;
    final Color borderColor = theme.colors.input;
    final double scale = theme.scaling;

    Decoration decoration(Set<WidgetState> states) {
      final double alpha = states.hovered || states.pressed ? 0.5 : 0.3;
      return BoxDecoration(
        color: theme.colors.input.withValues(
          alpha: theme.colors.input.a * alpha,
        ),
        border: Border.all(color: borderColor, width: _triggerBorderWidth),
        borderRadius: theme.borderRadiusMd,
      );
    }

    Widget content = widget.value == null
        ? DefaultTextStyle.merge(
            style: TextStyle(color: muted),
            child: widget.placeholder,
          )
        : widget.builder(context, widget.value as T);
    // One centred row, never an ellipsis. The [Flexible] label hugs when
    // roomy and shrinks to a second line when the parent is narrower.
    // Builders must return wrappable labels (see date/time pickers).
    content = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (widget.leading != null) _adornment(widget.leading!),
        if (widget.leading != null) Gap(theme.spacing.sm),
        Flexible(child: content),
        if (widget.trailing != null) Gap(theme.spacing.sm),
        if (widget.trailing != null) _adornment(widget.trailing!),
      ],
    );

    // Hug by default ([IntrinsicWidth]): the trigger is exactly
    // `icon + gap + full label + padding` (the empty placeholder sets the
    // width when there is no value), floored at [triggerMinWidth] so date
    // (240) and time pickers keep their upstream widths. `expand` or a tight
    // parent fills instead (a tighter parent drops the minimum, and the
    // label shrinks to a second line rather than overflowing). Height is
    // outside the padding, so the total stays h-9 like `EditableTextShell`.
    final double minWidth = widget.triggerMinWidth * scale;
    Widget button(double floor) => ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: objectFormTriggerMinHeight,
        minWidth: floor,
      ),
      child: Clickable(
        enabled: enabled,
        onPressed: enabled ? prompt : null,
        mouseCursor: const StateValue<MouseCursor>(
          rest: SystemMouseCursors.click,
          disabled: SystemMouseCursors.basic,
        ),
        decoration: WidgetStateProperty.resolveWith(decoration),
        textStyle: WidgetStatePropertyAll<TextStyle>(
          theme.typography.small.copyWith(color: foreground),
        ),
        padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
          // Always the prompt padding (`px-3 py-2`); the popover surface
          // padding is unrelated. Deflated by the 1px border (see above).
          _triggerPadding(
            resolveEdgeInsets(
              objectFormPromptPadding,
              theme.density.baseContentPadding * scale,
            ),
          ),
        ),
        child: content,
      ),
    );

    final Widget sized = widget.expand
        ? SizedBox(width: double.infinity, child: button(0))
        : LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (!constraints.hasBoundedWidth ||
                  constraints.maxWidth >= minWidth) {
                return IntrinsicWidth(child: button(minWidth));
              }
              return button(0);
            },
          );

    return Opacity(opacity: enabled ? 1 : 0.5, child: sized);
  }
}
