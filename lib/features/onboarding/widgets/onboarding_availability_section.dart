import 'package:fitflowapp/core/theme/app_colors.dart';
import 'package:fitflowapp/core/theme/app_styles.dart';
import 'package:fitflowapp/features/onboarding/widgets/day_chip.dart';
import 'package:flutter/material.dart';

class OnboardingAvailabilitySection extends StatefulWidget {
  const OnboardingAvailabilitySection({super.key});

  @override
  State<OnboardingAvailabilitySection> createState() =>
      _OnboardingAvailabilitySectionState();
}

class _OnboardingAvailabilitySectionState
    extends State<OnboardingAvailabilitySection> {
  static const _imagePath = 'assets/images/onboarding_image.png';
  static const _gradientPath = 'assets/images/onbooarding_gradient.png';

  int _selectedDays = 3;

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
              DayChip(
                label: '2 Days',
                isSelected: _selectedDays == 2,
                onTap: () => setState(() => _selectedDays = 2),
              ),
              DayChip(
                label: '3 Days',
                isSelected: _selectedDays == 3,
                onTap: () => setState(() => _selectedDays = 3),
              ),
              DayChip(
                label: '4 Days',
                isSelected: _selectedDays == 4,
                onTap: () => setState(() => _selectedDays = 4),
              ),
              DayChip(
                label: '5+ Days',
                isSelected: _selectedDays == 5,
                onTap: () => setState(() => _selectedDays = 5),
              ),
            ],
          ),
        ),
        if (_selectedDays == 3)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 150,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(_imagePath, fit: BoxFit.cover),
                  Image.asset(_gradientPath, fit: BoxFit.cover),
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
