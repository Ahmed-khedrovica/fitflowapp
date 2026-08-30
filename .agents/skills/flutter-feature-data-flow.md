---
name: flutter-feature-data-flow
description: >
  Scaffolds the domain and data layers for a FitFlow feature, then generates
  one Cubit per use-case (full domain) or one Cubit per repository method
  (data layer only) to manage loading state. Creates entities, repository
  contracts, use-cases, data models, services, repository implementations,
  and Cubits. Does NOT touch screens or widgets.
---

# Flutter Feature Data-Flow Skill

## Overview

This skill sets up the **domain** and **data** layers, then generates
**Cubits** to expose that data to the presentation layer.
It does **not** modify screens or widgets.

Generated structure:

```
lib/features/<feature>/
├── domain/                          ← only when "full domain"
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── data/
│   ├── models/
│   ├── services/
│   └── repositories/
└── presentation/
    └── cubits/
        ├── <action>_cubit.dart      ← one per use-case / repo method
        └── <action>_state.dart
```

---

## Step 0 — Ask Before Writing Any Code (REQUIRED)

Before creating **any** file, ask the following questions and wait for all
answers. Do NOT assume or proceed without them.

### Q1 — Feature name
> **"Which feature are we scaffolding? (e.g. onboarding, profile, exercise)"**

### Q2 — Domain layer
> **"Do you want a full domain layer with entities and use-cases, or only the
> data layer (models, service, repository impl)?"**

- **"full domain"** → generate `domain/entities/`, `domain/repositories/`
  (abstract interface), and `domain/usecases/`.
- **"data layer only"** → skip `domain/` entirely; the repository impl exposes
  its own minimal interface or none at all.

### Q3 — Persistence backend
> **"Which storage backend should the service use?"**

- `shared_preferences` (local key-value — default)
- `hive` (local NoSQL box)
- `isar` (local relational-ish DB)
- `http` (remote REST API)
- Other (user specifies)

### Q4 — Splash routing integration
> **"Should a CheckStatus use-case be included so the splash/router can decide
> whether to skip this feature on relaunch?"**

- **Yes** → add a `Check<Feature>Status` use-case that returns `bool`.
  (Only applicable when Q2 = full domain.)
- **No** → skip.

### Q5 — State management style
> **"Do you want Cubit or BLoC for the presentation state management?"**

- **Cubit** → one `<Action>Cubit` per operation; state is emitted directly by
  calling a method on the cubit.
- **BLoC** → one `<Feature>Bloc` that handles all operations through typed
  events; state is emitted in response to dispatched events.

---

## Step 1 — Core Shared Files

Create these files in `lib/core/` **only if they do not already exist**.

### `lib/core/error/failures.dart`

```dart
/// Base class for all domain-level failures.
sealed class Failure {
  const Failure(this.message);
  final String message;
}

/// Failure originating from local storage operations.
final class LocalStorageFailure extends Failure {
  const LocalStorageFailure(super.message);
}

/// Failure originating from remote network operations.
final class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}
```

### `lib/core/usecases/use_case.dart`

Only create when the user chose **"full domain"** in Q2.

```dart
/// Generic use-case contract.
///
/// [Type] is the return type, [Params] is the input parameter type.
/// Use [NoParams] when the use-case requires no input.
abstract interface class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

/// Placeholder for use-cases that take no parameters.
final class NoParams {
  const NoParams();
}
```

---

## Step 2 — Domain Layer

> **Skip this entire step if the user answered "data layer only" in Q2.**

### 2a — Entities

Create one file per entity in `lib/features/<feature>/domain/entities/`.

Rules:
- Pure Dart only — no Flutter imports, no `dart:ui`.
- Use `final` fields with a `const` constructor.
- Prefer enums or sealed classes over plain booleans for state variants.
- Override `==` and `hashCode` for value equality.

Example:

```dart
/// Represents the user's fitness objective.
enum FitnessGoal { buildMuscle, getStrong, generalFitness }

/// Immutable snapshot of the user's onboarding selections.
final class OnboardingPreferences {
  const OnboardingPreferences({
    required this.goal,
    required this.weeklyDays,
  });

  final FitnessGoal goal;
  final int weeklyDays;

  @override
  bool operator ==(Object other) =>
      other is OnboardingPreferences &&
      other.goal == goal &&
      other.weeklyDays == weeklyDays;

  @override
  int get hashCode => Object.hash(goal, weeklyDays);
}
```

