import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBarWidget {
  static AppBar customAppBar(
      {Map<String, dynamic>? arguments, bool? automaticallyImplyLeading}) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      foregroundColor: Colors.white,
      automaticallyImplyLeading: (automaticallyImplyLeading != null)
          ? automaticallyImplyLeading
          : true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.deepPurple],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight)),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(arguments!.containsKey("title") ? arguments['title'] : ''),
      centerTitle: true,
    );
  }
}
