import 'package:fitflowapp/core/theme/app_colors.dart';
import 'package:fitflowapp/core/theme/app_styles.dart';
import 'package:fitflowapp/features/onboarding/data/models/onboarding_goal.dart';
import 'package:flutter/material.dart';

class OnboardingGoalCard extends StatelessWidget {
  const OnboardingGoalCard({
    super.key,
    required this.goal,
    required this.languageCode,
    required this.isSelected,
  });

  final OnboardingGoal goal;
  final String languageCode;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final icon = _iconForGoal(goal);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.primary : const Color(0xFFE2E8F0),
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Row(
        spacing: 16,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 24, color: AppColors.primary),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Text(
                  goal.localizedTitle(languageCode),
                  style: AppStyles.onboardingGoalTitle,
                ),
                Text(
                  goal.localizedDescription(languageCode),
                  style: AppStyles.onboardingGoalDescription,
                ),
              ],
            ),
          ),
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            size: 20,
            color: isSelected ? AppColors.primary : AppColors.textMuted,
          ),
        ],
      ),
    );
  }

  IconData _iconForGoal(OnboardingGoal goal) {
    return switch (goal.id) {
      'build_muscle' => Icons.fitness_center,
      'get_strong' => Icons.bolt,
      'general_fitness' => Icons.self_improvement,
      _ => Icons.flag,
    };
  }
}
