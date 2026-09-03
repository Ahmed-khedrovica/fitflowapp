import 'package:fitflowapp/features/onboarding/data/repositories/workout_plans_repository.dart';
import 'package:fitflowapp/features/onboarding/data/services/exercises_asset_service.dart';
import 'package:fitflowapp/features/onboarding/data/services/workout_plans_asset_service.dart';
import 'package:fitflowapp/features/onboarding/domain/usecases/get_complete_workout_plan.dart';
import 'package:fitflowapp/features/onboarding/presentation/cubits/create_complete_workout_plan_cubit.dart';
import 'package:fitflowapp/features/onboarding/presentation/cubits/create_complete_workout_plan_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CreateCompleteWorkoutPlanCubit', () {
    test('creates a complete plan with exercise details', () async {
      final cubit = CreateCompleteWorkoutPlanCubit(
        GetCompleteWorkoutPlanUseCase(
          WorkoutPlansRepository(
            workoutPlansAssetService: _PlansService(),
            exercisesAssetService: _ExercisesService(),
          ),
        ),
      );

      await cubit.create('plan_build_muscle_3d');

      final state = cubit.state;
      expect(state, isA<CreateCompleteWorkoutPlanLoaded>());

      final plan = (state as CreateCompleteWorkoutPlanLoaded).plan;
      expect(plan.planId, 'plan_build_muscle_3d');
      expect(plan.goalId, 'build_muscle');
      expect(plan.availabilityDays, 3);
      expect(plan.workoutDays, hasLength(1));
      expect(plan.workoutDays.first.exercises, hasLength(1));
      expect(
        plan.workoutDays.first.exercises.first.exercise.id,
        'ex_dumbbell_bench_press',
      );
    });

    test('emits failure when a plan cannot be found', () async {
      final cubit = CreateCompleteWorkoutPlanCubit(
        GetCompleteWorkoutPlanUseCase(
          WorkoutPlansRepository(
            workoutPlansAssetService: _PlansService(),
            exercisesAssetService: _ExercisesService(),
          ),
        ),
      );

      await cubit.create('missing_plan');

      final state = cubit.state;
      expect(state, isA<CreateCompleteWorkoutPlanFailure>());
      expect(
        (state as CreateCompleteWorkoutPlanFailure).message,
        'Workout plan not found: missing_plan',
      );
    });

    test('emits failure when a referenced exercise cannot be found', () async {
      final cubit = CreateCompleteWorkoutPlanCubit(
        GetCompleteWorkoutPlanUseCase(
          WorkoutPlansRepository(
            workoutPlansAssetService: _PlansService(
              exerciseId: 'missing_exercise',
            ),
            exercisesAssetService: _ExercisesService(),
          ),
        ),
      );

      await cubit.create('plan_build_muscle_3d');

      final state = cubit.state;
      expect(state, isA<CreateCompleteWorkoutPlanFailure>());
      expect(
        (state as CreateCompleteWorkoutPlanFailure).message,
        'Exercise not found: missing_exercise',
      );
    });
  });
}

class _PlansService implements WorkoutPlansAssetService {
  const _PlansService({this.exerciseId = 'ex_dumbbell_bench_press'});

  final String exerciseId;

  @override
  Future<List<Map<String, dynamic>>> loadPlans() async {
    return [
      {
        'plan_id': 'plan_build_muscle_3d',
        'goal_id': 'build_muscle',
        'availability_days': 3,
        'level': 'intermediate',
        'schedule_notes': {'en': 'Rest between sessions.'},
        'workout_days': [
          {
            'day_number': 1,
            'workout_id': 'workout_build_muscle_3d_1',
            'title': {'en': 'Upper Body'},
            'duration_minutes': 50,
            'exercises': [
              {
                'exercise_id': exerciseId,
                'sets': 3,
                'reps': '8-12',
                'rest_seconds': 120,
              },
            ],
          },
        ],
      },
    ];
  }
}

class _ExercisesService implements ExercisesAssetService {
  @override
  Future<List<Map<String, dynamic>>> loadExercises() async {
    return [
      {
        'id': 'ex_dumbbell_bench_press',
        'title': {'en': 'Dumbbell Bench Press'},
        'video_url': 'https://example.com/video.mp4',
        'thumbnail_url': 'https://example.com/thumb.jpg',
        'equipment': ['dumbbell', 'bench'],
        'muscles': {
          'primary': ['chest'],
          'secondary': ['triceps'],
          'stabilizers': <String>[],
        },
        'form_cues': {
          'en': ['Keep your shoulder blades retracted.'],
        },
      },
    ];
  }
}
