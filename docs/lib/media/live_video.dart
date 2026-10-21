// Docs-only live video example: real `package:video_player` playback.
//
// The kit stays dependency-free: this file lives in the docs app, which owns
// the `video_player` dependency. A source switcher offers the three SPEC
// sources: online MP4 (plays), live HLS stream (Chrome cannot play HLS
// natively — the exact plugin error is shown), and the live camera feed (a
// real permission attempt; the SPEC fallback message shows on denial).
// Captions come from an inline WebVTT sample parsed below.
//
// This file is a docs preview *sidecar*: `tool/gen_docs_data.dart` appends its
// `liveVideoPlayerPreviews` to the `video_player` examples (labels, counts,
// Code tabs and the deferred preview loader).

import 'package:docs/media/video_adapter.dart';
import 'package:docs/ui/dashcn/components/video_player/video_player.dart';
import 'package:docs/ui/dashcn/foundation/component_preview.dart';
import 'package:docs/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:docs/web_bridge.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart' as plugin;

/// Inline WebVTT sample for the captions toggle.
const String _sampleVtt = '''
WEBVTT

00:00.000 --> 00:05.000
Hello, world

00:05.000 --> 00:12.000
Butterfly wings at 24 frames
''';

/// Minimal WebVTT parser (cues with `start --> end` headers).
List<VideoCaptionCue> parseWebVtt(String source) {
  final List<VideoCaptionCue> cues = <VideoCaptionCue>[];
  final List<String> lines = source.replaceAll('\r\n', '\n').split('\n');
  int i = 0;
  if (lines.isNotEmpty && lines.first.trim() == 'WEBVTT') i = 1;
  final RegExp stamp = RegExp(
    r'(?:(\d+):)?([0-5]?\d):([0-5]\d)[.,](\d{3})\s*-->\s*(?:(\d+):)?([0-5]?\d):([0-5]\d)[.,](\d{3})',
  );
  Duration? toDuration(Match m, int h, int min, int s, int ms) {
    final int hours = m.group(h) == null ? 0 : int.parse(m.group(h)!);
    return Duration(
      hours: hours,
      minutes: int.parse(m.group(min)!),
      seconds: int.parse(m.group(s)!),
      milliseconds: int.parse(m.group(ms)!),
    );
  }

  while (i < lines.length) {
    final String line = lines[i].trim();
    i++;
    if (line.isEmpty) continue;
    final Match? m = stamp.firstMatch(line);
    if (m == null) continue;
    final Duration start = toDuration(m, 1, 2, 3, 4)!;
    final Duration end = toDuration(m, 5, 6, 7, 8)!;
    final StringBuffer text = StringBuffer();
    while (i < lines.length && lines[i].trim().isNotEmpty) {
      if (text.isNotEmpty) text.write('\n');
      text.write(lines[i].trim());
      i++;
    }
    if (text.isNotEmpty) {
      cues.add(VideoCaptionCue(start: start, end: end, text: text.toString()));
    }
  }
  return cues;
}

/// Live video docs example: source switcher over real plugin playback.
class _LiveVideo extends StatefulWidget {
  const _LiveVideo();

  @override
  State<_LiveVideo> createState() => _LiveVideoState();
}

class _LiveVideoState extends State<_LiveVideo> {
  int _sourceIndex = 0;
  plugin.VideoPlayerController? _inner;
  PluginVideoAdapter? _adapter;
  bool _cameraGranted = false;
  bool _cameraAsked = false;
  Object? _loadError;

  @override
  void initState() {
    super.initState();
    _openSource(0);
  }

  @override
  void dispose() {
    _adapter?.dispose();
    // See live_audio.dart: plugin dispose throws where plugins are absent.
    _inner?.dispose().then((_) {}, onError: (_) {});
    super.dispose();
  }

