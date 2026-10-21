import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations.dart';

/// Portuguese (`pt`) locale data.
///
/// Translations only: anything this table does not override falls
/// through to the English default on [ComponentLocalizations]. Text
/// direction is not handled here - Flutter resolves it from
/// [WidgetsLocalizations] and [Directionality].
class ComponentLocalizationsPt extends ComponentLocalizations {
  /// Creates the Portuguese strings.
  const ComponentLocalizationsPt([super.locale = const Locale('pt')]);

  /// Formats [value] as a number in this locale, or returns it
  /// verbatim when it is not a number.
  String _number(Object? value) {
    if (value is! num) return '$value';
    return intl.NumberFormat.decimalPattern(localeName).format(value);
  }

  @override
  String get formNotEmpty => 'Este campo não pode ficar vazio';

  @override
  String get invalidValue => 'Valor inválido';

  @override
  String get invalidEmail => 'E-mail inválido';

  @override
  String get invalidURL => 'URL inválido';

  @override
  String formLessThan(Object? value) => 'Deve ser menor que ${_number(value)}';

  @override
  String formGreaterThan(Object? value) =>
      'Deve ser maior que ${_number(value)}';

  @override
  String formLessThanOrEqualTo(Object? value) =>
      'Deve ser menor ou igual a ${_number(value)}';

  @override
  String get formPhoneNumberInvalid => 'O número de telefone é inválido';

  @override
  String get formPhoneNumberEmpty => 'O número de telefone é obrigatório';

  @override
  String formGreaterThanOrEqualTo(Object? value) =>
      'Deve ser maior ou igual a ${_number(value)}';

  @override
  String formBetweenInclusively(Object? min, Object? max) =>
      'Deve estar entre ${_number(min)} e ${_number(max)} (inclusive)';

  @override
  String formEqualTo(Object? value) => 'Deve ser igual a ${_number(value)}';

  @override
  String formBetweenExclusively(Object? min, Object? max) =>
      'Deve estar entre ${_number(min)} e ${_number(max)} (exclusive)';

  @override
  String formLengthLessThan(int limit) =>
      'Deve ter pelo menos $limit caracteres';

  @override
  String formLengthGreaterThan(int limit) =>
      'Deve ter no máximo $limit caracteres';

  @override
  String get formPasswordDigits => 'Deve conter pelo menos um dígito';

  @override
  String get formPasswordLowercase =>
      'Deve conter pelo menos uma letra minúscula';

  @override
  String get formPasswordUppercase =>
      'Deve conter pelo menos uma letra maiúscula';

  @override
  String get formPasswordSpecial =>
      'Deve conter pelo menos um caractere especial';

  @override
  String get commandSearch => 'Digite um comando ou pesquise...';

  @override
  String get commandEmpty => 'Nenhum resultado encontrado.';

  @override
  String get datePickerSelectYear => 'Selecione um ano';

  @override
  String get abbreviatedMonday => 'Seg';

  @override
  String get abbreviatedTuesday => 'Ter';

  @override
  String get abbreviatedWednesday => 'Qua';

  @override
  String get abbreviatedThursday => 'Qui';

  @override
  String get abbreviatedFriday => 'Sex';

  @override
  String get abbreviatedSaturday => 'Sáb';

  @override
  String get abbreviatedSunday => 'Dom';

  @override
  String get monthJanuary => 'Janeiro';

  @override
  String get monthFebruary => 'Fevereiro';

  @override
  String get monthMarch => 'Março';

  @override
  String get monthApril => 'Abril';

  @override
  String get monthMay => 'Maio';

  @override
  String get monthJune => 'Junho';

  @override
  String get monthJuly => 'Julho';

  @override
  String get monthAugust => 'Agosto';

  @override
  String get monthSeptember => 'Setembro';

  @override
  String get monthOctober => 'Outubro';

  @override
  String get monthNovember => 'Novembro';

  @override
  String get monthDecember => 'Dezembro';

  @override
  String get abbreviatedJanuary => 'Jan';

