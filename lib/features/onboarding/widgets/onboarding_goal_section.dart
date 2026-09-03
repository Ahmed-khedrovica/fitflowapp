import 'package:fitflowapp/core/localization/localization_extension.dart';
import 'package:fitflowapp/core/localization/language_cubit.dart';
import 'package:fitflowapp/core/theme/app_styles.dart';
import 'package:fitflowapp/features/onboarding/data/models/onboarding_goal.dart';
import 'package:fitflowapp/features/onboarding/presentation/cubits/load_goals_cubit.dart';
import 'package:fitflowapp/features/onboarding/presentation/cubits/load_goals_state.dart';
import 'package:fitflowapp/features/onboarding/presentation/onboarding_screen.dart';
import 'package:fitflowapp/features/onboarding/widgets/onboarding_goal_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingGoalSection extends StatefulWidget {
  const OnboardingGoalSection({
    required this.input,
    required this.onChanged,
    super.key,
  });

  final OnboardingInputModel input;
  final VoidCallback onChanged;

  @override
  State<OnboardingGoalSection> createState() => _OnboardingGoalSectionState();
}

class _OnboardingGoalSectionState extends State<OnboardingGoalSection> {
  List<OnboardingGoal>? _goals;

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
        if (_goals == null)
          BlocListener<LoadGoalsCubit, LoadGoalsState>(
            listener: (context, state) {
              if (state is LoadGoalsLoaded) {
                setState(() => _goals = state.goals);
              }
            },
            child: Builder(
              builder: (context) {
                final state = context.read<LoadGoalsCubit>().state;
                if (state is LoadGoalsFailure) {
                  return Text(
                    state.message,
                    style: AppStyles.onboardingSubtitle,
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          )
        else
          _GoalList(
            goals: _goals!,
            input: widget.input,
            onChanged: widget.onChanged,
          ),
      ],
    );
  }
}

class _GoalList extends StatelessWidget {
  const _GoalList({
    required this.goals,
    required this.input,
    required this.onChanged,
  });

  final List<OnboardingGoal> goals;
  final OnboardingInputModel input;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final languageCode = context.watch<LanguageCubit>().state.languageCode;
    return Column(
      spacing: 12,
      children: List.generate(
        goals.length,
        (index) => Semantics(
          button: true,
          label: goals[index].localizedTitle(languageCode),
          selected: input.goalId == goals[index].id,
          child: GestureDetector(
            onTap: () {
              input.selectGoal(goals[index].id);
              onChanged();
            },
            child: OnboardingGoalCard(
              goal: goals[index],
              languageCode: languageCode,
              isSelected: input.goalId == goals[index].id,
            ),
          ),
        ),
      ),
    );
  }
}
