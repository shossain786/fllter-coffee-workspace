// ignore_for_file: must_be_immutable

import 'package:filtercoffee/global/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/blocs/internet/internet_cubit.dart';
import '../../../global/blocs/internet/internet_state.dart';

class AddCustomerScreen extends StatelessWidget {
   late Map<String, dynamic> arguments;
  AddCustomerScreen({
    super.key,
    required this.arguments,
  });

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
      ),
    );
  }
}