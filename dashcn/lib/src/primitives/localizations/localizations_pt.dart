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

  @override
  String get mediaLiveBadge => 'AO VIVO';

  @override
  String get blockDontHaveAccount => 'Não tem conta?';

  @override
  String get blockAlreadyHaveAccount => 'Já tem conta?';

  @override
  String get blockNoAccountYet => 'Ainda não tem conta?';

  @override
  String get blockHaveAnAccount => 'Tem conta?';

  @override
  String get blockCreateOne => 'Crie uma';

  @override
  String get blockCreateAccount => 'Criar conta';

  @override
  String get blockCreateYourAccount => 'Crie sua conta';

  @override
  String get blockForgotYourPassword => 'Esqueceu a senha?';

  @override
  String get blockBackToSignIn => 'Voltar ao início de sessão';

  @override
  String get blockEnterCredentialsWorkspace =>
      'Digite suas credenciais para acessar seu espaço de trabalho.';

  @override
  String get blockEnterCredentialsContinue =>
      'Digite suas credenciais para continuar.';

  @override
  String get blockEnterDetailsContinue =>
      'Digite seus dados abaixo para continuar.';

  @override
  String get blockEnterEmailCreateAccount =>
      'Digite seu e-mail abaixo para criar sua conta.';

  @override
  String get blockSignedInWelcomeBack =>
      'Sessão iniciada — bem-vindo de volta.';

  @override
  String get blockAccountCreatedVerify =>
      'Conta criada — verifique sua caixa de entrada para confirmá-la.';

  @override
  String get blockTrialStartedVerify =>
      'Avaliação iniciada — verifique sua caixa de entrada para confirmá-la.';

  @override
  String get blockPasswordsDoNotMatch => 'As senhas não coincidem.';

  @override
  String get blockCurrentPassword => 'Senha atual';

  @override
  String get blockNewPassword => 'Nova senha';

  @override
  String get blockConfirmNewPassword => 'Confirmar a nova senha';

  @override
  String get blockUpdatePassword => 'Atualizar senha';

  @override
  String get blockPasswordUpdated => 'Senha atualizada.';

  @override
  String get blockPasswordHintChange =>
      'Pelo menos 8 caracteres. Alterá-la encerra sua sessão em outros lugares.';

  @override
  String get blockUsername => 'Nome de usuário';

  @override
  String get blockUsernameHint => 'Letras minúsculas, dígitos, sublinhados.';

  @override
  String get blockYourAvatar => 'Seu avatar';

  @override
  String get blockUploadImage => 'Enviar imagem';

  @override
  String get blockBio => 'Biografia';

  @override
  String get blockBioHint => 'Conte um pouco sobre você';

  @override
  String get blockBioCounterHint => 'Até 160 caracteres.';

  @override
  String get blockProfileSaved => 'Perfil salvo.';

  @override
  String get blockSaveChanges => 'Salvar alterações';

  @override
  String get blockInviteMember => 'Convidar membro';

  @override
  String get blockRoleAdmin => 'Admin';

  @override
  String get blockRoleOwner => 'Proprietário';

  @override
  String get blockRoleMember => 'Membro';

  @override
  String get blockTeam => 'Equipe';

  @override
  String get blockProfile => 'Perfil';

  @override
  String get blockSignInWithEmail => 'Entrar com e-mail';

  @override
  String get blockSignUp => 'Cadastrar-se';

  @override
  String get blockPickWayYouPrefer => 'Escolha o método de sua preferência.';

  @override
  String blockContinueWith(Object? provider) => 'Continuar com $provider';

  @override
  String get blockCreating => 'Criando…';

  @override
  String get blockSigningIn => 'Entrando…';

  @override
  String get blockSending => 'Enviando…';

  @override
  String get blockSaving => 'Salvando…';

  @override
  String get blockPaying => 'Pagando…';

  @override
  String get blockSendResetLink => 'Enviar link de redefinição';

  @override
  String get blockResetPassword => 'Redefinir senha';

  @override
  String get blockResetLinkSent =>
      'Link de redefinição enviado. Verifique sua caixa de entrada para continuar.';

  @override
  String get blockWeWillEmailReset =>
      'Enviaremos um link de redefinição por e-mail.';

  @override
  String get blockMustAcceptTerms =>
      'Você precisa aceitar os termos para continuar.';

  @override
  String get blockCheckInbox => 'Verifique sua caixa de entrada';

  @override
  String get blockEnterSixDigitCode =>
      'Digite o código de 6 dígitos que enviamos.';

  @override
  String get blockCodeVerifiedSignedIn =>
      'Código verificado. Você está conectado.';

  @override
  String get blockEmailVerifiedSet => 'E-mail verificado — está tudo pronto.';

  @override
  String get blockVerifyYourEmail => 'Verifique seu e-mail';

  @override
  String blockWeSentCodeTo(Object? email) =>
      'Enviamos um código de 6 dígitos para $email.';

  @override
  String get blockDidntGetCode => 'Não recebeu o código?';

  @override
  String get blockBack => 'Voltar';

  @override
  String get blockBackToCart => 'Voltar ao carrinho';

  @override
  String get blockBackToSettings => 'Voltar às configurações';

  @override
  String get blockOneAccountEverything => 'Uma conta para tudo.';

  @override
  String get blockStartTrialNoCard =>
      'Inicie sua avaliação de 14 dias. Sem cartão de crédito.';

  @override
  String get blockNotifications => 'Notificações';

  @override
  String get blockNotifChoose => 'Escolha sobre o que quer saber, e onde.';

  @override
  String get blockEmailNotifications => 'Notificações por e-mail';

  @override
  String get blockPushNotifications => 'Notificações push';

  @override
  String get blockMentionsReplies => 'Menções e respostas';

  @override
  String get blockDeliveredToDevices => 'Entregue nos seus dispositivos';

  @override
  String blockEmailChannel(Object? channel) => 'E-mail · $channel';

  @override
  String blockPushChannel(Object? channel) => 'Push · $channel';

  @override
  String get blockQuietHours => 'Horário silencioso';

  @override
  String get blockWeeklyDigest => 'Resumo semanal';

  @override
  String get blockWeeklyDigestBlurb =>
      'Um e-mail toda segunda-feira com tudo o que aconteceu.';

  @override
  String get blockPreferencesSaved => 'Preferências salvas.';

  @override
  String get blockSavePreferences => 'Salvar preferências';

  @override
  String get blockReset => 'Redefinir';

  @override
  String get blockWelcomeAboard => 'Bem-vindo a bordo';

  @override
  String get blockQuickTour => 'Um tour rápido antes de começar a usar o app.';

  @override
  String get blockStayInLoop => 'Fique por dentro';

  @override
  String get blockMessagesArriveMoment =>
      'Mensagens e novidades chegam no momento em que acontecem.';

  @override
  String get blockNeverMissThing => 'Não perca nada';

  @override
  String get blockNotifPermissionBlurb =>
      'Enviamos apenas o importante: respostas, lembretes e alertas de segurança. Você pode alterar depois.';

  @override
  String get blockEnableNotifications => 'Ativar notificações?';

  @override
  String get blockAllowNotifications => 'Permitir notificações';

  @override
  String get blockAllowNotificationsBlurb =>
      'Permita notificações para aproveitar ao máximo o app.';

  @override
  String get blockNotNow => 'Agora não';

  @override
  String get blockSkip => 'Pular';

  @override
  String get blockGetStarted => 'Começar';

  @override
  String get blockMessages => 'Mensagens';

  @override
  String get blockNoConversations => 'Sem conversas';

  @override
  String get blockPullRefreshChat =>
      'Puxe para atualizar ou inicie uma nova conversa.';

  @override
  String get blockMute => 'Silenciar';

  @override
  String get blockMuted => 'Silenciado';

  @override
  String get blockAttach => 'Anexar';

  @override
  String get blockAttachFile => 'Arquivo';

  @override
  String get blockAttachPhoto => 'Foto';

  @override
  String get blockWriteMessage => 'Escreva uma mensagem…';

  @override
  String get blockYourCart => 'Seu carrinho';

  @override
  String get blockAddSomethingFirst => 'Adicione primeiro algo de que goste.';

  @override
  String get blockCartEmpty => 'Carrinho vazio';

  @override
  String get blockCheckout => 'Finalizar compra';

  @override
  String blockQty(int quantity) => 'Qtd. $quantity';

  @override
  String blockPayTotal(Object? amount) => 'Pagar $amount';

  @override
  String get blockPayment => 'Pagamento';

  @override
  String get blockCardNumber => 'Número do cartão';

  @override
  String get blockExpiry => 'Validade';

  @override
  String get blockCvc => 'CVC';

  @override
  String get blockDeliveryAddress => 'Endereço de entrega';

  @override
  String get blockStreet => 'Rua';

  @override
  String get blockCity => 'Cidade';

  @override
  String get blockSaveAndContinue => 'Salvar e continuar';

  @override
  String get blockOrderPlaced => 'Pedido feito';

  @override
  String get blockOrderThanks =>
      'Obrigado por comprar conosco. Uma confirmação está a caminho.';

  @override
  String get blockContinueShopping => 'Continuar comprando';

  @override
  String get blockSchedule => 'Agenda';

  @override
  String get blockPickDateRangeReport =>
      'Escolha um intervalo de datas para seu relatório.';

  @override
  String get blockPickDateRange => 'Escolher intervalo de datas';

  @override
  String get blockTapAnotherDay =>
      'toque em outro dia para estender o intervalo';

  @override
  String get blockBookMeeting => 'Agendar reunião';

  @override
  String get blockPickDayTime => 'Escolha um dia e depois um horário adequado.';

  @override
  String get blockFourSlots =>
      'Restam quatro horários de 30 minutos. Escolha um.';

  @override
  String blockPickedSlot(Object? slot) => '$slot escolhido, 30 minutos.';

  @override
  String get blockOverview => 'Visão geral';

  @override
  String get blockRevenueOrdersBlurb =>
      'Receita, assinaturas e os pedidos mais recentes.';

  @override
  String get blockTotalRevenue => 'Receita total';

  @override
  String get blockSubscriptions => 'Assinaturas';

  @override
  String get blockSales => 'Vendas';

  @override
  String get blockRevenueByMonth => 'Receita por mês';

  @override
  String get blockRecentSales => 'Vendas recentes';

  @override
  String get blockViewAll => 'Ver tudo';

  @override
  String get blockTransactions => 'Transações';

  @override
  String get blockFilterTransactions => 'Filtrar transações';

  @override
  String get blockCustomer => 'Cliente';

  @override
  String get blockAmount => 'Valor';

  @override
  String get blockMethod => 'Método';

  @override
  String get blockStatus => 'Status';

  @override
  String get blockPaid => 'Pago';

  @override
  String get blockPending => 'Pendente';

  @override
  String get blockRefunded => 'Reembolsado';

  @override
  String blockNoTransactions(Object? query) =>
      'Nenhuma transação corresponde a "$query".';

  @override
  String blockDeltaFromLastMonth(Object? delta) =>
      '$delta em relação ao mês passado';

  @override
  String get blockAnalytics => 'Análises';

  @override
  String get blockSessionsDevicesBlurb =>
      'Sessões, dispositivos e origem do tráfego.';

  @override
  String get blockSearchReports => 'Pesquisar relatórios';

  @override
  String get blockLast30Days => 'Últimos 30 dias';

  @override
  String get blockAllDevices => 'Todos os dispositivos';

  @override
  String get blockSessions => 'Sessões';

  @override
  String get blockUsers => 'Usuários';

  @override
  String get blockAvgSession => 'Sessão méd.';

  @override
  String get blockBounceRate => 'Taxa de rejeição';

  @override
  String get blockConversions => 'Conversões';

  @override
  String get blockByDevice => 'Por dispositivo';

  @override
  String get blockDesktop => 'Computador';

  @override
  String get blockMobile => 'Celular';

  @override
  String get blockTablet => 'Tablet';

  @override
  String get blockDirect => 'Direto';

  @override
  String get blockReferral => 'Indicação';

  @override
  String get blockSocial => 'Social';

  @override
  String get blockTrafficSources => 'Fontes de tráfego';

  @override
  String get blockVisitors => 'Visitantes';

  @override
  String get blockHome => 'Início';

  @override
  String get blockInbox => 'Caixa de entrada';

  @override
  String get blockCalendar => 'Agenda';

  @override
  String get blockCompose => 'Escrever';

  @override
  String get blockMarkAllRead => 'Marcar tudo como lido';

  @override
  String get blockStarred => 'Com estrela';

  @override
  String get blockSnoozed => 'Adiados';

  @override
  String get blockUnread => 'Não lidos';

  @override
  String get blockDocuments => 'Documentos';

  @override
  String get blockReports => 'Relatórios';

  @override
  String get blockDashboard => 'Painel';

  @override
  String get blockStorage => 'Armazenamento';

  @override
  String get blockNavigation => 'Navegação';

  @override
  String get blockSharedWithYou => 'Compartilhado com você';

  @override
  String get blockRecentProjects => 'Projetos recentes';

  @override
  String get blockStorageUsed => 'Armazenamento usado';

  @override
  String get blockOpen => 'Abrir';

  @override
  String get blockLive => 'Ao vivo';

  @override
  String get blockMembers => 'Membros';

  @override
  String get blockProjects => 'Projetos';

  @override
  String get blockDeploys => 'Implantações';

  @override
  String get blockActivity => 'Atividade';

  @override
  String get blockRecentFiles => 'Arquivos recentes';

  @override
  String get blockUsageThisMonth => 'Uso este mês';

  @override
  String get blockUpgradePlan => 'Atualizar plano';

  @override
  String blockNoMatches(Object? query) => 'Sem resultados para "$query".';

  @override
  String get blockWorkspaces => 'Espaços de trabalho';

  @override
  String get blockPricing => 'Preços';

  @override
  String get blockPlansScale => 'Planos que crescem com você';

  @override
  String get blockPlansBlurb =>
      'Comece grátis e atualize quando sua equipe crescer. Cada plano inclui a biblioteca completa de componentes e os ajustes de tema.';

  @override
  String get blockPerUserMonth => 'por usuário / mês';

  @override
  String get blockSubscribe => 'Assinar';

  @override
  String get blockContactSales => 'Falar com vendas';

  @override
  String get blockPromoCode => 'Código promocional';

  @override
  String get blockApplyCode => 'Aplicar código';

  @override
  String get blockHaveCodeEnter => 'Tem um código? Digite abaixo.';

  @override
  String get blockCodeAppliedDiscount =>
      'Código aplicado — seu desconto aparece na finalização.';

  @override
  String get blockFaqTitle => 'Perguntas';

  @override
  String get blockFaqChangePlans => 'Posso trocar de plano depois?';

  @override
  String get blockFaqChangePlansAnswer =>
      'Sim. Upgrades valem na hora, downgrades no próximo ciclo.';

  @override
  String get blockFaqFreeTrial => 'Há uma avaliação gratuita?';

  @override
  String get blockFaqFreeTrialAnswer =>
      'Cada plano começa com 14 dias, sem cartão.';

  @override
  String get blockAccount => 'Conta';

  @override
  String get blockGeneral => 'Geral';

  @override
  String get blockAppearance => 'Aparência';

  @override
  String get blockDarkMode => 'Modo escuro';

  @override
  String get blockPreferences => 'Preferências';

  @override
  String get blockSignOut => 'Sair';

  @override
  String get blockSignOutConfirm => 'Sair?';

  @override
  String get blockSignOutBlurb => 'Você pode entrar novamente mais tarde.';

  @override
  String get blockSounds => 'Sons';

  @override
  String get blockWhatYouGet => 'O que você recebe';

  @override
  String get blockAllComponentCategories =>
      'Todas as categorias de componentes';

  @override
  String get blockPrioritySupport => 'Suporte prioritário';

  @override
  String get blockUnlimitedProjectsTrial =>
      'Projetos ilimitados durante a avaliação';

  @override
  String get blockTrialDaysLeft => 'Faltam 14 dias de avaliação';

  @override
  String get blockStarterChat => 'Conversa';

  @override
  String get blockStarterShop => 'Loja';

  @override
  String get blockStarterCart => 'Carrinho';

  @override
  String get blockAddToCart => 'Adicionar ao carrinho';
}
