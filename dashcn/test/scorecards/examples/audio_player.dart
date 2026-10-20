// Canonical scorecard example for `audio_player`: first docs preview.
import 'package:flutter/widgets.dart';

import 'package:dashcn/src/components/audio_player/preview.dart';

/// Minimal example pumped by the scorecard harness.
Widget scorecardExample(BuildContext context) =>
    audioPlayerPreviews[0].builder(context);
