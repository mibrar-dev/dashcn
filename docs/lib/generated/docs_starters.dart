// GENERATED CODE - DO NOT MODIFY BY HAND.
//
// Sources:
//   * dashcn/lib/src/manifests/registry.json
//   * dashcn/lib/src/starters/<id>/starter.json
//   * dashcn/lib/src/starters/<id>/README.md
//
// Regenerate: dart run tool/gen_docs_data.dart
//
// Every starter and starter file list is derived from the
// registry manifest; the Starters pages never hard-code them.
// Only rendered-template targets are emitted (never raw `.tmpl`
// text); template sources are linked on GitHub from the pages.

/// One starter route: an app path backed by a flow, block or
/// starter-owned page.
class DocsStarterRoute {
  /// Creates a route entry.
  const DocsStarterRoute({
    required this.path,
    required this.title,
    required this.kind,
    required this.ref,
  });

  /// App path (`/signin`).
  final String path;

  /// Display title (`Sign in`).
  final String title;

  /// `flow`, `block` or `page`.
  final String kind;

  /// Flow/block id or starter-owned page ref.
  final String ref;
}

/// One rendered-template file: registry template + app target.
class DocsStarterFile {
  /// Creates a file entry.
  const DocsStarterFile({required this.template, required this.target});

  /// Registry-relative template (`starters/saas/…tmpl`).
  final String template;

  /// App-relative target (`lib/app.dart`).
  final String target;
}

/// One installable starter, generated from the registry manifest.
class DocsStarter {
  /// Creates a starter entry.
  const DocsStarter({
    required this.id,
    required this.name,
    required this.description,
    required this.themePreset,
    required this.platforms,
    required this.flows,
    required this.blocks,
    required this.components,
    required this.routes,
    required this.files,
    required this.tags,
    required this.install,
  });

  /// Registry id / route segment (`/docs/starters/<id>`).
  final String id;

  /// Display name (`SaaS starter`).
  final String name;

  /// One-line description from the manifest.
  final String description;

  /// Default theme preset id (`neutral`).
  final String themePreset;

  /// Supported platforms, in manifest order.
  final List<String> platforms;

  /// Flow ids the starter composes.
  final List<String> flows;

  /// Block ids the starter composes.
  final List<String> blocks;

  /// Component ids the starter composes.
  final List<String> components;

  /// App routes, in manifest order.
  final List<DocsStarterRoute> routes;

  /// Rendered-template files, in manifest order.
  final List<DocsStarterFile> files;

  /// Manifest tags, sorted.
  final List<String> tags;

  /// `dashcn create <id> my_app` from the manifest.
  final String install;
}

