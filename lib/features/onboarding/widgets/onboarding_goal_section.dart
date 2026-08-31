import 'package:fitflowapp/core/localization/localization_extension.dart';
import 'package:fitflowapp/core/localization/language_cubit.dart';
import 'package:fitflowapp/core/theme/app_styles.dart';
import 'package:fitflowapp/features/onboarding/data/models/onboarding_goal.dart';
import 'package:fitflowapp/features/onboarding/presentation/cubits/load_goals_cubit.dart';
import 'package:fitflowapp/features/onboarding/presentation/cubits/load_goals_state.dart';
import 'package:fitflowapp/features/onboarding/widgets/onboarding_goal_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingGoalSection extends StatefulWidget {
  const OnboardingGoalSection({super.key});

  @override
  State<OnboardingGoalSection> createState() => _OnboardingGoalSectionState();
}

class _OnboardingGoalSectionState extends State<OnboardingGoalSection> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l = context.localize;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 0,
      children: [
        Text(l.selectYourGoal, style: AppStyles.onboardingTitle),
        Text(l.goalSubtitle, style: AppStyles.onboardingSubtitle),
        const SizedBox(height: 16),
        BlocBuilder<LoadGoalsCubit, LoadGoalsState>(
          builder: (context, state) {
            if (state is LoadGoalsInitial || state is LoadGoalsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is LoadGoalsFailure) {
              return Text(state.message, style: AppStyles.onboardingSubtitle);
            }

            final List<OnboardingGoal> goals = (state as LoadGoalsLoaded).goals;
            final languageCode = context
                .watch<LanguageCubit>()
                .state
                .languageCode;
            return Column(
              spacing: 12,
              children: List.generate(
                goals.length,
                (index) => Semantics(
                  button: true,
                  label: goals[index].localizedTitle(languageCode),
                  selected: _selectedIndex == index,
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedIndex = index),
                    child: OnboardingGoalCard(
                      goal: goals[index],
                      languageCode: languageCode,
                      isSelected: _selectedIndex == index,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
