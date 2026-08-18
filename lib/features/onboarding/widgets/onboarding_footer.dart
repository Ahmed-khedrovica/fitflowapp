import 'package:fitflowapp/core/theme/app_colors.dart';
import 'package:fitflowapp/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        spacing: 16,
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: const StadiumBorder(),
                elevation: 0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 8,
                children: [
                  Text('Continue', style: AppStyles.onboardingContinue),
                  const Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: AppColors.surface,
                  ),
                ],
              ),
            ),
          ),
          Text(
            'YOU CAN CHANGE THIS LATER IN PROFILE',
            textAlign: TextAlign.center,
            style: AppStyles.onboardingFooterNote,
          ),
        ],
      ),
    );
  }
}
