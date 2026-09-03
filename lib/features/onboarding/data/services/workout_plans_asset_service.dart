import 'dart:convert';

import 'package:flutter/services.dart';

/// Reads the bundled workout plan catalog without applying app-level mapping.
class WorkoutPlansAssetService {
  static const _assetPath = 'lib/data/fitflow_plans.json';

  Future<List<Map<String, dynamic>>> loadPlans() async {
    final contents = await rootBundle.loadString(_assetPath);
    final json = jsonDecode(contents) as Map<String, dynamic>;
    return (json['plans'] as List<dynamic>)
        .map((plan) => Map<String, dynamic>.from(plan as Map))
        .toList(growable: false);
  }
}
