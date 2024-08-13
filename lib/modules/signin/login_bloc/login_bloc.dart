import 'package:filtercoffee/global/utils/database_helper.dart';
import 'package:filtercoffee/global/utils/logger_util.dart';
import 'package:filtercoffee/modules/signin/login_bloc/login_event.dart';
import 'package:filtercoffee/modules/signin/login_bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/utils/shared_preferences_helper.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SessionHelper sp = SessionHelper();
  final DatabaseHelper db = DatabaseHelper();

  LoginBloc() : super(LoginInitial()) {
    //! Map Event 1 with States according to logic
    on<LoginTextChangedEvent>(_onTextChangedEvent);
    //! Map Event 2 with States according to logic
    on<LoginFormSubmitEvent>(_loginProcess);
  }

  void _onTextChangedEvent(
      LoginTextChangedEvent event, Emitter<LoginState> emit) {
    if (event.usernameValue.isEmpty && event.passwordValue.isEmpty) {
      emit(LoginFormInValidState(
          usernameError: "Please Enter Username",
          passwordError: "Please Enter Password"));
    } else if (event.usernameValue.isNotEmpty && event.passwordValue.isEmpty) {
      emit(LoginFormInValidState(
          usernameError: null, passwordError: "Please Enter Password"));
    } else if (event.usernameValue.isEmpty && event.passwordValue.isNotEmpty) {
      emit(LoginFormInValidState(
          usernameError: "Please Enter Username", passwordError: null));
    } else {
      emit(LoginFormValidState());
    }
  }

  Future<void> _loginProcess(
      LoginFormSubmitEvent event, Emitter<LoginState> emit) async {
    try {
      final List<Map<String, dynamic>>? result = await db.queryRowByClause(
        "UserCredData",
        "username=? and password=?",
        [event.usernameData, event.passwordData],
      );

      if (result != null && result.isNotEmpty) {
        LoggerUtil().errorData("Data already exists, please login");
        sp.setBool("isLoggedIn", true);
        emit(LoginFormSuccessState(
            successMessage: "Data already exists, please login."));
      } else {
        LoggerUtil().errorData("Data not available");
        emit(LoginFormFailedState(
            usernameErrorMessage: "Data not available",
            passwordErrorMessage: "Data not available"));
      }
    } catch (e) {
      LoggerUtil().errorData("An error occurred: $e");
      emit(LoginFormFailedState(
          usernameErrorMessage: "An error occurred",
          passwordErrorMessage: "An error occurred"));
    }
  }
}
