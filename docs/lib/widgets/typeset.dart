// Small typeset prose primitives (spec §2.3): measured sizes for the docs
// article body. D4 composes these with the generated API tables; D3 uses them
// on the introduction and index pages.
//
// Inline code and links are exposed both as [InlineSpan] helpers (for mixed
// paragraphs) and as standalone widgets.

import 'package:flutter/widgets.dart';

import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/primitives/clickable.dart';
import '../ui/dashcn/theme/theme.dart';
import 'docs_tokens.dart';

/// A prose paragraph: 15/26.25, 18.75 px top margin.
class TypesetParagraph extends StatelessWidget {
  /// Creates a paragraph from plain text.
  const TypesetParagraph(this.text, {super.key}) : spans = null;

  /// Creates a paragraph from [spans].
  const TypesetParagraph.rich(List<InlineSpan> this.spans, {super.key})
    : text = '';

  /// Body text (empty for [TypesetParagraph.rich]).
  final String text;

  /// Rich spans; empty for the plain constructor.
  final List<InlineSpan>? spans;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = docsText(context, size: 15, height: 26.25 / 15);
    return Padding(
      padding: const EdgeInsets.only(top: 18.75),
      child: spans == null
          ? Text(text, style: style, textAlign: TextAlign.start)
          : Text.rich(
              TextSpan(children: spans),
              style: style,
              textAlign: TextAlign.start,
            ),
    );
  }
}

/// An inline code chip: muted fill, radius 4.46, Geist Mono 12.75.
class TypesetInlineCode extends StatelessWidget {
  /// Creates an inline code chip.
  const TypesetInlineCode(this.code, {super.key});

  /// Code text.
  final String code;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colors.muted,
        // P7-TH1: inline code uses the small radius token.
        borderRadius: theme.borderRadiusSm,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1.5),
        child: Text(
          code,
          style: theme.typography.mono.copyWith(
            fontSize: 12.75,
            color: theme.colors.foreground,
          ),
        ),
      ),
    );
  }
}

/// An underlined prose link (30 % colour, 100 % on hover).
class TypesetLink extends StatefulWidget {
  /// Creates a link.
  const TypesetLink({super.key, required this.label, required this.onPressed});

  /// Link text.
  final String label;

  /// Tap handler.
  final VoidCallback onPressed;

  @override
  State<TypesetLink> createState() => _TypesetLinkState();
}

/// Inline-span form of [TypesetInlineCode] for mixed paragraphs.
InlineSpan typesetInlineCodeSpan(String code) {
  return WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: TypesetInlineCode(code),
  );
}

/// Inline-span form of [TypesetLink] for mixed paragraphs.
InlineSpan typesetLinkSpan(String label, VoidCallback onPressed) {
  return WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: TypesetLink(label: label, onPressed: onPressed),
  );
}

/// Parses a generated doc comment into rich spans.
///
/// Backticked words (`` `Text` ``) become inline code chips and `[Type]`
/// references become inline code chips with the brackets stripped, so no
/// raw `` ` `` or `[`/`]` symbols reach the UI. Newlines collapse to spaces
/// so the description wraps naturally inside tables. Empty input renders
/// an em dash.
List<InlineSpan> docsDocSpans(String raw, TextStyle base) {
  final String normalized = raw
      .replaceAll('\n', ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
  if (normalized.isEmpty) {
    return <InlineSpan>[TextSpan(text: '—', style: base)];
  }
  final List<InlineSpan> out = <InlineSpan>[];
  int i = 0;
  while (i < normalized.length) {
    final int backtick = normalized.indexOf('`', i);
    final int bracket = normalized.indexOf('[', i);
    int next;
    bool isBacktick;
    if (backtick == -1 && bracket == -1) {
      out.add(TextSpan(text: normalized.substring(i), style: base));
      break;
    } else if (backtick != -1 && (bracket == -1 || backtick < bracket)) {
      next = backtick;
      isBacktick = true;
    } else {
      next = bracket;
      isBacktick = false;
    }
    if (next > i) {
      out.add(TextSpan(text: normalized.substring(i, next), style: base));
    }
    if (isBacktick) {
      final int close = normalized.indexOf('`', next + 1);
      if (close == -1) {
        out.add(TextSpan(text: normalized.substring(next), style: base));
        break;
      }
      final String code = normalized.substring(next + 1, close);
      if (code.isEmpty) {
        out.add(TextSpan(text: '``', style: base));
      } else {
        out.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: TypesetInlineCode(code),
          ),
        );
      }
      i = close + 1;
    } else {
      final int close = normalized.indexOf(']', next + 1);
      if (close == -1) {
        out.add(TextSpan(text: normalized.substring(next), style: base));
        break;
      }
      final String ref = normalized.substring(next + 1, close);
      if (ref.isEmpty) {
        out.add(TextSpan(text: '[]', style: base));
      } else {
        out.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: TypesetInlineCode(ref),
          ),
        );
      }
      i = close + 1;
    }
  }
  return out;
}

class _TypesetLinkState extends State<TypesetLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color base = theme.colors.foreground;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Clickable(
        onPressed: widget.onPressed,
        child: Text(
          widget.label,
          style: docsText(context, size: 15, weight: FontWeight.w500).copyWith(
            decoration: TextDecoration.underline,
            decorationColor: base.withValues(alpha: _hovered ? 1 : 0.3),
          ),
        ),
      ),
    );
  }
}

/// A 1 px prose rule (`hr`), 36 px top margin.
class TypesetRule extends StatelessWidget {
  /// Creates a rule.
  const TypesetRule({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 36, bottom: 8),
      child: SizedBox(height: 1, child: ColoredBox(color: theme.colors.border)),
    );
  }
}

/// A bullet list (`ul`): 24 px inline start, 8 px item spacing.
class TypesetBullets extends StatelessWidget {
  /// Creates a bullet list; each item is a span list.
  const TypesetBullets({super.key, required this.items});

  /// The items, in order.
  final List<List<InlineSpan>> items;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle style = docsText(context, size: 15, height: 26.25 / 15);
    return Padding(
      padding: const EdgeInsets.only(top: 18.75, left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final List<InlineSpan> item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '•',
                    style: style.copyWith(color: theme.colors.mutedForeground),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Text.rich(TextSpan(children: item), style: style),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
