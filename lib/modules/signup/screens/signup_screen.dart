// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, use_build_context_synchronously

import 'package:filtercoffee/global/blocs/internet/internet_cubit.dart';
import 'package:filtercoffee/global/blocs/internet/internet_state.dart';
import 'package:filtercoffee/global/widgets/auto_click_button_widget.dart';
import 'package:filtercoffee/global/widgets/custom_app_bar.dart';
import 'package:filtercoffee/global/widgets/form_widgets.dart';
import 'package:filtercoffee/global/widgets/toast_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../register_bloc/register_bloc.dart';
import '../register_bloc/register_event.dart';
import '../register_bloc/register_state.dart';

class SignUpScreen extends StatelessWidget {
  late Map<String, dynamic> arguments;
  SignUpScreen({
    super.key,
    required this.arguments,
  });
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      bloc: InternetCubit(),
      listener: (context, state) {
        if (state == InternetState.internetLost) {
          Navigator.pushReplacementNamed(context, '/network-error-screen');
        }
      },
      child: Scaffold(
        appBar: CustomAppBarWidget.customAppBar(arguments: arguments),
        body: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return Center(
              child: Form(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  (state is RegisterFormSuccessState)
                      ? AutoClickButtonWidget.automaticTaskWorker(
                          taskWaitDuration: Durations.medium3,
                          task: () async {
                            ToastNotificationWidget.sucessNotification(
                                context: context,
                                title: null,
                                description: state.successMessage);
                            Navigator.pushReplacementNamed(
                                context, '/login-screen',
                                arguments: {'title': "Login Screen"});
                          },
                          context: context)
                      : Container(),
                  (state is RegisterFormFailedState)
                      ? AutoClickButtonWidget.automaticTaskWorker(
                          taskWaitDuration: Durations.medium3,
                          task: () {
                            ToastNotificationWidget.failedNotification(
                                context: context,
                                title: null,
                                description: state.errorMessage);
                            Navigator.pushReplacementNamed(
                                context, '/Register-screen');
                          },
                          context: context)
                      : Container(),
                  //! Username or Email
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: FormWidgets.buildTextFormField(
                      context,
                      controller: usernameController,
                      onChanged: () {
                        BlocProvider.of<RegisterBloc>(context).add(
                            RegisterTextChangedEvent(
                                usernameValue: usernameController.text,
                                passwordValue: passwordController.text));
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9@.]'))
                      ],
                      errorText: (state is RegisterFormInvalidState)
                          ? state.usernameError
                          : null,
                      labelText: "Username/E-Mail",
                      helperText:
                          "Please Enter data in 'xxxxyew@fe.com' format",
                      hintText: "xxxxyew@fe.com",
                    ),
                  ),

                  //! Password
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: FormWidgets.buildTextFormField(context,
                        controller: passwordController, onChanged: () {
                      BlocProvider.of<RegisterBloc>(context).add(
                          RegisterTextChangedEvent(
                              usernameValue: usernameController.text,
                              passwordValue: passwordController.text));
                    },
                        obscureText: (state is ToggleChangeRegisterStatus)
                            ? state.successMessage
                            : hidePassword,
                        obscuringCharacter: '*',
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9@]'))
                        ],
                        errorText: (state is RegisterFormInvalidState)
                            ? state.passwordError
                            : null,
                        labelText: "Password",
                        hintText: "hjhs@123",
                        suffixIcon: InkWell(
                            onTap: () {
                              BlocProvider.of<RegisterBloc>(context).add(
                                  TogglePasswordRegisterEvent(
                                      passwordStatus:
                                          (state is ToggleChangeRegisterStatus)
                                              ? state.successMessage
                                              : hidePassword));
                            },
                            child: Icon((((state is ToggleChangeRegisterStatus)
                                        ? state.successMessage
                                        : hidePassword) ==
                                    true)
                                ? Icons.visibility
                                : Icons.visibility_off))),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<RegisterBloc>(context).add(
                            RegisterFormSubmitEvent(
                                usernameData: usernameController.text,
                                passwordData: passwordController.text));
                      },
                      child: Container(
                        height: 50,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [Colors.green, Colors.blue])),
                        child: const Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.deepPurple,
                          textStyle: const TextStyle(fontSize: 14)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/login-screen',
                            arguments: {'title': "Login Screen"});
                      },
                      child: const Text("Login Here"))
                ],
              )),
            );
          },
        ),
      ),
    );
  }
}