### 2b — Repository Interface

Create
`lib/features/<feature>/domain/repositories/<feature>_repository.dart`.

```dart
import '../entities/<entity>.dart';

/// Contract for persisting and retrieving <feature> data.
abstract interface class <Feature>Repository {
  Future<void> save<Entity>(<Entity> entity);
  Future<<Entity>?> load<Entity>();
  Future<bool> hasCompleted<Feature>();
}
```

### 2c — Use-Cases

Create one file per use-case in `lib/features/<feature>/domain/usecases/`.

Each use-case:
- Implements `UseCase<ReturnType, Params>` from
  `lib/core/usecases/use_case.dart`.
- Has a single `call` method.
- Receives the repository via constructor injection.
- Contains no business logic beyond delegation to the repository.

Example — save:

```dart
import 'package:fitflowapp/core/usecases/use_case.dart';
import '../entities/onboarding_preferences.dart';
import '../repositories/onboarding_repository.dart';

/// Persists the user's onboarding selections.
final class SaveOnboardingPreferences
    implements UseCase<void, OnboardingPreferences> {
  const SaveOnboardingPreferences(this._repository);

  final OnboardingRepository _repository;

  @override
  Future<void> call(OnboardingPreferences params) =>
      _repository.savePreferences(params);
}
```

Example — load:

```dart
import 'package:fitflowapp/core/usecases/use_case.dart';
import '../entities/onboarding_preferences.dart';
import '../repositories/onboarding_repository.dart';

/// Loads previously saved onboarding preferences.
/// Returns [null] if the user has not completed onboarding.
final class LoadOnboardingPreferences
    implements UseCase<OnboardingPreferences?, NoParams> {
  const LoadOnboardingPreferences(this._repository);

  final OnboardingRepository _repository;

  @override
  Future<OnboardingPreferences?> call(NoParams params) =>
      _repository.loadPreferences();
}
```

Example — check status (only when Q4 = Yes):

```dart
import 'package:fitflowapp/core/usecases/use_case.dart';
import '../repositories/onboarding_repository.dart';

/// Returns [true] if the user has already completed onboarding.
final class CheckOnboardingStatus
    implements UseCase<bool, NoParams> {
  const CheckOnboardingStatus(this._repository);

  final OnboardingRepository _repository;

  @override
  Future<bool> call(NoParams params) =>
      _repository.hasCompletedOnboarding();
}
```

---

## Step 3 — Data Layer

### 3a — Model (DTO)

Create `lib/features/<feature>/data/models/<feature>_model.dart`.

Rules:
- Named `<Entity>Model`, not `<Entity>`.
- Has a `fromJson` factory and a `toJson` method.
- When **full domain**: also has `toDomain()` and `fromDomain()`.
- When **data layer only**: omit `toDomain()` / `fromDomain()`.
- No Flutter imports.

Full-domain example:

```dart
import '../../domain/entities/onboarding_preferences.dart';

/// Data Transfer Object for [OnboardingPreferences].
final class OnboardingPreferencesModel {
  const OnboardingPreferencesModel({
    required this.goal,
    required this.weeklyDays,
  });

  final String goal;
  final int weeklyDays;

  factory OnboardingPreferencesModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      OnboardingPreferencesModel(
        goal: json['goal'] as String,
        weeklyDays: json['weekly_days'] as int,
      );

  factory OnboardingPreferencesModel.fromDomain(
    OnboardingPreferences prefs,
  ) =>
      OnboardingPreferencesModel(
        goal: prefs.goal.name,
        weeklyDays: prefs.weeklyDays,
      );

  Map<String, dynamic> toJson() => {
        'goal': goal,
        'weekly_days': weeklyDays,
      };

  OnboardingPreferences toDomain() => OnboardingPreferences(
        goal: FitnessGoal.values.byName(goal),
        weeklyDays: weeklyDays,
      );
}
```

### 3b — Service

Create
`lib/features/<feature>/data/services/<feature>_local_service.dart`
(or `_remote_service.dart` for HTTP).

Rules:
- Wraps only the storage/network package — **no business logic**.
- Returns raw primitives or `Map<String, dynamic>` — not entities or models.
- All methods are `async`.

SharedPreferences example:

```dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Low-level wrapper around [SharedPreferences] for onboarding data.
final class OnboardingLocalService {
  static const _prefsKey = 'onboarding_preferences';
  static const _completedKey = 'onboarding_completed';

  Future<void> savePreferences(Map<String, dynamic> json) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, jsonEncode(json));
    await prefs.setBool(_completedKey, true);
  }

  Future<Map<String, dynamic>?> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<bool> hasCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_completedKey) ?? false;
  }
}
```

### 3c — Repository Implementation

Create
`lib/features/<feature>/data/repositories/<feature>_repository_impl.dart`.

Rules:
- Implements the domain interface (when full domain) or its own minimal
  interface (when data layer only).
- Receives the service via constructor injection.
- Maps between models and domain entities (when full domain).
- Catches all storage/network exceptions and re-throws them as typed
  `Failure` subclasses.

Full-domain example:

```dart
import '../../domain/entities/onboarding_preferences.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../models/onboarding_preferences_model.dart';
import '../services/onboarding_local_service.dart';

/// Concrete implementation of [OnboardingRepository]
/// backed by local storage.
final class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._service);

  final OnboardingLocalService _service;

  @override
  Future<void> savePreferences(OnboardingPreferences prefs) async {
    final model = OnboardingPreferencesModel.fromDomain(prefs);
    await _service.savePreferences(model.toJson());
  }

  @override
  Future<OnboardingPreferences?> loadPreferences() async {
    final json = await _service.loadPreferences();
    if (json == null) return null;
    return OnboardingPreferencesModel.fromJson(json).toDomain();
  }

  @override
  Future<bool> hasCompletedOnboarding() => _service.hasCompleted();
}
```

Data-layer-only example (no domain entity — returns model directly):

```dart
import '../models/onboarding_preferences_model.dart';
import '../services/onboarding_local_service.dart';

final class OnboardingRepositoryImpl {
  const OnboardingRepositoryImpl(this._service);

  final OnboardingLocalService _service;

  Future<void> savePreferences(OnboardingPreferencesModel model) =>
      _service.savePreferences(model.toJson());

  Future<OnboardingPreferencesModel?> loadPreferences() async {
    final json = await _service.loadPreferences();
    if (json == null) return null;
    return OnboardingPreferencesModel.fromJson(json);
  }

  Future<bool> hasCompletedOnboarding() => _service.hasCompleted();
}
```

---

## Step 4 — Package Dependency

Before writing any service file, verify the storage package exists in
`pubspec.yaml`. Add it if missing using the `pub` MCP tool or:

```shell
# shared_preferences
flutter pub add shared_preferences

# hive
flutter pub add hive hive_flutter

# isar
flutter pub add isar isar_flutter isar_generator
```

> Always check pub.dev for the latest stable version. Never assume a version.

---

## Step 5 — State Management

Generate presentation-layer state classes based on the user's answer to **Q5**.

### Rule for number of classes

| Q5 answer | Q2 = full domain | Q2 = data layer only |
|---|---|---|
| **Cubit** | One `<Action>Cubit` per **use-case** | One `<Action>Cubit` per **repo method** |
| **BLoC** | One `<Feature>Bloc` covering **all events** | One `<Feature>Bloc` covering **all repo methods** |

---

### State pattern (shared by both Cubit and BLoC)

Each operation gets its own sealed state hierarchy.
For operations with a return value:

```dart
sealed class LoadPreferencesState {
  const LoadPreferencesState();
}

final class LoadPreferencesInitial extends LoadPreferencesState {
  const LoadPreferencesInitial();
}

final class LoadPreferencesLoading extends LoadPreferencesState {
  const LoadPreferencesLoading();
}

/// Carries the result on success.
final class LoadPreferencesLoaded extends LoadPreferencesState {
  const LoadPreferencesLoaded(this.data);
  final OnboardingPreferences data; // replace with actual return type
}

final class LoadPreferencesFailure extends LoadPreferencesState {
  const LoadPreferencesFailure(this.message);
  final String message;
}
```

> For `void` operations (e.g. save), replace `<Action>Loaded` with
> `<Action>Success` (no data field).

---

### Option A — Cubit (Q5 = "Cubit")

Files live in `lib/features/<feature>/presentation/cubits/`.
One pair of files per operation:

