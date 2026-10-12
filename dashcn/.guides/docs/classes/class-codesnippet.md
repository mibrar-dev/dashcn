---
title: "Class: CodeSnippet"
description: "Scrollable code block with optional top-right [actions] (copy, run)."
---

```dart
/// Scrollable code block with optional top-right [actions] (copy, run).
///
/// The [code] content renders in the ambient monospace small style. When a
/// [language] is given (or auto-detected from a fence tag / strong content
/// signals), the code is syntax-highlighted with the theme's `syntax` token
/// group. The block sits inside a [SelectableRegion], so the source is
/// selectable by mouse, by the keyboard (`Ctrl/Cmd+A`, then `Ctrl/Cmd+C`) and
/// through the platform context menu; [Text] and [Text.rich] register with
/// the region on their own, so the syntax colours are unchanged.
class CodeSnippet extends StatelessWidget {
  /// Creates a code snippet display.
  const CodeSnippet({super.key, this.constraints, this.actions = const <Widget>[], required this.code, this.language, this.theme});
  /// Bounds of the snippet area.
  final BoxConstraints? constraints;
  /// Action buttons in the top-right corner.
  final List<Widget> actions;
  /// Code content (usually a [Text]).
  final Widget code;
  /// Language id or fence tag (`dart`, `js`, `py`, …) used for syntax
  /// highlighting. When null, the language is auto-detected from the code
  /// text (fence tag first, then conservative content signals); unknown
  /// content stays plain.
  final String? language;
  /// Widget-leg theme override, merged over the other legs.
  final CodeSnippetTheme? theme;
  Widget build(BuildContext context);
}
```
