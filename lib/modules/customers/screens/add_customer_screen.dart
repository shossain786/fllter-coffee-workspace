// ignore_for_file: must_be_immutable

import 'package:filtercoffee/global/utils/logger_util.dart';
import 'package:filtercoffee/global/utils/utillity_section.dart';
import 'package:filtercoffee/global/widgets/custom_app_bar.dart';
import 'package:filtercoffee/global/widgets/form_widgets.dart';
import 'package:filtercoffee/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:filtercoffee/modules/dashboard/bloc/dashboard_event.dart';
import 'package:filtercoffee/modules/dashboard/bloc/dashboard_state.dart';
import 'package:filtercoffee/modules/dashboard/model/country_response_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/blocs/internet/internet_cubit.dart';
import '../../../global/blocs/internet/internet_state.dart';

class AddCustomerScreen extends StatefulWidget {
  late Map<String, dynamic> arguments;
  AddCustomerScreen({
    super.key,
    required this.arguments,
  });

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  TextEditingController customerNameController = TextEditingController();

  TextEditingController customerAgeController = TextEditingController();

  TextEditingController customerContactController = TextEditingController();

  String? gender;
  CountryListResponseData? selectedCountry;
  late DashboardBloc dashboardBloc;
  @override
  void initState() {
    fetchCountry();
    super.initState();
  }

  fetchCountry() {
    //! calls on page start
    dashboardBloc = DashboardBloc()..add(FetchCountryListEvent());
  }

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
        appBar: CustomAppBarWidget.customAppBar(arguments: widget.arguments),
        body: Container(
          margin: EdgeInsets.symmetric(
              horizontal: context.screenWidth * 0.1,
              vertical: context.screenHeight * 0.1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.05,
                      vertical: context.screenHeight * 0.01),
                  child: FormWidgets.buildTextFormField(context,
                      controller: customerNameController,
                      keyboardType: TextInputType.name,
                      onChanged: () {},
                      labelText: "Customer Name",
                      prefixIcon: const Icon(CupertinoIcons.person),
                      errorText: null),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.05,
                      vertical: context.screenHeight * 0.01),
                  child: FormWidgets.buildTextFormField(context,
                      controller: customerAgeController,
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                      ],
                      onChanged: () {},
                      labelText: "Customer Age",
                      prefixIcon: const Icon(CupertinoIcons.number),
                      errorText: null),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.05,
                      vertical: context.screenHeight * 0.01),
                  child: FormWidgets.buildTextFormField(context,
                      controller: customerContactController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      onChanged: () {},
                      labelText: "Customer Contact",
                      prefixIcon: const Icon(CupertinoIcons.phone),
                      errorText: null),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.05,
                      vertical: context.screenHeight * 0.01),
                  child: Row(
                    children: [
                      RadioMenuButton(
                        value: "1",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                          LoggerUtil().debugData("Gender :- $gender");
                        },
                        child: const Text(
                          "Male",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      RadioMenuButton(
                        value: "2",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                          LoggerUtil().debugData("Gender :- $gender");
                        },
                        child: const Text(
                          "Female",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      RadioMenuButton(
                        value: "3",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                          LoggerUtil().debugData("Gender :- $gender");
                        },
                        child: const Text(
                          "Other",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                BlocProvider(
                  create: (context) => dashboardBloc,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.screenWidth * 0.05,
                        vertical: context.screenHeight * 0.01),
                    child: BlocBuilder<DashboardBloc, DashboardState>(
                      builder: (context, state) {
                        if (state is CountryLoadingSuccessState) {
                          return DropdownButtonFormField(
                            items: state.countryListData
                                ?.map((c) => DropdownMenuItem(
                                      value: c,
                                      child: Text(c.name ?? ''),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              LoggerUtil()
                                  .errorData("Value :- ${value?.name ?? ''}");
                              setState(() {
                                selectedCountry = value;
                              });
                            },
                          );
                        } else {
                          return DropdownButtonFormField(
                            items: [],
                            onChanged: (value) {},
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
