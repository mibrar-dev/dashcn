// Shared control chrome for [ComponentLocalizations]: announcements,
// toolbar overflow, tree toggles, carousels, steppers, pagination, charts,
// auth/block actions and markdown fallbacks.

/// Shared control chrome for [ComponentLocalizations].
///
/// Applied by `ComponentLocalizations`; every getter has an English default and
/// translated locale tables may override it. Blocks reuse these keys for their
/// buttons and field labels; the wider blocks/flows/starters chrome lives in
/// `ComponentLocalizationsBlocks`, and only demo data (names, messages,
/// amounts, timestamps) stays English sample content.
mixin ComponentLocalizationsChrome {
  /// Screen-reader announcement of a loading status.
  String get announcementLoading => 'Loading';

  /// Screen-reader announcement of a success status.
  String get announcementSuccess => 'Success';

  /// Screen-reader announcement of a failure status.
  String get announcementFailure => 'Failure';

  /// Label of a `toolbar` overflow trigger.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  /// Override per instance with `Toolbar.overflowLabel`.
  String get toolbarMore => 'More';

  /// Semantics label of a `toolbar` overflow trigger.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  /// Override per instance with `Toolbar.overflowSemanticLabel`.
  String get toolbarMoreActions => 'More actions';

  /// Semantics label of an expanded tree toggle.
  String get treeCollapse => 'Collapse';

  /// Semantics label of a collapsed tree toggle.
  String get treeExpand => 'Expand';

  /// Default summary of a markdown `<details>` block without one.
  String get markdownDetails => 'Details';

  /// Semantics label of a `feature_carousel` region.
  String get carouselLabel => 'Feature carousel';

  /// Default call-to-action label of a `feature_carousel` card.
  ///
  /// Override per instance with `FeatureCarouselTheme.primaryActionLabel`.
  String get carouselPrimaryAction => 'Add to chat';

  /// Semantics label of a `feature_carousel` card for [title].
  String carouselItemPreview(Object? title) =>
      'Feature preview: ${title ?? 'Untitled'}';

  /// Screen-reader position of a carousel or dot indicator page.
  String carouselPageOf(int position, int length) =>
      'Page $position of $length';

  /// Semantics label of a stepper step at [index] (zero-based).
  String stepperStep(int index) => 'Step ${index + 1}';

  /// Semantics label of a pagination item jumping to [page].
  String paginationPage(Object? page) => 'Page $page';

  /// Fallback legend/tooltip label of chart series [index] (zero-based).
  String chartSeriesDefault(int index) => 'Series ${index + 1}';

  /// Fallback legend/tooltip label when a chart row exposes no label.
  String get chartValueDefault => 'Value';

  /// Label of a chart tooltip total row.
  ///
  /// No Flutter ARB equivalent exists, so this is the English fallback only.
  /// Override per instance with `ChartTooltipConfig.totalLabel`.
  String get chartTotalLabel => 'Total';

  /// Fallback legend label of pie/donut slice [index] (zero-based).
  String chartSliceDefault(int index) => 'Slice $index';

  /// Fallback axis label of category [index].
  String chartCategoryDefault(int index) => 'Category $index';

  /// Chart-kind word used by the chart semantics summary.
  String get chartKindLine => 'Line';

  /// Chart-kind word used by the chart semantics summary.
  String get chartKindArea => 'Area';

  /// Chart-kind word used by the chart semantics summary.
  String get chartKindBar => 'Bar';

  /// Chart-kind word used by the chart semantics summary.
  String get chartKindDonut => 'Donut';

  /// Chart-kind word used by the chart semantics summary.
  String get chartKindPie => 'Pie';

  /// Chart-kind word used by the chart semantics summary.
  String get chartKindSparkline => 'Sparkline';

  /// Chart-kind word used by the chart semantics summary.
  String get chartKindScatter => 'Scatter';

  /// Chart-kind word used by the chart semantics summary.
  String get chartKindRadar => 'Radar';

  /// Chart-kind word used by the chart semantics summary.
  String get chartKindRadial => 'Radial';

  /// Semantics summary of a chart with no data, of kind [kind].
  String chartSummaryEmpty(Object? kind) => '$kind chart with no data';

  /// Semantics summary of a chart of kind [kind] with [series] series and
  /// [points] points.
  String chartSummary(int series, int points, Object? kind) =>
      '$kind chart with $series series, $points points';

  /// Semantics label of an HSV `color_field` region.
  String get colorFieldHsv => 'HSV color field';

  /// Semantics label of an HSL `color_field` region.
  String get colorFieldHsl => 'HSL color field';

  /// Label of a clear action (e.g. calendar-01).
  String get actionClear => 'Clear';

  /// Label of an apply/confirm action (e.g. calendar-01).
  String get actionApply => 'Apply';

  /// Label of a verify action (e.g. otp-01).
  String get actionVerify => 'Verify';

  /// Label of a resend action (e.g. otp-01).
  String get actionResend => 'Resend';

  /// Countdown label of a resend action with [seconds] left (e.g. otp-01).
  String resendInSeconds(int seconds) => 'Resend in ${seconds}s';

  /// Field label of a one-time code field (e.g. otp-01).
  String get authCode => 'Code';

  /// Field label of an email field (e.g. login-01).
  String get authEmail => 'Email';

  /// Field label of a password field (e.g. login-01).
  String get authPassword => 'Password';

  /// Field label of a name field (e.g. signup-01).
  String get authName => 'Name';

  /// Label of a sign-in action (e.g. login-01).
  String get authSignIn => 'Sign in';

  /// Label of a forgot-password action (e.g. login-01).
  String get authForgotPassword => 'Forgot password?';

  /// Label of a remember-me control (e.g. login-01).
  String get authRememberMe => 'Remember me';

  /// Title of a create-account screen (e.g. signup-01).
  String get authCreateAccount => 'Create an account';

  /// Label of a close control (e.g. image_lightbox).
  String get actionClose => 'Close';

  /// Label of a start-trial action (e.g. signup-02).
  String get actionStartTrial => 'Start free trial';

  /// Field label of a first-name field (e.g. signup-02).
  String get authFirstName => 'First name';

  /// Field label of a last-name field (e.g. signup-02).
  String get authLastName => 'Last name';

  /// Field label of a work-email field (e.g. signup-02).
  String get authWorkEmail => 'Work email';

  /// Hint of a password field describing the minimum length (e.g. signup-01).
  String get authPasswordHint => 'At least 8 characters.';

  /// Label of a use-a-different-email action (e.g. otp-01).
  String get authUseDifferentEmail => 'Use a different email';
}
