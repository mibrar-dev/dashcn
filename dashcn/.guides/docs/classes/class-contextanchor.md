---
title: "Class: ContextAnchor"
description: "An [Anchor] resolved from a plain [BuildContext]."
---

```dart
/// An [Anchor] resolved from a plain [BuildContext]. A null [context]
/// (`const ContextAnchor()`) is filled in by the consumer with the context of
/// the `show()` call.
class ContextAnchor extends Anchor {
  /// Creates a context anchor.
  const ContextAnchor([this.context]);
  /// The context to anchor to, or null to use the consumer's own context.
  final BuildContext? context;
  Anchor resolve(BuildContext context);
  AnchorSubscription subscribe();
}
```
