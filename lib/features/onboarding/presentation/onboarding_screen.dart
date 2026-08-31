import 'package:fitflowapp/core/theme/app_colors.dart';
import 'package:fitflowapp/features/onboarding/data/repositories/onboarding_goals_repository.dart';
import 'package:fitflowapp/features/onboarding/data/services/onboarding_goals_asset_service.dart';
import 'package:fitflowapp/features/onboarding/presentation/cubits/load_goals_cubit.dart';
import 'package:fitflowapp/features/onboarding/widgets/onboarding_availability_section.dart';
import 'package:fitflowapp/features/onboarding/widgets/onboarding_footer.dart';
import 'package:fitflowapp/features/onboarding/widgets/onboarding_goal_section.dart';
import 'package:fitflowapp/features/onboarding/widgets/onboarding_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoadGoalsCubit(
        OnboardingGoalsRepository(OnboardingGoalsAssetService()),
      )..load(),
      child: const Scaffold(
        backgroundColor: AppColors.surface,
        body: SafeArea(
          child: Column(
            children: [
              OnboardingHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 24),
                  child: Column(
                    spacing: 24,
                    children: [
                      OnboardingGoalSection(),
                      OnboardingAvailabilitySection(),
                    ],
                  ),
                ),
              ),
              OnboardingFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
