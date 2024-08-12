// ignore_for_file: must_be_immutable

import 'package:filtercoffee/modules/dashboard/bloc/dashboard_state.dart';
import 'package:filtercoffee/modules/dashboard/model/country_response_model.dart';
import 'package:flutter/material.dart';

class ListViewWidget extends StatefulWidget {
  late CountryLoadingSuccessState? state;
  ListViewWidget({
    this.state,
    super.key,
  });

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.state?.countryListData!.length,
        itemBuilder: (context, index) {
          CountryListResponseData? crd = widget.state?.countryListData?[index];
          return Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue, Colors.deepPurple],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight)),
              child: ListTile(
                  title: Text(
                crd?.name??'',
                style: const TextStyle(color: Colors.white),
              )));
        });
  }
}
