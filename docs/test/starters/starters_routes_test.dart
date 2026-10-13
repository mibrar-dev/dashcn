// P9-Z2 route tests: the Starters sitemap parses and round-trips.

import 'package:docs/routing/docs_router.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('starters routes', () {
    test('parse maps the starters sitemap', () {
      expect(
        DocsRouteConfiguration.parse('/docs/starters'),
        DocsRouteConfiguration.starters,
      );
      expect(
        DocsRouteConfiguration.parse('/docs/starters/saas'),
        DocsRouteConfiguration.starter('saas'),
      );
      expect(
        DocsRouteConfiguration.starter('saas').location,
        '/docs/starters/saas',
      );
      expect(DocsRouteConfiguration.starters.location, '/docs/starters');
    });

    test('starters titles resolve', () {
      expect(DocsRouteConfiguration.starters.title, 'Starters');
      expect(DocsRouteConfiguration.starter('saas').title, 'saas');
    });

    test('ignores trailing segments, query and fragment', () {
      expect(
        DocsRouteConfiguration.parse('/docs/starters/?frame=iphone'),
        DocsRouteConfiguration.starters,
      );
      expect(
        DocsRouteConfiguration.parse('/docs/starters/saas#installation'),
        DocsRouteConfiguration.starter('saas'),
      );
    });

    test('unknown starters deep links 404', () {
      expect(
        DocsRouteConfiguration.parse('/docs/starters/a/b').route,
        DocsRoute.notFound,
      );
    });

    test('locations round-trip', () {
      expect(
        DocsRouteConfiguration.parse(
          DocsRouteConfiguration.starter('shop').location,
        ),
        DocsRouteConfiguration.starter('shop'),
      );
    });
  });
}
