import 'package:fitflowapp/core/theme/app_colors.dart';
import 'package:fitflowapp/core/router/app_routes.dart';
import 'package:fitflowapp/features/splash/widgets/splash_logo.dart';
import 'package:fitflowapp/features/splash/widgets/splash_tagline.dart';
import 'package:fitflowapp/features/splash/widgets/splash_title.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      context.goNamed(AppRoutes.onboardingName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 24,
                  children: [
                    SplashLogo(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 8,
                      children: [SplashTitle(), SplashTagline()],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
