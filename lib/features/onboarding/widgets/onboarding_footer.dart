import 'package:fitflowapp/core/localization/localization_extension.dart';
import 'package:fitflowapp/core/theme/app_colors.dart';
import 'package:fitflowapp/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({
    required this.onContinue,
    this.isLoading = false,
    super.key,
  });

  final VoidCallback? onContinue;
  final bool isLoading;

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
              onPressed: isLoading ? null : onContinue,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: const StadiumBorder(),
                elevation: 0,
              ),
              child: isLoading
                  ? const SizedBox.square(
                      dimension: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.surface,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 8,
                      children: [
                        Text(
                          context.localize.continueButton,
                          style: AppStyles.onboardingContinue,
                        ),
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
            context.localize.changeInProfile,
            textAlign: TextAlign.center,
            style: AppStyles.onboardingFooterNote,
          ),
        ],
      ),
    );
  }
}
