// Named examples for the `code_snippet` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/clickable.dart';
import '../../theme/color_tokens.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import 'code_snippet.dart';

/// A small pill button for the snippet actions row.
class _CodeSnippetAction extends StatelessWidget {
  const _CodeSnippetAction({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Button(
      size: ButtonSize.sm,
      variant: ButtonVariant.ghost,
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

/// Default snippet with syntax colouring and copy button.
Widget _codeSnippetDefault(BuildContext context) {
  return const Align(
    alignment: Alignment.center,
    child: CodeSnippet(code: Text('const greeting = "hello";')),
  );
}

/// Interactive showcase across the supported languages.
class _CodeSnippetLanguages extends StatefulWidget {
  const _CodeSnippetLanguages();

  @override
  State<_CodeSnippetLanguages> createState() => _CodeSnippetLanguagesState();
}

class _CodeSnippetLanguagesState extends State<_CodeSnippetLanguages> {
  int _selected = 0;

  static const List<({String label, String lang, String code})> _samples = [
    (
      label: 'Dart',
      lang: 'dart',
      code: 'void main() {\n  runApp(const MyApp());\n}',
    ),
    (
      label: 'JSON',
      lang: 'json',
      code:
          '{\n  "name": "dashcn",\n  "version": "1.0.0",\n  "private": true\n}',
    ),
    (
      label: 'YAML',
      lang: 'yaml',
      code: 'name: dashcn\nversion: 1.0.0\nenvironment:\n  sdk: ^3.0.0',
    ),
    (
      label: 'Shell',
      lang: 'bash',
      code: 'flutter pub add dashcn\ndashcn add code_snippet',
    ),
    (
      label: 'TypeScript',
      lang: 'ts',
      code: 'interface User {\n  id: string;\n  name: string;\n}',
    ),
    (
      label: 'HTML',
      lang: 'html',
      code: '<div class="card">\n  <span id="title">Hello</span>\n</div>',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final current = _samples[_selected];
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (int i = 0; i < _samples.length; i++) ...<Widget>[
                if (i > 0) Gap(theme.spacing.xs),
                Clickable(
                  onPressed: () => setState(() => _selected = i),
                  padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(
                      horizontal: theme.spacing.sm,
                      vertical: theme.spacing.xs,
                    ),
                  ),
                  decoration: WidgetStateProperty.resolveWith<Decoration?>((
                    states,
                  ) {
                    final bool active = i == _selected;
                    return BoxDecoration(
                      color: active
                          ? theme.colors.primary
                          : states.contains(WidgetState.hovered)
                          ? theme.colors.muted
                          : null,
                      borderRadius: theme.borderRadiusSm,
                    );
                  }),
                  child: Text(
                    _samples[i].label,
                    style: theme.typography.small.copyWith(
                      color: i == _selected
                          ? theme.colors.primaryForeground
                          : theme.colors.mutedForeground,
                      fontWeight: i == _selected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        Gap(theme.spacing.sm),
        SizedBox(
          width: 380,
          child: CodeSnippet(
            key: ValueKey<String>(current.lang),
            language: current.lang,
            code: Text(current.code),
          ),
        ),
      ],
    );
  }
}

/// A snippet with an extra action button alongside the copy button.
class _CodeSnippetWithActions extends StatefulWidget {
  const _CodeSnippetWithActions();

  @override
  State<_CodeSnippetWithActions> createState() =>
      _CodeSnippetWithActionsState();
}

class _CodeSnippetWithActionsState extends State<_CodeSnippetWithActions> {
  String _status = 'idle';

  @override
  Widget build(BuildContext context) {
    final spacing = Theme.of(context).spacing;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 320,
          child: CodeSnippet(
            showCopyButton: false,
            actions: <Widget>[
              _CodeSnippetAction(
                label: 'Copy',
                onPressed: () => setState(() => _status = 'copied'),
              ),
              _CodeSnippetAction(
                label: 'Run',
                onPressed: () => setState(() => _status = 'running'),
              ),
            ],
            code: const Text('flutter run -d chrome'),
          ),
        ),
        Gap(spacing.sm),
        Text(
          _status,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}

/// A long line that scrolls horizontally inside its bounded box without overflowing.
Widget _codeSnippetLongLines(BuildContext context) {
  return const Align(
    alignment: Alignment.center,
    child: SizedBox(
      width: 320,
      child: CodeSnippet(
        code: Text(
          'void main() { runApp(const MyApp(home: Center(child: Text("long line scrolls horizontally inside code block")))); }',
        ),
      ),
    ),
  );
}

/// A customized snippet using builder slots and per-instance style overrides.
Widget _codeSnippetCustomized(BuildContext context) {
  return Align(
    alignment: Alignment.center,
    child: SizedBox(
      width: 360,
      child: CodeSnippet(
        theme: const CodeSnippetTheme(
          borderColor: ThemedColor.ref(ColorRef.primary),
          borderWidth: 1.5,
        ),
        copyButtonBuilder: (context, onCopy, copied) {
          final theme = Theme.of(context);
          return Clickable(
            onPressed: onCopy,
            focusOutline: true,
            padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                horizontal: theme.spacing.sm,
                vertical: theme.spacing.xs,
              ),
            ),
            decoration: WidgetStateProperty.resolveWith<Decoration?>((states) {
              return BoxDecoration(
                color: copied
                    ? theme.colors.primary.withValues(alpha: 0.2)
                    : theme.colors.muted,
                borderRadius: theme.borderRadiusSm,
              );
            }),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  copied ? LucideIcons.check : LucideIcons.copy,
                  size: 13,
                  color: copied
                      ? theme.colors.primary
                      : theme.colors.foreground,
                ),
                Gap(theme.spacing.xs),
                Text(
                  copied ? 'Copied!' : 'Copy',
                  style: theme.typography.small.copyWith(
                    fontSize: 12,
                    color: copied
                        ? theme.colors.primary
                        : theme.colors.foreground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
        code: const Text('final custom = CodeSnippetCustomized();'),
      ),
    ),
  );
}

Widget _codeSnippetLanguages(BuildContext context) =>
    const _CodeSnippetLanguages();

Widget _codeSnippetWithActions(BuildContext context) =>
    const _CodeSnippetWithActions();

/// Named docs examples for `code_snippet`; the first entry is the default.
const List<ComponentPreview> codeSnippetPreviews = <ComponentPreview>[
  ComponentPreview('Default', _codeSnippetDefault),
  ComponentPreview('With actions', _codeSnippetWithActions),
  ComponentPreview('Long lines', _codeSnippetLongLines),
  ComponentPreview('Languages', _codeSnippetLanguages),
  ComponentPreview('Customized', _codeSnippetCustomized),
];
