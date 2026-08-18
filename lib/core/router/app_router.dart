import 'package:fitflowapp/core/router/app_routes.dart';
import 'package:fitflowapp/core/theme/app_colors.dart';
import 'package:fitflowapp/features/onboarding/presentation/onboarding_screen.dart';
import 'package:fitflowapp/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: AppRoutes.splashName,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      name: AppRoutes.onboardingName,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: AppRoutes.homeName,
      builder: (context, state) => const _RoutePlaceholder(title: 'Home'),
    ),
    GoRoute(
      path: AppRoutes.exercise,
      name: AppRoutes.exerciseName,
      builder: (context, state) => const _RoutePlaceholder(title: 'Exercise'),
    ),
    GoRoute(
      path: AppRoutes.profile,
      name: AppRoutes.profileName,
      builder: (context, state) => const _RoutePlaceholder(title: 'Profile'),
    ),
    GoRoute(
      path: AppRoutes.body,
      name: AppRoutes.bodyName,
      builder: (context, state) => const _RoutePlaceholder(title: 'Body'),
    ),
  ],
);

class _RoutePlaceholder extends StatelessWidget {
  const _RoutePlaceholder({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}
