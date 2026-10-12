---
title: "Class: Command"
description: "A command palette with a search field, async results and keyboard support."
---

```dart
/// A command palette with a search field, async results and keyboard support.
class Command extends StatefulWidget {
  /// Creates a command palette.
  const Command({super.key, required this.builder, this.autofocus = true, this.debounceDuration = const Duration(milliseconds: 300), this.emptyBuilder, this.errorBuilder, this.loadingBuilder, this.searchPlaceholder, this.theme});
  /// Builds the results for the current query.
  final CommandBuilder builder;
  /// Delay between typing and running [builder]; each query restarts it.
  final Duration debounceDuration;
  /// Whether the search field takes focus when mounted.
  final bool autofocus;
  /// Shown when the finished result stream is empty.
  final WidgetBuilder? emptyBuilder;
  /// Shown when the result stream errors; defaults to the empty state.
  final CommandErrorBuilder? errorBuilder;
  /// Shown while the debounce/result stream has not produced data.
  final WidgetBuilder? loadingBuilder;
  /// Placeholder of the search field; defaults to the localized hint.
  final Widget? searchPlaceholder;
  /// Widget-leg theme override, merged over the component/app/defaults.
  final CommandTheme? theme;
  State<Command> createState();
}
```
