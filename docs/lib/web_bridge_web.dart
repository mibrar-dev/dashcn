// Web implementation of the docs bridge: DOM custom events, localStorage and
// the `prefers-reduced-motion` probe.
//
// The custom events are the embedder contract kept from the old docs site
// (`dashcn_app_ready`, `dashcn_theme_changed`); they are
// harmless when nothing listens. All calls are wrapped: the docs shell must
// never crash because a browser API is unavailable (private mode, iframe).

import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

/// Fires the ready event once the shell has painted its first frame.
void dispatchWebAppReady() {
  try {
    web.window.dispatchEvent(web.CustomEvent('dashcn_app_ready'));
  } catch (_) {
    // Not available; embedders simply do not get the event.
  }
}

/// Fires the theme-changed event with the current colour tokens.
void dispatchWebThemeChanged(Map<String, String> colors) {
  try {
    web.window.dispatchEvent(
      web.CustomEvent(
        'dashcn_theme_changed',
        web.CustomEventInit(detail: colors.jsify()),
      ),
    );
  } catch (_) {
    // Same as above.
  }
}

/// Whether the browser asked for reduced motion.
bool webPrefersReducedMotion() {
  try {
    return web.window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  } catch (_) {
    return false;
  }
}

/// Reads a localStorage entry (`null` when it does not exist or is blocked).
String? webLocalStorageRead(String key) {
  try {
    return web.window.localStorage.getItem(key);
  } catch (_) {
    return null;
  }
}

/// Writes a localStorage entry; silently ignored when storage is blocked.
void webLocalStorageWrite(String key, String value) {
  try {
    web.window.localStorage.setItem(key, value);
  } catch (_) {
    // Ignore quota/security errors.
  }
}

/// Opens [url] in a new browser tab; silently ignored when blocked.
void webOpenUrl(String url) {
  try {
    web.window.open(url, '_blank');
  } catch (_) {
    // Popup blocked or not available; the link is simply inert.
  }
}

/// Opens a file picker for a text file with one of [extensions] and reads it.
///
/// Resolves null when the picker is cancelled, the file cannot be read, or a
/// browser API is unavailable. The Theme Studio import dialog fills its paste
/// area with the result.
Future<String?> webPickTextFile(List<String> extensions) async {
  final Completer<String?> done = Completer<String?>();
  try {
    final web.HTMLInputElement input =
        web.document.createElement('input') as web.HTMLInputElement;
    input.type = 'file';
    input.accept = extensions.map((String e) => '.$e').join(',');
    void onChange(web.Event event) {
      final web.FileList? files = input.files;
      if (files == null || files.length == 0) {
        done.complete(null);
        return;
      }
      final web.Blob blob = files.item(0)!;
      blob.text().toDart.then(
        (JSString text) {
          if (!done.isCompleted) {
            done.complete(text.toDart);
          }
        },
        onError: (_) {
          if (!done.isCompleted) {
            done.complete(null);
          }
        },
      );
    }

    input.addEventListener('change', onChange.toJS);
    input.click();
  } catch (_) {
    if (!done.isCompleted) {
      done.complete(null);
    }
  }
  return done.future;
}

/// Downloads [text] as [filename] through a data URL; silently ignored when
/// blocked. The Theme Studio Export tabs use it for their download buttons.
void webDownloadText(String filename, String text) {
  try {
    final web.HTMLAnchorElement anchor =
        web.document.createElement('a') as web.HTMLAnchorElement;
    anchor.href = 'data:text/plain;charset=utf-8,${Uri.encodeComponent(text)}';
    anchor.download = filename;
    anchor.click();
  } catch (_) {
    // Not available; the copy button next to it still works.
  }
}
