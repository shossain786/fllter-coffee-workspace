

import 'package:filtercoffee/modules/dashboard/bloc/dashboard_event.dart';
import 'package:filtercoffee/modules/dashboard/bloc/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
