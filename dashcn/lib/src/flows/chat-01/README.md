# Chat 01 (`chat-01`)

Thread list with swipe actions and pull-to-refresh, a conversation with chat
bubbles + composer, and an attachments sheet. Mobile-first; centres at
desktop widths.

## Files

- `flow.dart` — `Chat01Flow` (owns the nested `Navigator`), `Chat01Thread`,
  `Chat01Message`.
- `screens/thread_list_screen.dart`, `screens/conversation_screen.dart`,
  `screens/attachments_sheet.dart`

## Install

```sh
dashcn add flow:chat-01
```

```dart
import 'package:<your_app>/ui/dashcn/flows/chat-01/flow.dart';

Chat01Flow(
  threads: const [Chat01Thread(id: 'a', name: 'Ada', initials: 'A', lastMessage: 'Hi')],
  messages: const {'a': [Chat01Message(text: 'Hi', mine: false)]},
  onRefresh: refresh,
  onSend: (threadId, text) => send(threadId, text),
  onAttach: (threadId, kind) => attach(threadId, kind),
)
```

## Declared dependencies

| Layer | Units |
|---|---|
| `foundation` | `gap` |
| `theme` | `theme` |
| `components` | `avatar`, `button`, `card`, `chat`, `drawer_container`, `empty_state`, `input`, `page_route`, `pinned_sheet`, `refresh_trigger`, `swipe_actions` |

## Notes

The flow takes threads + messages in and reports through callbacks; there is
no chat backend and no demo data in the kit. `/` threads, `/thread`
conversation; attachments are a `PinnedSheet` over the conversation.
