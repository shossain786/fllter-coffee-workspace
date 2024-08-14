// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, use_build_context_synchronously

import 'package:filtercoffee/global/blocs/internet/internet_cubit.dart';
import 'package:filtercoffee/global/blocs/internet/internet_state.dart';
import 'package:filtercoffee/global/widgets/auto_click_button_widget.dart';
import 'package:filtercoffee/global/widgets/toast_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../register_bloc/register_bloc.dart';
import '../register_bloc/register_event.dart';
import '../register_bloc/register_state.dart';

class SignUpScreen extends StatefulWidget {
  late Map<String, dynamic> arguments;
  SignUpScreen({
    super.key,
    required this.arguments,
  });

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
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
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          foregroundColor: Colors.white,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.deepPurple],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight)),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(widget.arguments.containsKey("title")
              ? widget.arguments['title']
              : ''),
          centerTitle: true,
        ),
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
                    child: TextFormField(
                      onChanged: (value) {
                        BlocProvider.of<RegisterBloc>(context).add(
                            RegisterTextChangedEvent(
                                usernameValue: usernameController.text,
                                passwordValue: passwordController.text));
                      },
                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9@.]'))
                      ],
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_add_alt_sharp),
                          prefixIconColor: Colors.green,
                          labelText: "Username/E-Mail",
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                          helperText:
                              "Please Enter data in 'xxxxyew@fe.com' format",
                          helperStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 10),
                          hintText: "xxxxyew@fe.com",
                          hintStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 10),
                          errorText: (state is RegisterFormInvalidState)
                              ? state.usernameError
                              : null,
                          errorStyle: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w300,
                              fontSize: 10),
                          errorBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2)),
                          disabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2)),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2))),
                    ),
                  ),
                  //! Password
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: TextFormField(
                      onChanged: (value) {
                        BlocProvider.of<RegisterBloc>(context).add(
                            RegisterTextChangedEvent(
                                usernameValue: usernameController.text,
                                passwordValue: passwordController.text));
                      },
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: hidePassword,
                      obscuringCharacter: '*',
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9@]'))
                      ],
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password),
                          prefixIconColor: Colors.green,
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              child: Icon((hidePassword == true)
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          suffixIconColor: Colors.green,
                          labelText: "Password",
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                          hintText: "xxxxyew",
                          hintStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 10),
                          errorText: (state is RegisterFormInvalidState)
                              ? state.passwordError
                              : null,
                          errorStyle: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w300,
                              fontSize: 10),
                          errorBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2)),
                          disabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2)),
                          border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2))),
                    ),
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