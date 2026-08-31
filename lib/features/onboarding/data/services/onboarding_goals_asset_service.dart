import 'dart:convert';

import 'package:flutter/services.dart';

/// Reads the bundled onboarding goals catalog without applying presentation mapping.
class OnboardingGoalsAssetService {
  static const _assetPath = 'lib/data/fitflow_goals.json';

  Future<List<Map<String, dynamic>>> loadGoals() async {
    final contents = await rootBundle.loadString(_assetPath);
    final json = jsonDecode(contents) as Map<String, dynamic>;
    return (json['goals'] as List<dynamic>)
        .map((goal) => Map<String, dynamic>.from(goal as Map))
        .toList(growable: false);
  }
}
