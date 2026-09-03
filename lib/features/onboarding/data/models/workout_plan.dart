class WorkoutPlan {
  const WorkoutPlan({
    required this.planId,
    required this.goalId,
    required this.availabilityDays,
    required this.level,
    required this.scheduleNotes,
    required this.workoutDays,
  });

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) {
    return WorkoutPlan(
      planId: json['plan_id'] as String,
      goalId: json['goal_id'] as String,
      availabilityDays: json['availability_days'] as int,
      level: json['level'] as String,
      scheduleNotes: _localizedText(json['schedule_notes']),
      workoutDays: (json['workout_days'] as List<dynamic>)
          .map(
            (day) => WorkoutDay.fromJson(Map<String, dynamic>.from(day as Map)),
          )
          .toList(growable: false),
    );
  }

  final String planId;
  final String goalId;
  final int availabilityDays;
  final String level;
  final Map<String, String> scheduleNotes;
  final List<WorkoutDay> workoutDays;

  String localizedScheduleNotes(String languageCode) =>
      scheduleNotes[languageCode] ?? scheduleNotes['en'] ?? '';

  static Map<String, String> _localizedText(Object? value) {
    final json = value as Map<String, dynamic>;
    return json.map((key, text) => MapEntry(key, text as String));
  }
}

class WorkoutDay {
  const WorkoutDay({
    required this.dayNumber,
    required this.workoutId,
    required this.title,
    required this.durationMinutes,
    required this.exercises,
  });

  factory WorkoutDay.fromJson(Map<String, dynamic> json) {
    return WorkoutDay(
      dayNumber: json['day_number'] as int,
      workoutId: json['workout_id'] as String,
      title: WorkoutPlan._localizedText(json['title']),
      durationMinutes: json['duration_minutes'] as int,
      exercises: (json['exercises'] as List<dynamic>)
          .map(
            (exercise) => WorkoutExercisePrescription.fromJson(
              Map<String, dynamic>.from(exercise as Map),
            ),
          )
          .toList(growable: false),
    );
  }

  final int dayNumber;
  final String workoutId;
  final Map<String, String> title;
  final int durationMinutes;
  final List<WorkoutExercisePrescription> exercises;

  String localizedTitle(String languageCode) =>
      title[languageCode] ?? title['en'] ?? '';
}

class WorkoutExercisePrescription {
  const WorkoutExercisePrescription({
    required this.exerciseId,
    required this.sets,
    required this.reps,
    required this.restSeconds,
  });

  factory WorkoutExercisePrescription.fromJson(Map<String, dynamic> json) {
    return WorkoutExercisePrescription(
      exerciseId: json['exercise_id'] as String,
      sets: json['sets'] as int,
      reps: json['reps'] as String,
      restSeconds: json['rest_seconds'] as int,
    );
  }

  final String exerciseId;
  final int sets;
  final String reps;
  final int restSeconds;
}
