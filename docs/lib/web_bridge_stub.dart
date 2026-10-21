// No-op bridge for non-web targets (VM tests, `dart run`).
//
// Keep every signature identical to `web_bridge_web.dart`.

/// Emits the `dashcn_app_ready` DOM event; no-op off web.
void dispatchWebAppReady() {}

/// Emits the `dashcn_theme_changed` DOM event; no-op off web.
void dispatchWebThemeChanged(Map<String, String> colors) {}

/// `prefers-reduced-motion: reduce` in the browser; false off web.
bool webPrefersReducedMotion() => false;

/// Reads a `window.localStorage` entry; always null off web.
String? webLocalStorageRead(String key) => null;

/// Writes a `window.localStorage` entry; no-op off web.
void webLocalStorageWrite(String key, String value) {}

/// Opens an external URL in a new browser tab; no-op off web.
///
/// Used by the header/footer GitHub links — the app deliberately has no
/// `url_launcher` dependency (see the pubspec dependency policy).
void webOpenUrl(String url) {}

/// Opens a file picker for a text file with one of [extensions] (`css`,
/// `js`, `json`); always null off web (the VM test path pastes instead).
Future<String?> webPickTextFile(List<String> extensions) async => null;

/// Downloads [text] as [filename]; no-op off web.
void webDownloadText(String filename, String text) {}

/// Downloads the file at [url] as [filename]; no-op off web.
void webDownloadUrl(String url, String filename) {}

/// Requests one-shot camera access; always false off web.
Future<bool> webRequestCamera() async => false;
