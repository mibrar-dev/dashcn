# Chat starter (`chat`)

Auth into a tab bar with chat threads and settings.

## Routes

- `/signin` — `auth-01` flow.
- `/chat` — `chat-01` flow (thread list, conversation, attachments sheet).
- `/settings` — `settings-01` flow.

Threads and messages start from the app's own `ChatRepository`
(`lib/data/repository.dart`, marked replace-with-backend) and every send,
refresh and attachment leaves through callbacks; the kit holds no backend.

## Create

```sh
dashcn create chat my_app
dashcn create chat my_app --theme vercel --mode package
```
