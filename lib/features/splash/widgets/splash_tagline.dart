import 'package:fitflowapp/core/localization/localization_extension.dart';
import 'package:fitflowapp/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class SplashTagline extends StatelessWidget {
  const SplashTagline({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.localize.splashTagline,
      textAlign: TextAlign.center,
      style: AppStyles.splashTagline,
    );
  }
}
