import 'package:fitflowapp/core/theme/app_colors.dart';
import 'package:fitflowapp/core/theme/app_styles.dart';
import 'package:fitflowapp/features/onboarding/data/models/onboarding_goal.dart';
import 'package:flutter/material.dart';

class OnboardingGoalCard extends StatelessWidget {
  const OnboardingGoalCard({
    super.key,
    required this.goal,
  });

  final OnboardingGoal goal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: goal.isSelected ? AppColors.primary : const Color(0xFFE2E8F0),
          width: goal.isSelected ? 1.5 : 1,
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
            child: Icon(goal.icon, size: 24, color: AppColors.primary),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Text(goal.title, style: AppStyles.onboardingGoalTitle),
                Text(goal.description, style: AppStyles.onboardingGoalDescription),
              ],
            ),
          ),
          Icon(
            goal.isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            size: 20,
            color: goal.isSelected ? AppColors.primary : AppColors.textMuted,
          ),
        ],
      ),
    );
  }
}
