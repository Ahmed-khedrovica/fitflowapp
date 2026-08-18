import 'package:fitflowapp/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class SplashTitle extends StatelessWidget {
  const SplashTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'FitFlow',
      textAlign: TextAlign.center,
      style: AppStyles.splashTitle,
    );
  }
}
