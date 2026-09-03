import 'package:fitflowapp/features/onboarding/domain/usecases/get_complete_workout_plan.dart';
import 'package:fitflowapp/features/onboarding/presentation/cubits/create_complete_workout_plan_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Builds a selected workout plan with full exercise details attached.
class CreateCompleteWorkoutPlanCubit
    extends Cubit<CreateCompleteWorkoutPlanState> {
  CreateCompleteWorkoutPlanCubit(this._getCompleteWorkoutPlan)
    : super(const CreateCompleteWorkoutPlanInitial());

  final GetCompleteWorkoutPlanUseCase _getCompleteWorkoutPlan;

  Future<void> create(String planId) async {
    emit(const CreateCompleteWorkoutPlanLoading());
    try {
      emit(CreateCompleteWorkoutPlanLoaded(await _getCompleteWorkoutPlan(planId)));
    } on Object catch (error) {
      emit(CreateCompleteWorkoutPlanFailure(error.toString()));
    }
  }
}
