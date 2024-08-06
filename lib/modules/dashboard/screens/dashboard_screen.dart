// ignore_for_file: must_be_immutable

import 'package:filtercoffee/global/blocs/internet/internet_cubit.dart';
import 'package:filtercoffee/global/blocs/internet/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../model/country_response_model.dart';

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
  final List<String> items = [];

  CountryListResponseData? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
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
  void dispose() {
    textEditingController.dispose();
    super.dispose();
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
        body: BlocProvider(
          create: (_) => dashboardBloc,
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              /*
                    return Center(
                      child: (state is CountryLoadingSuccessState)
                          ? DropdownButtonHideUnderline(
                              child: DropdownButton2<CountryListResponseData>(
                                isExpanded: true,
                                hint: Text(
                                  'Select Country',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: state.countryListData!
                                    .map((item) =>
                                        DropdownMenuItem<CountryListResponseData>(
                                          value: item,
                                          child: Text(
                                            item.name!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  height: 40,
                                  width: 200,
                                ),
                                dropdownStyleData: const DropdownStyleData(
                                  maxHeight: 200,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                                dropdownSearchData: DropdownSearchData(
                                  searchController: textEditingController,
                                  searchInnerWidgetHeight: 50,
                                  searchInnerWidget: Container(
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 4,
                                      right: 8,
                                      left: 8,
                                    ),
                                    child: TextFormField(
                                      expands: true,
                                      maxLines: null,
                                      controller: textEditingController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: 'Search for an item...',
                                        hintStyle: const TextStyle(fontSize: 12),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  searchMatchFn:
                                      (DropdownMenuItem<CountryListResponseData> item,
                                          searchValue) {
                                    return item.value!.name
                                        .toString()
                                        .toLowerCase()
                                        .trim()
                                        .contains(searchValue
                                            .toString()
                                            .toLowerCase()
                                            .trim());
                                  },
                                ),
                                //This to clear the search value when you close the menu
                                onMenuStateChange: (isOpen) {
                                  if (!isOpen) {
                                    textEditingController.clear();
                                  }
                                },
                              ),
                            )
                          : const Text("No Data Found"),
                    );
                  */
              if (state is CountryLoadingSuccessState) {
                return ListView.builder(
                  itemCount: state.countryListData!.length,
                  itemBuilder: (context, index) {
                    CountryListResponseData crd = state.countryListData![index];
                    return ListTile(
                      title: Text(crd.name!),
                    );
                  },
                );
              }
              if (state is CountryLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CountryLoadingFailedState) {
                return Center(
                  child: Text(state.errorMessage!),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
