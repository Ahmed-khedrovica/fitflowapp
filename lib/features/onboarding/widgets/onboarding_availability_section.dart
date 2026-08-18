import 'package:fitflowapp/core/theme/app_colors.dart';
import 'package:fitflowapp/core/theme/app_styles.dart';
import 'package:flutter/material.dart';

class OnboardingAvailabilitySection extends StatelessWidget {
  const OnboardingAvailabilitySection({super.key});

  static const _imagePath = 'assets/images/onboarding_image.png';
  static const _gradientPath = 'assets/images/onbooarding_gradient.png';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Text('Weekly Availability', style: AppStyles.onboardingSectionTitle),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              _DayChip(label: '2 Days', isSelected: false),
              _DayChip(label: '3 Days', isSelected: true),
              _DayChip(label: '4 Days', isSelected: false),
              _DayChip(label: '5+ Days', isSelected: false),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 150,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  _imagePath,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  _gradientPath,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('RECOMMENDED', style: AppStyles.onboardingBadge),
                      Text(
                        'Optimal recovery cycle',
                        style: AppStyles.onboardingCaption,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DayChip extends StatelessWidget {
  const _DayChip({
    required this.label,
    required this.isSelected,
  });

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: AppStyles.onboardingChipLabel.copyWith(
            color: isSelected ? AppColors.surface : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}
