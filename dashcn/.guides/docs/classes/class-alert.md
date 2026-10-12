---
title: "Class: Alert"
description: "A bordered banner that highlights a message."
---

```dart
/// A bordered banner that highlights a message.
///
/// ```dart
/// Alert(
///   leading: const Icon(LucideIcons.info),
///   title: const Text('Heads up'),
///   content: const Text('You can add components from the registry.'),
/// )
/// ```
class Alert extends StatelessWidget {
  /// Creates an alert.
  const Alert({super.key, this.leading, this.title, this.content, this.trailing, this.variant = AlertVariant.base, this.theme});
  /// Optional leading widget, usually a 16px `Icon`.
  final Widget? leading;
  /// Optional title widget.
  final Widget? title;
  /// Optional descriptive content.
  final Widget? content;
  /// Optional trailing widget (actions/dismissal).
  final Widget? trailing;
  /// Visual variant. Defaults to [AlertVariant.base].
  final AlertVariant variant;
  /// Widget-leg style override, merged on top of the component/app/defaults.
  final AlertTheme? theme;
  Widget build(BuildContext context);
}
```
