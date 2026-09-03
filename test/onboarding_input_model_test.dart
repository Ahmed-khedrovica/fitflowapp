import 'package:fitflowapp/features/onboarding/presentation/onboarding_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnboardingInputModel', () {
    test('uses build muscle three days by default', () {
      final input = OnboardingInputModel();

      expect(input.toPlanId(), 'plan_build_muscle_3d');
    });

    test('maps selected goal and availability to a plan id', () {
      final input = OnboardingInputModel()
        ..selectGoal('get_strong')
        ..selectAvailabilityDays(5);

      expect(input.toPlanId(), 'plan_get_strong_5d');
    });

    test('supports all bundled goal and day combinations', () {
      const goalIds = ['build_muscle', 'get_strong', 'general_fitness'];
      const days = [2, 3, 4, 5];

      for (final goalId in goalIds) {
        for (final dayCount in days) {
          final input = OnboardingInputModel()
            ..selectGoal(goalId)
            ..selectAvailabilityDays(dayCount);

          expect(input.toPlanId(), 'plan_${goalId}_${dayCount}d');
        }
      }
    });
  });
}