  @override
  String get abbreviatedFebruary => 'Fev';

  @override
  String get abbreviatedMarch => 'Mar';

  @override
  String get abbreviatedApril => 'Abr';

  @override
  String get abbreviatedMay => 'Mai';

  @override
  String get abbreviatedJune => 'Jun';

  @override
  String get abbreviatedJuly => 'Jul';

  @override
  String get abbreviatedAugust => 'Ago';

  @override
  String get abbreviatedSeptember => 'Set';

  @override
  String get abbreviatedOctober => 'Out';

  @override
  String get abbreviatedNovember => 'Nov';

  @override
  String get abbreviatedDecember => 'Dez';

  @override
  String get dialogDismiss => 'Dispensar';

  @override
  String get chipInputRemoveChip => 'Excluir';

  @override
  String get buttonCancel => 'Cancelar';

  @override
  String get buttonSave => 'Salvar';

  @override
  String get timeHour => 'Hora';

  @override
  String get timeMinute => 'Minuto';

  @override
  String get timeSecond => 'Segundo';

  @override
  String get timeAM => 'AM';

  @override
  String get timePM => 'PM';

  @override
  String get colorRed => 'Vermelho';

  @override
  String get colorGreen => 'Verde';

  @override
  String get colorBlue => 'Azul';

  @override
  String get colorAlpha => 'Alfa';

  @override
  String get colorHue => 'Matiz';

  @override
  String get colorSaturation => 'Sat';

  @override
  String get colorValue => 'Val';

  @override
  String get colorLightness => 'Lum';

  @override
  String get menuCut => 'Recortar';

  @override
  String get menuCopy => 'Copiar';

  @override
  String get menuPaste => 'Colar';

  @override
  String get menuSelectAll => 'Selecionar tudo';

  @override
  String get menuUndo => 'Desfazer';

  @override
  String get menuRedo => 'Refazer';

  @override
  String get menuDelete => 'Excluir';

  @override
  String get menuShare => 'Compartilhar';

  @override
  String get menuSearchWeb => 'Pesquisar na web';

  @override
  String get menuLiveTextInput => 'Texto ao vivo';

  @override
  String get placeholderDatePicker => 'Selecione uma data';

  @override
  String get placeholderTimePicker => 'Selecione um horário';

  @override
  String get placeholderColorPicker => 'Selecione uma cor';

  @override
  String get buttonPrevious => 'Anterior';

  @override
  String get buttonNext => 'Próximo';

  @override
  String get refreshTriggerPull => 'Puxe para atualizar';

  @override
  String get refreshTriggerRelease => 'Solte para atualizar';

  @override
  String get refreshTriggerRefreshing => 'Atualizando...';

  @override
  String get refreshTriggerComplete => 'Atualização concluída';

  @override
  String get colorPickerTabRGB => 'RGB';

  @override
  String get colorPickerTabHSV => 'HSV';

  @override
  String get colorPickerTabHSL => 'HSL';

  @override
  String get colorPickerTabHEX => 'HEX';

  @override
  String get commandMoveUp => 'Mover para cima';

  @override
  String get commandMoveDown => 'Mover para baixo';

  @override
  String get commandActivate => 'Selecionar';

  @override
  String get timeDaysAbbreviation => 'DD';

  @override
  String get timeHoursAbbreviation => 'HH';

  @override
  String get timeMinutesAbbreviation => 'MM';

  @override
  String get timeSecondsAbbreviation => 'SS';

  @override
  String get placeholderDurationPicker => 'Selecione uma duração';

  @override
  String get durationDay => 'Dia';

  @override
  String get durationHour => 'Hora';

  @override
  String get durationMinute => 'Minuto';

  @override
  String get durationSecond => 'Segundo';

  @override
  String get dropzoneIdle => 'Procurar para enviar arquivos';

  @override
  String get dropzoneDragging => 'Solte arquivos para enviar';

  @override
  String get dropzoneUploading => 'Enviando arquivos...';

  @override
  String get dropzoneSuccess => 'Arquivos prontos';

