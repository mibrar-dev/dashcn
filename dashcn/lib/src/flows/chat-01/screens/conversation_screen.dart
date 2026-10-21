// Conversation screen of the `chat-01` flow: chat bubbles, a composer and
// an attachments sheet.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../components/button/button.dart';
import '../../../components/chat/chat.dart';
import '../../../components/drawer_container/drawer_container.dart';
import '../../../components/input/input.dart';
import '../../../components/pinned_sheet/pinned_sheet.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import '../flow.dart';
import 'attachments_sheet.dart';
import '../../../primitives/localizations/localizations.dart';

/// Conversation with composer; attach opens the attachments sheet.
class Chat01ConversationScreen extends StatefulWidget {
  /// Creates the conversation screen.
  const Chat01ConversationScreen({
    super.key,
    required this.thread,
    required this.messages,
    this.onSend,
    this.onAttach,
  });

  /// Thread being shown.
  final Chat01Thread thread;

  /// Starting messages.
  final List<Chat01Message> messages;

  /// Called with the thread id + composer text on send.
  final Future<void> Function(String threadId, String text)? onSend;

  /// Called with the thread id + attachment kind.
  final Future<void> Function(String threadId, String kind)? onAttach;

  @override
  State<Chat01ConversationScreen> createState() =>
      _Chat01ConversationScreenState();
}

class _Chat01ConversationScreenState extends State<Chat01ConversationScreen> {
  late List<Chat01Message> _messages = List.of(widget.messages);
  final TextEditingController _composer = TextEditingController();
  final SheetController _sheet = SheetController();
  bool _sheetOpen = false;
  bool _busy = false;

  @override
  void dispose() {
    _composer.dispose();
    _sheet.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final String text = _composer.text.trim();
    if (text.isEmpty || _busy) {
      return;
    }
    setState(() => _busy = true);
    try {
      await widget.onSend?.call(widget.thread.id, text);
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _messages = <Chat01Message>[
        ..._messages,
        Chat01Message(text: text, mine: true),
      ];
    });
    _composer.clear();
  }

  Future<void> _attach(String kind) async {
    await widget.onAttach?.call(widget.thread.id, kind);
    if (!mounted) {
      return;
    }
    setState(() => _sheetOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    final strings = ComponentLocalizations.of(context);
    final ThemeData appTheme = Theme.of(context);
    return ColoredBox(
      color: appTheme.colors.background,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(appTheme.spacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Button(
                            variant: ButtonVariant.ghost,
                            size: ButtonSize.sm,
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('‹ ${strings.blockBack}'),
                          ),
                          Expanded(
                            child: Text(
                              widget.thread.name,
                              textAlign: TextAlign.center,
                              style: appTheme.typography.textSmall,
                            ),
                          ),
                          const SizedBox(width: 64),
                        ],
                      ),
                      Gap(appTheme.spacing.md),
                      Expanded(
                        child: ListView.separated(
                          itemCount: _messages.length,
                          separatorBuilder: (_, _) => Gap(appTheme.spacing.sm),
                          itemBuilder: (BuildContext context, int index) {
                            final Chat01Message message = _messages[index];
                            return ChatBubble(
                              alignment: message.mine
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Text(message.text),
                            );
                          },
                        ),
                      ),
                      Gap(appTheme.spacing.sm),
                      Row(
                        children: <Widget>[
                          Button(
                            key: const ValueKey<String>('chat01.attach'),
                            variant: ButtonVariant.outline,
                            size: ButtonSize.icon,
                            onPressed: () => setState(() => _sheetOpen = true),
                            child: const Text('+'),
                          ),
                          Gap(appTheme.spacing.sm),
                          Expanded(
                            child: Input(
                              key: const ValueKey<String>('chat01.composer'),
                              controller: _composer,
                              hintText: strings.blockWriteMessage,
                              textInputAction: TextInputAction.send,
                              onSubmitted: (_) => _send(),
                            ),
                          ),
                          Gap(appTheme.spacing.sm),
                          Button(
                            key: const ValueKey<String>('chat01.send'),
                            size: ButtonSize.icon,
                            onPressed: _busy ? null : _send,
                            child: const Text('›'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (_sheetOpen)
                  PinnedSheet(
                    controller: _sheet,
                    initialStage: const SheetStage.expanded(),
                    child: DrawerContainer(
                      child: Chat01AttachmentsSheet(
                        controller: _sheet,
                        onClose: () => setState(() => _sheetOpen = false),
                        onPick: _attach,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
