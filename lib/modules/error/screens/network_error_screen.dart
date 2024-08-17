// ignore_for_file: must_be_immutable

import 'package:filtercoffee/global/blocs/internet/internet_cubit.dart';
import 'package:filtercoffee/global/blocs/internet/internet_state.dart';
import 'package:filtercoffee/modules/error/widgets/network_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NetworkErrorScreen extends StatefulWidget {
  late Map<String, dynamic> arguments;
  NetworkErrorScreen({
    super.key,
    required this.arguments,
  });

  @override
  State<NetworkErrorScreen> createState() => _NetworkErrorScreenState();
}

class _NetworkErrorScreenState extends State<NetworkErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      bloc: InternetCubit(),
      listener: (context, state) {
        if (state == InternetState.internetAvailable) {
          Navigator.pushReplacementNamed(context, '/');
        }
      },
      child: const Scaffold(
        body: Center(
          child: NetworkErrorWidget(),
        ),
      ),
    );
  }
}
