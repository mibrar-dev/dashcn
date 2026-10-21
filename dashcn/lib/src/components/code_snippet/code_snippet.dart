// The `code_snippet` component: [CodeSnippet] (scrollable code block with
// syntax colouring, selectable text and copy button).

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../foundation/platform.dart';
import '../../primitives/clickable.dart';
import '../../primitives/surface.dart';
import '../../primitives/syntax_highlight/syntax_highlight.dart';
import '../../primitives/text/text_extension.dart';
import '../../primitives/text_editing/text_editing.dart';
import '../../primitives/touch_hit_area.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import 'code_snippet_style.dart';

export 'code_snippet_style.dart';

/// Builder slot for replacing the copy button widget.
typedef CodeSnippetCopyButtonBuilder = Widget Function(
  BuildContext context,
  VoidCallback onCopy,
  bool copied,
);

/// Builder slot for customizing the entire actions row.
typedef CodeSnippetActionsBuilder = Widget Function(
  BuildContext context,
  List<Widget> actions,
);

/// Builder slot for customizing or wrapping the highlighted code widget.
typedef CodeSnippetCodeBuilder = Widget Function(
  BuildContext context,
  Widget code,
);

/// Scrollable code block with syntax colouring, top-right [actions] and a
/// built-in copy button.
///
/// The [code] content renders in the ambient monospace small style. When a
/// [language] is given (or auto-detected from a fence tag / content signals),
/// the code is syntax-highlighted with the theme's `syntax` token group.
///
/// Text is selectable by mouse and keyboard (`Ctrl/Cmd+A`, `Ctrl/Cmd+C`).
/// Long lines scroll horizontally inside the block without overflowing.
class CodeSnippet extends StatefulWidget {
  /// Creates a code snippet display.
  const CodeSnippet({
    super.key,
    this.constraints,
    this.actions = const <Widget>[],
    required this.code,
    this.rawCode,
    this.language,
    this.showCopyButton,
    this.copied,
    this.onCopiedChange,
    this.onCopy,
    this.copyButtonBuilder,
    this.actionsBuilder,
    this.codeBuilder,
    this.theme,
  });

  /// Bounds of the snippet area.
  final BoxConstraints? constraints;

  /// Custom action buttons in the top-right corner.
  final List<Widget> actions;

  /// Code content widget (typically a [Text] or [Text.rich]).
  final Widget code;

  /// Optional verbatim code string to copy and highlight. When omitted, the
  /// source text is extracted from [code] if it is a [Text].
  final String? rawCode;

  /// Language id or fence tag (`dart`, `json`, `yaml`, `sh`, `js`, `html`, …)
  /// used for syntax highlighting. When null, the language is auto-detected.
  final String? language;

  /// Whether the copy button renders in the actions row. When null, resolves
  /// from the theme (default true).
  final bool? showCopyButton;

  /// Controlled copy state. When null, state is managed internally.
  final bool? copied;

  /// Called when the copied state changes (in both controlled and uncontrolled
  /// modes).
  final ValueChanged<bool>? onCopiedChange;

  /// Called when the copy button is activated.
  final VoidCallback? onCopy;

  /// Builder slot for replacing the copy button widget.
  final CodeSnippetCopyButtonBuilder? copyButtonBuilder;

  /// Builder slot for customizing the entire actions row.
  final CodeSnippetActionsBuilder? actionsBuilder;

  /// Builder slot for customizing or wrapping the highlighted code widget.
  final CodeSnippetCodeBuilder? codeBuilder;

  /// Widget-leg theme override.
  final CodeSnippetTheme? theme;

  @override
  State<CodeSnippet> createState() => _CodeSnippetState();
}

class _CodeSnippetState extends State<CodeSnippet> {
  bool _internalCopied = false;
  Timer? _feedbackTimer;

  bool get _isCopied => widget.copied ?? _internalCopied;

  @override
  void dispose() {
    _feedbackTimer?.cancel();
    super.dispose();
  }

