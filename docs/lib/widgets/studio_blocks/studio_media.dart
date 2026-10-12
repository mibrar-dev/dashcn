// The media blocks of the Theme Studio canvas: the reference's QR/share card,
// the file-upload dropzone, the OTP field and a chat thread.
//
// `Dropzone`, `InputOtp`, `ChatBubble` and `ChatGroup` are the registry
// components; the QR tile is a docs-only painter (`studio_paint.dart`).

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../ui/shadcn/components/badge/badge.dart';
import '../../ui/shadcn/components/button/button.dart';
import '../../ui/shadcn/components/chat/chat.dart';
import '../../ui/shadcn/components/dropzone/dropzone.dart';
import '../../ui/shadcn/components/input_otp/input_otp.dart';
import '../../ui/shadcn/components/text_area/text_area.dart';
import '../../ui/shadcn/foundation/gap.dart';
import '../../ui/shadcn/foundation/icons/lucide_icons.dart';
import '../../ui/shadcn/theme/theme.dart';
import '../../ui/shadcn/theme/color_tokens.dart';
import 'studio_card.dart';
import 'studio_paint.dart';

/// `Scan to connect your mobile device`: the reference's QR share card.
class StudioShareCard extends StatelessWidget {
  /// Creates the card.
  const StudioShareCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ShadcnThemeData theme = ShadcnTheme.of(context);
    return StudioCard(
      title: 'Share this release',
      subtitle: 'Open the Ledger mobile app and scan this code to link.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }
}

/// `Cover Art` upload: the registry dropzone with its browse action.
class StudioFileUploadCard extends StatelessWidget {
  /// Creates the card.
  const StudioFileUploadCard({super.key});

  @override
  Widget build(BuildContext context) {
    return StudioCard(
      title: 'Cover Art',
      subtitle: 'Upload the artwork of the release.',
      child: Dropzone(
        icon: const Icon(LucideIcons.image, size: 22),
        actionLabel: 'Upload Artwork',
        hint: const Text('Minimum 3000 × 3000px · JPEG or PNG only'),
      ),
    );
  }
}

/// `Verify your phone`: a six-slot OTP field with its action row.
class StudioOtpCard extends StatelessWidget {
  /// Creates the card.
  const StudioOtpCard({super.key});

  @override
  Widget build(BuildContext context) {
    return StudioCard(
      title: 'Verify your phone',
      subtitle: 'Enter the 6-digit code we texted to ···· 1192.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          InputOtp(length: 6),
          Gap(16),
          Row(
            children: <Widget>[
              Expanded(
                child: Button(
                  variant: ButtonVariant.outline,
                  onPressed: studioNoop,
                  child: Text('Resend'),
                ),
              ),
              Gap(12),
              Expanded(
                child: Button(
                  variant: ButtonVariant.primary,
                  onPressed: studioNoop,
                  child: Text('Verify'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// `Support`: a working support thread with a reply composer.
///
/// Same behaviour as the home `Support` card: typing + Enter/Send appends
/// the user's bubble, a typing indicator shows after ~800 ms, then a canned
/// agent reply lands. The thread auto-scrolls, the counter badge tracks the
/// message count, and Send stays disabled while the field is empty.
class StudioChatCard extends StatefulWidget {
  /// Creates the card.
  const StudioChatCard({super.key});

  @override
  State<StudioChatCard> createState() => StudioChatCardState();
}

/// State of the working [StudioChatCard]; public so tests drive send/reply.
class StudioChatCardState extends State<StudioChatCard> {
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
    return StudioCard(
      title: 'Support',
      subtitle: 'We reply within one business day.',
      trailing: Badge(
        variant: BadgeVariant.secondary,
        child: Text('${messages.length}'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
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
                      child: _StudioTypingDots(),
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
      ),
    );
  }
}

/// Three static dots for the typing indicator (static: no ticker).
class _StudioTypingDots extends StatelessWidget {
  const _StudioTypingDots();

  @override
  Widget build(BuildContext context) {
    final ShadcnThemeData theme = ShadcnTheme.of(context);
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

/// Incoming (other side) bubbles: start-aligned on the muted surface.
const ChatTheme _incomingBubble = ChatTheme(
  background: ThemedColor.ref(ColorRef.muted),
  foreground: ThemedColor.ref(ColorRef.foreground),
  alignment: AlignmentDirectional.centerStart,
  avatarAlignment: AlignmentDirectional.topStart,
);
