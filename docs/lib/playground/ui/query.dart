// Playground URL query helpers: shareable, reload-safe control state.
//
// [PlaygroundValues.toQuery]/[PlaygroundValues.fromQuery] already carry the
// `p.<name>` encoding (non-default entries only); this unit maps that
// encoding onto real URIs so a configured playground survives reload and
// browser back/forward:
//
// * [playgroundQueryOf] reads the `p.*` entries out of a URI,
// * [playgroundUri] merges the current values into a base URI, keeping
//   every unrelated param (`frame`, `tab`, ...) and dropping `p.*` keys
//   that are back at their defaults,
// * [browserPlaygroundQuery] reads the live browser URL on web,
// * [reportPlaygroundUri] hands the merged URI to the engine (web only,
//   fire-and-forget).
//
// Router note: `DocsRouteConfiguration.parse` ignores the query string, so
// the component route still resolves with `?p.*` present; P9-Z merges
// [playgroundQuery] into `restoreRouteInformation` and feeds the parsed
// query back as `PlaygroundPanel(initialQuery: ...)` — the panel's
// `onQueryChanged` callback is the seam.

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../generated/docs_controls.dart';
import '../values.dart';

/// The current values as `p.<name>` entries (non-defaults only).
Map<String, String> playgroundQuery(
  ComponentControls spec,
  PlaygroundValues values,
) {
  return values.toQuery(spec);
}

/// [base] with the current playground params merged in.
///
/// Unrelated params survive; `p.*` and `t.*` keys back at their defaults are dropped.
Uri playgroundUri(Uri base, ComponentControls spec, PlaygroundValues values) {
  final Map<String, String> params = Map<String, String>.of(
    base.queryParameters,
  )..removeWhere((String key, String value) => key.startsWith('p.'));
  params.addAll(values.toQuery(spec));
  return base.replace(queryParameters: params.isEmpty ? null : params);
}

/// [base] with all current playground and theme query parameters merged in.
Uri mergedPlaygroundUri(Uri base, Map<String, String> query) {
  final Map<String, String> params =
      Map<String, String>.of(base.queryParameters)..removeWhere(
        (String key, String value) =>
            key.startsWith('p.') || key.startsWith('t.'),
      );
  params.addAll(query);
  return base.replace(queryParameters: params.isEmpty ? null : params);
}

/// The `p.*` and `t.*` entries of [uri], for [PlaygroundValues.fromQuery] and theme.
Map<String, String> playgroundQueryOf(Uri uri) {
  return <String, String>{
    for (final MapEntry<String, String> entry in uri.queryParameters.entries)
      if (entry.key.startsWith('p.') || entry.key.startsWith('t.'))
        entry.key: entry.value,
  };
}

/// The live browser URL's `p.*` entries (empty off web or on failure).
Map<String, String> browserPlaygroundQuery() {
  try {
    if (kIsWeb) {
      return playgroundQueryOf(Uri.base);
    }
  } catch (_) {
    // Non-browser platforms and test bindings have no route URL.
  }
  return <String, String>{};
}

/// Reports [uri] to the engine (web only).
///
/// Fire-and-forget: the navigation channel has no handler in widget tests
/// and on non-web platforms, so failures are swallowed. P9-Z replaces this
/// with router-owned reporting (`restoreRouteInformation`).
Future<void> reportPlaygroundUri(Uri uri) async {
  if (!kIsWeb) {
    return;
  }
  try {
    await SystemNavigator.routeInformationUpdated(uri: uri);
  } catch (_) {
    // No navigation channel (tests, non-web embedders): stay silent.
  }
}