  @override
  String get dropzoneError => 'Corrija os erros para continuar';

  @override
  String get dropzoneDisabled => 'Envio de arquivos desativado';

  @override
  String get dropzoneBrowse => 'Procurar arquivos';

  @override
  String get emptyStateEmptyTitle => 'Nada aqui ainda';

  @override
  String get emptyStateEmptyDescription =>
      'Crie seu primeiro item para começar.';

  @override
  String get emptyStateNoResultsTitle => 'Nenhum resultado encontrado';

  @override
  String get emptyStateNoResultsDescription =>
      'Tente ajustar seus filtros ou termos de pesquisa.';

  @override
  String get emptyStateErrorTitle => 'Algo deu errado';

  @override
  String get emptyStateErrorDescription =>
      'Não conseguimos carregar estes dados. Tente novamente em instantes.';

  @override
  String get filterSearch => 'Pesquisar';

  @override
  String get filterSort => 'Ordenar';

  @override
  String get filterDateRange => 'Intervalo de datas';

  @override
  String get filterClearAll => 'Limpar tudo';

  @override
  String get filterFilters => 'Filtros';

  @override
  String filterActiveCount(int count) => '${_number(count)} filtros ativos';

  @override
  String filterResultsCount(int count) => '${_number(count)} resultados';

  @override
  String get fileUploadChoose => 'Escolher arquivo';

  @override
  String get fileUploadNoFile => 'Nenhum arquivo escolhido';

  @override
  String get fileUploadPickFailed => 'Falha ao selecionar o arquivo.';

  @override
  String get fileUploadTooMany => 'Arquivos demais selecionados.';

  @override
  String get fileUploadTooLarge => 'O arquivo é muito grande.';

  @override
  String get fileUploadInvalidType => 'O tipo de arquivo não é permitido.';

  @override
  String get fileUploadUploadFailed => 'Falha no envio.';

  @override
  String fileUploadUploadFailedFor(String name) => 'Falha no envio de $name.';

  @override
  String get fileUploadStatusQueued => 'Na fila';

  @override
  String get fileUploadStatusUploading => 'Enviando';

  @override
  String get fileUploadStatusCompleted => 'Concluído';

  @override
  String get fileUploadStatusFailed => 'Com falha';

  @override
  String get fileUploadUnknownType => 'Arquivo';

  @override
  String get fileUploadRemove => 'Remover arquivo';

  @override
  String get fileUploadRetry => 'Tentar envio novamente';

  @override
  String get fileUploadPreview => 'Visualizar arquivo';

  @override
  String get fileUploadDownload => 'Baixar arquivo';

  @override
  String get errorSomethingWentWrong => 'Algo deu errado';

  @override
  String get errorUnexpectedMessage =>
      'Tente novamente ou entre em contato com o suporte se o problema persistir.';

  @override
  String get errorActionRetry => 'Tentar novamente';

  @override
  String get errorActionReport => 'Denunciar';

  @override
  String get errorActionBack => 'Voltar';

  @override
  String get errorActionLogin => 'Entrar';

  @override
  String get errorActionSettings => 'Configurações';

  @override
  String get errorActionContactSupport => 'Falar com o suporte';

  @override
  String get errorBadRequest => 'Solicitação inválida';

  @override
  String get errorBadRequestMessage =>
      'A solicitação era inválida. Revise e tente novamente.';

  @override
  String get errorUnauthorized => 'Não autorizado';

  @override
  String get errorLoginRequiredMessage => 'Faça login para continuar.';

  @override
  String get errorAccessDenied => 'Acesso negado';

  @override
  String get errorAccessDeniedMessage =>
      'Você não tem permissão para executar esta ação.';

  @override
  String get errorNotFound => 'Não encontrado';

  @override
  String get errorNotFoundMessage =>
      'Não conseguimos encontrar o que você procurava.';

  @override
  String get errorConflict => 'Conflito';

  @override
  String get errorConflictMessage =>
      'Esta ação conflita com os dados existentes.';

  @override
  String get errorInvalidData => 'Dados inválidos';

