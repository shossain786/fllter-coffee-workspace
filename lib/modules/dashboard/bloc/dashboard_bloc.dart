import 'package:filtercoffee/api_list.dart';
import 'package:filtercoffee/modules/dashboard/bloc/dashboard_event.dart';
import 'package:filtercoffee/modules/dashboard/bloc/dashboard_state.dart';
import 'package:filtercoffee/modules/dashboard/model/country_response_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<FetchCountryListEvent>(_fetchCountry);
  }
  _fetchCountry(
      FetchCountryListEvent event, Emitter<DashboardState> emit) async {
    var map = {};
    map['search'] = '';
    map['token'] = 'bnbuujn';
    try {
      http.Response response = await http.post(
        Uri.http(ApiList.mainDomain, ApiList.countryListUrl),
        body: map,
      );
      if (response.statusCode == 200) {
        CountryListResponseModel countryListResponseModel =
            CountryListResponseModel.fromJson(
                convert.jsonDecode(response.body));
        if (countryListResponseModel.countryListResponseData!.isNotEmpty) {
          emit(CountryLoadingSuccessState(
              successMessage: "Data fetched successfully",
              countryListData:
                  countryListResponseModel.countryListResponseData));
        } else {
          emit(CountryLoadingFailedState(errorMessage: "Data not found"));
        }
      } else {
        emit(CountryLoadingFailedState(
            errorMessage:
                "Request Failed to get success with status code ${response.statusCode}"));
      }
    } on PlatformException {
      emit(CountryLoadingFailedState(errorMessage: "Failed to get Platform"));
    } on Exception {
      emit(CountryLoadingFailedState(
          errorMessage: "Failed to Access Countries"));
    } catch (e) {
      emit(CountryLoadingFailedState(errorMessage: e.toString()));
    }
  }
}
