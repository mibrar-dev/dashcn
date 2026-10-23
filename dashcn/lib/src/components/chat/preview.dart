// Named examples for the `chat` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// P7-C2: the reaction chips are live — tapping one toggles it and the count
// follows, so the demo shows what the reaction row does.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import '../text_area/text_area.dart';
import 'chat.dart';

/// A round initials avatar drawn with theme tokens.
class _ChatAvatar extends StatelessWidget {
  const _ChatAvatar(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colors.muted,
        shape: BoxShape.circle,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          // Initials sit on the muted circle: the raw token fails AA on it.
          color: theme.colors.onMuted,
        ),
      ),
    );
  }
}

/// The conversation column, bounded so the stage never overflows.
class _ChatConversation extends StatelessWidget {
  const _ChatConversation();

  static const Widget _start = _ChatAvatar('JO');
  static const Widget _end = _ChatAvatar('AI');

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ChatGroup(
              avatarSuffix: _end,
              children: <Widget>[
                ChatBubble(
                  child: Text(
                    docsSample(context, 'Did you remember the meeting time?'),
                  ),
                ),
                ChatBubble(
                  child: Text(docsSample(context, 'Please reply ASAP.')),
                ),
              ],
            ),
            Gap(spacing.lg),
            ChatGroup(
              avatarPrefix: _start,
              children: <Widget>[
                ChatBubble(child: Text(docsSample(context, 'Around 6 or 7?'))),
                ChatBubble(
                  child: Text(docsSample(context, 'New phone who dis?')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Incoming bubbles only.
Widget _chatIncoming(BuildContext context) {
  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ChatGroup(
            avatarPrefix: _ChatConversation._start,
            children: <Widget>[
              ChatBubble(
                child: Text(docsSample(context, 'Is the build green yet?')),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

/// Outgoing bubbles only.
Widget _chatOutgoing(BuildContext context) {
  return Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 560),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ChatGroup(
            avatarSuffix: _ChatConversation._end,
            children: <Widget>[
              ChatBubble(
                child: Text(
                  docsSample(context, 'Deploying now - two minutes.'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

/// A grouped run with a tailed shape and a live reaction row.
class _ChatGrouped extends StatefulWidget {
  const _ChatGrouped();

  @override
  State<_ChatGrouped> createState() => _ChatGroupedState();
}

class _ChatGroupedState extends State<_ChatGrouped> {
  bool _thumbsUp = true;
  bool _party = false;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ChatGroup(
              avatarPrefix: _ChatConversation._start,
              children: <Widget>[
                ChatBubble(child: Text(docsSample(context, 'First message'))),
                ChatBubble(child: Text(docsSample(context, 'Second message'))),
                ChatBubble(child: Text(docsSample(context, 'Third message'))),
              ],
            ),
            Gap(spacing.sm),
            ChatReaction(
              chips: <Widget>[
                ChatReactionContainer(
                  onTap: () => setState(() => _thumbsUp = !_thumbsUp),
                  selected: _thumbsUp,
                  child: Text('\u{1F44D} ${_thumbsUp ? 4 : 3}'),
                ),
                ChatReactionContainer(
                  onTap: () => setState(() => _party = !_party),
                  selected: _party,
                  child: Text('\u{1F389} ${_party ? 2 : 1}'),
                ),
              ],
              child: ChatBubble(child: Text(docsSample(context, 'Nice work!'))),
            ),
            Gap(spacing.lg),
            ComponentTheme<ChatTheme>(
              data: const ChatTheme(
                widthFactor: 0.8,
                background: ThemedColor.ref(ColorRef.accent),
                foreground: ThemedColor.ref(ColorRef.accentForeground),
              ),
              child: ChatGroup(
                children: <Widget>[
                  ChatBubble(
                    child: Text(docsSample(context, 'Accented group bubble.')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _chatDefault(BuildContext context) => const _ChatConversation();

Widget _chatGrouped(BuildContext context) => const _ChatGrouped();

Widget _chatLive(BuildContext context) => const _ChatLive();

/// One message of the live demo thread.
class _LiveMessage {
  const _LiveMessage(this.text, this.mine);

  final String text;
  final bool mine;
}

/// Canned agent replies, cycled in order.
List<String> _liveReplies = <String>[
  docsSample(null, 'Got it — pulling up your payout history now.'),
  docsSample(
    null,
    'That month was prorated after the reissue; I can send the breakdown.',
  ),
  docsSample(null, 'All set — refresh the report to see the corrected split.'),
];

/// A working support thread: typing + Enter/Send appends the user's bubble,
/// a typing indicator shows after ~800 ms, then a canned agent reply lands.
/// The list auto-scrolls and Send stays disabled while the field is empty.
class _ChatLive extends StatefulWidget {
  const _ChatLive();

  @override
  State<_ChatLive> createState() => _ChatLiveState();
}

class _ChatLiveState extends State<_ChatLive> {
  final List<_LiveMessage> _messages = <_LiveMessage>[
    _LiveMessage(
      docsSample(null, 'Can you re-check the 2026-01 payout?'),
      true,
    ),
    _LiveMessage(
      docsSample(null, 'I see it — that month was prorated.'),
      false,
    ),
  ];
  final TextEditingController _reply = TextEditingController();
  final ScrollController _scroll = ScrollController();
  bool _canSend = false;
  bool _typing = false;
  int _nextReply = 0;
  int _sendCount = 0;

  @override
  void initState() {
    super.initState();
    _reply.addListener(_syncSend);
  }

  @override
  void dispose() {
    _reply.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _syncSend() {
    final bool next = _reply.text.trim().isNotEmpty;
    if (next != _canSend) {
      setState(() => _canSend = next);
    }
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scroll.hasClients) {
        return;
      }
      _scroll.jumpTo(_scroll.position.maxScrollExtent);
    });
  }

  Future<void> _send() async {
    final String text = _reply.text.trim();
    if (text.isEmpty || _typing) {
      return;
    }
    final int ticket = ++_sendCount;
    setState(() {
      _messages.add(_LiveMessage(text, true));
      _reply.clear();
    });
    _scrollToEnd();
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted || ticket != _sendCount) {
      return;
    }
    setState(() => _typing = true);
    _scrollToEnd();
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted || ticket != _sendCount) {
      return;
    }
    setState(() {
      _typing = false;
      _messages.add(
        _LiveMessage(_liveReplies[_nextReply % _liveReplies.length], false),
      );
      _nextReply++;
    });
    _scrollToEnd();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 220),
              child: SingleChildScrollView(
                controller: _scroll,
                child: ChatGroup(
                  children: <Widget>[
                    for (final _LiveMessage message in _messages)
                      ChatBubble(
                        theme: message.mine ? null : _incomingBubble,
                        variant: message.mine
                            ? ChatBubbleVariant.tail
                            : ChatBubbleVariant.plain,
                        child: Text(message.text),
                      ),
                    if (_typing)
                      const ChatBubble(
                        theme: _incomingBubble,
                        child: _TypingDots(),
                      ),
                  ],
                ),
              ),
            ),
            Gap(spacing.md),
            TextArea(
              controller: _reply,
              minLines: 1,
              maxLines: 4,
              hintText: docsSample(context, 'Write a reply...'),
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _send(),
            ),
            Gap(spacing.md),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Button(
                variant: ButtonVariant.primary,
                size: ButtonSize.sm,
                leading: const Icon(LucideIcons.send, size: 14),
                enabled: _canSend,
                onPressed: _send,
                child: Text(docsSample(context, 'Send')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Three static dots shown while the agent "types" (static: no ticker, so
/// the ticker-off static collage and the 720x420 preview stage stay still).
class _TypingDots extends StatelessWidget {
  const _TypingDots();

  @override
  Widget build(BuildContext context) {
    final Color dot = Theme.of(context).colors.mutedForeground;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (int i = 0; i < 3; i++)
          Container(
            width: 6,
            height: 6,
            margin: EdgeInsets.only(left: i == 0 ? 0 : 4),
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
          ),
      ],
    );
  }
}

/// Named docs examples for `chat`; the first entry is the default.
List<ComponentPreview> get chatPreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _chatDefault),
  ComponentPreview(docsSample(null, 'Incoming'), _chatIncoming),
  ComponentPreview(docsSample(null, 'Outgoing'), _chatOutgoing),
  ComponentPreview(docsSample(null, 'Grouped'), _chatGrouped),
  ComponentPreview(docsSample(null, 'Live'), _chatLive),
];

/// Incoming (other side) bubbles: start-aligned on the muted surface.
const ChatTheme _incomingBubble = ChatTheme(
  background: ThemedColor.ref(ColorRef.muted),
  foreground: ThemedColor.ref(ColorRef.foreground),
  alignment: AlignmentDirectional.centerStart,
  avatarAlignment: AlignmentDirectional.topStart,
);
