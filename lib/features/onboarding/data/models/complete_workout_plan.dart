import 'package:fitflowapp/features/onboarding/data/models/exercise.dart';
import 'package:fitflowapp/features/onboarding/data/models/workout_plan.dart';

class CompleteWorkoutPlan {
  const CompleteWorkoutPlan({
    required this.planId,
    required this.goalId,
    required this.availabilityDays,
    required this.level,
    required this.scheduleNotes,
    required this.workoutDays,
  });

  final String planId;
  final String goalId;
  final int availabilityDays;
  final String level;
  final Map<String, String> scheduleNotes;
  final List<CompleteWorkoutDay> workoutDays;

  String localizedScheduleNotes(String languageCode) =>
      scheduleNotes[languageCode] ?? scheduleNotes['en'] ?? '';
}

class CompleteWorkoutDay {
  const CompleteWorkoutDay({
    required this.dayNumber,
    required this.workoutId,
    required this.title,
    required this.durationMinutes,
    required this.exercises,
  });

  final int dayNumber;
  final String workoutId;
  final Map<String, String> title;
  final int durationMinutes;
  final List<CompleteWorkoutExercise> exercises;

  String localizedTitle(String languageCode) =>
      title[languageCode] ?? title['en'] ?? '';
}

class CompleteWorkoutExercise {
  const CompleteWorkoutExercise({
    required this.prescription,
    required this.exercise,
  });

  final WorkoutExercisePrescription prescription;
  final Exercise exercise;
}
