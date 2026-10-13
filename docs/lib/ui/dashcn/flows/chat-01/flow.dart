// The `chat-01` flow: thread list with swipe actions + pull-to-refresh, a
// conversation with bubbles + composer, and an attachments sheet.
//
// Entry: [Chat01Flow] owns a nested [Navigator] (`/`, `/thread`). Threads
// and messages come in as data; sends, refreshes and attachments leave
// through callbacks. The kit holds no chat backend and no demo threads.

import 'package:flutter/widgets.dart';

import '../../components/page_route/page_route.dart';
import 'screens/conversation_screen.dart';
import 'screens/thread_list_screen.dart';

/// One conversation of [Chat01Flow].
class Chat01Thread {
  /// Creates a thread.
  const Chat01Thread({
    required this.id,
    required this.name,
    required this.initials,
    required this.lastMessage,
    this.unread = 0,
  });

  /// Stable id used to look up messages and report actions.
  final String id;

  /// Display name of the thread.
  final String name;

  /// Avatar fallback initials.
  final String initials;

  /// Preview line shown under the name.
  final String lastMessage;

  /// Unread badge count; zero hides the badge.
  final int unread;
}

/// One message of a conversation.
class Chat01Message {
  /// Creates a message.
  const Chat01Message({required this.text, required this.mine});

  /// Message text.
  final String text;

  /// Whether the bubble aligns to the local user.
  final bool mine;
}

/// Thread list → conversation with attachments.
class Chat01Flow extends StatelessWidget {
  /// Creates the flow.
  const Chat01Flow({
    super.key,
    this.threads = const <Chat01Thread>[
      Chat01Thread(
        id: 'studio',
        name: 'Design studio',
        initials: 'DS',
        lastMessage: 'The new mockups are ready.',
        unread: 2,
      ),
      Chat01Thread(
        id: 'ada',
        name: 'Ada Lovelace',
        initials: 'AL',
        lastMessage: 'See you at the demo!',
      ),
    ],
    this.messages = const <String, List<Chat01Message>>{
      'studio': <Chat01Message>[
        Chat01Message(text: 'Morning! Did the review land?', mine: false),
        Chat01Message(text: 'Just sent the new mockups.', mine: true),
        Chat01Message(text: 'The new mockups are ready.', mine: false),
      ],
      'ada': <Chat01Message>[
        Chat01Message(text: 'See you at the demo!', mine: false),
      ],
    },
    this.onRefresh,
    this.onSend,
    this.onAttach,
    this.onThreadMuted,
    this.onThreadDeleted,
    this.initialScreen = '/',
  });

  /// Starting threads; the list screen owns a mutable copy.
  final List<Chat01Thread> threads;

  /// Starting messages per thread id.
  final Map<String, List<Chat01Message>> messages;

  /// Called on pull-to-refresh.
  final Future<void> Function()? onRefresh;

  /// Called with the thread id + composer text on send.
  final Future<void> Function(String threadId, String text)? onSend;

  /// Called with the thread id + attachment kind (`photo`, `file`).
  final Future<void> Function(String threadId, String kind)? onAttach;

  /// Called with the muted thread.
  final ValueChanged<Chat01Thread>? onThreadMuted;

  /// Called with the deleted thread.
  final ValueChanged<Chat01Thread>? onThreadDeleted;

  /// Initial route of the nested navigator (`/`).
  final String initialScreen;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: initialScreen,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/thread') {
          // A bare `/thread` (e.g. a docs screen-map jump with no thread
          // yet) falls back to the thread list instead of throwing.
          final Object? args = settings.arguments;
          if (args is! Chat01Thread) {
            return AppPageRoute(
              settings: settings,
              builder: (_) => Chat01ThreadListScreen(
                threads: threads,
                onRefresh: onRefresh,
                onThreadMuted: onThreadMuted,
                onThreadDeleted: onThreadDeleted,
              ),
            );
          }
          final Chat01Thread thread = args;
          return AppPageRoute(
            settings: settings,
            builder: (_) => Chat01ConversationScreen(
              thread: thread,
              messages: messages[thread.id] ?? const <Chat01Message>[],
              onSend: onSend,
              onAttach: onAttach,
            ),
          );
        }
        return AppPageRoute(
          settings: settings,
          builder: (_) => Chat01ThreadListScreen(
            threads: threads,
            onRefresh: onRefresh,
            onThreadMuted: onThreadMuted,
            onThreadDeleted: onThreadDeleted,
          ),
        );
      },
    );
  }
}
