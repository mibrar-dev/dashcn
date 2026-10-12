---
title: "Mixin: ComponentLocalizationsError"
description: "Error text for [ComponentLocalizations]."
---

```dart
/// Error text for [ComponentLocalizations].
///
/// Applied by `ComponentLocalizations`; every getter has an English default and
/// translated locale tables may override it.
mixin ComponentLocalizationsError {
  /// Default title of an error with no more specific mapping.
  String get errorSomethingWentWrong;
  /// Default message of an error with no more specific mapping.
  String get errorUnexpectedMessage;
  /// Label of a retry action.
  String get errorActionRetry;
  /// Label of a report action.
  String get errorActionReport;
  /// Label of a navigate-back action.
  String get errorActionBack;
  /// Label of a log-in action.
  String get errorActionLogin;
  /// Label of an open-settings action.
  String get errorActionSettings;
  /// Label of a contact-support action.
  String get errorActionContactSupport;
  /// Title for HTTP 400.
  String get errorBadRequest;
  /// Message for HTTP 400.
  String get errorBadRequestMessage;
  /// Title for HTTP 401.
  String get errorUnauthorized;
  /// Message for HTTP 401 and for auth failures.
  String get errorLoginRequiredMessage;
  /// Title for HTTP 403.
  String get errorAccessDenied;
  /// Message for HTTP 403.
  String get errorAccessDeniedMessage;
  /// Title for HTTP 404.
  String get errorNotFound;
  /// Message for HTTP 404.
  String get errorNotFoundMessage;
  /// Title for HTTP 409.
  String get errorConflict;
  /// Message for HTTP 409.
  String get errorConflictMessage;
  /// Title for HTTP 422.
  String get errorInvalidData;
  /// Message for HTTP 422.
  String get errorInvalidDataMessage;
  /// Title for HTTP 429.
  String get errorTooManyRequests;
  /// Message for HTTP 429.
  String get errorTooManyRequestsMessage;
  /// Title for HTTP 5xx and other server failures.
  String get errorServerError;
  /// Message for HTTP 5xx and other server failures.
  String get errorServerErrorMessage;
  /// Title of a timed-out request.
  String get errorRequestTimedOut;
  /// Message of a timed-out request.
  String get errorRequestTimedOutMessage;
  /// Title of an authentication failure.
  String get errorAuthenticationRequired;
  /// Title of a validation failure.
  String get errorInvalidInput;
  /// Message of a validation failure.
  String get errorReviewFieldsMessage;
  /// Title of a platform-channel failure.
  String get errorPlatformError;
  /// Message of a platform-channel failure.
  String get errorDeviceErrorMessage;
  /// Title of a connection failure.
  String get errorConnectionFailed;
  /// Message of a connection failure.
  String get errorConnectionFailedMessage;
  /// Title of a secure-connection failure.
  String get errorSecureConnectionFailed;
  /// Message of a secure-connection failure.
  String get errorSecureConnectionMessage;
}
```
