// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:filtercoffee/modules/dashboard/model/country_response_model.dart';

class DashboardState {}

final class DashboardInitial extends DashboardState {}

//! States mapped for 'FetchCountryListEvent'

class CountryLoadingState extends DashboardState {}

class CountryLoadingSuccessState extends DashboardState {
  late String? successMessage;
  late List<CountryListResponseData>? countryListData;
  CountryLoadingSuccessState({
    this.successMessage,
    this.countryListData,
  });
}

class CountryLoadingFailedState extends DashboardState {
  late String? errorMessage;
  CountryLoadingFailedState({
    required this.errorMessage,
  });
}
