// Named examples for the `dialog` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// Every trigger pushes a real route over the WHOLE app (the default root
// navigator), never clipped to the stage. A barrier-locked dialog always
// offers an explicit way out (Cancel), so the user is never trapped.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import '../input/input.dart';
import 'dialog.dart';

/// Centred trigger button.
class _Trigger extends StatelessWidget {
  const _Trigger({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

/// Dialog title line in the foreground token.
Widget _title(BuildContext context, String text) {
  final theme = Theme.of(context);
  return Text(
    text,
    style: TextStyle(
      color: theme.colors.foreground,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );
}

/// Dialog body text in the muted token.
Widget _body(BuildContext context, String text) {
  return Text(
    text,
    style: TextStyle(color: Theme.of(context).colors.mutedForeground),
  );
}

/// Action row: right-aligned, wraps on narrow cards.
Widget _actions(BuildContext context, List<Widget> buttons) {
  return Wrap(
    alignment: WrapAlignment.end,
    spacing: 8,
    runSpacing: 8,
    children: buttons,
  );
}

/// Edit-profile form with working Save/Cancel.
class _EditProfileBody extends StatefulWidget {
  const _EditProfileBody();

  @override
  State<_EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<_EditProfileBody> {
  final TextEditingController _name = TextEditingController(text: 'Ada');
  final TextEditingController _user = TextEditingController(text: 'ada');

  @override
  void dispose() {
    _name.dispose();
    _user.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gap = Theme.of(context).spacing.md;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _title(context, 'Edit profile'),
        Gap(gap),
        Input(controller: _name, placeholder: const Text('Name')),
        Gap(gap),
        Input(controller: _user, placeholder: const Text('Username')),
        Gap(gap * 2),
        _actions(context, <Widget>[
          Button(
            variant: ButtonVariant.outline,
            size: ButtonSize.sm,
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          Button(
            size: ButtonSize.sm,
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Save'),
          ),
        ]),
      ],
    );
  }
}

Widget _editProfile(BuildContext context) => _Trigger(
  label: 'Edit profile',
  onPressed: () => showDialog<bool>(
    context: context,
    builder: (context) => const _EditProfileBody(),
  ),
);

/// Share link with a working copy button.
class _ShareBody extends StatefulWidget {
  const _ShareBody();

  @override
  State<_ShareBody> createState() => _ShareBodyState();
}

class _ShareBodyState extends State<_ShareBody> {
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(
      const ClipboardData(text: 'https://example.com/s/abc123'),
    );
    if (mounted) setState(() => _copied = true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gap = theme.spacing.md;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _title(context, 'Share this document'),
        Gap(gap),
        _body(context, 'Anyone with the link can view.'),
        Gap(gap),
        DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colors.muted,
            borderRadius: theme.borderRadiusMd,
            border: Border.all(color: theme.colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: <Widget>[
                const Flexible(child: Text('example.com/s/abc123')),
                Gap(gap),
                Button(
                  variant: ButtonVariant.secondary,
                  size: ButtonSize.sm,
                  onPressed: _copy,
                  child: Text(_copied ? 'Copied!' : 'Copy'),
                ),
              ],
            ),
          ),
        ),
        Gap(gap * 2),
        _actions(context, <Widget>[
          Button(
            variant: ButtonVariant.outline,
            size: ButtonSize.sm,
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ]),
      ],
    );
  }
}

Widget _share(BuildContext context) => _Trigger(
  label: 'Share link',
  onPressed: () =>
      showDialog<void>(context: context, builder: (_) => const _ShareBody()),
);

/// Invite team members with a working list.
class _InviteBody extends StatefulWidget {
  const _InviteBody();

  @override
  State<_InviteBody> createState() => _InviteBodyState();
}

class _InviteBodyState extends State<_InviteBody> {
  final TextEditingController _email = TextEditingController();
  final List<String> _invited = <String>['ada@example.com'];

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gap = Theme.of(context).spacing.md;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _title(context, 'Invite members'),
        Gap(gap),
        Row(
          children: <Widget>[
            Flexible(
              child: Input(controller: _email, hintText: 'Email'),
            ),
            Gap(gap),
            Button(
              size: ButtonSize.sm,
              onPressed: () {
                final String value = _email.text.trim();
                if (value.isEmpty) return;
                setState(() {
                  _invited.add(value);
                  _email.clear();
                });
              },
              child: const Text('Invite'),
            ),
          ],
        ),
        Gap(gap),
        for (final String address in _invited) Text(address),
        Gap(gap * 2),
        _actions(context, <Widget>[
          Button(
            variant: ButtonVariant.outline,
            size: ButtonSize.sm,
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Done'),
          ),
        ]),
      ],
    );
  }
}

