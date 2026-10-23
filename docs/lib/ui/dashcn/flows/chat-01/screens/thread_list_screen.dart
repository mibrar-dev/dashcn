// Thread list screen of the `chat-01` flow: pull-to-refresh plus swipe
// actions per thread; a tap pushes `/thread` with the thread.

import 'package:flutter/widgets.dart';

import '../../../components/avatar/avatar.dart';
import '../../../components/button/button.dart';
import '../../../components/card/card.dart';
import '../../../components/empty_state/empty_state.dart';
import '../../../components/refresh_trigger/refresh_trigger.dart';
import '../../../components/swipe_actions/swipe_actions.dart';
import '../../../foundation/gap.dart';
import '../../../theme/theme.dart';
import '../flow.dart';
import '../../../primitives/localizations/localizations.dart';
import '../../../foundation/component_preview.dart';

/// Thread list with refresh + swipe actions.
class Chat01ThreadListScreen extends StatefulWidget {
  /// Creates the thread list screen.
  const Chat01ThreadListScreen({
    super.key,
    required this.threads,
    this.onRefresh,
    this.onThreadMuted,
    this.onThreadDeleted,
  });

  /// Starting threads; the screen owns a mutable copy.
  final List<Chat01Thread> threads;

  /// Called on pull-to-refresh.
  final Future<void> Function()? onRefresh;

  /// Called with the muted thread.
  final ValueChanged<Chat01Thread>? onThreadMuted;

  /// Called with the deleted thread.
  final ValueChanged<Chat01Thread>? onThreadDeleted;

  @override
  State<Chat01ThreadListScreen> createState() => _Chat01ThreadListScreenState();
}

class _Chat01ThreadListScreenState extends State<Chat01ThreadListScreen> {
  late final List<Chat01Thread> _threads = List.of(widget.threads);
  final Set<String> _muted = <String>{};

  void _delete(Chat01Thread thread) {
    setState(() => _threads.removeWhere((Chat01Thread t) => t.id == thread.id));
    widget.onThreadDeleted?.call(thread);
  }

  void _mute(Chat01Thread thread) {
    setState(() => _muted.add(thread.id));
    widget.onThreadMuted?.call(thread);
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
            child: Padding(
              padding: EdgeInsets.all(appTheme.spacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(strings.blockMessages, style: appTheme.typography.h3),
                  Gap(appTheme.spacing.md),
                  Expanded(
                    child: RefreshTrigger(
                      onRefresh: widget.onRefresh,
                      child: _threads.isEmpty
                          ? SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: EmptyState(
                                title: Text(strings.blockNoConversations),
                                description: Text(
                                  docsSample(
                                    context,
                                    docsSample(
                                      context,
                                      'Pull to refresh or start a new chat.',
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : ListView.separated(
                              itemCount: _threads.length,
                              separatorBuilder: (_, _) =>
                                  Gap(appTheme.spacing.sm),
                              itemBuilder: (BuildContext context, int index) {
                                final Chat01Thread thread = _threads[index];
                                final bool muted = _muted.contains(thread.id);
                                return SwipeActions(
                                  key: ValueKey<String>(
                                    'chat01.thread.${thread.id}',
                                  ),
                                  actions: <SwipeAction>[
                                    SwipeAction(
                                      label: muted
                                          ? docsSample(context, 'Muted')
                                          : docsSample(context, 'Mute'),
                                      onPressed: () => _mute(thread),
                                    ),
                                    SwipeAction(
                                      label: strings.menuDelete,
                                      destructive: true,
                                      onPressed: () => _delete(thread),
                                    ),
                                  ],
                                  onDismissed: () => _delete(thread),
                                  child: Card(
                                    child: Button(
                                      variant: ButtonVariant.ghost,
                                      onPressed: () => Navigator.of(
                                        context,
                                      ).pushNamed('/thread', arguments: thread),
                                      child: _ThreadRow(
                                        thread: thread,
                                        muted: muted,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// One thread row: avatar, name + preview, unread badge.
class _ThreadRow extends StatelessWidget {
  const _ThreadRow({required this.thread, required this.muted});

  final Chat01Thread thread;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);
    return Row(
      children: <Widget>[
        Avatar(initials: thread.initials),
        Gap(appTheme.spacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                muted ? '${thread.name} (muted)' : thread.name,
                style: appTheme.typography.textSmall,
              ),
              Text(
                thread.lastMessage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: appTheme.typography.textMuted.copyWith(
                  color: appTheme.colors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
        if (thread.unread > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: appTheme.colors.primary,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '${thread.unread}',
              style: appTheme.typography.textSmall.copyWith(
                color: appTheme.colors.primaryForeground,
              ),
            ),
          ),
      ],
    );
  }
}