  @override
  String get errorInvalidDataMessage =>
      'Alguns campos precisam da sua atenção.';

  @override
  String get errorTooManyRequests => 'Solicitações demais';

  @override
  String get errorTooManyRequestsMessage =>
      'Aguarde um momento e tente novamente.';

  @override
  String get errorServerError => 'Erro do servidor';

  @override
  String get errorServerErrorMessage =>
      'O servidor encontrou um problema. Tente novamente.';

  @override
  String get errorRequestTimedOut => 'Tempo de solicitação esgotado';

  @override
  String get errorRequestTimedOutMessage =>
      'O servidor está demorando muito para responder.';

  @override
  String get errorAuthenticationRequired => 'Autenticação necessária';

  @override
  String get errorInvalidInput => 'Entrada inválida';

  @override
  String get errorReviewFieldsMessage => 'Revise os campos destacados.';

  @override
  String get errorPlatformError => 'Erro de plataforma';

  @override
  String get errorDeviceErrorMessage => 'Algo deu errado neste dispositivo.';

  @override
  String get errorConnectionFailed => 'Falha na conexão';

  @override
  String get errorConnectionFailedMessage =>
      'Verifique sua conexão com a Internet e tente novamente.';

  @override
  String get errorSecureConnectionFailed => 'Falha na conexão segura';

  @override
  String get errorSecureConnectionMessage =>
      'Não conseguimos estabelecer uma conexão segura.';

  @override
  String get tableResizeColumn => 'Redimensionar coluna';

  @override
  String get tableResizeRow => 'Redimensionar linha';

  @override
  String get resizableHandle => 'Alça de redimensionamento';

  @override
  String get spellCheckNoSuggestions => 'Sem sugestões';

  @override
  String get announcementLoading => 'Carregando';

  @override
  String get announcementSuccess => 'Êxito';

  @override
  String get announcementFailure => 'Falha';

  @override
  String get toolbarMore => 'Mais';

  @override
  String get toolbarMoreActions => 'Mais ações';

  @override
  String get treeCollapse => 'Recolher';

  @override
  String get treeExpand => 'Expandir';

  @override
  String get markdownDetails => 'Detalhes';

  @override
  String get carouselLabel => 'Carrossel em destaque';

  @override
  String get carouselPrimaryAction => 'Adicionar ao bate-papo';

  @override
  String carouselItemPreview(Object? title) =>
      'Prévia em destaque: ${title ?? mediaUntitled}';

  @override
  String carouselPageOf(int position, int length) =>
      'Página ${_number(position)} de ${_number(length)}';

  @override
  String stepperStep(int index) => 'Etapa ${_number(index + 1)}';

  @override
  String paginationPage(Object? page) => 'Página ${_number(page)}';

  @override
  String chartSeriesDefault(int index) => 'Série ${_number(index + 1)}';

  @override
  String chartSliceDefault(int index) => 'Fatia ${_number(index)}';

  @override
  String chartCategoryDefault(int index) => 'Categoria ${_number(index)}';

  @override
  String get chartValueDefault => 'Valor';

  @override
  String get chartKindLine => 'Linha';

  @override
  String get chartKindArea => 'Área';

  @override
  String get chartKindBar => 'Barras';

  @override
  String get chartKindDonut => 'Rosca';

  @override
  String get chartKindPie => 'Pizza';

  @override
  String get chartKindSparkline => 'Minigráfico';

  @override
  String get chartKindScatter => 'Dispersão';

  @override
  String get chartKindRadar => 'Radar';

  @override
  String get chartKindRadial => 'Radial';

  @override
  String chartSummaryEmpty(Object? kind) => 'Gráfico $kind sem dados';

  @override
  String chartSummary(int series, int points, Object? kind) =>
      'Gráfico $kind com ${_number(series)} séries e ${_number(points)} pontos';

  @override
  String get colorFieldHsv => 'Campo de cor HSV';

  @override
  String get colorFieldHsl => 'Campo de cor HSL';

  @override
  String get actionClear => 'Limpar';

