// ignore_for_file: must_be_immutable

import 'package:filtercoffee/global/blocs/internet/internet_cubit.dart';
import 'package:filtercoffee/global/blocs/internet/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  late Map<String, dynamic> arguments;
  DashboardScreen({
    super.key,
    required this.arguments,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
          title: const Text("Dashboard Screen"),
          centerTitle: true,
        ),
        body: Center(
          child: Text("Dashboard Screen"),
        ),
      ),
    );
  }
}
