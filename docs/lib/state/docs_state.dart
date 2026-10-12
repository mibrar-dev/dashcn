// The docs site's shell state: the live theme plus the mode.
//
// Brightness defaults to **system** (the reference uses `next-themes` with
// the system default): [brightness] is the explicit choice when one was
// persisted, otherwise [systemBrightness]. Toggling stores an explicit mode
// and stops following the system until the storage is cleared.
//
// Every token of the theme lives in the [SiteThemeModel] (D7): the rail edits
// it, [theme] resolves it for the whole shell — home, docs, component pages,
// palette — and it persists as one canonical preset JSON. Keeping a second set
// of scalar overrides here (as the pre-D7 radius/density sliders had) would
// give the model two sources of truth and make the exported `app_theme.dart`
// drift from what the site renders.

import 'package:flutter/widgets.dart';

import '../ui/dashcn/theme/theme.dart';
import '../widgets/device_frame/device_spec.dart';
import 'docs_storage.dart';
import 'site_theme_model.dart';

export 'docs_storage.dart'
    show DocsStorage, kDocsBrightnessKey, kDocsPresetKey, kDocsThemeDocumentKey;
export 'site_theme_model.dart'
    show SiteThemeModel, kDefaultResetPresetId, kDocsFontOptions;

/// Preset id selected on a first visit: the official upstream neutral base
/// (`themes/neutral.json`), matching the reference site's palette.
const String kDefaultDocsPresetId = kDefaultResetPresetId;

/// localStorage key of the preview frame choice (P9-1).
const String kDocsFrameKey = 'docs.preview.frame';

/// localStorage key of the preview orientation (P9-1).
const String kDocsOrientationKey = 'docs.preview.orientation';

/// The docs site's theme state: the theme document and the mode.
class DocsState extends ChangeNotifier {
  /// Creates the state; call [restore] once to load persisted preferences.
  DocsState({
    required DocsStorage storage,
    String presetId = kDefaultDocsPresetId,
    Brightness? brightness,
    Brightness systemBrightness = Brightness.light,
  }) : themeModel = SiteThemeModel(storage: storage, presetId: presetId),
       _explicitBrightness = brightness,
       _platformBrightness = systemBrightness {
    // One notification chain: every Theme Studio edit reaches the shell
    // (the router delegate, the web bridge and the header toggle all listen
    // to `DocsState`), so the document changes have to travel through it.
    themeModel.addListener(notifyListeners);
  }

  /// The site-wide theme model (preset, colours, radius, spacing, fonts,
  /// shadows). Every Theme Studio edit lands here.
  final SiteThemeModel themeModel;

  /// Where the shell preferences live (the model's own storage).
  DocsStorage get storage => themeModel.storage;

  Brightness? _explicitBrightness;
  Brightness _platformBrightness;

  DeviceFrameId _frame = DeviceFrameId.none;
  DeviceOrientation _orientation = DeviceOrientation.portrait;

  /// The document's id — a registry preset id, or `shuffled` / a pasted id.
  String get presetId => themeModel.presetId;

  /// The effective mode: the explicit choice or the system brightness.
  Brightness get brightness => _explicitBrightness ?? _platformBrightness;

  /// Whether the mode still follows the platform (no explicit choice stored).
  bool get followsSystem => _explicitBrightness == null;

  /// The last observed platform brightness.
  Brightness get systemBrightness => _platformBrightness;

  /// The radius in px (0–16) of the live document.
  double get effectiveRadiusPx => themeModel.radiusPx;

  /// The fully-resolved theme for the current state.
  ThemeData get theme => themeModel.themeFor(brightness);

  /// The preview frame choice (P9-1); `none` renders previews unframed.
  DeviceFrameId get frame => _frame;

  /// Portrait or landscape for the framed previews (P9-1).
  DeviceOrientation get orientation => _orientation;

  /// The `?frame=` query value, or null when the choice is the default.
  String? get frameQueryValue =>
      _frame == DeviceFrameId.none ? null : _frame.queryValue;

  /// The `?orientation=` query value, or null when portrait.
  String? get orientationQueryValue =>
      _orientation == DeviceOrientation.portrait
      ? null
      : _orientation.queryValue;

