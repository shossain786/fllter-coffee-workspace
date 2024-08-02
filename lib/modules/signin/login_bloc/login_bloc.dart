import 'package:filtercoffee/modules/signin/login_bloc/login_event.dart';
import 'package:filtercoffee/modules/signin/login_bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String currentUsername = "ankit@demo.com";
  String currentPassword = "Ankit@12@34@56";
  LoginBloc() : super(LoginInitial()) {
    //! Map Event 1 with States according to logic
    on<LoginTextChangedEvent>((event, emit) {
      if (event.usernameValue.isEmpty && event.passwordValue.isEmpty) {
        emit(LoginFormInValidState(
            usernameError: "Please Enter Username",
            passwordError: "Please Enter Password"));
      } else if (event.usernameValue.isNotEmpty &&
          event.passwordValue.isEmpty) {
        emit(LoginFormInValidState(
            usernameError: null, passwordError: "Please Enter Password"));
      } else if (event.usernameValue.isEmpty &&
          event.passwordValue.isNotEmpty) {
        emit(LoginFormInValidState(
            usernameError: "Please Enter Username", passwordError: null));
      } else {
        emit(LoginFormValidState());
      }
    });
//! Map Event 2 with States according to logic
    on<LoginFormSubmitEvent>((event, emit) {
      if ((event.usernameData.trim() != currentUsername.trim()) &&
          (event.passwordData.trim() != currentPassword.trim())) {
        emit(LoginFormFailedState(
            usernameErrorMessage: "Please Enter Correct Username",
            passwordErrorMessage: "Please Enter Correct Password"));
      } else if ((event.usernameData.trim() == currentUsername.trim()) &&
          (event.passwordData.trim() != currentPassword.trim())) {
        emit(LoginFormFailedState(
            usernameErrorMessage: null,
            passwordErrorMessage: "Please Enter Correct Password"));
      } else if ((event.usernameData.trim() != currentUsername.trim()) &&
          (event.passwordData.trim() == currentPassword.trim())) {
        emit(LoginFormFailedState(
            usernameErrorMessage: "Please Enter Correct Username",
            passwordErrorMessage: null));
      } else {
        emit(LoginFormSuccessState(successMessage: "Login Sucessfull"));
      }
    });
  }
}
