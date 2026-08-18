import 'package:flutter/material.dart';

class OnboardingGoal {
  const OnboardingGoal({
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
  });

  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
}
