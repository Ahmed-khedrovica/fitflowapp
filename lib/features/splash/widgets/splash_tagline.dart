import 'package:fitflowapp/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class SplashTagline extends StatelessWidget {
  const SplashTagline({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Elevate Your Movement',
      textAlign: TextAlign.center,
      style: AppStyles.splashTagline,
    );
  }
}
