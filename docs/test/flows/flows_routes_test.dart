// P9-3b route tests: the Flows sitemap parses and round-trips.

import 'package:docs/routing/docs_router.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('flows routes', () {
    test('parse maps the flows sitemap', () {
      expect(
        DocsRouteConfiguration.parse('/docs/flows'),
        DocsRouteConfiguration.flows,
      );
      expect(
        DocsRouteConfiguration.parse('/docs/flows/auth-01'),
        DocsRouteConfiguration.flow('auth-01'),
      );
      expect(
        DocsRouteConfiguration.flow('auth-01').location,
        '/docs/flows/auth-01',
      );
      expect(DocsRouteConfiguration.flows.location, '/docs/flows');
    });

    test('flows titles resolve', () {
      expect(DocsRouteConfiguration.flows.title, 'Flows');
      expect(DocsRouteConfiguration.flow('chat-01').title, 'chat-01');
    });

    test('ignores trailing segments, query and fragment', () {
      expect(
        DocsRouteConfiguration.parse('/docs/flows/?frame=iphone'),
        DocsRouteConfiguration.flows,
      );
      expect(
        DocsRouteConfiguration.parse('/docs/flows/auth-01#installation'),
        DocsRouteConfiguration.flow('auth-01'),
      );
    });

    test('unknown flows deep links 404', () {
      expect(
        DocsRouteConfiguration.parse('/docs/flows/a/b').route,
        DocsRoute.notFound,
      );
    });

    test('locations round-trip', () {
      expect(
        DocsRouteConfiguration.parse(
          DocsRouteConfiguration.flow('settings-01').location,
        ),
        DocsRouteConfiguration.flow('settings-01'),
      );
    });
  });
}
