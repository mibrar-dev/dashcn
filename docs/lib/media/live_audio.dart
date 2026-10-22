// Docs-only live audio example: real `just_audio` playback.
//
// The kit stays dependency-free: this file lives in the docs app, which owns
// the `just_audio` dependency. One shared [JustAudioAdapter] drives the
// compact pill and the expanded card together over the three SPEC tracks
// (online URLs), with next/previous, shuffle, repeat, speed cycling and
// per-track download anchors. Cover art loads from the network with a
// gradient fallback (the track 2/3 cover URLs are dead upstream).
//
// This file is a docs preview *sidecar*: `tool/gen_docs_data.dart` appends its
// `liveAudioPlayerPreviews` to the `audio_player` examples (labels, counts,
// Code tabs and the deferred preview loader).

import 'package:docs/media/audio_adapter.dart';
import 'package:docs/ui/dashcn/components/audio_player/audio_player.dart';
import 'package:docs/ui/dashcn/foundation/component_preview.dart';
import 'package:docs/ui/dashcn/foundation/icons/lucide_icons.dart';
import 'package:docs/ui/dashcn/theme/theme.dart';
import 'package:docs/web_bridge.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart' as audio;

/// Gradient placeholder shown while a cover loads or when it 404s.
Widget _coverFallback(List<Color> colors) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    alignment: Alignment.center,
    child: const Icon(LucideIcons.music, size: 56, color: Color(0xFFFFFFFF)),
  );
}

/// File name for a track download.
String _downloadName(AudioTrack track) =>
    '${track.artist}-${track.title}'.replaceAll(RegExp('[^A-Za-z0-9]+'), '-');

/// Live audio docs example: shared controller, compact + expanded.
class _LiveAudio extends StatefulWidget {
  const _LiveAudio();

  @override
  State<_LiveAudio> createState() => _LiveAudioState();
}

class _LiveAudioState extends State<_LiveAudio> {
  audio.AudioPlayer? _player;
  JustAudioAdapter? _adapter;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    final audio.AudioPlayer player = audio.AudioPlayer();
    final JustAudioAdapter adapter = JustAudioAdapter(player);
    try {
      await adapter.setTracks(demoAudioTracks);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _player = player;
        _adapter = adapter;
        _failed = true;
      });
      return;
    }
    if (!mounted) {
      adapter.dispose();
      try {
        await player.dispose();
      } catch (_) {}
      return;
    }
    setState(() {
      _player = player;
      _adapter = adapter;
    });
  }

  @override
  void dispose() {
    _adapter?.dispose();
    // Plugin dispose is fire-and-forget here; swallow the
    // MissingPluginException it throws where plugins are absent (VM tests).
    _player?.dispose().then((_) {}, onError: (_) {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final JustAudioAdapter? adapter = _adapter;
    if (adapter == null) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double avail = constraints.maxWidth.isFinite
              ? constraints.maxWidth
              : 360;
          final double width = avail < 360 ? avail : 360;
          return SizedBox(
            width: width,
            height: 120,
            child: const Center(
              child: Text(
                'Loading live audio…',
                style: TextStyle(fontSize: 13),
              ),
            ),
          );
        },
      );
    }
    return ListenableBuilder(
      listenable: adapter,
      builder: (BuildContext context, Widget? _) {
        final AudioTrack? track = adapter.currentTrack;
        final String? coverUrl = track?.coverUrl;
        final List<Color> gradient = const <Color>[
          Color(0xFF7C3AED),
          Color(0xFFEC4899),
        ];
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double avail = constraints.maxWidth.isFinite
                ? constraints.maxWidth
                : 360;
            final double width = avail < 360 ? avail : 360;
            final double gap =
                Theme.of(context).density.baseGap *
                Theme.of(context).scaling *
                1.5;
            return SizedBox(
              width: width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _TrackSelector(adapter: adapter),
                  SizedBox(height: gap),
                  SizedBox(
                    width: width,
                    child: AudioPlayer(
                      controller: adapter,
                      variant: AudioPlayerVariant.compact,
                      onDownload: _downloadCurrent,
                    ),
                  ),
                  SizedBox(height: gap),
                  SizedBox(
                    width: width,
                    child: AudioPlayer(
                      controller: adapter,
                      variant: AudioPlayerVariant.full,
                      cover: coverUrl == null
                          ? _coverFallback(gradient)
                          : Image.network(
                              coverUrl,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (
                                    BuildContext context,
                                    Object error,
                                    StackTrace? stackTrace,
                                  ) => _coverFallback(gradient),
                            ),
                    ),
                  ),
                  if (adapter.error != null || _failed)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Playback failed: ${adapter.error ?? 'could not load track'}',
                        style: const TextStyle(
                          color: Color(0xFFDC2626),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _downloadCurrent() {
    final AudioTrack? track = _adapter?.currentTrack;
    final String? src = track?.src;
    if (src == null || track == null) return;
    webDownloadUrl(src, '${_downloadName(track)}.mp3');
  }
}

/// Track selector chips (docs chrome around the component).
class _TrackSelector extends StatelessWidget {
  const _TrackSelector({required this.adapter});

  final JustAudioAdapter adapter;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 0,
      runSpacing: 8,
      children: <Widget>[
        for (int i = 0; i < adapter.tracks.length; i++)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => adapter.setTrack(i),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: adapter.currentIndex == i
                    ? const Color(0xFF18181B)
                    : const Color(0x00000000),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: const Color(0xFF27272A)),
              ),
              child: Text(
                adapter.tracks[i].title,
                style: TextStyle(
                  color: adapter.currentIndex == i
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

Widget _liveAudio(BuildContext context) => const _LiveAudio();

/// Live docs examples for `audio_player` (docs-only sidecar).
const List<ComponentPreview> liveAudioPlayerPreviews = <ComponentPreview>[
  ComponentPreview(
    'Live playback',
    _liveAudio,
    description:
        'Real just_audio playback: shared compact pill + expanded card.',
  ),
];
