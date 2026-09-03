import 'package:fitflowapp/features/onboarding/data/models/complete_workout_plan.dart';

sealed class CreateCompleteWorkoutPlanState {
  const CreateCompleteWorkoutPlanState();
}

class CreateCompleteWorkoutPlanInitial extends CreateCompleteWorkoutPlanState {
  const CreateCompleteWorkoutPlanInitial();
}

class CreateCompleteWorkoutPlanLoading extends CreateCompleteWorkoutPlanState {
  const CreateCompleteWorkoutPlanLoading();
}

class CreateCompleteWorkoutPlanLoaded extends CreateCompleteWorkoutPlanState {
  const CreateCompleteWorkoutPlanLoaded(this.plan);

  final CompleteWorkoutPlan plan;
}

class CreateCompleteWorkoutPlanFailure extends CreateCompleteWorkoutPlanState {
  const CreateCompleteWorkoutPlanFailure(this.message);

  final String message;
}
