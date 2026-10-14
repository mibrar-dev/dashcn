// Home showcase: media cards — chat, share, upload (P6-H1).
//
// Extends the Theme Studio media blocks
// (`studio_blocks/studio_media.dart`): the support thread, the QR share
// card and the cover-art dropzone, re-shelled in [CollageCard].

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../ui/dashcn/components/badge/badge.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/components/chat/chat.dart';
import '../ui/dashcn/components/dropzone/dropzone.dart';
import '../ui/dashcn/components/text_area/text_area.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/theme/color_tokens.dart';
import '../ui/dashcn/theme/theme.dart';
import 'collage_cards.dart';
import 'studio_blocks/studio_paint.dart';

/// `Support`: a working support thread with a reply composer.
///
/// Typing + Enter/Send appends the user's bubble; after ~800 ms a typing
/// indicator shows and a canned agent reply lands (cycled in order). The
/// thread auto-scrolls, the counter badge tracks the message count, and Send
/// stays disabled while the field is empty.
class HomeChatCard extends StatefulWidget {
  /// Creates the card.
  const HomeChatCard({super.key});

  @override
  State<HomeChatCard> createState() => HomeChatCardState();
}

/// State of the working [HomeChatCard]; public so tests drive send/reply.
class HomeChatCardState extends State<HomeChatCard> {
  /// Canned agent replies, cycled in order.
  static const List<String> cannedReplies = <String>[
    'Got it — pulling up your payout history now.',
    'That month was prorated after the reissue; I can send the breakdown.',
    'All set — refresh the report to see the corrected split.',
  ];

  final TextEditingController reply = TextEditingController();
  final ScrollController scroll = ScrollController();

  final List<(String, bool)> messages = <(String, bool)>[
    ('The royalty report shows a lower split than expected.', true),
    ('Can you re-check the 2026-01 payout?', true),
    ('I see it — that month was prorated after the reissue.', false),
  ];

  bool canSend = false;
  bool typing = false;
  int _nextReply = 0;
  int _sendCount = 0;

  @override
  void initState() {
    super.initState();
    reply.addListener(_syncSend);
  }

  @override
  void dispose() {
    reply.dispose();
    scroll.dispose();
    super.dispose();
  }

  void _syncSend() {
    final bool next = reply.text.trim().isNotEmpty;
    if (next != canSend) {
      setState(() => canSend = next);
    }
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !scroll.hasClients) {
        return;
      }
      scroll.jumpTo(scroll.position.maxScrollExtent);
    });
  }

  /// Sends the composer's text as the user's bubble, then the canned reply.
  Future<void> send() async {
    final String text = reply.text.trim();
    if (text.isEmpty || typing) {
      return;
    }
    final int ticket = ++_sendCount;
    setState(() {
      messages.add((text, true));
      reply.clear();
    });
    _scrollToEnd();
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted || ticket != _sendCount) {
      return;
    }
    setState(() => typing = true);
    _scrollToEnd();
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted || ticket != _sendCount) {
      return;
    }
    setState(() {
      typing = false;
      messages.add((cannedReplies[_nextReply % cannedReplies.length], false));
      _nextReply++;
    });
    _scrollToEnd();
  }

  @override
  Widget build(BuildContext context) {
    return CollageCard(
      title: 'Support',
      subtitle: 'We reply within one business day.',
      trailing: Badge(
        variant: BadgeVariant.secondary,
        child: Text('${messages.length}'),
      ),
      children: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 260),
          child: SingleChildScrollView(
            controller: scroll,
            child: ChatGroup(
              children: <Widget>[
                for (final (String text, bool mine) in messages)
                  ChatBubble(
                    theme: mine ? null : _incomingBubble,
                    variant: mine
                        ? ChatBubbleVariant.tail
                        : ChatBubbleVariant.plain,
                    child: Text(text),
                  ),
                if (typing)
                  const ChatBubble(
                    theme: _incomingBubble,
                    child: _ChatTypingDots(),
                  ),
              ],
            ),
          ),
        ),
        const Gap(12),
        TextArea(
          controller: reply,
          minLines: 1,
          maxLines: 4,
          hintText: 'Write a reply...',
          textInputAction: TextInputAction.send,
          onSubmitted: (_) => send(),
        ),
        const Gap(12),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Button(
            variant: ButtonVariant.primary,
            size: ButtonSize.sm,
            leading: const Icon(LucideIcons.send, size: 14),
            enabled: canSend,
            onPressed: send,
            child: const Text('Send'),
          ),
        ),
      ],
    );
  }
}

/// Three static dots for the typing indicator (static: no ticker, so the
/// ticker-off static collage stays still).
class _ChatTypingDots extends StatelessWidget {
  const _ChatTypingDots();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (int i = 0; i < 3; i++)
          Container(
            width: 6,
            height: 6,
            margin: EdgeInsets.only(left: i == 0 ? 0 : 4),
            decoration: BoxDecoration(
              color: theme.colors.mutedForeground,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}

/// `Share this release`: the reference's QR share card.
class HomeShareCard extends StatelessWidget {
  /// Creates the card.
  const HomeShareCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return CollageCard(
      title: 'Share this release',
      subtitle: 'Open the Ledger mobile app and scan this code to link.',
      children: <Widget>[
        const StudioQrTile(size: 108, seed: 11),
        const Gap(16),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'midnight-drive-2026',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.typography.small.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
            ),
            const Gap(8),
            Button(
              variant: ButtonVariant.outline,
              size: ButtonSize.sm,
              leading: const Icon(LucideIcons.copy, size: 14),
              onPressed: () {},
              child: const Text('Copy link'),
            ),
          ],
        ),
      ],
    );
  }
}

/// `Cover Art` upload: the registry dropzone with its browse action.
class HomeUploadCard extends StatelessWidget {
  /// Creates the card.
  const HomeUploadCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const CollageCard(
      title: 'Cover Art',
      subtitle: 'Upload the artwork of the release.',
      children: <Widget>[
        Dropzone(
          icon: Icon(LucideIcons.image, size: 22),
          actionLabel: 'Upload Artwork',
          hint: Text('Minimum 3000 × 3000px · JPEG or PNG only'),
        ),
      ],
    );
  }
}

/// Incoming (other side) bubbles: start-aligned on the muted surface.
const ChatTheme _incomingBubble = ChatTheme(
  background: ThemedColor.ref(ColorRef.muted),
  foreground: ThemedColor.ref(ColorRef.foreground),
  alignment: AlignmentDirectional.centerStart,
  avatarAlignment: AlignmentDirectional.topStart,
);