Widget _invite(BuildContext context) => _Trigger(
  label: 'Invite members',
  onPressed: () =>
      showDialog<void>(context: context, builder: (_) => const _InviteBody()),
);

/// Scrollable terms with explicit Accept/Decline.
Widget _termsBody(BuildContext context) {
  final gap = Theme.of(context).spacing.md;
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _title(context, 'Terms of service'),
      Gap(gap),
      ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 220),
        child: SingleChildScrollView(
          child: _body(
            context,
            '1. Be kind.\n\n2. Ship working software.\n\n'
            '3. Respect the theme tokens.\n\n4. Prefer composition.\n\n'
            '5. Test what you ship.\n\n6. Document the contract.',
          ),
        ),
      ),
      Gap(gap * 2),
      _actions(context, <Widget>[
        Button(
          variant: ButtonVariant.outline,
          size: ButtonSize.sm,
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Decline'),
        ),
        Button(
          size: ButtonSize.sm,
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Accept'),
        ),
      ]),
    ],
  );
}

Widget _terms(BuildContext context) => _Trigger(
  label: 'Read terms',
  onPressed: () => showDialog<bool>(
    context: context,
    builder: (context) => _termsBody(context),
  ),
);

/// Command-like picker with a working filter.
class _PickerBody extends StatefulWidget {
  const _PickerBody();

  @override
  State<_PickerBody> createState() => _PickerBodyState();
}

class _PickerBodyState extends State<_PickerBody> {
  final TextEditingController _query = TextEditingController();
  String _filter = '';

  static const List<String> _items = <String>[
    'Calendar',
    'Search Emoji',
    'Calculator',
    'Activity',
  ];

  @override
  void initState() {
    super.initState();
    _query.addListener(() => setState(() => _filter = _query.text));
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gap = Theme.of(context).spacing.md;
    final List<String> shown = _items
        .where(
          (String item) => item.toLowerCase().contains(_filter.toLowerCase()),
        )
        .toList();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _title(context, 'Jump to…'),
        Gap(gap),
        Input(controller: _query, hintText: 'Type to filter'),
        Gap(gap),
        for (final String item in shown)
          Button(
            variant: ButtonVariant.ghost,
            size: ButtonSize.sm,
            onPressed: () => Navigator.of(context).pop(item),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(item),
            ),
          ),
        if (shown.isEmpty) _body(context, 'No matches.'),
      ],
    );
  }
}

Widget _picker(BuildContext context) => _Trigger(
  label: 'Open picker',
  onPressed: () =>
      showDialog<String>(context: context, builder: (_) => const _PickerBody()),
);

/// Barrier-locked dialog with an explicit Cancel way out (never traps).
Widget _lockedBody(BuildContext context) {
  final gap = Theme.of(context).spacing.md;
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _title(context, 'Delete this project?'),
      Gap(gap),
      _body(
        context,
        'The barrier is locked: tap outside or press Escape does nothing. '
        'Use Cancel or Delete to leave.',
      ),
      Gap(gap * 2),
      _actions(context, <Widget>[
        Button(
          variant: ButtonVariant.outline,
          size: ButtonSize.sm,
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        Button(
          variant: ButtonVariant.destructive,
          size: ButtonSize.sm,
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Delete'),
        ),
      ]),
    ],
  );
}

Widget _locked(BuildContext context) => _Trigger(
  label: 'Open locked dialog',
  onPressed: () => showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => _lockedBody(context),
  ),
);

/// Named docs examples for `dialog`; the first entry is the default.
const List<ComponentPreview> dialogPreviews = <ComponentPreview>[
  ComponentPreview('Edit profile', _editProfile),
  ComponentPreview('Share link', _share),
  ComponentPreview('Invite members', _invite),
  ComponentPreview('Terms', _terms),
  ComponentPreview('Picker', _picker),
  ComponentPreview('Barrier locked', _locked),
];
