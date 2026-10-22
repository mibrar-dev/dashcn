// Expanded card for `audio_player` (SPEC reference 2).
//
// Portrait card (~360px wide, radius 20): full circular disc cover art that
// rotates while playing (20 s per turn, paused when stopped), equaliser
// glyph, uppercase artist, large centred title, full-width progress with
// centred mono times, and a 5-button transport row (shuffle, previous, 56px
// black play, next, repeat) wired to the playlist. Tapping the disc opens a
// details panel on top of the card (title, artist, album, duration, track
// number). Card padding is the 16 px density token; the transport row uses
// 12 px density gaps.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/focus_tap.dart';
import '../../primitives/localizations/localizations.dart';
import '../../primitives/surface.dart';
import '../../theme/density.dart';
import '../../theme/theme.dart';
import 'audio_player_controller.dart';
import 'audio_player_expanded_transport.dart';
import 'audio_player_playlist.dart';
import 'audio_player_progress.dart';
import 'audio_player_style.dart';
import 'audio_player_transport.dart';

/// Expanded portrait card body; the card wrapper lives in [AudioPlayer].
class AudioExpandedCard extends StatefulWidget {
  /// Creates an expanded card.
  const AudioExpandedCard({
    super.key,
    required this.controller,
    required this.style,
    required this.fg,
    required this.muted,
    this.title,
    this.subtitle,
    this.cover,
    this.supportedSpeeds = kAudioSpeeds,
    this.showSpeed = true,
    this.initialSpeedOpen = false,
    this.coverBuilder,
    this.titleBuilder,
    this.subtitleBuilder,
    this.progressBuilder,
    this.waveformBuilder,
    this.controlsBuilder,
    this.playButtonBuilder,
    this.previousBuilder,
    this.nextBuilder,
    this.shuffleBuilder,
    this.repeatBuilder,
    this.speedBuilder,
    this.loadingBuilder,
  });

  /// Playback controller (shared with the compact pill).
  final AudioPlaybackController controller;

  /// Resolved theme.
  final AudioPlayerTheme style;

  /// Primary text/icons.
  final Color fg;

  /// Secondary text.
  final Color muted;

  /// Fallback title when the controller has no track.
  final String? title;

  /// Fallback artist when the controller has no track.
  final String? subtitle;

  /// Cover art shown as the rotating disc.
  final Widget? cover;

  /// Speeds offered by the speed menu.
  final List<double> supportedSpeeds;

  /// Whether the speed control shows.
  final bool showSpeed;

  /// Whether the expanded speed menu starts open.
  final bool initialSpeedOpen;

  /// Builder slots for every visible part.
  final AudioPartBuilder? coverBuilder;
  final AudioPartBuilder? titleBuilder;
  final AudioPartBuilder? subtitleBuilder;
  final Widget Function(
    BuildContext context,
    AudioPlaybackController controller,
    AudioProgressBar defaults,
  )?
  progressBuilder;
  final Widget Function(
    BuildContext context,
    AudioPlaybackController controller,
    AudioProgressBar defaults,
  )?
  waveformBuilder;
  final AudioPartBuilder? controlsBuilder;
  final AudioPartBuilder? playButtonBuilder;
  final AudioPartBuilder? previousBuilder;
  final AudioPartBuilder? nextBuilder;
  final AudioPartBuilder? shuffleBuilder;
  final AudioPartBuilder? repeatBuilder;
  final AudioPartBuilder? speedBuilder;
  final AudioPartBuilder? loadingBuilder;

  @override
  State<AudioExpandedCard> createState() => _AudioExpandedCardState();
}

class _AudioExpandedCardState extends State<AudioExpandedCard> {
  bool _detailsOpen = false;

