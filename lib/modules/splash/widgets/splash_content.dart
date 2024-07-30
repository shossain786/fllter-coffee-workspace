import 'package:filtercoffee/modules/splash/widgets/splash_logo.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Spacer(),
        SplashLogo(),
        Spacer(),
        Align(
            alignment: Alignment.bottomCenter,
            child: CircularProgressIndicator()),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
