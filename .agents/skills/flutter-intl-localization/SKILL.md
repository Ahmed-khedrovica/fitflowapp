---
name: flutter-intl-localization
description: >
  Sets up Flutter Intl (intl_utils) localization with ARB files, a LanguageCubit
  for runtime locale switching, and a BuildContext extension for ergonomic key
  access. Use when adding multi-language support to a Flutter app using the
  Flutter Intl VS Code extension workflow.
---

# Flutter Intl Localization Skill

## Overview

This skill integrates the **Flutter Intl** (`intl_utils`) localization system into
a Flutter app. It covers:

1. Adding required dependencies to `pubspec.yaml`
2. Creating ARB translation files (`lib/l10n/`)
3. Generating localization code via `intl_utils`
4. Creating a `LanguageCubit` for runtime locale switching
5. Creating a `BuildContext` extension for ergonomic key access
6. Wiring everything into `MaterialApp` / `MaterialApp.router`

---

## Step 0 — Ask the User (Required)

Before writing any code:

> **"What should be the default (main) locale for the app?"**
> **"Which additional locales do you want to support from the start?"**

Do NOT assume a default locale. Wait for the user's answers.

---

## Step 1 — Add Dependencies

### `pubspec.yaml` changes

```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: ^0.20.2          # Check pub.dev for latest
  flutter_bloc: ^9.1.1   # Check pub.dev for latest

dev_dependencies:
  intl_utils: ^2.8.9     # Check pub.dev for latest

flutter_intl:
  enabled: true
  class_name: S
  main_locale: en                # Replace with the user chosen main locale
  arb_dir: lib/l10n
  output_dir: lib/generated
```

> **Always verify latest stable versions on pub.dev before pinning.**

---

## Step 2 — Create ARB Files

### `lib/l10n/intl_<main_locale>.arb` (source of truth)

```json
{
  "@@locale": "en",
  "appName": "My App",
  "continueButton": "Continue"
}
```

### `lib/l10n/intl_<other_locale>.arb` (translations)

```json
{
  "@@locale": "ar",
  "appName": "تطبيقي",
  "continueButton": "متابعة"
}
```

**Rules:**
- All keys in the main ARB must also exist in every other ARB file.
- Use ICU format for plurals, genders, and selects.
- Never edit files inside `lib/generated/` — they are auto-generated.

---

## Step 3 — Generate Localization Code

Run:

```shell
flutter pub get
dart run intl_utils:generate
```

This creates:
- `lib/generated/l10n.dart` — the `S` class
- `lib/generated/intl/messages_all.dart`
- `lib/generated/intl/messages_<locale>.dart` (one per locale)

> **Commit generated files** — they must be in version control.

---

## Step 4 — Create `LanguageCubit`

**File:** `lib/core/localization/language_cubit.dart`

```dart
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Manages the active [Locale] at runtime.
/// Call [changeLanguage] to switch the app locale globally.
class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en')); // Replace with main locale

  /// Switches the app to the given [locale].
  void changeLanguage(Locale locale) => emit(locale);
}
```

---

## Step 5 — Create Context Extension

**File:** `lib/core/localization/localization_extension.dart`

```dart
import 'package:flutter/widgets.dart';
import 'package:yourapp/generated/l10n.dart'; // Adjust import to your package

/// Shorthand for [S.of(context)].
/// Usage: `context.localize.someKey`
extension LocalizationX on BuildContext {
  S get localize => S.of(this);
}
```

> **Naming convention:** Use `localize` (not `l10n`) as the getter name.

---

## Step 6 — Wire into `main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yourapp/core/localization/language_cubit.dart';
import 'package:yourapp/generated/l10n.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => LanguageCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp.router(
          locale: locale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          routerConfig: appRouter,
        );
      },
    );
  }
}
```

---

## Step 7 — iOS Setup

Add to `ios/Runner/Info.plist`:

```xml
<key>CFBundleLocalizations</key>
<array>
  <string>en</string>
  <string>ar</string>
</array>
```

This list must stay in sync with the locales in `lib/l10n/`.

---

## Usage Examples

### Switching Language

```dart
context.read<LanguageCubit>().changeLanguage(const Locale('ar'));
context.read<LanguageCubit>().changeLanguage(const Locale('en'));
```

### Accessing Strings

```dart
// Via context extension (preferred):
Text(context.localize.welcomeTitle)

// Via S.of(context) directly:
Text(S.of(context).welcomeTitle)

// Without context (e.g., outside widget tree):
Text(S.current.welcomeTitle)
```

### ARB Key with Placeholder

```json
{
  "welcomeUser": "Welcome, {name}!",
  "@welcomeUser": {
    "placeholders": {
      "name": { "type": "String" }
    }
  }
}
```

```dart
Text(context.localize.welcomeUser('John'))
```

### Plural Key

```json
{
  "messageCount": "{count, plural, one{1 message} other{{count} messages}}",
  "@messageCount": {
    "placeholders": {
      "count": { "type": "int" }
    }
  }
}
```

```dart
Text(context.localize.messageCount(5))
```

---

## Verification Checklist

- [ ] `flutter pub get` succeeds with no conflicts
- [ ] `dart run intl_utils:generate` produces files in `lib/generated/`
- [ ] `flutter analyze` reports no errors
- [ ] App builds and displays strings in the default locale
- [ ] Calling `changeLanguage(Locale('ar'))` rebuilds the app in Arabic
- [ ] `context.localize.<key>` resolves with IDE auto-complete
- [ ] iOS `Info.plist` updated if targeting iOS

---

## Re-running Code Generation

Run after every change to any `.arb` file:

```shell
dart run intl_utils:generate
```

Or install the **Flutter Intl** VS Code extension to auto-generate on save.
