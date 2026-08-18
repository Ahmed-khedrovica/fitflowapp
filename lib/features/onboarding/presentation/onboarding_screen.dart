import 'package:fitflowapp/core/theme/app_colors.dart';
import 'package:fitflowapp/features/onboarding/widgets/onboarding_availability_section.dart';
import 'package:fitflowapp/features/onboarding/widgets/onboarding_footer.dart';
import 'package:fitflowapp/features/onboarding/widgets/onboarding_goal_section.dart';
import 'package:fitflowapp/features/onboarding/widgets/onboarding_header.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            OnboardingHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 24),
                child: Column(
                  spacing: 24,
                  children: [
                    OnboardingGoalSection(),
                    OnboardingAvailabilitySection(),
                  ],
                ),
              ),
            ),
            OnboardingFooter(),
          ],
        ),
      ),
    );
  }
}