```
cubits/
├── load_preferences_cubit.dart
├── load_preferences_state.dart
├── save_preferences_cubit.dart
└── save_preferences_state.dart
```

**With use-case (full domain):**

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/load_onboarding_preferences.dart';
import '../../domain/usecases/use_case.dart';
import 'load_preferences_state.dart';

/// Manages state for the [LoadOnboardingPreferences] use-case.
final class LoadPreferencesCubit extends Cubit<LoadPreferencesState> {
  LoadPreferencesCubit(this._useCase)
      : super(const LoadPreferencesInitial());

  final LoadOnboardingPreferences _useCase;

  Future<void> load() async {
    emit(const LoadPreferencesLoading());
    try {
      final result = await _useCase(const NoParams());
      emit(
        result == null
            ? const LoadPreferencesInitial()
            : LoadPreferencesLoaded(result),
      );
    } catch (e) {
      emit(LoadPreferencesFailure(e.toString()));
    }
  }
}
```

**Without use-case (data layer only):**

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/onboarding_repository_impl.dart';
import 'load_preferences_state.dart';

/// Manages state for loading preferences via [OnboardingRepositoryImpl].
final class LoadPreferencesCubit extends Cubit<LoadPreferencesState> {
  LoadPreferencesCubit(this._repository)
      : super(const LoadPreferencesInitial());

  final OnboardingRepositoryImpl _repository;

  Future<void> load() async {
    emit(const LoadPreferencesLoading());
    try {
      final result = await _repository.loadPreferences();
      emit(
        result == null
            ? const LoadPreferencesInitial()
            : LoadPreferencesLoaded(result),
      );
    } catch (e) {
      emit(LoadPreferencesFailure(e.toString()));
    }
  }
}
```

**Naming convention:**

| Method / use-case | Cubit class | State base |
|---|---|---|
| `loadPreferences` | `LoadPreferencesCubit` | `LoadPreferencesState` |
| `savePreferences` | `SavePreferencesCubit` | `SavePreferencesState` |
| `hasCompletedOnboarding` | `CheckOnboardingStatusCubit` | `CheckOnboardingStatusState` |

Use **verb + noun** derived from the use-case or repository method.

---

### Option B — BLoC (Q5 = "BLoC")

One BLoC per feature. Files live in
`lib/features/<feature>/presentation/bloc/`.

```
bloc/
├── <feature>_bloc.dart
├── <feature>_event.dart
└── <feature>_state.dart
```

**Events** — one sealed subclass per operation:

```dart
sealed class OnboardingEvent {
  const OnboardingEvent();
}

final class LoadPreferencesRequested extends OnboardingEvent {
  const LoadPreferencesRequested();
}

final class SavePreferencesRequested extends OnboardingEvent {
  const SavePreferencesRequested(this.preferences);
  final OnboardingPreferences preferences;
}
```

**State** — a single sealed hierarchy covering all operations:

```dart
sealed class OnboardingState {
  const OnboardingState();
}

final class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

final class OnboardingLoading extends OnboardingState {
  const OnboardingLoading();
}

final class OnboardingPreferencesLoaded extends OnboardingState {
  const OnboardingPreferencesLoaded(this.preferences);
  final OnboardingPreferences preferences;
}

final class OnboardingPreferencesSaved extends OnboardingState {
  const OnboardingPreferencesSaved();
}

final class OnboardingFailure extends OnboardingState {
  const OnboardingFailure(this.message);
  final String message;
}
```

**BLoC — with use-cases (full domain):**

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/load_onboarding_preferences.dart';
import '../../domain/usecases/save_onboarding_preferences.dart';
import '../../domain/usecases/use_case.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

