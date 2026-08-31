import 'package:fitflowapp/features/onboarding/data/repositories/onboarding_goals_repository.dart';
import 'package:fitflowapp/features/onboarding/presentation/cubits/load_goals_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Manages loading the bundled goal catalog for onboarding.
class LoadGoalsCubit extends Cubit<LoadGoalsState> {
  LoadGoalsCubit(this._repository) : super(const LoadGoalsInitial());

  final OnboardingGoalsRepository _repository;

  Future<void> load() async {
    emit(const LoadGoalsLoading());
    try {
      emit(LoadGoalsLoaded(await _repository.loadGoals()));
    } on Object catch (error) {
      emit(LoadGoalsFailure(error.toString()));
    }
  }
}
