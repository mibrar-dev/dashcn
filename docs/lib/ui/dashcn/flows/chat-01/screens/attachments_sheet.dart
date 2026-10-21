// Attachments sheet body of the `chat-01` flow: photo / file pickers shown
// inside the conversation's [PinnedSheet].

import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/pinned_sheet/pinned_sheet.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import '../../../primitives/localizations/localizations.dart';

/// Attachment kinds; picking reports [onPick] and closes via [onClose].
class Chat01AttachmentsSheet extends StatelessWidget {
  /// Creates the attachments sheet body.
  const Chat01AttachmentsSheet({
    super.key,
    required this.controller,
    required this.onClose,
    required this.onPick,
  });

  /// Sheet controller for the Close button.
  final SheetController controller;

  /// Hides the sheet.
  final VoidCallback onClose;

  /// Called with `photo` or `file`.
  final Future<void> Function(String kind) onPick;

  @override
  Widget build(BuildContext context) {
    final strings = ComponentLocalizations.of(context);
    final ThemeData appTheme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(appTheme.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(strings.blockAttach, style: appTheme.typography.h3),
          Gap(appTheme.spacing.md),
          Button(
            key: const ValueKey<String>('chat01.attach.photo'),
            variant: ButtonVariant.outline,
            onPressed: () => onPick('photo'),
            child: Text(strings.blockAttachPhoto),
          ),
          Gap(appTheme.spacing.sm),
          Button(
            key: const ValueKey<String>('chat01.attach.file'),
            variant: ButtonVariant.outline,
            onPressed: () => onPick('file'),
            child: Text(strings.blockAttachFile),
          ),
          Gap(appTheme.spacing.sm),
          Button(
            variant: ButtonVariant.ghost,
            onPressed: () {
              controller.close();
              onClose();
            },
            child: Text(strings.actionClose),
          ),
        ],
      ),
    );
  }
}
