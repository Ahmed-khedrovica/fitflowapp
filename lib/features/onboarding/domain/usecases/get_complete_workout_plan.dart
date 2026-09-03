import 'package:fitflowapp/features/onboarding/data/models/complete_workout_plan.dart';
import 'package:fitflowapp/features/onboarding/data/models/exercise.dart';
import 'package:fitflowapp/features/onboarding/data/models/workout_plan.dart';
import 'package:fitflowapp/features/onboarding/data/repositories/workout_plans_repository.dart';

class CompleteWorkoutPlanException implements Exception {
  const CompleteWorkoutPlanException(this.message);

  final String message;

  @override
  String toString() => message;
}

class GetCompleteWorkoutPlanUseCase {
  const GetCompleteWorkoutPlanUseCase(this._repository);

  final WorkoutPlansRepository _repository;

  Future<CompleteWorkoutPlan> call(String planId) async {
    final results = await Future.wait<Object>([
      _repository.loadPlans(),
      _repository.loadExercises(),
    ]);
    final plans = results[0] as List<WorkoutPlan>;
    final exercises = results[1] as List<Exercise>;

    WorkoutPlan? plan;
    for (final candidate in plans) {
      if (candidate.planId == planId) {
        plan = candidate;
        break;
      }
    }
    if (plan == null) {
      throw CompleteWorkoutPlanException('Workout plan not found: $planId');
    }

    final exercisesById = {
      for (final exercise in exercises) exercise.id: exercise,
    };
    final completeDays = <CompleteWorkoutDay>[];

    for (final day in plan.workoutDays) {
      final completeExercises = <CompleteWorkoutExercise>[];
      for (final prescription in day.exercises) {
        final exercise = exercisesById[prescription.exerciseId];
        if (exercise == null) {
          throw CompleteWorkoutPlanException(
            'Exercise not found: ${prescription.exerciseId}',
          );
        }
        completeExercises.add(
          CompleteWorkoutExercise(
            prescription: prescription,
            exercise: exercise,
          ),
        );
      }

      completeDays.add(
        CompleteWorkoutDay(
          dayNumber: day.dayNumber,
          workoutId: day.workoutId,
          title: day.title,
          durationMinutes: day.durationMinutes,
          exercises: completeExercises,
        ),
      );
    }

    return CompleteWorkoutPlan(
      planId: plan.planId,
      goalId: plan.goalId,
      availabilityDays: plan.availabilityDays,
      level: plan.level,
      scheduleNotes: plan.scheduleNotes,
      workoutDays: completeDays,
    );
  }
}
