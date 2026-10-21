// Tests for the docs-only live player sidecars.
//
// The real plugin backends need a browser (see CAPTURES.md for the headed
// proof); here we cover what the VM can: the WebVTT parser, caption
// plumbing on the video adapter, and the audio adapter's error surfacing
// when plugins are unavailable.

import 'dart:async';

import 'package:docs/media/audio_adapter.dart';
import 'package:docs/media/live_video.dart';
import 'package:docs/media/video_adapter.dart';
import 'package:docs/ui/dashcn/components/audio_player/audio_player.dart';
import 'package:docs/ui/dashcn/components/video_player/video_player.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart' as audio;
import 'package:video_player/video_player.dart' as plugin;

void main() {
  // The adapters touch method channels; the binding makes those calls fail
  // deterministically with MissingPluginException in the VM instead of
  // "Binding has not yet been initialized".
  TestWidgetsFlutterBinding.ensureInitialized();
  group('parseWebVtt', () {
    test('parses the inline sample', () {
      final List<VideoCaptionCue> cues = parseWebVtt('''
WEBVTT

00:00.000 --> 00:05.000
Hello, world

00:05.000 --> 00:12.000
Butterfly wings at 24 frames
''');
      expect(cues.length, 2);
      expect(cues[0].start, Duration.zero);
      expect(cues[0].end, const Duration(seconds: 5));
      expect(cues[0].text, 'Hello, world');
      expect(cues[1].start, const Duration(seconds: 5));
      expect(cues[1].end, const Duration(seconds: 12));
      expect(cues[1].text, 'Butterfly wings at 24 frames');
      expect(cues[0].isActive(const Duration(seconds: 3)), isTrue);
      expect(cues[0].isActive(const Duration(seconds: 6)), isFalse);
    });

    test('handles hours and ignores garbage', () {
      final List<VideoCaptionCue> cues = parseWebVtt('''
WEBVTT
Kind: captions

01:02:03.500 --> 01:02:05.000
An hour in

not a cue
''');
      expect(cues.length, 1);
      expect(
        cues.single.start,
        const Duration(hours: 1, minutes: 2, seconds: 3, milliseconds: 500),
      );
    });

    test('empty input yields no cues', () {
      expect(parseWebVtt(''), isEmpty);
      expect(parseWebVtt('WEBVTT\n\n'), isEmpty);
    });
  });

  group('PluginVideoAdapter captions', () {
    test('setCues and toggle work without a plugin', () async {
      final plugin.VideoPlayerController inner =
          plugin.VideoPlayerController.networkUrl(
            Uri.parse('https://example.com/video.mp4'),
          );
      final PluginVideoAdapter adapter = PluginVideoAdapter(inner);
      addTearDown(() {
        adapter.dispose();
        inner.dispose();
      });
      expect(adapter.areCaptionsEnabled, isFalse);
      adapter.setCues(parseWebVtt('WEBVTT\n\n00:01.000 --> 00:02.000\nHi\n'));
      await adapter.setCaptionsEnabled(true);
      expect(adapter.areCaptionsEnabled, isTrue);
      expect(adapter.cues.single.text, 'Hi');
      await adapter.toggleCaptions();
      expect(adapter.areCaptionsEnabled, isFalse);
    });
  });

  group('JustAudioAdapter without plugins', () {
    test('failed loads surface the error', () async {
      // just_audio reports VM platform failures both through the awaited
      // future AND as uncaught zone errors; collect both.
      final List<Object> zoneErrors = <Object>[];
      await runZonedGuarded(
        () async {
          final audio.AudioPlayer player = audio.AudioPlayer();
          final JustAudioAdapter adapter = JustAudioAdapter(player);
          try {
            await adapter.setTracks(demoAudioTracks);
          } catch (_) {}
          expect(adapter.error, isNotNull);
          adapter.clearError();
          expect(adapter.error, isNull);
          adapter.dispose();
          try {
            await player.dispose();
          } catch (_) {}
        },
        (Object error, StackTrace stack) {
          zoneErrors.add(error);
        },
      );
      expect(zoneErrors, isNotEmpty);
    });
  });
}
