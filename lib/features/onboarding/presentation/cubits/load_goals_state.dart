import 'package:fitflowapp/features/onboarding/data/models/onboarding_goal.dart';

sealed class LoadGoalsState {
  const LoadGoalsState();
}

class LoadGoalsInitial extends LoadGoalsState {
  const LoadGoalsInitial();
}

class LoadGoalsLoading extends LoadGoalsState {
  const LoadGoalsLoading();
}

class LoadGoalsLoaded extends LoadGoalsState {
  const LoadGoalsLoaded(this.goals);

  final List<OnboardingGoal> goals;
}

class LoadGoalsFailure extends LoadGoalsState {
  const LoadGoalsFailure(this.message);

  final String message;
}
