import 'package:fitflowapp/core/theme/app_styles.dart';
import 'package:fitflowapp/features/onboarding/data/models/onboarding_goal.dart';
import 'package:fitflowapp/features/onboarding/widgets/onboarding_goal_card.dart';
import 'package:flutter/material.dart';

class OnboardingGoalSection extends StatelessWidget {
  const OnboardingGoalSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 0,
      children: [
        Text('Select Your Goal', style: AppStyles.onboardingTitle),
        Text(
          'Customize your journey for precision\nperformance.',
          style: AppStyles.onboardingSubtitle,
        ),
        const SizedBox(height: 16),
        const Column(
          spacing: 12,
          children: [
            OnboardingGoalCard(
              goal: OnboardingGoal(
                title: 'Build Muscle',
                description: 'Focus on hypertrophy and\nstrength.',
                icon: Icons.fitness_center,
                isSelected: true,
              ),
            ),
            OnboardingGoalCard(
              goal: OnboardingGoal(
                title: 'Get Strong',
                description: 'Prioritize heavy lifting and power.',
                icon: Icons.bolt,
                isSelected: false,
              ),
            ),
            OnboardingGoalCard(
              goal: OnboardingGoal(
                title: 'General Fitness',
                description: 'Balanced health and mobility.',
                icon: Icons.self_improvement,
                isSelected: false,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