  String? get _effectiveText {
    if (widget.rawCode != null) return widget.rawCode;
    final Widget raw = widget.code;
    return raw is Text ? (raw.data ?? raw.textSpan?.toPlainText()) : null;
  }

  Future<void> _handleCopy(Duration feedbackDuration) async {
    final String? text = _effectiveText;
    if (text != null && text.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: text));
    }
    widget.onCopy?.call();
    if (!mounted) return;
    if (widget.copied == null) {
      setState(() => _internalCopied = true);
      _feedbackTimer?.cancel();
      _feedbackTimer = Timer(feedbackDuration, () {
        if (mounted) {
          setState(() => _internalCopied = false);
          widget.onCopiedChange?.call(false);
        }
      });
    }
    widget.onCopiedChange?.call(true);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final CodeSnippetTheme style =
        resolveComponentStyle<CodeSnippetTheme, CodeSnippetTheme>(
          context,
          widget: widget.theme,
          select: (t) => t,
          defaults: codeSnippetDefaults,
        );
    final double scale = ambient.scaling;
    final TextDirection direction = Directionality.of(context);
    final EdgeInsets padding = resolveEdgeInsets(
      style.padding ?? EdgeInsets.zero,
      ambient.density.baseContainerPadding * scale,
    ).resolve(direction);

    final bool mobile = isMobile(ambient.platform);
    final double buttonSize = 28 * scale;
    final double touch = math.max(
      0,
      (touchMinEdge(ambient.platform) - buttonSize) / 2,
    );
    final double touchTargetSize = buttonSize + (mobile ? 2 * touch : 0);

    final bool shouldShowCopy =
        widget.showCopyButton ?? style.showCopyButton ?? true;
    final List<Widget> allActions = <Widget>[
      ...widget.actions,
      if (shouldShowCopy)
        _buildCopyButton(context, ambient, style, scale, buttonSize, touch),
    ];

    final Widget? actionsRow = allActions.isEmpty
        ? null
        : (widget.actionsBuilder != null
              ? widget.actionsBuilder!(context, allActions)
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: _spaced(
                    allActions,
                    scale,
                    style.actionSpacing ?? 4,
                  ),
                ));

    final double minContainerHeight = math.max(
      widget.constraints?.minHeight ?? 0,
      mobile && actionsRow != null ? touchTargetSize : 0,
    );
    final BoxConstraints effectiveConstraints =
        (widget.constraints ?? const BoxConstraints()).copyWith(
          minHeight: minContainerHeight,
        );

    final Widget codeChild = _codeChild(ambient);
    final Widget selectableCode =
        Overlay.maybeOf(context) == null ||
            SelectionContainer.maybeOf(context) != null
        ? codeChild
        : SelectableRegion(
            selectionControls: SelectionControls(),
            child: codeChild,
          );

    final BorderRadiusGeometry paintRadius =
        style.borderRadius?.resolve(direction) ?? ambient.borderRadiusLg;
    final Color? rawFill = style.background?.resolve(ambient.colors);
    // Frosted glass: the card fill carries the ambient surfaceOpacity and
    // the blur wraps the painted block (no extra layer at default).
    final Color? fill = rawFill == null
        ? null
        : surfaceColor(rawFill, ambient.surfaceOpacity);
    return GlassSurface(
      surfaceBlur: ambient.surfaceBlur,
      borderRadius: paintRadius,
      child: Container(
        decoration: BoxDecoration(
          color: fill,
          border: Border.all(
            color:
                style.borderColor?.resolve(ambient.colors) ??
                ambient.colors.border,
            width: (style.borderWidth ?? 1) * scale,
          ),
          borderRadius: paintRadius,
        ),
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            Container(
              constraints: effectiveConstraints,
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: padding,
                  child: DefaultTextStyle.merge(
                    style: TextStyle(color: ambient.colors.foreground),
                    child: selectableCode,
                  ),
                ),
              ),
            ),
            if (actionsRow != null)
              Positioned.directional(
                textDirection: direction,
                end: mobile
                    ? math.max(0, ambient.density.baseGap * scale - touch)
                    : ambient.density.baseGap * scale,
                top: mobile
                    ? math.max(0, (minContainerHeight - touchTargetSize) / 2)
                    : ambient.density.baseGap * scale,
                child: actionsRow,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCopyButton(
    BuildContext context,
    ThemeData ambient,
    CodeSnippetTheme style,
    double scale,
    double buttonSize,
    double touch,
  ) {
    final bool isCopied = _isCopied;
    final Duration feedbackDuration =
        style.copyFeedbackDuration ?? const Duration(milliseconds: 2000);
    void onCopy() => _handleCopy(feedbackDuration);

    if (widget.copyButtonBuilder != null) {
      return widget.copyButtonBuilder!(context, onCopy, isCopied);
    }

    final IconData iconData = isCopied
        ? (style.copiedIcon ?? LucideIcons.check)
        : (style.copyIcon ?? LucideIcons.copy);
    final Color iconColor =
        (isCopied
            ? style.copiedIconColor?.resolve(ambient.colors)
            : style.copyIconColor?.resolve(ambient.colors)) ??
        (isCopied ? ambient.colors.primary : ambient.colors.mutedForeground);

    final bool disableAnimations = MediaQuery.disableAnimationsOf(context);
    final Duration animDuration = disableAnimations
        ? Duration.zero
        : ambient.motion.durations.fast;
    final double buttonSize = 28 * scale;
    final double touch = math.max(
      0,
      (touchMinEdge(ambient.platform) - buttonSize) / 2,
    );

    return Semantics(
      button: true,
      label: isCopied ? 'Copied' : 'Copy code',
      child: TouchHitArea(
        vertical: touch,
        horizontal: touch,
        child: SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: Clickable(
            onPressed: onCopy,
            focusOutline: true,
            mouseCursor: const WidgetStatePropertyAll<MouseCursor>(
              SystemMouseCursors.click,
            ),
            padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
              EdgeInsets.zero,
            ),
            decoration: WidgetStateProperty.resolveWith<Decoration?>((states) {
              final bool active =
                  states.contains(WidgetState.hovered) ||
                  states.contains(WidgetState.pressed);
              return BoxDecoration(
                color: active
                    ? ambient.colors.muted
                    : ambient.colors.card.withValues(alpha: 0.8),
                border: active
                    ? null
                    : Border.all(
                        color: ambient.colors.border.withValues(alpha: 0.5),
                        width: 1 * scale,
                      ),
                borderRadius: ambient.borderRadiusSm,
              );
            }),
            child: Center(
              child: AnimatedSwitcher(
                duration: animDuration,
                switchInCurve: ambient.motion.curves.standard,
                switchOutCurve: ambient.motion.curves.standard,
                child: Icon(
                  iconData,
                  key: ValueKey<bool>(isCopied),
                  size: 14 * scale,
                  color: iconColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _spaced(List<Widget> items, double scale, double spacing) => [
    for (int i = 0; i < items.length; i++) ...[
      if (i > 0) Gap(spacing * scale),
      items[i],
    ],
  ];

  Widget _codeChild(ThemeData ambient) {
    Widget content = widget.code;
    final String? text = _effectiveText;
    if (text != null) {
      final SyntaxLanguage? detected =
          syntaxLanguageFromId(widget.language) ?? syntaxLanguageGuess(text);
      if (detected != null) {
        final TextStyle base = ambient.typography.mono.copyWith(
          color: ambient.colors.foreground,
        );
        content = Text.rich(
          syntaxTextSpan(
            code: text,
            language: detected,
            base: base,
            colors: ambient.syntaxColors,
          ),
        );
      }
    }
    final Widget styled = content.mono.small;
    return widget.codeBuilder?.call(context, styled) ?? styled;
  }
}
