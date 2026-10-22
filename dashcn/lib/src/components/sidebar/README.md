# Sidebar

A production dashboard sidebar: a header (logo or app name plus a collapse
control), grouped navigation sections with labels, 32 px rows with a 16 px
icon, label, optional badge and optional trailing chevron for sub-menus, and
a footer account row (avatar, name, email, dropdown). The rail is 240 px
expanded and 56 px collapsed (icons only, with tooltips).

The same widget renders as a fixed column on desktop and inside a drawer or
sheet on phone widths: place it directly in an `openDrawer` builder. The
active row is highlighted, the list scrolls internally, arrow keys move
between rows (mirrored in RTL) and Enter activates the focused row.

## Usage

```dart
DashboardSidebar(
  sections: const <SidebarSection>[
    SidebarSection(
      label: 'Main',
      items: <SidebarItem>[
        SidebarItem(label: 'Dashboard', icon: LucideIcons.layoutDashboard),
        SidebarItem(
          label: 'Documents',
          icon: LucideIcons.fileText,
          badge: '12',
        ),
      ],
    ),
    SidebarSection(
      label: 'Account',
      items: <SidebarItem>[
        SidebarItem(
          label: 'Settings',
          icon: LucideIcons.settings,
          children: <SidebarItem>[
            SidebarItem(label: 'Profile', icon: LucideIcons.circleUser),
            SidebarItem(label: 'Billing', icon: LucideIcons.creditCard),
          ],
        ),
      ],
    ),
  ],
  selectedId: 'Dashboard',
  onSelected: (String id) => setState(() => _selected = id),
  onToggleCollapsed: () => setState(() => _collapsed(!_collapsed)),
  user: const SidebarUser(name: 'Ibrar Ahmed', email: 'm@example.com'),
  onUserPressed: () => _openAccountMenu(context),
)
```

In a drawer (phone widths):

```dart
openDrawer(
  context: context,
  position: OverlayPosition.start,
  builder: (BuildContext drawerContext) => DashboardSidebar(
    sections: sections,
    selectedId: _selected,
    onSelected: (String id) {
      setState(() => _selected = id);
      closeDrawer(drawerContext);
    },
    user: const SidebarUser(name: 'Ibrar Ahmed', email: 'm@example.com'),
  ),
);
```

## Keyboard

| Key | Action |
|---|---|
| `ArrowUp` / `ArrowDown` | move between visible rows |
| `Home` / `End` | jump to the first or last visible row |
| `ArrowRight` | expand the focused sub-menu (mirrored in RTL) |
| `ArrowLeft` | collapse the focused sub-menu (mirrored in RTL) |
| `Enter` / `Space` | activate the focused row |

A tap focuses the row it hits, so pointer and keyboard selection cannot drift
apart.

Accessibility: every row is a `Semantics` button labelled with the row label
and marked selected when highlighted; collapsed icons expose the label
through tooltips.

## Fixed bugs

- The old sidebar blocks stacked centred icon-and-label items with oversized
  "Main"/"Account" headers and no usable structure. This component lays rows
  out horizontally (icon, label, badge, chevron) at the compact density
  sizes and keeps group labels at 12 px muted.
