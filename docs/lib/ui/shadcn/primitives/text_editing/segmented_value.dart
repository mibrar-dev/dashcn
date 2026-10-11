// The value model of a segmented field: the parts (separators + editable
// segments) and the values they carry.
//
// Split out of `segmented_editing.dart` so both files stay under the 400-line
// rule; `formatted_input` is the component that renders this model.

import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'segmented_editing.dart';

/// One part of a segmented value: a separator or an editable segment.
///
/// ```dart
/// const SegmentPart.separator('(');
/// const SegmentPart.editable(length: 3, width: 28, placeholder: Text('MM'));
/// ```
class SegmentPart {
  /// Creates a separator part.
  const SegmentPart.separator(this.separator)
    : length = 0,
      width = null,
      obscureText = false,
      placeholder = null,
      inputFormatters = const <TextInputFormatter>[],
      value = '';

  /// Creates an editable segment.
  ///
  /// [width] is an explicit override in logical pixels. Null (the default)
  /// sizes from the resolved text style (`length` glyph advances + cursor);
  /// a provided value is never shrunk below what the content needs.
  const SegmentPart.editable({
    this.value = '',
    required this.length,
    this.width,
    this.obscureText = false,
    this.placeholder,
    this.inputFormatters = const <TextInputFormatter>[],
  }) : separator = null;

  /// The separator text; null when this part is an editable segment.
  final String? separator;

  /// Maximum length of an editable segment.
  final int length;

  /// Explicit width override; null sizes from the text style.
  final double? width;

  /// Whether the segment paints dots.
  final bool obscureText;

  /// Placeholder widget of an editable segment.
  final Widget? placeholder;

  /// Formatters of an editable segment.
  final List<TextInputFormatter> inputFormatters;

  /// The current text of an editable segment.
  final String value;

  /// Whether this part holds a value.
  bool get holdsValue => separator == null;

  /// The segment definition of an editable part.
  TextSegment get segment => TextSegment(
    length: length,
    obscureText: obscureText,
    placeholder: placeholder,
    inputFormatters: inputFormatters,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is SegmentPart &&
        other.separator == separator &&
        other.length == length &&
        other.width == width &&
        other.obscureText == obscureText &&
        other.placeholder == placeholder &&
        other.inputFormatters == inputFormatters &&
        other.value == value;
  }

  @override
  int get hashCode => Object.hash(
    separator,
    length,
    width,
    obscureText,
    placeholder,
    inputFormatters,
    value,
  );

  @override
  String toString() => 'SegmentPart($value)';
}

/// The value of a segmented field: its parts plus the value of each editable
/// segment.
class SegmentedValue {
  /// Creates a value from [parts].
  const SegmentedValue([this.parts = const <SegmentPart>[]]);

  /// The parts, in display order.
  final List<SegmentPart> parts;

  /// The editable parts only, in order.
  Iterable<SegmentPart> get values =>
      parts.where((SegmentPart part) => part.holdsValue);

  /// The whole field's text (separators included).
  String get text => parts
      .map(
        (SegmentPart part) =>
            part.holdsValue ? part.value : part.separator ?? '',
      )
      .join();

  /// Returns a copy with the editable part at [index] set to [value].
  SegmentedValue withValue(int index, String value) {
    final List<SegmentPart> next = List<SegmentPart>.of(parts);
    int i = 0;
    for (int part = 0; part < next.length; part++) {
      if (!next[part].holdsValue) {
        continue;
      }
      if (i == index) {
        final SegmentPart old = next[part];
        next[part] = SegmentPart.editable(
          value: value,
          length: old.length,
          width: old.width,
          obscureText: old.obscureText,
          placeholder: old.placeholder,
          inputFormatters: old.inputFormatters,
        );
        break;
      }
      i++;
    }
    return SegmentedValue(next);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is SegmentedValue && listEquals(other.parts, parts);
  }