/// Handles all onboarding data operations.
final class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc({
    required LoadOnboardingPreferences loadPreferences,
    required SaveOnboardingPreferences savePreferences,
  })  : _loadPreferences = loadPreferences,
        _savePreferences = savePreferences,
        super(const OnboardingInitial()) {
    on<LoadPreferencesRequested>(_onLoadRequested);
    on<SavePreferencesRequested>(_onSaveRequested);
  }

  final LoadOnboardingPreferences _loadPreferences;
  final SaveOnboardingPreferences _savePreferences;

  Future<void> _onLoadRequested(
    LoadPreferencesRequested event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(const OnboardingLoading());
    try {
      final result = await _loadPreferences(const NoParams());
      emit(
        result == null
            ? const OnboardingInitial()
            : OnboardingPreferencesLoaded(result),
      );
    } catch (e) {
      emit(OnboardingFailure(e.toString()));
    }
  }

  Future<void> _onSaveRequested(
    SavePreferencesRequested event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(const OnboardingLoading());
    try {
      await _savePreferences(event.preferences);
      emit(const OnboardingPreferencesSaved());
    } catch (e) {
      emit(OnboardingFailure(e.toString()));
    }
  }
}
```

**BLoC — without use-cases (data layer only):**
Replace each use-case constructor parameter with the repository impl directly
and call its methods inline inside the handlers.

### State pattern

Every state file uses a **sealed class** with four variants:

```dart
/// Represents all possible states for the load-preferences operation.
sealed class LoadPreferencesState {
  const LoadPreferencesState();
}

/// Initial state before any operation has been triggered.
final class LoadPreferencesInitial extends LoadPreferencesState {
  const LoadPreferencesInitial();
}

/// Operation is in progress.
final class LoadPreferencesLoading extends LoadPreferencesState {
  const LoadPreferencesLoading();
}

/// Operation completed successfully.
final class LoadPreferencesLoaded extends LoadPreferencesState {
  const LoadPreferencesLoaded(this.preferences);
  final OnboardingPreferences preferences; // replace with actual return type
}

/// Operation failed.
final class LoadPreferencesFailure extends LoadPreferencesState {
  const LoadPreferencesFailure(this.message);
  final String message;
}
```

> For operations that return `void` (e.g. save), omit the `Loaded` data
> payload and use a `SavePreferencesSuccess` state instead.

### Cubit pattern — with use-case (full domain)

The Cubit receives the use-case via constructor injection.

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/load_onboarding_preferences.dart';
import '../../domain/usecases/use_case.dart';
import 'load_preferences_state.dart';

/// Manages the state for the [LoadOnboardingPreferences] use-case.
final class LoadPreferencesCubit extends Cubit<LoadPreferencesState> {
  LoadPreferencesCubit(this._loadPreferences)
      : super(const LoadPreferencesInitial());

  final LoadOnboardingPreferences _loadPreferences;

  Future<void> load() async {
    emit(const LoadPreferencesLoading());
    try {
      final prefs = await _loadPreferences(const NoParams());
      if (prefs == null) {
        emit(const LoadPreferencesInitial());
      } else {
        emit(LoadPreferencesLoaded(prefs));
      }
    } catch (e) {
      emit(LoadPreferencesFailure(e.toString()));
    }
  }
}
```

### Cubit pattern — without use-case (data layer only)

The Cubit receives the repository directly.

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/onboarding_repository_impl.dart';
import 'load_preferences_state.dart';

/// Manages the state for loading preferences from [OnboardingRepositoryImpl].
final class LoadPreferencesCubit extends Cubit<LoadPreferencesState> {
  LoadPreferencesCubit(this._repository)
      : super(const LoadPreferencesInitial());

  final OnboardingRepositoryImpl _repository;

  Future<void> load() async {
    emit(const LoadPreferencesLoading());
    try {
      final model = await _repository.loadPreferences();
      if (model == null) {
        emit(const LoadPreferencesInitial());
      } else {
        emit(LoadPreferencesLoaded(model));
      }
    } catch (e) {
      emit(LoadPreferencesFailure(e.toString()));
    }
  }
}
```

### Naming convention

| Operation | Cubit class | State base class |
|---|---|---|
| Load preferences | `LoadPreferencesCubit` | `LoadPreferencesState` |
| Save preferences | `SavePreferencesCubit` | `SavePreferencesState` |
| Check onboarding status | `CheckOnboardingStatusCubit` | `CheckOnboardingStatusState` |

Use the **verb + noun** from the use-case or repository method name.

---

## Step 6 — Verification

Run after all files are written:

```shell
flutter pub get
flutter analyze
```

Checklist:
- [ ] `flutter analyze` — zero errors, zero warnings.
- [ ] Every Cubit transitions through `Loading` → `Loaded` or `Failure`.
- [ ] Every use-case can be instantiated with a fake repository in a unit test.
- [ ] Service reads and writes raw data without transformation.
- [ ] Repository impl correctly maps between model and entity (full domain) or
  works with the model directly (data layer only).
