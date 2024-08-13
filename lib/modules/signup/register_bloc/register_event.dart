// ignore_for_file: public_member_api_docs

/// Base class for all Register events.
class RegisterEvent {}

/// Event for when the text in the registration form changes.
class RegisterTextChangedEvent extends RegisterEvent {
  /// The current value of the username field.
  final String usernameValue;

  /// The current value of the password field.
  final String passwordValue;

  /// Constructs a [RegisterTextChangedEvent] with the given [usernameValue] and [passwordValue].
  RegisterTextChangedEvent({
    required this.usernameValue,
    required this.passwordValue,
  });
}

/// Event for when the registration form is submitted.
class RegisterFormSubmitEvent extends RegisterEvent {
  /// The value of the username field when the form is submitted.
  final String usernameData;

  /// The value of the password field when the form is submitted.
  final String passwordData;

  /// Constructs a [RegisterFormSubmitEvent] with the given [usernameData] and [passwordData].
  RegisterFormSubmitEvent({
    required this.usernameData,
    required this.passwordData,
  });
}
