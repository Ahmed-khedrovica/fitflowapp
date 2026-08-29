import 'package:fitflowapp/core/localization/localization_extension.dart';
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
    final l = context.localize;
    final goals = [
      OnboardingGoal(
        title: l.buildMuscle,
        description: l.buildMuscleDesc,
        icon: Icons.fitness_center,
      ),
      OnboardingGoal(
        title: l.getStrong,
        description: l.getStrongDesc,
        icon: Icons.bolt,
      ),
      OnboardingGoal(
        title: l.generalFitness,
        description: l.generalFitnessDesc,
        icon: Icons.self_improvement,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 0,
      children: [
        Text(l.selectYourGoal, style: AppStyles.onboardingTitle),
        Text(l.goalSubtitle, style: AppStyles.onboardingSubtitle),
        const SizedBox(height: 16),
        Column(
          spacing: 12,
          children: List.generate(
            goals.length,
            (index) => GestureDetector(
              onTap: () => setState(() => _selectedIndex = index),
              child: OnboardingGoalCard(
                goal: goals[index],
                isSelected: _selectedIndex == index,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
