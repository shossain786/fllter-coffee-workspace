import 'package:filtercoffee/img_list.dart';
import 'package:flutter/material.dart';

class PageErrorWidget extends StatelessWidget {
  const PageErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 300,
        height: 300,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: const LinearGradient(
                colors: [Colors.deepOrange, Colors.yellow],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight)),
        child: Image.asset(ImageList.pageNotFoundImage),
      ),
    );
  }
}