  @override
  String get actionApply => 'Aplicar';

  @override
  String get actionVerify => 'Verificar';

  @override
  String get actionResend => 'Reenviar';

  @override
  String resendInSeconds(int seconds) => 'Reenviar em ${_number(seconds)} s';

  @override
  String get authCode => 'Código';

  @override
  String get authEmail => 'E-mail';

  @override
  String get authPassword => 'Senha';

  @override
  String get authName => 'Nome';

  @override
  String get authSignIn => 'Entrar';

  @override
  String get authForgotPassword => 'Esqueceu a senha?';

  @override
  String get authRememberMe => 'Lembrar de mim';

  @override
  String get authCreateAccount => 'Criar uma conta';

  @override
  String get actionClose => 'Fechar';

  @override
  String get mediaPlay => 'Reproduzir';

  @override
  String get mediaPause => 'Pausar';

  @override
  String get mediaMute => 'Silenciar';

  @override
  String get mediaUnmute => 'Ativar som';

  @override
  String get mediaVolume => 'Volume';

  @override
  String get mediaSeek => 'Buscar';

  @override
  String get mediaDownload => 'Baixar';

  @override
  String get mediaAudioPlayer => 'Reprodutor de áudio';

  @override
  String get mediaVideoPlayer => 'Reprodutor de vídeo';

  @override
  String get mediaUntitled => 'Sem título';

  @override
  String get mediaPlaybackFailed => 'Falha na reprodução';

  @override
  String get mediaPreviousTrack => 'Faixa anterior';

  @override
  String get mediaNextTrack => 'Próxima faixa';

  @override
  String get mediaShuffleDisable => 'Desativar aleatório';

  @override
  String get mediaShuffleEnable => 'Ativar aleatório';

  @override
  String get mediaRepeatDisable => 'Desativar repetição';

  @override
  String get mediaRepeatEnable => 'Ativar repetição';

  @override
  String mediaPlaybackSpeed(Object? speed) =>
      'Velocidade: ${speed}x, toque para alterar';

  @override
  String mediaPositionOf(Object position, Object duration) =>
      '$position de $duration';

  @override
  String mediaHours(int count) =>
      count == 1 ? '1 hora' : '${_number(count)} horas';

  @override
  String mediaMinutes(int count) =>
      count == 1 ? '1 minuto' : '${_number(count)} minutos';

  @override
  String mediaSeconds(int count) =>
      count == 1 ? '1 segundo' : '${_number(count)} segundos';

  @override
  String get signaturePadLabel => 'Área de assinatura';

  @override
  String get qrCodeLabel => 'Código QR';

  @override
  String get marqueeContent => 'Conteúdo em rolagem';

  @override
  String mediaSkipBack(int seconds) => 'Voltar ${_number(seconds)} segundos';

  @override
  String mediaSkipForward(int seconds) =>
      'Avançar ${_number(seconds)} segundos';

  @override
  String get mediaCaptionsShow => 'Mostrar legendas';

  @override
  String get mediaCaptionsHide => 'Ocultar legendas';

  @override
  String get mediaCaptionsOn => 'Legendas ativadas';

  @override
  String get mediaCaptionsOff => 'Legendas desativadas';

  @override
  String get mediaFullscreen => 'Tela cheia';

  @override
  String mediaMoreOptionsSpeed(Object? speed) =>
      'Mais opções, velocidade: ${speed}x';

  @override
  String mediaSpeed(Object? speed) => 'Velocidade: ${speed}x';

  @override
  String get actionStartTrial => 'Iniciar avaliação gratuita';

  @override
  String get authFirstName => 'Nome próprio';

  @override
  String get authLastName => 'Apelido';

  @override
  String get authPasswordHint => 'Pelo menos 8 caracteres.';

  @override
  String get authUseDifferentEmail => 'Utilizar outro e-mail';

  @override
  String get authWorkEmail => 'E-mail profissional';

  @override
  String get chartTotalLabel => 'Total';

  @override
  String get mediaQualityAuto => 'Qualidade Auto';
}
