// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:filtercoffee/modules/customers/widgets/add_costomer_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:filtercoffee/global/utils/logger_util.dart';
import 'package:filtercoffee/global/utils/utillity_section.dart';
import 'package:filtercoffee/global/widgets/custom_app_bar.dart';
import 'package:filtercoffee/modules/dashboard/bloc/dashboard_bloc.dart';
import 'package:filtercoffee/modules/dashboard/bloc/dashboard_event.dart';
import 'package:filtercoffee/modules/dashboard/bloc/dashboard_state.dart';
import 'package:filtercoffee/modules/dashboard/model/country_response_model.dart';

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
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController marriedController = TextEditingController();

  String? gender;
  String? married;
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
              horizontal: context.screenWidth * 0.01,
              vertical: context.screenHeight * 0.01),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextInputField(
                  context: context,
                  districtController: customerNameController,
                  icon: const Icon(CupertinoIcons.person),
                  keyboardType: TextInputType.name,
                  regExp: RegExp(r'[A-Za-z0-9 ]'),
                  labelText: 'Customer Name',
                  maxLength: 36,
                ),
                TextInputField(
                  context: context,
                  districtController: customerAgeController,
                  icon: const Icon(CupertinoIcons.number),
                  keyboardType: TextInputType.number,
                  regExp: RegExp(r'[0-9.]'),
                  labelText: 'Customer Age',
                  maxLength: 3,
                ),
                TextInputField(
                  context: context,
                  districtController: customerContactController,
                  icon: const Icon(CupertinoIcons.phone),
                  keyboardType: TextInputType.number,
                  regExp: RegExp(r'[0-9]'),
                  labelText: 'Customer Contact',
                  maxLength: 10,
                ),
                buildGenderRadioButtons(context),
                buildCountryDropdown(context),
                TextInputField(
                  context: context,
                  districtController: addressController,
                  icon: const Icon(CupertinoIcons.map_pin),
                  keyboardType: TextInputType.text,
                  regExp: RegExp(r'[A-Za-z0-9 ]'),
                  labelText: 'Address',
                  maxLength: 36,
                ),
                TextInputField(
                  context: context,
                  districtController: districtController,
                  icon: const Icon(Icons.map),
                  keyboardType: TextInputType.text,
                  regExp: RegExp(r'[A-Za-z0-9 ]'),
                  labelText: 'District',
                  maxLength: 36,
                ),
                TextInputField(
                  context: context,
                  districtController: pinCodeController,
                  icon: const Icon(CupertinoIcons.map_pin),
                  keyboardType: TextInputType.number,
                  regExp: RegExp(r'[0-9]'),
                  labelText: 'Pincode',
                  maxLength: 6,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * 0.05,
                      vertical: context.screenHeight * 0.01),
                  child: Row(
                    children: [
                      merriedRadioBtn("Married", "1"),
                      merriedRadioBtn("Unmarried", "2"),
                      merriedRadioBtn("Divorced", "3")
                    ],
                  ),
                ),
                Container(
                  width: context.screenWidth * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white24,
                      border: Border.all(
                        width: 2,
                      )),
                  child: InkWell(
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Submit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    onTap: () {
                      debugPrint('*********Submit button pressed*********');
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  RadioMenuButton<String> merriedRadioBtn(String label, String value) {
    return RadioMenuButton(
      value: value,
      groupValue: married,
      onChanged: (value) {
        setState(() {
          married = value;
        });
      },
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  BlocProvider<DashboardBloc> buildCountryDropdown(BuildContext context) {
    return BlocProvider(
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
                  LoggerUtil().errorData("Value :- ${value?.name ?? ''}");
                  setState(() {
                    selectedCountry = value;
                  });
                },
              );
            } else {
              return DropdownButtonFormField(
                items: const [],
                onChanged: (value) {},
              );
            }
          },
        ),
      ),
    );
  }

  Container buildGenderRadioButtons(BuildContext context) {
    return Container(
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
