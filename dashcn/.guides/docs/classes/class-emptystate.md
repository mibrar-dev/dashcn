---
title: "Class: EmptyState"
description: "A block that stands in for missing content."
---

```dart
/// A block that stands in for missing content.
///
/// ```dart
/// EmptyState(
///   variant: EmptyStateVariant.empty,
///   size: EmptyStateSize.fullPage,
///   primaryAction: EmptyStateAction(
///     label: 'Create project',
///     onPressed: _create,
///   ),
/// )
/// ```
class EmptyState extends StatelessWidget {
  /// Creates an empty state.
  const EmptyState({super.key, this.variant = EmptyStateVariant.empty, this.size = EmptyStateSize.fullPage, this.icon, this.title, this.description, this.primaryAction, this.secondaryAction, this.footerAction, this.showIconContainer = true, this.theme});
  /// Preset for the default strings and icon.
  final EmptyStateVariant variant;
  /// Presentation scale.
  final EmptyStateSize size;
  /// Icon shown above the title; null uses the preset's icon.
  final Widget? icon;
  /// Title; null uses the preset's localized string.
  final Widget? title;
  /// Description; null uses the preset's localized string.
  final Widget? description;
  /// First action.
  final EmptyStateAction? primaryAction;
  /// Second action, shown beside the first.
  final EmptyStateAction? secondaryAction;
  /// Trailing action, shown on its own row below the pair.
  final EmptyStateAction? footerAction;
  /// Whether the icon sits in the muted container.
  final bool showIconContainer;
  /// Widget-leg style override.
  final EmptyStateTheme? theme;
  Widget build(BuildContext context);
}
```
