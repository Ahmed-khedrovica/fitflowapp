import 'package:fitflowapp/features/onboarding/data/models/exercise.dart';
import 'package:fitflowapp/features/onboarding/data/services/exercises_asset_service.dart';

/// Maps raw asset data into exercises.
class ExercisesRepository {
  const ExercisesRepository(this._assetService);

  final ExercisesAssetService _assetService;

  Future<List<Exercise>> loadExercises() async {
    final exercises = await _assetService.loadExercises();
    return exercises.map(Exercise.fromJson).toList(growable: false);
  }
}
