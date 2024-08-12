// ignore_for_file: must_be_immutable

import 'package:filtercoffee/modules/dashboard/bloc/dashboard_state.dart';
import 'package:filtercoffee/modules/dashboard/model/country_response_model.dart';
import 'package:flutter/material.dart';

class GridViewWidget extends StatefulWidget {
  late CountryLoadingSuccessState? state;
  GridViewWidget({
    this.state,
    super.key,
  });

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: widget.state?.countryListData!.length,
        itemBuilder: (context, index) {
          CountryListResponseData? crd = widget.state?.countryListData?[index];
          return Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue, Colors.deepPurple],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight)),
              child: Center(
                  child: Text(
                crd?.name??'',
                style: const TextStyle(color: Colors.white),
              )));
        });
  }
}
