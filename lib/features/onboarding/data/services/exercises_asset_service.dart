import 'dart:convert';

import 'package:flutter/services.dart';

/// Reads the bundled exercise catalog without applying app-level mapping.
class ExercisesAssetService {
  static const _assetPath = 'lib/data/fitflow_exercises.json';

  Future<List<Map<String, dynamic>>> loadExercises() async {
    final contents = await rootBundle.loadString(_assetPath);
    final json = jsonDecode(contents) as Map<String, dynamic>;
    return (json['exercises'] as List<dynamic>)
        .map((exercise) => Map<String, dynamic>.from(exercise as Map))
        .toList(growable: false);
  }
}
