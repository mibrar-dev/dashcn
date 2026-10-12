// Named examples for the `breadcrumb` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. Every example is a working trail: clicking a crumb
// navigates (the trail truncates, the current page stays a non-link), links
// underline on hover, long trails collapse into an ellipsis that opens the
// hidden crumbs as a dropdown, and the responsive trail collapses at narrow
// widths.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/theme.dart';
import '../button/button.dart';
import '../dropdown_menu/dropdown_menu.dart';
import '../menu/menu.dart';
import 'breadcrumb.dart';

/// Current-page line under a trail, so navigation is visible (and testable).
Widget _currentLine(BuildContext context, String page) {
  final theme = ShadcnTheme.of(context);
  return Text(
    'Current page: $page',
    style: TextStyle(color: theme.colors.mutedForeground, fontSize: 12),
  );
}

/// Opens the [hidden] crumbs as a dropdown; tapping one navigates to it.
Future<void> _openHidden(
  BuildContext context,
  List<String> hidden,
  void Function(String crumb) onSelect,
) {
  return showShadcnDropdown<void>(
    context: context,
    children: <Widget>[
      for (final crumb in hidden)
        MenuButton(child: Text(crumb), onPressed: (_) => onSelect(crumb)),
    ],
  );
}

/// Clickable crumbs for [path] except the last one, which is the current
/// (non-link) page.
List<Widget> _crumbs(List<String> path, void Function(int index) onTap) =>
    <Widget>[
      for (int i = 0; i < path.length; i++)
        if (i == path.length - 1)
          Text(path[i])
        else
          BreadcrumbLink(onPressed: () => onTap(i), child: Text(path[i])),
    ];

/// Default chevron trail, centred.
class _DefaultTrail extends StatefulWidget {
  const _DefaultTrail();

  @override
  State<_DefaultTrail> createState() => _DefaultTrailState();
}

class _DefaultTrailState extends State<_DefaultTrail> {
  List<String> _path = const <String>['Home', 'Components', 'Breadcrumb'];

  @override
  Widget build(BuildContext context) {
    final spacing = ShadcnTheme.of(context).spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Breadcrumb(
            children: _crumbs(
              _path,
              (int i) => setState(() {
                _path = _path.sublist(0, i + 1);
              }),
            ),
          ),
        ),
        Gap(spacing.sm),
        _currentLine(context, _path.last),
      ],
    );
  }
}

/// Slash-separated file path, centred.
class _SlashTrail extends StatefulWidget {
  const _SlashTrail();

  @override
  State<_SlashTrail> createState() => _SlashTrailState();
}

class _SlashTrailState extends State<_SlashTrail> {
  List<String> _path = const <String>['src', 'components', 'breadcrumb.dart'];

  @override
  Widget build(BuildContext context) {
    final spacing = ShadcnTheme.of(context).spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Breadcrumb(
            separator: Breadcrumb.slashSeparator,
            children: _crumbs(
              _path,
              (int i) => setState(() {
                _path = _path.sublist(0, i + 1);
              }),
            ),
          ),
        ),
        Gap(spacing.sm),
        _currentLine(context, _path.last),
      ],
    );
  }
}

/// Long trail with an ellipsis dropdown for the collapsed middle.
class _EllipsisTrail extends StatefulWidget {
  const _EllipsisTrail();

  @override
  State<_EllipsisTrail> createState() => _EllipsisTrailState();
}

class _EllipsisTrailState extends State<_EllipsisTrail> {
  List<String> _path = const <String>[
    'Home',
    'Docs',
    'Guides',
    'Components',
    'Navigation',
    'Breadcrumb',
  ];

  void _goTo(String crumb) => setState(() {
    _path = _path.sublist(0, _path.indexOf(crumb) + 1);
  });

  @override
  Widget build(BuildContext context) {
    final spacing = ShadcnTheme.of(context).spacing;
    // A short trail needs no ellipsis.
    final Widget trail = _path.length <= 3
        ? Breadcrumb(children: _crumbs(_path, (int i) => _goTo(_path[i])))
        : Builder(
            builder: (BuildContext context) {
              final List<String> hidden = _path.sublist(1, _path.length - 2);
              return Breadcrumb(
                children: <Widget>[
                  BreadcrumbLink(
                    onPressed: () => _goTo(_path.first),
                    child: Text(_path.first),
                  ),
                  Button(
                    size: ButtonSize.icon,
                    variant: ButtonVariant.ghost,
                    onPressed: () => _openHidden(context, hidden, _goTo),
                    child: const Icon(LucideIcons.ellipsis, size: 16),
                  ),
                  ..._crumbs(_path.sublist(_path.length - 2), (int i) {
                    _goTo(_path[_path.length - 2 + i]);
                  }),
                ],
              );
            },
          );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(alignment: Alignment.center, child: trail),
        Gap(spacing.sm),
        _currentLine(context, _path.last),
      ],
    );
  }
}

/// Responsive trail: full above 420px, first + ellipsis + last below.
class _ResponsiveTrail extends StatefulWidget {
  const _ResponsiveTrail();

  @override
  State<_ResponsiveTrail> createState() => _ResponsiveTrailState();
}

class _ResponsiveTrailState extends State<_ResponsiveTrail> {
  List<String> _path = const <String>[
    'Home',
    'Library',
    'Components',
    'Navigation',
    'Breadcrumb',
  ];

  void _goTo(String crumb) => setState(() {
    _path = _path.sublist(0, _path.indexOf(crumb) + 1);
  });

  @override
  Widget build(BuildContext context) {
    final spacing = ShadcnTheme.of(context).spacing;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool collapsed =
                  constraints.maxWidth < 420 && _path.length > 3;
              final List<Widget> children;
              if (!collapsed) {
                children = _crumbs(_path, (int i) => _goTo(_path[i]));
              } else {
                children = <Widget>[
                  BreadcrumbLink(
                    onPressed: () => _goTo(_path.first),
                    child: Text(_path.first),
                  ),
                  Button(
                    size: ButtonSize.icon,
                    variant: ButtonVariant.ghost,
                    onPressed: () => _openHidden(
                      context,
                      _path.sublist(1, _path.length - 1),
                      _goTo,
                    ),
                    child: const Icon(LucideIcons.ellipsis, size: 16),
                  ),
                  Text(_path.last),
                ];
              }
              return Breadcrumb(children: children);
            },
          ),
        ),
        Gap(spacing.sm),
        _currentLine(context, _path.last),
      ],
    );
  }
}

Widget _breadcrumbDefault(BuildContext context) => const _DefaultTrail();

Widget _breadcrumbSlash(BuildContext context) => const _SlashTrail();

Widget _breadcrumbEllipsis(BuildContext context) => const _EllipsisTrail();

Widget _breadcrumbResponsive(BuildContext context) => const _ResponsiveTrail();

/// Named docs examples for `breadcrumb`; the first entry is the default.
const List<ComponentPreview> breadcrumbPreviews = <ComponentPreview>[
  ComponentPreview('Default', _breadcrumbDefault),
  ComponentPreview('With slash', _breadcrumbSlash),
  ComponentPreview('With ellipsis', _breadcrumbEllipsis),
  ComponentPreview('Responsive', _breadcrumbResponsive),
];
