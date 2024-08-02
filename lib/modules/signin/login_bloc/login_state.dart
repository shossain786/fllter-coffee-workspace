// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginState {}

final class LoginInitial extends LoginState {}

//! States For Event 1

class LoginFormValidState extends LoginState {}

class LoginFormInValidState extends LoginState {
  late String? usernameError;
  late String? passwordError;
  LoginFormInValidState({
    this.usernameError,
    this.passwordError,
  });
}

//! States For Event 2

class LoginFormLoadingState extends LoginState {}

class LoginFormSuccessState extends LoginState {
  late String? successMessage;
  LoginFormSuccessState({
    this.successMessage,
  });
}

class LoginFormFailedState extends LoginState {
  late String? usernameErrorMessage;
  late String? passwordErrorMessage;
  LoginFormFailedState({
    this.usernameErrorMessage,
    this.passwordErrorMessage,
  });
  
}
