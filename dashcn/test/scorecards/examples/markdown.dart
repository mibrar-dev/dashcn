// Canonical scorecard example for `markdown`: first docs preview.
import 'package:flutter/widgets.dart';

import 'package:dashcn/src/components/markdown/preview.dart';

/// Minimal example pumped by the scorecard harness.
Widget scorecardExample(BuildContext context) =>
    markdownPreviews[0].builder(context);
