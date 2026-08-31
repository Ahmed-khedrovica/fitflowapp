import 'package:fitflowapp/features/onboarding/data/models/onboarding_goal.dart';
import 'package:fitflowapp/features/onboarding/data/services/onboarding_goals_asset_service.dart';

/// Maps raw asset data into onboarding goals the presentation layer can render.
class OnboardingGoalsRepository {
  const OnboardingGoalsRepository(this._assetService);

  final OnboardingGoalsAssetService _assetService;

  Future<List<OnboardingGoal>> loadGoals() async {
    final goals = await _assetService.loadGoals();
    return goals.map(OnboardingGoal.fromJson).toList(growable: false);
  }
}
