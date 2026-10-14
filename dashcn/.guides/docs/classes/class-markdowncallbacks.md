---
title: "Class: MarkdownCallbacks"
description: "Callback bundle threaded through the block renderer."
---

```dart
/// Callback bundle threaded through the block renderer.
class MarkdownCallbacks {
  const MarkdownCallbacks({this.onTapLink, this.onTapLinkDetails, this.onTapImage, this.onTapHeading, this.onTapElement, this.blockBuilder, this.onDocumentReady, this.imagePreviewBehavior = MarkdownImagePreviewBehavior.dialog, this.imagePreviewBuilder, this.imageBuilder, required this.linkRecognizer});
  final MarkdownTapLinkCallback? onTapLink;
  final MarkdownTapLinkDetailsCallback? onTapLinkDetails;
  final MarkdownTapImageCallback? onTapImage;
  final MarkdownTapHeadingCallback? onTapHeading;
  final MarkdownTapElementCallback? onTapElement;
  final MarkdownBlockBuilder? blockBuilder;
  final MarkdownDocumentReadyCallback? onDocumentReady;
  final MarkdownImagePreviewBehavior imagePreviewBehavior;
  final MarkdownImagePreviewBuilder? imagePreviewBuilder;
  final MarkdownImageWidgetBuilder? imageBuilder;
  final MarkdownLinkRecognizerFactory linkRecognizer;
}
```
