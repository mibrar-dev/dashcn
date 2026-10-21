import 'package:flutter/widgets.dart';

import 'localizations.dart';
import 'localizations_pt.dart';

/// Brazilian Portuguese (`pt_BR`) locale data.
///
/// Inherits the full `pt` table and overrides only the strings where
/// Brazilian usage differs from European Portuguese. Anything neither table
/// overrides falls through to the English default on
/// [ComponentLocalizations]. Text direction is not handled here - Flutter
/// resolves it from [WidgetsLocalizations] and [Directionality].
class ComponentLocalizationsPtBr extends ComponentLocalizationsPt {
  /// Creates the Brazilian Portuguese strings.
  const ComponentLocalizationsPtBr([super.locale = const Locale('pt', 'BR')]);

  @override
  String get authFirstName => 'Nome';

  @override
  String get authLastName => 'Sobrenome';

  @override
  String get actionStartTrial => 'Iniciar teste gratuito';

  @override
  String get authUseDifferentEmail => 'Usar outro e-mail';

  @override
  String get errorActionReport => 'Reportar';

  @override
  String get chartTotalLabel => 'Total';
}
