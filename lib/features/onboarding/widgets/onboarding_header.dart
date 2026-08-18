import 'package:fitflowapp/core/theme/app_colors.dart';
import 'package:fitflowapp/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceMuted,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('FitFlow', style: AppStyles.onboardingBrand),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: const Icon(
              Icons.person_outline,
              size: 22,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
