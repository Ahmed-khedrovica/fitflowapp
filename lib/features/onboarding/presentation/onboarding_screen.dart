import 'package:fitflowapp/core/router/app_routes.dart';
import 'package:fitflowapp/core/theme/app_colors.dart';
import 'package:fitflowapp/features/onboarding/data/repositories/onboarding_goals_repository.dart';
import 'package:fitflowapp/features/onboarding/data/repositories/workout_plans_repository.dart';
import 'package:fitflowapp/features/onboarding/data/services/exercises_asset_service.dart';
import 'package:fitflowapp/features/onboarding/data/services/onboarding_goals_asset_service.dart';
import 'package:fitflowapp/features/onboarding/data/services/workout_plans_asset_service.dart';
import 'package:fitflowapp/features/onboarding/domain/usecases/get_complete_workout_plan.dart';
import 'package:fitflowapp/features/onboarding/presentation/cubits/create_complete_workout_plan_cubit.dart';
import 'package:fitflowapp/features/onboarding/presentation/cubits/create_complete_workout_plan_state.dart';
import 'package:fitflowapp/features/onboarding/presentation/cubits/load_goals_cubit.dart';
import 'package:fitflowapp/features/onboarding/widgets/onboarding_availability_section.dart';
import 'package:fitflowapp/features/onboarding/widgets/onboarding_footer.dart';
import 'package:fitflowapp/features/onboarding/widgets/onboarding_goal_section.dart';
import 'package:fitflowapp/features/onboarding/widgets/onboarding_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnboardingInputModel {
  OnboardingInputModel({
    this.goalId = 'build_muscle',
    this.availabilityDays = 3,
  });

  String goalId;
  int availabilityDays;

  void selectGoal(String goalId) {
    this.goalId = goalId;
  }

  void selectAvailabilityDays(int days) {
    availabilityDays = days;
  }

  String toPlanId() => 'plan_${goalId}_${availabilityDays}d';
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final OnboardingInputModel _input = OnboardingInputModel();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoadGoalsCubit(
            OnboardingGoalsRepository(OnboardingGoalsAssetService()),
          )..load(),
        ),
        BlocProvider(
          create: (_) => CreateCompleteWorkoutPlanCubit(
            GetCompleteWorkoutPlanUseCase(
              WorkoutPlansRepository(
                workoutPlansAssetService: WorkoutPlansAssetService(),
                exercisesAssetService: ExercisesAssetService(),
              ),
            ),
          ),
        ),
      ],
      child:
          BlocConsumer<
            CreateCompleteWorkoutPlanCubit,
            CreateCompleteWorkoutPlanState
          >(
            listener: (context, state) {
              if (state is CreateCompleteWorkoutPlanLoaded) {
                context.goNamed(AppRoutes.exerciseName, extra: state.plan);
              } else if (state is CreateCompleteWorkoutPlanFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              return Scaffold(
                backgroundColor: AppColors.surface,
                body: SafeArea(
                  child: Column(
                    children: [
                      const OnboardingHeader(),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
                          child: Column(
                            spacing: 24,
                            children: [
                              OnboardingGoalSection(
                                input: _input,
                                onChanged: () => setState(() {}),
                              ),
                              OnboardingAvailabilitySection(
                                input: _input,
                                onChanged: () => setState(() {}),
                              ),
                            ],
                          ),
                        ),
                      ),
                      OnboardingFooter(
                        isLoading: state is CreateCompleteWorkoutPlanLoading,
                        onContinue: () => context
                            .read<CreateCompleteWorkoutPlanCubit>()
                            .create(_input.toPlanId()),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
