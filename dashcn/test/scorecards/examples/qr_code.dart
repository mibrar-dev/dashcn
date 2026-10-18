// Canonical scorecard example for `qr_code`: first docs preview.
import 'package:flutter/widgets.dart';

import 'package:dashcn/src/components/qr_code/preview.dart';

/// Minimal example pumped by the scorecard harness.
Widget scorecardExample(BuildContext context) =>
    qrCodePreviews[0].builder(context);
