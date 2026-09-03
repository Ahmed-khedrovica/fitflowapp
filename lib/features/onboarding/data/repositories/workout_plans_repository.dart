import 'package:fitflowapp/features/onboarding/data/models/exercise.dart';
import 'package:fitflowapp/features/onboarding/data/models/workout_plan.dart';
import 'package:fitflowapp/features/onboarding/data/services/exercises_asset_service.dart';
import 'package:fitflowapp/features/onboarding/data/services/workout_plans_asset_service.dart';

/// Maps raw workout plan and exercise asset data into app models.
class WorkoutPlansRepository {
  const WorkoutPlansRepository({
    required WorkoutPlansAssetService workoutPlansAssetService,
    required ExercisesAssetService exercisesAssetService,
  }) : _workoutPlansAssetService = workoutPlansAssetService,
       _exercisesAssetService = exercisesAssetService;

  final WorkoutPlansAssetService _workoutPlansAssetService;
  final ExercisesAssetService _exercisesAssetService;

  Future<List<WorkoutPlan>> loadPlans() async {
    final plans = await _workoutPlansAssetService.loadPlans();
    return plans.map(WorkoutPlan.fromJson).toList(growable: false);
  }

  Future<List<Exercise>> loadExercises() async {
    final exercises = await _exercisesAssetService.loadExercises();
    return exercises.map(Exercise.fromJson).toList(growable: false);
  }
}
