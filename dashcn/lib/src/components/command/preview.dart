// Named examples for the `command` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// P7-C2: the palette is live — the search field filters as you type and
// picking a row echoes the command that was run.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../primitives/subfocus_list_item.dart';
import '../../theme/theme.dart';
import 'command.dart';

/// Commands the palette offers.
const List<String> _commandValues = <String>[
  'Calendar',
  'Search Emoji',
  'Launch',
  'Profile',
  'Mail',
  'Settings',
];

/// The palette itself, sized to the stage.
class _CommandPalette extends StatefulWidget {
  const _CommandPalette({this.buildGroups = false});

  final bool buildGroups;

  @override
  State<_CommandPalette> createState() => _CommandPaletteState();
}

class _CommandPaletteState extends State<_CommandPalette> {
  String? _lastCommand;

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Center(
      child: SizedBox(
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 300,
              child: Command(
                debounceDuration: Duration.zero,
                builder: (context, query) async* {
                  final List<Widget> items = <Widget>[];
                  if (!widget.buildGroups) {
                    for (final String value in _commandValues) {
                      if (query == null ||
                          value.toLowerCase().contains(query.toLowerCase())) {
                        items.add(
                          SubFocusListItem(
                            title: Text(value),
                            onTap: () => setState(() => _lastCommand = value),
                          ),
                        );
                      }
                    }
                  } else {
                    for (final String group in const <String>[
                      'Suggestions',
                      'Settings',
                    ]) {
                      items.add(
                        // upstream group heading: `px-2 py-1.5 text-xs font-medium`
                        // in the muted colour.
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          child: Text(
                            group,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colors.mutedForeground,
                            ),
                          ),
                        ),
                      );
                      for (final String value in _commandValues) {
                        if (query == null ||
                            value.toLowerCase().contains(query.toLowerCase())) {
                          items.add(
                            SubFocusListItem(
                              title: Text(value),
                              onTap: () => setState(() => _lastCommand = value),
                            ),
                          );
                        }
                      }
                      items.add(SizedBox(height: spacing.sm));
                    }
                  }
                  yield items;
                },
              ),
            ),
            SizedBox(height: spacing.sm),
            Text(
              _lastCommand == null
                  ? 'Run a command to see it here'
                  : 'Ran $_lastCommand',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colors.mutedForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The default palette.
Widget _commandDefault(BuildContext context) => const _CommandPalette();

/// The palette with grouped results.
Widget _commandWithGroups(BuildContext context) =>
    const _CommandPalette(buildGroups: true);

/// Named docs examples for `command`; the first entry is the default.
const List<ComponentPreview> commandPreviews = <ComponentPreview>[
  ComponentPreview('Default', _commandDefault),
  ComponentPreview('With groups', _commandWithGroups),
];
