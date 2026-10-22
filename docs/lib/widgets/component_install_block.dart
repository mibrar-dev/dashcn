// The install block for component pages (P8-4): Package | Own the code
// tabs sharing one command source (`install_commands.dart`), plus the
// one-line eject note. The Own tab also lists the exact installed files.

import 'package:flutter/widgets.dart';

import '../generated/docs_snippets.dart';
import '../routing/docs_router.dart';
import '../state/docs_strings.dart';
import '../ui/dashcn/components/badge/badge.dart';
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
import 'typeset.dart';

/// The install block: Package | Own the code tabs + eject note.
class ComponentInstallBlock extends StatefulWidget {
  /// Creates the install block for [componentId].
  const ComponentInstallBlock({super.key, required this.componentId});

  /// The registry component id.
  final String componentId;

  @override
  State<ComponentInstallBlock> createState() => _ComponentInstallBlockState();
}

class _ComponentInstallBlockState extends State<ComponentInstallBlock> {
  // 0 = Package, 1 = Own the code.
  int _tab = 0;

  String get _command => _tab == 0
      ? packageSnippet(widget.componentId)
      : '$kCliActivateCommand\n${ownCodeSnippet(widget.componentId)}';

  @override
  Widget build(BuildContext context) {
    final DocsFileList files = kComponentFileLists[widget.componentId]!;
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HeadingAnchor(
          id: 'installation',
          title: docsChrome(
            DocsRouterScope.maybeOf(context)?.state.locale ??
                const Locale('en'),
            'secInstallation',
          ),
        ),
        // P7-TH1: section gaps follow the theme (lg/md).
        Gap(theme.spacing.lg),
        // Narrow screens (320 px, wide test fonts) scroll the tabs
        // instead of overflowing.
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _LineTab(
                label: docsChrome(
                  DocsRouterScope.maybeOf(context)?.state.locale ??
                      const Locale('en'),
                  'cmpPackage',
                ),
                selected: _tab == 0,
                onTap: () => setState(() => _tab = 0),
              ),
              _LineTab(
                label: docsChrome(
                  DocsRouterScope.maybeOf(context)?.state.locale ??
                      const Locale('en'),
                  'cmpOwnCode',
                ),
                selected: _tab == 1,
                onTap: () => setState(() => _tab = 1),
              ),
            ],
          ),
        ),
        Gap(theme.spacing.md),
        _InstallFigure(command: _command, files: _tab == 1 ? files : null),
        Gap(theme.spacing.md),
        Builder(
          builder: (BuildContext context) {
            final locale =
                DocsRouterScope.maybeOf(context)?.state.locale ??
                const Locale('en');
            final List<String> parts = docsChrome(
              locale,
              'cmpEjectNote',
            ).split('{command}');
            final String prefix = parts.isNotEmpty ? parts[0] : '';
            final String suffix = parts.length > 1
                ? parts.sublist(1).join('{command}')
                : '';
            return TypesetParagraph.rich(<InlineSpan>[
              TextSpan(text: prefix),
              typesetInlineCodeSpan(ejectCommand(widget.componentId)),
              TextSpan(text: suffix),
            ]);
          },
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
  final DocsFileList? files;

  @override
  Widget build(BuildContext context) {
    final DocsSiteColors site = DocsSiteColors.of(context);
    final ThemeData theme = Theme.of(context);
    final DocsFileList? owned = files;
    return Container(
      decoration: BoxDecoration(
        color: site.codeSurface,
        // P7-TH1: install block uses the card radius token (rounded-lg).
        borderRadius: theme.borderRadiusLg,
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
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing.md,
              vertical: theme.spacing.sm,
            ),
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

  final DocsFileList files;

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
            for (final String file in files.files)
              Padding(
                // P7-TH1: file row gaps follow the theme (gap-1).
                padding: EdgeInsets.only(bottom: theme.spacing.xs),
                child: Text(
                  file,
                  style: theme.typography.mono.copyWith(fontSize: 13),
                ),
              ),
            for (final String file in files.userOwned)
              Padding(
                padding: EdgeInsets.only(bottom: theme.spacing.xs),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        file,
                        style: theme.typography.mono.copyWith(fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Gap(theme.spacing.sm),
                    Badge(
                      variant: BadgeVariant.outline,
                      child: Text(
                        docsChrome(
                          DocsRouterScope.maybeOf(context)?.state.locale ??
                              const Locale('en'),
                          'cmpUserOwned',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Gap(theme.spacing.sm),
            Text(
              docsChrome(
                DocsRouterScope.maybeOf(context)?.state.locale ??
                    const Locale('en'),
                'cmpUserOwnedNote',
              ),
              style: docsText(
                context,
                size: 12,
                color: theme.colors.mutedForeground,
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
        // P7-TH1: tab insets follow the theme (sm/xs).
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.sm,
          vertical: theme.spacing.xs,
        ),
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
