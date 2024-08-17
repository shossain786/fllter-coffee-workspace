// ignore_for_file: must_be_immutable

import 'package:filtercoffee/modules/error/widgets/page_error_widget.dart';
import 'package:flutter/material.dart';

class PageErrorScreen extends StatelessWidget {
  late Map<String, dynamic> arguments;
  PageErrorScreen({
    super.key,
    required this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: PageErrorWidget(),
      ),
    );
  }
}