  /// Applies one parsed `?frame=` / `?orientation=` pair (deep links and
  /// browser back/forward arrive here via the router in P9-Z). Unknown
  /// values fall back to the defaults; every change persists.
  void applyFrameQuery(String? frameValue, String? orientationValue) {
    setFrame(DeviceFrameId.parse(frameValue));
    setOrientation(DeviceOrientation.parse(orientationValue));
  }

  /// Reads the frame pair out of [uri]'s query parameters.
  void applyFrameUri(Uri uri) {
    applyFrameQuery(
      uri.queryParameters['frame'],
      uri.queryParameters['orientation'],
    );
  }

  /// Copies [uri] with the current frame pair set (nulls removed), so the
  /// router can report the choice to the browser history in P9-Z.
  Uri frameUri(Uri uri) {
    final Map<String, String> params = Map<String, String>.of(
      uri.queryParameters,
    );
    final String? frameValue = frameQueryValue;
    final String? orientationValue = orientationQueryValue;
    if (frameValue == null) {
      params.remove('frame');
    } else {
      params['frame'] = frameValue;
    }
    if (orientationValue == null) {
      params.remove('orientation');
    } else {
      params['orientation'] = orientationValue;
    }
    return uri.replace(queryParameters: params.isEmpty ? null : params);
  }

  /// Loads persisted preferences; safe to call once before `runApp`.
  ///
  /// A stored `light`/`dark` value becomes the explicit mode; `system` (or no
  /// value) keeps following the platform brightness. A stored document that no
  /// longer validates is dropped by [SiteThemeModel.restore] and the site
  /// falls back to the default preset.
  void restore() {
    bool changed = false;
    themeModel.restore();
    final String? brightness = storage.read(kDocsBrightnessKey);
    if (brightness != null) {
      final Brightness? parsed = switch (brightness) {
        'light' => Brightness.light,
        'dark' => Brightness.dark,
        _ => null,
      };
      if (parsed != _explicitBrightness) {
        _explicitBrightness = parsed;
        changed = true;
      }
    }
    final DeviceFrameId frame = DeviceFrameId.parse(
      storage.read(kDocsFrameKey),
    );
    if (frame != _frame) {
      _frame = frame;
      changed = true;
    }
    final DeviceOrientation orientation = DeviceOrientation.parse(
      storage.read(kDocsOrientationKey),
    );
    if (orientation != _orientation) {
      _orientation = orientation;
      changed = true;
    }
    if (changed) {
      notifyListeners();
    }
  }

  /// Switches the active preset (replaces the whole document).
  void setPreset(String presetId) => themeModel.selectPreset(presetId);

  /// Sets the explicit brightness and stops following the platform.
  void setBrightness(Brightness brightness) {
    if (brightness == _explicitBrightness) {
      return;
    }
    _explicitBrightness = brightness;
    storage.write(kDocsBrightnessKey, brightness.name);
    notifyListeners();
  }

  /// Records the platform brightness while no explicit mode is stored.
  void setSystemBrightness(Brightness brightness) {
    if (brightness == _platformBrightness) {
      return;
    }
    _platformBrightness = brightness;
    if (_explicitBrightness == null) {
      notifyListeners();
    }
  }

  /// Flips between light and dark (stores the explicit mode).
  void toggleBrightness() {
    setBrightness(
      brightness == Brightness.dark ? Brightness.light : Brightness.dark,
    );
  }

  /// Selects the preview frame (P9-1) and persists the choice.
  void setFrame(DeviceFrameId frame) {
    if (frame == _frame) {
      return;
    }
    _frame = frame;
    storage.write(kDocsFrameKey, frame.queryValue);
    notifyListeners();
  }

  /// Selects the preview orientation (P9-1) and persists the choice.
  void setOrientation(DeviceOrientation orientation) {
    if (orientation == _orientation) {
      return;
    }
    _orientation = orientation;
    storage.write(kDocsOrientationKey, orientation.queryValue);
    notifyListeners();
  }

  @override
  void dispose() {
    themeModel.removeListener(notifyListeners);
    themeModel.dispose();
    super.dispose();
  }
}
