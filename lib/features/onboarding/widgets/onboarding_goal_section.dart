import 'package:fitflowapp/core/theme/app_styles.dart';
import 'package:fitflowapp/features/onboarding/data/models/onboarding_goal.dart';
import 'package:fitflowapp/features/onboarding/widgets/onboarding_goal_card.dart';
import 'package:flutter/material.dart';

class OnboardingGoalSection extends StatefulWidget {
  const OnboardingGoalSection({super.key});

  @override
  State<OnboardingGoalSection> createState() => _OnboardingGoalSectionState();
}

class _OnboardingGoalSectionState extends State<OnboardingGoalSection> {
  int _selectedIndex = 0;

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
        Column(
          spacing: 12,
          children: [
            GestureDetector(
              onTap: () => setState(() => _selectedIndex = 0),
              child: OnboardingGoalCard(
                goal: const OnboardingGoal(
                  title: 'Build Muscle',
                  description: 'Focus on hypertrophy and\nstrength.',
                  icon: Icons.fitness_center,
                ),
                isSelected: _selectedIndex == 0,
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => _selectedIndex = 1),
              child: OnboardingGoalCard(
                goal: const OnboardingGoal(
                  title: 'Get Strong',
                  description: 'Prioritize heavy lifting and power.',
                  icon: Icons.bolt,
                ),
                isSelected: _selectedIndex == 1,
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => _selectedIndex = 2),
              child: OnboardingGoalCard(
                goal: const OnboardingGoal(
                  title: 'General Fitness',
                  description: 'Balanced health and mobility.',
                  icon: Icons.self_improvement,
                ),
                isSelected: _selectedIndex == 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
