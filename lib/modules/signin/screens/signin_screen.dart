// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

StreamController usernameStreamController = StreamController(); // Single Stream Controller
StreamController passwordStreamController = StreamController(); // Single Stream Controller

class SignInScreen extends StatefulWidget {
  late Map<String, dynamic> arguments;
  SignInScreen({
    super.key,
    required this.arguments,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text("Login Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            //! Username or Email
            StreamBuilder<dynamic>(
              stream: usernameStreamController.stream,
              builder: (context, snapshot) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    onChanged:(value) {
                      if (usernameController.text.isEmpty) {
                        usernameStreamController.addError("Please Enter Username");
                      } else if (usernameController.text.length>14) {
                        usernameStreamController.addError("Please Enter Username below 14 characters");
                      }else{
                        usernameStreamController.add('');
                      }
                    },
                    controller: usernameController,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))
                    ],
                    decoration:  InputDecoration(
                        prefixIcon: const Icon(Icons.person_add_alt_sharp),
                        prefixIconColor: Colors.green,
                        labelText: "Username/E-Mail",
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                        helperText: "Please Enter data in 'xxxxyew@fe.com' format",
                        helperStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 10),
                        hintText: "xxxxyew@fe.com",
                        hintStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 10),
                        errorText: (snapshot.hasError)?snapshot.error.toString():null,
                        errorStyle: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w300,
                            fontSize: 10),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2)),
                        disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2)),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2))),
                  ),
                );
              }
            ),
            //! Password
            StreamBuilder<dynamic>(
              stream: passwordStreamController.stream,
              builder: (context, snapshot) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextFormField(
                    onChanged:(value) {
                      if (passwordController.text.isEmpty) {
                        passwordStreamController.addError("Please Enter Password");
                      } else if (passwordController.text.length>14) {
                        passwordStreamController.addError("Please Enter Password below 14 characters");
                      }else{
                        passwordStreamController.add('');
                      }
                    },
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: hidePassword,
                    obscuringCharacter: '*',
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))
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
                        errorText: (snapshot.hasError)?snapshot.error.toString():null,
                        errorStyle: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w300,
                            fontSize: 10),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2)),
                        disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2)),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2))),
                  ),
                );
              }
            ),
          ],
        )),
      ),
    );
  }
}
