// The install block for flow pages (P9-3b): Package | Own the code tabs
// sharing one command source (`install_commands.dart`), plus the installed
// file list on the Own tab. Mirrors `ComponentInstallBlock`.

import 'package:flutter/widgets.dart';

import '../generated/docs_flows.dart';
import '../routing/docs_router.dart';
import '../state/docs_strings.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/primitives/clickable.dart';
import '../ui/dashcn/primitives/syntax_highlight/syntax_highlight.dart';
import '../ui/dashcn/theme/theme.dart';
import 'copy_button.dart';
import 'docs_tokens.dart';
import 'heading_anchor.dart';
import 'install_commands.dart';
import 'selectable_code.dart';

/// The install block: Package | Own the code tabs for one flow.
class FlowInstallBlock extends StatefulWidget {
  /// Creates the install block for [flow].
  const FlowInstallBlock({super.key, required this.flow});

  /// The registry flow.
  final DocsFlow flow;

  @override
  State<FlowInstallBlock> createState() => _FlowInstallBlockState();
}

class _FlowInstallBlockState extends State<FlowInstallBlock> {
  // 0 = Package, 1 = Own the code.
  int _tab = 0;

  String get _command => _tab == 0
      ? packageFlowSnippet(widget.flow.id)
      : '$kCliActivateCommand\n${ownFlowCodeSnippet(widget.flow.id)}';

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HeadingAnchor(
          id: 'installation',
          title: docsChrome(locale, 'secInstallation'),
        ),
        const Gap(16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _LineTab(
                label: docsChrome(locale, 'cmpPackage'),
                selected: _tab == 0,
                onTap: () => setState(() => _tab = 0),
              ),
              _LineTab(
                label: docsChrome(locale, 'cmpOwnCode'),
                selected: _tab == 1,
                onTap: () => setState(() => _tab = 1),
              ),
            ],
          ),
        ),
        const Gap(12),
        _InstallFigure(
          command: _command,
          files: _tab == 1 ? widget.flow.files : null,
        ),
      ],
    );
  }
}

/// The code figure: terminal header + copy, then the snippet and — on the
/// Own tab — the installed file list.
class _InstallFigure extends StatelessWidget {
  const _InstallFigure({required this.command, required this.files});

  final String command;
  final List<String>? files;

  @override
  Widget build(BuildContext context) {
    final DocsSiteColors site = DocsSiteColors.of(context);
    final ThemeData theme = Theme.of(context);
    final List<String>? owned = files;
    return Container(
      decoration: BoxDecoration(
        color: site.codeSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.colors.border.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: theme.colors.border.withValues(alpha: 0.3),
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: <Widget>[
                Icon(
                  LucideIcons.terminal,
                  size: 16,
                  color: theme.colors.foreground.withValues(alpha: 0.7),
                ),
                const Spacer(),
                CopyButton(
                  text: command,
                  variant: ButtonVariant.ghost,
                  size: ButtonSize.sm,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SelectableCode(
                child: Text.rich(
                  syntaxTextSpan(
                    code: command,
                    language: SyntaxLanguage.bash,
                    base: theme.typography.mono.copyWith(
                      fontSize: 14,
                      height: 24.5 / 14,
                    ),
                    colors: theme.syntaxColors,
                  ),
                ),
              ),
            ),
          ),
          if (owned != null) _FileList(files: owned),
        ],
      ),
    );
  }
}

/// The installed file list shown under the Own-the-code snippet.
class _FileList extends StatelessWidget {
  const _FileList({required this.files});

  final List<String> files;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SelectableCode(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (final String file in files)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  file,
                  style: theme.typography.mono.copyWith(fontSize: 13),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LineTab extends StatelessWidget {
  const _LineTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Clickable(
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? theme.colors.primary : const Color(0x00000000),
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: docsText(
            context,
            size: 14,
            weight: FontWeight.w500,
            color: selected
                ? theme.colors.foreground
                : theme.colors.mutedForeground,
          ),
        ),
      ),
    );
  }
}
