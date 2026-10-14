---
title: "Class: Window"
description: "A draggable, resizable window frame driven by a [WindowController]."
---

```dart
/// A draggable, resizable window frame driven by a [WindowController].
///
/// Put one or more in a [WindowNavigator]:
///
/// ```dart
/// WindowNavigator(initialWindows: <Window>[
///   Window(controller: controller, title: const Text('Notes')),
/// ]);
/// ```
class Window extends StatefulWidget implements ManagedWindow {
  /// Creates a window.
  const Window({super.key, required this.controller, this.title, this.actions = const WindowActions(), this.content, this.theme});
  /// The window's state controller.
  final WindowController controller;
  final Widget? title;
  /// Title bar action area; defaults to [WindowActions].
  final Widget? actions;
  /// Window body.
  final Widget? content;
  final WindowTheme? theme;
  bool get alwaysOnTop;
  State<Window> createState();
}
```