  @override
  Widget build(BuildContext context) {
    // Density-driven gaps: at the default density baseGap is 8, so gapMd
    // (1.5x) is the 12 px controls rhythm and xsGap keeps the tight
    // artist/title stack. Card padding (16 px) lives in the body wrapper.
    final ThemeData ambient = Theme.of(context);
    final double gap = ambient.density.baseGap * ambient.scaling;
    final double sectionGap = gap * gapMd;
    final double xsGap = gap * 0.75;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Flexible disc: the loose card measures 439 px tall (405 px column
        // + 16 px top/bottom padding + border) but the docs preview stage is
        // a tight 720x420 box, so the column only gets ~388 px and a fixed
        // 144 px disc overflows by 19 px. Shrink just the disc when the
        // incoming height is bounded and too short; unbounded/phone layouts
        // keep the full 144 px circle so existing size contracts hold.
        double discSize = 144;
        if (constraints.maxHeight.isFinite) {
          const double reserve = 280;
          const double minDisc = 96;
          if (constraints.maxHeight < reserve + 144) {
            discSize = (constraints.maxHeight - reserve).clamp(minDisc, 144);
          }
        }
        if (constraints.maxWidth.isFinite && constraints.maxWidth < discSize) {
          discSize = constraints.maxWidth;
        }
        final Widget column = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _disc(context, discSize),
            SizedBox(height: sectionGap),
            _equaliser(context),
            SizedBox(height: sectionGap),
            _artist(context),
            SizedBox(height: xsGap),
            _title(context),
            SizedBox(height: sectionGap),
            _progress(context),
            SizedBox(height: gap * gapSm),
            _times(context),
            SizedBox(height: sectionGap),
            _transport(context),
          ],
        );
        if (!_detailsOpen) return column;
        return Stack(
          children: <Widget>[
            column,
            Positioned.fill(child: _detailsPanel(context)),
          ],
        );
      },
    );
  }

  Widget _disc(BuildContext context, [double discSize = 144]) {
    if (widget.coverBuilder != null) {
      final Widget custom = widget.coverBuilder!(context, widget.controller);
      return _tappableDisc(context, custom, discSize);
    }
    final Widget art =
        widget.cover ??
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Color(0xFF7C3AED), Color(0xFFEC4899)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          alignment: Alignment.center,
          child: const Icon(
            LucideIcons.music,
            size: 48,
            color: Color(0xFFFFFFFF),
          ),
        );
    // Full disc, fully inside the card: centred circle with a ring
    // and spindle hole, rotating while playing (20 s per turn). The
    // diameter is flexible (144 px loose, down to 96 px in the tight
    // 720x420 preview) so the card keeps its 16 px bottom padding.
    final Widget disc = SizedBox(
      width: discSize,
      height: discSize,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _RotatingDisc(
            isPlaying: widget.controller.isPlaying,
            child: Container(
              width: discSize,
              height: discSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.muted.withAlpha(0x59),
                  width: 6,
                ),
              ),
              child: ClipOval(child: art),
            ),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.muted.withAlpha(0x33),
              border: Border.all(color: widget.fg.withAlpha(0x99), width: 2),
            ),
            alignment: Alignment.center,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.fg,
              ),
            ),
          ),
        ],
      ),
    );
    return Center(child: _tappableDisc(context, disc, discSize));
  }

  Widget _tappableDisc(
    BuildContext context,
    Widget disc, [
    double discSize = 144,
  ]) {
    final String label = resolveAudioTitle(
      widget.controller,
      widget.title,
      ComponentLocalizations.of(context),
    );
    return FocusableTap(
      label: label,
      onTap: () => setState(() => _detailsOpen = true),
      minWidth: discSize,
      minHeight: discSize,
      circular: true,
      child: disc,
    );
  }

  Widget _detailsPanel(BuildContext context) {
    final AudioPlaybackController c = widget.controller;
    final AudioTrack? track = c.currentTrack;
    final String title = resolveAudioTitle(
      c,
      widget.title,
      ComponentLocalizations.of(context),
    );
    final String? artist = resolveAudioArtist(c, widget.subtitle);
    final String album = track?.album ?? artist ?? title;
    final String duration = formatAudioTime(c.duration);
    final int total = c.tracks.isEmpty ? 1 : c.tracks.length;
    final int current = c.tracks.isEmpty
        ? 1
        : (c.currentIndex + 1).clamp(1, total);
    final ThemeData ambient = Theme.of(context);
    final Color cardBase =
        widget.style.background?.resolve(ambient.colors) ?? ambient.colors.card;
    final double? opacity = resolveSurfaceOpacity(
      context,
      component: widget.style.surfaceOpacity,
    );
    final double? blur = resolveSurfaceBlur(
      context,
      component: widget.style.surfaceBlur,
    );
    final double densityBase =
        ambient.density.baseContentPadding * ambient.scaling;
    final EdgeInsetsGeometry panelPadding = resolveEdgeInsets(
      const EdgeInsetsDensity.pxAll(16),
      densityBase,
    );
    // Details overlay frosts like every other surface: the scrim and the
    // inner card both paint through surfaceColor + GlassSurface so the
    // global opacity/blur legs reach them (navigation-bar parity).
    final Color scrim = surfaceColor(cardBase.withAlpha(0xF2), opacity);
    final Color cardPaint = surfaceColor(cardBase, opacity);
    final Widget panel = Container(
      color: scrim,
      padding: panelPadding,
      child: Center(
        child: Container(
          padding: panelPadding,
          decoration: BoxDecoration(
            color: cardPaint,
            border: Border.all(color: ambient.colors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: widget.fg,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (artist != null) ...<Widget>[
                const SizedBox(height: 4),
                Text(
                  artist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: widget.muted, fontSize: 13),
                ),
              ],
              const SizedBox(height: 4),
              Text(
                album,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(color: widget.muted, fontSize: 13),
              ),
              const SizedBox(height: 8),
              Text(
                duration,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: widget.muted,
                  fontSize: 12,
                  fontFeatures: const <FontFeature>[
                    FontFeature.tabularFigures(),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$current / $total',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(color: widget.muted, fontSize: 12),
              ),
              const SizedBox(height: 12),
              Center(
                child: FocusableTap(
                  label: ComponentLocalizations.of(context).dialogDismiss,
                  onTap: () => setState(() => _detailsOpen = false),
                  minWidth: 48,
                  minHeight: 32,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: ambient.colors.border),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(LucideIcons.x, size: 16, color: widget.fg),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return GlassSurface(
      surfaceBlur: blur,
      borderRadius: BorderRadius.circular(12),
      child: panel,
    );
  }

  Widget _equaliser(BuildContext context) {
    final colors = Theme.of(context).colors;
    final AudioProgressBar defaults = AudioProgressBar(
      position: widget.controller.position,
      duration: widget.controller.duration,
      buffered: widget.controller.buffered,
      onSeek: widget.controller.seekTo,
      trackColor: widget.style.track?.resolve(colors) ?? colors.secondary,
      bufferedColor: widget.style.buffered?.resolve(colors) ?? colors.muted,
      fillColor: widget.fg,
      thumbColor: widget.fg,
      trackHeight: widget.style.trackHeight ?? 4,
    );
    if (widget.waveformBuilder != null) {
      return widget.waveformBuilder!(context, widget.controller, defaults);
    }
    return ExcludeSemantics(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < 5; i++)
            Container(
              width: 3,
              height: 6 + (i % 3) * 5.0,
              margin: const EdgeInsets.symmetric(horizontal: 1.5),
              decoration: BoxDecoration(
                color: widget.muted,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
        ],
      ),
    );
  }

  Widget _artist(BuildContext context) {
    if (widget.subtitleBuilder != null) {
      return widget.subtitleBuilder!(context, widget.controller);
    }
    final String? artist = resolveAudioArtist(
      widget.controller,
      widget.subtitle,
    );
    if (artist == null) return const SizedBox.shrink();
    // Row + Expanded lets the line flex to the available width and truncate
    // instead of forcing the Column wider/taller on narrow stages.
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            artist.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style:
                widget.style.subtitleTextStyle ??
                TextStyle(
                  color: widget.muted,
                  fontSize: 11,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ],
    );
  }

  Widget _title(BuildContext context) {
    if (widget.titleBuilder != null) {
      return widget.titleBuilder!(context, widget.controller);
    }
    // Same flex + truncate contract as the compact pill title: the Expanded
    // gives the Row's remaining width to the label and the ellipsis keeps a
    // long track name on one line instead of overflowing the card.
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            resolveAudioTitle(
              widget.controller,
              widget.title,
              ComponentLocalizations.of(context),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style:
                widget.style.titleTextStyle ??
                TextStyle(
                  color: widget.fg,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }

  Widget _progress(BuildContext context) {
    final colors = Theme.of(context).colors;
    final AudioProgressBar defaults = AudioProgressBar(
      position: widget.controller.position,
      duration: widget.controller.duration,
      buffered: widget.controller.buffered,
      onSeek: widget.controller.seekTo,
      trackColor: widget.style.track?.resolve(colors) ?? colors.secondary,
      bufferedColor: widget.style.buffered?.resolve(colors) ?? colors.muted,
      fillColor: widget.fg,
      thumbColor: widget.fg,
      trackHeight: widget.style.trackHeight ?? 4,
    );
    return widget.progressBuilder?.call(context, widget.controller, defaults) ??
        defaults;
  }

  Widget _times(BuildContext context) {
    final AudioPlaybackController c = widget.controller;
    final Widget times = Text(
      '${formatAudioTime(c.position)} / ${formatAudioTime(c.duration)}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style:
          widget.style.timeTextStyle ??
          TextStyle(
            color: widget.muted,
            fontSize: 12,
            fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
          ),
    );
    if (!widget.showSpeed && widget.speedBuilder == null) return times;
    return Row(
      children: <Widget>[
        const SizedBox(width: 32),
        Expanded(child: times),
        widget.speedBuilder?.call(context, c) ??
            AudioSpeedButton(
              controller: c,
              fg: widget.fg,
              supportedSpeeds: widget.supportedSpeeds,
              initialOpen: widget.initialSpeedOpen,
            ),
      ],
    );
  }

  Widget _transport(BuildContext context) {
    return AudioExpandedTransport(
      controller: widget.controller,
      style: widget.style,
      fg: widget.fg,
      muted: widget.muted,
      controlsBuilder: widget.controlsBuilder,
      playButtonBuilder: widget.playButtonBuilder,
      previousBuilder: widget.previousBuilder,
      nextBuilder: widget.nextBuilder,
      shuffleBuilder: widget.shuffleBuilder,
      repeatBuilder: widget.repeatBuilder,
      loadingBuilder: widget.loadingBuilder,
    );
  }
}

/// Disc rotation: one turn every 20 s while playing, frozen when stopped.
///
/// The animation controller repeats while [isPlaying] is true and stops
/// (preserving the angle) when it flips false, so pause resumes smoothly
/// without a jump.
class _RotatingDisc extends StatefulWidget {
  const _RotatingDisc({required this.isPlaying, required this.child});

  final bool isPlaying;
  final Widget child;

  @override
  State<_RotatingDisc> createState() => _RotatingDiscState();
}

class _RotatingDiscState extends State<_RotatingDisc>
    with SingleTickerProviderStateMixin {
  late final AnimationController _turns;

  @override
  void initState() {
    super.initState();
    _turns = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    if (widget.isPlaying) _turns.repeat();
  }

  @override
  void didUpdateWidget(covariant _RotatingDisc oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying == oldWidget.isPlaying) return;
    if (widget.isPlaying) {
      _turns.repeat();
    } else {
      _turns.stop();
    }
  }

  @override
  void dispose() {
    _turns.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(turns: _turns, child: widget.child);
  }
}
