// ignore_for_file: use_build_context_synchronously

import 'package:filtercoffee/global/blocs/internet/internet_cubit.dart';
import 'package:filtercoffee/global/blocs/internet/internet_state.dart';
import 'package:filtercoffee/modules/splash/widgets/splash_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      bloc: InternetCubit(),
      listener: (context, state) {
        if (state == InternetState.internetAvailable) {
          redirectPage(context);
        }
        if (state == InternetState.internetLost) {
          Navigator.pushReplacementNamed(context, '/network-error-screen');
        }
      },
      child: const Scaffold(
        body: Center(
          child: SplashContent(),
        ),
      ),
    );
  }

  Future<void> redirectPage(BuildContext context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.containsKey("isLoggedIn")) {
       Navigator.pushReplacementNamed(context, '/dashboard-screen');
    } else {
       Navigator.pushReplacementNamed(context, '/login-screen');
    }
  }
}