/// All 3 installable starters, ordered by id.
const List<DocsStarter> kStarters = <DocsStarter>[
  DocsStarter(
    id: 'chat',
    name: 'Chat starter',
    description: 'Auth into a tab bar with chat threads and settings.',
    themePreset: 'neutral',
    platforms: <String>['ios', 'android', 'web', 'macos', 'windows', 'linux'],
    flows: <String>['auth-01', 'chat-01', 'settings-01'],
    blocks: <String>[],
    components: <String>['app', 'navigation_bar'],
    routes: <DocsStarterRoute>[
      DocsStarterRoute(
        path: '/signin',
        title: 'Sign in',
        kind: 'flow',
        ref: 'auth-01',
      ),
      DocsStarterRoute(
        path: '/chat',
        title: 'Chat',
        kind: 'flow',
        ref: 'chat-01',
      ),
      DocsStarterRoute(
        path: '/settings',
        title: 'Settings',
        kind: 'flow',
        ref: 'settings-01',
      ),
    ],
    files: <DocsStarterFile>[
      DocsStarterFile(
        template: 'starters/chat/templates/lib/main.dart.tmpl',
        target: 'lib/main.dart',
      ),
      DocsStarterFile(
        template: 'starters/chat/templates/lib/app.dart.tmpl',
        target: 'lib/app.dart',
      ),
      DocsStarterFile(
        template: 'starters/chat/templates/lib/data/repository.dart.tmpl',
        target: 'lib/data/repository.dart',
      ),
      DocsStarterFile(
        template: 'starters/chat/templates/lib/shell.dart.tmpl',
        target: 'lib/shell.dart',
      ),
      DocsStarterFile(
        template: 'starters/chat/templates/test/smoke_test.dart.tmpl',
        target: 'test/smoke_test.dart',
      ),
    ],
    tags: <String>['auth', 'chat', 'messages', 'settings'],
    install: 'dashcn create chat my_app',
  ),
  DocsStarter(
    id: 'saas',
    name: 'SaaS starter',
    description:
        'Auth plus onboarding into a responsive shell with dashboard, pricing and settings.',
    themePreset: 'neutral',
    platforms: <String>['ios', 'android', 'web', 'macos', 'windows', 'linux'],
    flows: <String>['auth-01', 'onboarding-01', 'settings-01'],
    blocks: <String>['dashboard-01', 'pricing-01'],
    components: <String>['app', 'navigation_bar'],
    routes: <DocsStarterRoute>[
      DocsStarterRoute(
        path: '/signin',
        title: 'Sign in',
        kind: 'flow',
        ref: 'auth-01',
      ),
      DocsStarterRoute(
        path: '/welcome',
        title: 'Welcome',
        kind: 'flow',
        ref: 'onboarding-01',
      ),
      DocsStarterRoute(
        path: '/dashboard',
        title: 'Dashboard',
        kind: 'block',
        ref: 'dashboard-01',
      ),
      DocsStarterRoute(
        path: '/pricing',
        title: 'Pricing',
        kind: 'block',
        ref: 'pricing-01',
      ),
      DocsStarterRoute(
        path: '/settings',
        title: 'Settings',
        kind: 'flow',
        ref: 'settings-01',
      ),
    ],
    files: <DocsStarterFile>[
      DocsStarterFile(
        template: 'starters/saas/templates/lib/main.dart.tmpl',
        target: 'lib/main.dart',
      ),
      DocsStarterFile(
        template: 'starters/saas/templates/lib/app.dart.tmpl',
        target: 'lib/app.dart',
      ),
      DocsStarterFile(
        template: 'starters/saas/templates/lib/data/repository.dart.tmpl',
        target: 'lib/data/repository.dart',
      ),
      DocsStarterFile(
        template: 'starters/saas/templates/lib/shell.dart.tmpl',
        target: 'lib/shell.dart',
      ),
      DocsStarterFile(
        template: 'starters/saas/templates/test/smoke_test.dart.tmpl',
        target: 'test/smoke_test.dart',
      ),
    ],
    tags: <String>[
      'auth',
      'dashboard',
      'onboarding',
      'pricing',
      'saas',
      'settings',
    ],
    install: 'dashcn create saas my_app',
  ),
  DocsStarter(
    id: 'shop',
    name: 'Shop starter',
    description: 'Auth into a product grid with cart checkout and settings.',
    themePreset: 'neutral',
    platforms: <String>['ios', 'android', 'web', 'macos', 'windows', 'linux'],
    flows: <String>['auth-01', 'checkout-01', 'settings-01'],
    blocks: <String>[],
    components: <String>[
      'app',
      'navigation_bar',
      'card',
      'badge',
      'button',
      'image',
    ],
    routes: <DocsStarterRoute>[
      DocsStarterRoute(
        path: '/signin',
        title: 'Sign in',
        kind: 'flow',
        ref: 'auth-01',
      ),
      DocsStarterRoute(
        path: '/shop',
        title: 'Shop',
        kind: 'page',
        ref: 'product-grid',
      ),
      DocsStarterRoute(
        path: '/cart',
        title: 'Cart',
        kind: 'flow',
        ref: 'checkout-01',
      ),
      DocsStarterRoute(
        path: '/settings',
        title: 'Settings',
        kind: 'flow',
        ref: 'settings-01',
      ),
    ],
    files: <DocsStarterFile>[
      DocsStarterFile(
        template: 'starters/shop/templates/lib/main.dart.tmpl',
        target: 'lib/main.dart',
      ),
      DocsStarterFile(
        template: 'starters/shop/templates/lib/app.dart.tmpl',
        target: 'lib/app.dart',
      ),
      DocsStarterFile(
        template: 'starters/shop/templates/lib/data/repository.dart.tmpl',
        target: 'lib/data/repository.dart',
      ),
      DocsStarterFile(
        template: 'starters/shop/templates/lib/shop/product_grid.dart.tmpl',
        target: 'lib/shop/product_grid.dart',
      ),
      DocsStarterFile(
        template: 'starters/shop/templates/lib/shell.dart.tmpl',
        target: 'lib/shell.dart',
      ),
      DocsStarterFile(
        template: 'starters/shop/templates/test/smoke_test.dart.tmpl',
        target: 'test/smoke_test.dart',
      ),
    ],
    tags: <String>['auth', 'cart', 'checkout', 'settings', 'shop'],
    install: 'dashcn create shop my_app',
  ),
];
