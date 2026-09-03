## Role

Act as an expert Flutter developer with strong knowledge of Dart, Flutter architecture, performance, maintainability, and production-ready development.

# 7. Input Model Pattern for User Input

## Rule

Whenever a screen collects **any form of user input**, you MUST define a dedicated **Input Model** class for that screen.

## Structure

- Define the input model class **in the same file as the screen** (above the `StatefulWidget`).
- All fields represent exactly the inputs exposed by the screen's widgets — no more, no less.
- Fields are **mutable** (not `final`) since they are updated in-place.
- Provide **default values** in the constructor for every field.
- Expose **named mutator methods** per field (e.g., `selectGoal`, `selectAvailabilityDays`) instead of setting fields directly from widgets.
- Add any **derived / computed helpers** (e.g., `toPlanId()`) as methods on the model.

## Usage in the Screen

- Instantiate the model as a `final` field on the `State` class: `final MyInputModel _input = MyInputModel();`.
- Pass the **entire model object** (never individual primitives) down to child widgets that need it.
- Child widgets call the model's mutator methods, then invoke an `onChanged: () => setState(() {})` callback to trigger a rebuild.
- The model is **never** stored in a Cubit/Bloc — it lives only in the `State` and is passed to the domain layer when the user submits.

## Example (reference implementation)

```dart
// Defined in onboarding_screen.dart — above the StatefulWidget.
class OnboardingInputModel {
  OnboardingInputModel({
    this.goalId = 'build_muscle',
    this.availabilityDays = 3,
  });

  String goalId;
  int availabilityDays;

  void selectGoal(String goalId) => this.goalId = goalId;
  void selectAvailabilityDays(int days) => availabilityDays = days;

  String toPlanId() => 'plan_${goalId}_${availabilityDays}d';
}

class OnboardingScreen extends StatefulWidget { ... }

class _OnboardingScreenState extends State<OnboardingScreen> {
  final OnboardingInputModel _input = OnboardingInputModel();

  // Widgets receive _input and call setState via onChanged callback.
}
```

## Naming Convention

| Screen | Input Model |
|---|---|
| `RegistrationScreen` | `RegistrationInputModel` |
| `ProfileEditScreen` | `ProfileEditInputModel` |
| `OnboardingScreen` | `OnboardingInputModel` |

Always name the model `<ScreenName>InputModel` and the instance `_input`.
