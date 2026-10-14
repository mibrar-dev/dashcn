---
title: "Class: GooeyAutopilot"
description: "Auto expand/collapse policy of a shown toast."
---

```dart
/// Auto expand/collapse policy of a shown toast.
///
/// Delays are relative to when the toast appears (expand) and when it opens
/// (collapse). `Duration.zero` expands immediately or disables the collapse
/// schedule; a null autopilot disables both, leaving expansion to hover, press
/// and tap only.
class GooeyAutopilot {
  /// Creates an autopilot policy.
  const GooeyAutopilot({this.expandDelay = const Duration(milliseconds: 150), this.collapseDelay = const Duration(milliseconds: 4000)});
  /// Delay before the body expands after the toast appears.
  final Duration? expandDelay;
  /// Delay before the body collapses back once it has expanded.
  final Duration? collapseDelay;
  /// Delay before auto-expansion starts.
  Duration get resolvedExpandDelay;
  /// Delay before auto-collapse starts.
  Duration get resolvedCollapseDelay;
}
```
