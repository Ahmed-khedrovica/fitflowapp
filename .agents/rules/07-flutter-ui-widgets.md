# FitFlow App — Project Rules

## UI & Widget Rules

### No Helper Functions That Return Widgets

**Never** create private helper methods that return a `Widget`. This pattern
is forbidden:

```dart
// ❌ FORBIDDEN — helper function returning a widget
Widget _buildHeader() {
  return Text('Hello');
}
```

**Always** extract UI into a dedicated `StatelessWidget` or `StatefulWidget`
class instead:

```dart
// ✅ CORRECT — custom widget class
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Text('Hello');
  }
}
```

### Custom Widgets Must Live in Separate Files

Every custom widget class must be placed in its own file under the
appropriate feature or shared directory. Do **not** define reusable widget
classes inside a screen/page file.

**File placement guidelines:**

- **Shared / generic widgets** → `lib/core/widgets/<widget_name>.dart`
- **Feature-specific widgets** → `lib/features/<feature>/widgets/<widget_name>.dart`
- **Screen-level private widgets** (used only by one screen) → a dedicated
  `widgets/` subfolder next to the screen file, e.g.
  `lib/features/<feature>/widgets/<widget_name>.dart`

**Naming convention:**

| Widget class | File name |
|---|---|
| `WorkoutCard` | `workout_card.dart` |
| `PrimaryButton` | `primary_button.dart` |
| `CalorieProgressBar` | `calorie_progress_bar.dart` |

### Summary Checklist

Before committing any UI code, verify:

- [ ] No `Widget _buildXxx()` private methods exist in `build()` or elsewhere.
- [ ] Every widget extracted during refactoring is a proper `class` extending
      `StatelessWidget` or `StatefulWidget`.
- [ ] Each widget class lives in its own `.dart` file following the naming
      and placement conventions above.
- [ ] `const` constructors are used wherever possible.