  Future<void> _openSource(int index) async {
    final VideoSource source = demoVideoSources[index];
    final plugin.VideoPlayerController? oldInner = _inner;
    final PluginVideoAdapter? oldAdapter = _adapter;
    oldAdapter?.dispose();
    if (mounted) {
      setState(() {
        _sourceIndex = index;
        _inner = null;
        _adapter = null;
        _loadError = null;
        _cameraAsked = source.isCamera;
      });
    }
    if (source.isCamera) {
      final bool granted = await webRequestCamera();
      if (!mounted) return;
      setState(() => _cameraGranted = granted);
      try {
        await oldInner?.dispose();
      } catch (_) {}
      return;
    }
    final String? uri = source.uri;
    if (uri == null) {
      if (!mounted) return;
      setState(() => _loadError = StateError('No playable URL'));
      try {
        await oldInner?.dispose();
      } catch (_) {}
      return;
    }
    final plugin.VideoPlayerController inner =
        plugin.VideoPlayerController.networkUrl(Uri.parse(uri));
    final PluginVideoAdapter adapter = PluginVideoAdapter(inner);
    adapter.setSource(isLive: source.isLive, label: source.detail);
    adapter.setCues(parseWebVtt(_sampleVtt));
    if (source.isLive) {
      await adapter.setCaptionsEnabled(false);
    } else {
      // Demo default: captions on so the WebVTT sample shows; the bar and
      // menu toggles turn them off.
      await adapter.setCaptionsEnabled(true);
    }
    try {
      await inner.initialize();
    } catch (error) {
      if (!mounted) {
        adapter.dispose();
        await inner.dispose();
        return;
      }
      setState(() {
        _inner = inner;
        _adapter = adapter;
        _loadError = error;
      });
      try {
        await oldInner?.dispose();
      } catch (_) {}
      return;
    }
    if (!mounted) {
      adapter.dispose();
      await inner.dispose();
      return;
    }
    setState(() {
      _inner = inner;
      _adapter = adapter;
    });
    await oldInner?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth.isFinite
            ? constraints.maxWidth.clamp(320.0, 640.0)
            : 640.0;
        return SizedBox(
          width: width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _SourceSwitcher(current: _sourceIndex, onSelect: _openSource),
              const SizedBox(height: 8),
              _stage(width),
            ],
          ),
        );
      },
    );
  }

  Widget _stage(double width) {
    final VideoSource source = demoVideoSources[_sourceIndex];
    if (source.isCamera) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF18181B),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFF27272A)),
          ),
          alignment: Alignment.center,
          child: !_cameraAsked
              ? const SizedBox.shrink()
              : _cameraGranted
              ? const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(LucideIcons.video, size: 32, color: Color(0xFFFFFFFF)),
                    SizedBox(height: 8),
                    Text(
                      'Camera live — feed renders on device browsers',
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13),
                    ),
                  ],
                )
              : const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      LucideIcons.cameraOff,
                      size: 32,
                      color: Color(0xFFFFFFFF),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Camera unavailable — permission denied',
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13),
                    ),
                  ],
                ),
        ),
      );
    }
    final PluginVideoAdapter? adapter = _adapter;
    final plugin.VideoPlayerController? inner = _inner;
    if (adapter == null || inner == null) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF000000),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFF27272A)),
          ),
          alignment: Alignment.center,
          child: _loadError == null
              ? const Icon(
                  LucideIcons.loaderCircle,
                  size: 32,
                  color: Color(0xFFFFFFFF),
                )
              : Text(
                  'Playback failed: $_loadError',
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
        ),
      );
    }
    return VideoPlayer(
      controller: adapter,
      title: source.label,
      subtitle: source.detail,
      content: adapter.buildView(),
      errorBuilder: (BuildContext context, Object error) => Center(
        child: Text(
          'Playback failed: $error',
          style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// Source switcher chips (docs chrome around the component).
class _SourceSwitcher extends StatelessWidget {
  const _SourceSwitcher({required this.current, required this.onSelect});

  final int current;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: 8,
      children: <Widget>[
        for (int i = 0; i < demoVideoSources.length; i++)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onSelect(i),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: current == i
                    ? const Color(0xFF18181B)
                    : const Color(0x00000000),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: const Color(0xFF27272A)),
              ),
              child: Text(
                demoVideoSources[i].label,
                style: TextStyle(
                  color: current == i
                      ? const Color(0xFFFFFFFF)
                      : const Color(0xFF71717A),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

Widget _liveVideo(BuildContext context) => const _LiveVideo();

/// Live docs examples for `video_player` (docs-only sidecar).
const List<ComponentPreview> liveVideoPlayerPreviews = <ComponentPreview>[
  ComponentPreview(
    'Live playback',
    _liveVideo,
    description: 'Real plugin playback: MP4, live HLS and camera sources.',
  ),
];
