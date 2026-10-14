---
title: "Class: Markdown"
description: "Text-only markdown renderer."
---

```dart
/// Text-only markdown renderer. Source is a string: read assets or files
/// yourself and pass the content (the old `asset`/`file` ctors and their
/// loading states are gone; the streaming extension only supports text
/// anyway). Link taps only fire callbacks: open URLs in [onTapLink] with
/// `url_launcher` (the old platform-channel opener cannot be widgets-only).
class Markdown extends StatefulWidget {
  const Markdown({super.key, required this.data, this.selectable = true, this.style, this.onTapLink, this.onTapLinkDetails, this.onTapImage, this.onTapHeading, this.onTapElement, this.blockBuilder, this.onDocumentReady, this.viewportStorageId, this.shrinkWrap = true, this.htmlSanitizationStrategy = MarkdownHtmlSanitizationStrategy.stripDangerousHtml, this.imagePreviewBehavior = MarkdownImagePreviewBehavior.dialog, this.imagePreviewBuilder, this.imageBuilder, this.theme});
  final String data;
  final bool selectable;
  final TextStyle? style;
  final MarkdownTapLinkCallback? onTapLink;
  final MarkdownTapLinkDetailsCallback? onTapLinkDetails;
  final MarkdownTapImageCallback? onTapImage;
  final MarkdownTapHeadingCallback? onTapHeading;
  final MarkdownTapElementCallback? onTapElement;
  final MarkdownBlockBuilder? blockBuilder;
  final MarkdownDocumentReadyCallback? onDocumentReady;
  final Object? viewportStorageId;
  final bool shrinkWrap;
  final MarkdownHtmlSanitizationStrategy htmlSanitizationStrategy;
  final MarkdownImagePreviewBehavior imagePreviewBehavior;
  final MarkdownImagePreviewBuilder? imagePreviewBuilder;
  final MarkdownImageWidgetBuilder? imageBuilder;
  final MarkdownTheme? theme;
  Markdown copyWith({String? data, bool? selectable, TextStyle? style, MarkdownTapLinkCallback? onTapLink, MarkdownTapLinkDetailsCallback? onTapLinkDetails, MarkdownTapImageCallback? onTapImage, MarkdownTapHeadingCallback? onTapHeading, MarkdownTapElementCallback? onTapElement, MarkdownBlockBuilder? blockBuilder, MarkdownDocumentReadyCallback? onDocumentReady, Object? viewportStorageId, bool? shrinkWrap, MarkdownHtmlSanitizationStrategy? htmlSanitizationStrategy, MarkdownImagePreviewBehavior? imagePreviewBehavior, MarkdownImagePreviewBuilder? imagePreviewBuilder, MarkdownImageWidgetBuilder? imageBuilder, MarkdownTheme? theme});
  State<Markdown> createState();
}
```
