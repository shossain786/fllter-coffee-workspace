import 'package:filtercoffee/img_list.dart';
import 'package:flutter/material.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: const LinearGradient(
                colors: [Colors.deepOrange, Colors.yellow],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight)),
        child: Image.asset(
          ImageList.appLogo,
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
