// Demo playlist for the `audio_player` component (SPEC reference tracks).
//
// The kit never fetches these URLs: the docs app wires `just_audio` to the
// shared [AudioPlaybackController]. Previews and tests use titles, artists
// and cover placeholders only.

import 'audio_player_controller.dart';
import '../../primitives/localizations/localizations.dart';

/// The three SPEC tracks, in order.
const List<AudioTrack> demoAudioTracks = <AudioTrack>[
  AudioTrack(
    title: 'Southern Roots Boogie',
    artist: 'Falconer',
    coverUrl:
        'https://cdn.21st.dev/assets/mirror/ba/bafb64c13ba4ed85d598cc318a62f9a5129f3abaecee80943d495e7356fd0603.jpg',
    src:
        'https://cdn.21st.dev/assets/mirror/ca/cadd2666c5571e12fafdb21697b26aef6f196a5a9c28e708129870167679991d.mp3',
  ),
  AudioTrack(
    title: 'Sax Party',
    artist: 'Ofer Koren',
    coverUrl:
        'https://cdn.21st.dev/assets/mirror/ca/ca5a0ecf3ecbf81caded68eb8929e9d2f060c50dfbefd6ca1c04792856a049.jpg',
    src:
        'https://cdn.21st.dev/assets/mirror/ab/ab5cb08483abe63edd2a2ce4d843ad8f3073fcbb4a738a94f6b7529df3e1b437.mp3',
  ),
  AudioTrack(
    title: 'Nonsense',
    artist: 'Raw',
    coverUrl:
        'https://cdn.21st.dev/assets/mirror/d0/d0d6fb080fce774573e95f73ac22b73be5e7b342d433bb8f73c9e4a15e.jpg',
    src:
        'https://cdn.21st.dev/assets/mirror/79/793e6ffda56e28691998b90a55bdaf0f2bccb8950cd8a7ee9ef7421c4ebbafdb.mp3',
  ),
];

/// Resolves the compact pill title: track title, then widget title.
///
/// English fallback for code without a [BuildContext]; widget builds should
/// pass the ambient [ComponentLocalizations] so the fallback is localized.
String resolveAudioTitle(
  AudioPlaybackController controller,
  String? title, [
  ComponentLocalizations? strings,
]) {
  final AudioTrack? track = controller.currentTrack;
  if (track != null) return track.title;
  return title ?? strings?.mediaUntitled ?? 'Untitled';
}

/// Resolves the artist line: track artist, then widget subtitle.
String? resolveAudioArtist(AudioPlaybackController controller, String? artist) {
  final AudioTrack? track = controller.currentTrack;
  if (track != null) return track.artist;
  return artist;
}
