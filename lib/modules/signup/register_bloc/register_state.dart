// ignore_for_file: public_member_api_docs

/// Base class for all Register states.
class RegisterState {}

/// Initial state of the registration process.
final class RegisterInitial extends RegisterState {}

/// State when the registration form is valid.
final class RegisterFormValidState extends RegisterState {}

/// State when the registration form is invalid.
final class RegisterFormInvalidState extends RegisterState {
  /// The error message for the username field, if any.
  final String? usernameError;

  /// The error message for the password field, if any.
  final String? passwordError;

  /// Constructs a [RegisterFormInvalidState] with optional error messages for [usernameError] and [passwordError].
  RegisterFormInvalidState({
    this.usernameError,
    this.passwordError,
  });
}

/// State when the registration form is in the loading state.
final class RegisterFormLoadingState extends RegisterState {}

/// State when the registration is successful.
final class RegisterFormSuccessState extends RegisterState {
  /// The success message to be displayed, if any.
  final String? successMessage;

  /// Constructs a [RegisterFormSuccessState] with an optional [successMessage].
  RegisterFormSuccessState({
    this.successMessage,
  });
}

/// State when the registration has failed.
final class RegisterFormFailedState extends RegisterState {
  /// The error message to be displayed, if any.
  final String? errorMessage;

  /// Constructs a [RegisterFormFailedState] with an optional [errorMessage].
  RegisterFormFailedState({
    this.errorMessage,
  });
}


class ToggleChangeRegisterStatus extends RegisterState {
  late bool successMessage;
  ToggleChangeRegisterStatus({
    required this.successMessage,
  });
}