  /// Whether [parts] describes the same field as this value: same parts in the
  /// same order with the same lengths and widths. Values are ignored, so a
  /// value swap never rebuilds the field's segment controllers.
  bool hasShape(List<SegmentPart> parts) {
    if (parts.length != this.parts.length) {
      return false;
    }
    for (int i = 0; i < parts.length; i++) {
      final SegmentPart a = parts[i];
      final SegmentPart b = this.parts[i];
      if (a.holdsValue != b.holdsValue) {
        return false;
      }
      if (a.holdsValue) {
        if (a.length != b.length ||
            a.width != b.width ||
            a.obscureText != b.obscureText ||
            a.placeholder != b.placeholder ||
            !listEquals(a.inputFormatters, b.inputFormatters)) {
          return false;
        }
      } else if (a.separator != b.separator) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode => parts.length;

  @override
  String toString() => 'SegmentedValue(${parts.length} parts, $text)';
}

/// Plain text of [placeholder] when it is a [Text]; null otherwise.
///
/// Segment placeholders are locale labels (`MM`, `HH`) rendered as plain
/// [Text]; anything else (a [RichText], an icon) cannot be measured here and
/// sizes from the glyph floor in [segmentMinWidth] instead.
String? segmentPlaceholderText(Widget? placeholder) {
  if (placeholder is Text) {
    return placeholder.data ?? placeholder.textSpan?.toPlainText();
  }
  return null;
}

/// Measured width of a [Text] [placeholder] in [style]; 0 otherwise.
///
/// The caller's own [Text.style] wins over [style] (the overlay paints the
/// placeholder style underneath it), matching how `DefaultTextStyle.merge`
/// resolves the visible label.
double segmentPlaceholderWidth(Widget? placeholder, TextStyle style) {
  final String? text = segmentPlaceholderText(placeholder);
  if (text == null || text.isEmpty) {
    return 0;
  }
  TextStyle effective = style;
  if (placeholder is Text && placeholder.style != null) {
    effective = style.merge(placeholder.style);
  }
  final TextPainter painter = TextPainter(
    text: TextSpan(text: text, style: effective),
    textDirection: TextDirection.ltr,
  )..layout();
  return painter.width;
}

/// Widest advance of the digits (plus filler/obscure glyphs) in [style].
///
/// Measured with [TextPainter] so tabular figures, fallback fonts and text
/// scaling are honoured; the ambient font is already baked into [style].
double maxSegmentGlyphAdvance(TextStyle style) {
  double widest = 0;
  for (final String glyph in <String>[
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '_',
    '•',
  ]) {
    final TextPainter painter = TextPainter(
      text: TextSpan(text: glyph, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    if (painter.width > widest) {
      widest = painter.width;
    }
  }
  return widest;
}

/// Minimum width for a segment holding [length] glyphs in [style].
///
/// The wider of `length` × [maxSegmentGlyphAdvance] and the measured
/// [placeholder] width (in [placeholderStyle] or [style]), plus a
/// [caretAllowance] for the cursor and nothing else, so adjacent segments
/// butt against their static separators like one text field. [densityScale]
/// scales the fixed caret reserve (the glyph part already scales with
/// [style]). An explicit `SegmentPart.width` only ever widens past this.
double segmentMinWidth({
  required TextStyle style,
  required int length,
  Widget? placeholder,
  TextStyle? placeholderStyle,
  double densityScale = 1,
  double caretAllowance = 2,
}) {
  final double advance = maxSegmentGlyphAdvance(style);
  double content = length * advance;
  final double placeholderWidth = segmentPlaceholderWidth(
    placeholder,
    placeholderStyle ?? style,
  );
  if (placeholderWidth > content) {
    content = placeholderWidth;
  }
  return content + caretAllowance * densityScale;
}

/// Minimum width for [part]: [segmentMinWidth] with the part's own length,
/// placeholder and explicit-width override applied.
double segmentMinWidthForPart(
  SegmentPart part, {
  required TextStyle textStyle,
  TextStyle? placeholderStyle,
  double densityScale = 1,
}) {
  final double needed = segmentMinWidth(
    style: textStyle,
    length: part.length,
    placeholder: part.placeholder,
    placeholderStyle: placeholderStyle ?? textStyle,
    densityScale: densityScale,
  );
  final double? override = part.width;
  if (override == null) {
    return needed;
  }
  return override > needed ? override : needed;
}
