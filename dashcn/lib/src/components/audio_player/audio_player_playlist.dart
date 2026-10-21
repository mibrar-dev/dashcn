// Demo playlist for the `audio_player` component (SPEC reference tracks).
//
// The kit never fetches these URLs: the docs app wires `just_audio` to the
// shared [AudioPlaybackController]. Previews and tests use titles, artists
// and cover placeholders only.

import 'audio_player_controller.dart';

/// The three SPEC tracks, in order.
const List<AudioTrack> demoAudioTracks = <AudioTrack>[
  AudioTrack(
    title: 'Southern Roots Boogie',
    artist: 'Falconer',
    coverUrl:
        'https://cdn.21st.dev/assets/mirror/ba/bafb64c13ba4ed85d598cc318a62f9a5129f3abaecee80943d495e7356fd0603.jpg',
    src:
        'https://cdn.21st.dev/assets/mirror/ca/cadd2666c5571e12fafdb21697a26aef6f196a5a9c28e708129870167679991d.mp3',
  ),
  AudioTrack(
    title: 'Sax Party',
    artist: 'Ofer Koren',
    coverUrl:
        'https://cdn.21st.dev/assets/mirror/ca/ca5a0ecf3ecbf81caded68eb8929e9d2f060c50dfbefd6ca1c04792856a049.jpg',
    src:
        'https://cdn.21st.dev/assets/mirror/ab/ab5cb08483abe3edd2a2ce4d843ad8f3073cbb4a798d7462b9e4dc590d5ca.mp3',
  ),
  AudioTrack(
    title: 'Nonsense',
    artist: 'Raw',
    coverUrl:
        'https://cdn.21st.dev/assets/mirror/d0/d0d6fb080fce77435843ac5edf73ac22b73be5e7b342d433bb8f73c9e4a15e.jpg',
    src:
        'https://cdn.21st.dev/assets/mirror/79/793e6ffda56e2869198b0a55bdaf0f2bccb8950d42f1c4ebb42f7ddc4ebbdb.mp3',
  ),
];

/// Resolves the compact pill title: track title, then widget title.
String resolveAudioTitle(AudioPlaybackController controller, String? title) {
  final AudioTrack? track = controller.currentTrack;
  if (track != null) return track.title;
  return title ?? 'Untitled';
}

/// Resolves the artist line: track artist, then widget subtitle.
String? resolveAudioArtist(AudioPlaybackController controller, String? artist) {
  final AudioTrack? track = controller.currentTrack;
  if (track != null) return track.artist;
  return artist;
}
