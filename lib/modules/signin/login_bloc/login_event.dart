// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginEvent {}
//! Event 1
class LoginTextChangedEvent extends LoginEvent {
  late String usernameValue;
  late String passwordValue;
  LoginTextChangedEvent({
    required this.usernameValue,
    required this.passwordValue,
  });
}
//! Event 2
class LoginFormSubmitEvent extends LoginEvent {
  late String usernameData;
  late String passwordData;
  LoginFormSubmitEvent({
    required this.usernameData,
    required this.passwordData,
  });
}
