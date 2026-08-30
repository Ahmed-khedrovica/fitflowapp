---
name: flutter-ui-builder
description: >
  Builds the presentation layer UI for a FitFlow feature.
  Reads UI specifications from the `generated_ui/` directory (if present),
  decomposes the screen into small single-responsibility widgets, places each
  widget in its own file under `widgets/`, and wires BLoC/Cubit state only
  where the data comes from the domain/data layer.
  For UI-only interaction state (expanded panels, active tabs, hover, etc.)
  it uses local `setState` inside a `StatefulWidget` — never a Cubit.
---

# Flutter UI Builder Skill

## Overview

This skill owns the **presentation layer** for a single feature.

- **Input** : a `generated_ui/<feature>/` directory containing screen
  descriptions, wireframes, or markdown specs written by the user or another
  agent. If that directory is absent the skill asks the user to describe the
  screen instead.
- **Output** : production-ready Dart files placed at
  `lib/features/<feature>/presentation/` (screens) and
  `lib/features/<feature>/widgets/` (reusable widgets).

### What this skill does NOT do

- It does **not** create or modify Cubits, use-cases, repositories, models, or
  services. Use the `flutter-feature-data-flow` skill for that.
- It does **not** add new routes. Add routes manually or with the router skill
  after this skill finishes.

---

## Step 0 — Gather Context (REQUIRED before writing any code)

Ask **all** of the following questions and wait for **all** answers.

### Q1 — Feature name
> **"Which feature are we building the UI for?
> (e.g. `onboarding`, `dashboard`, `profile`, `workout`)"**

### Q2 — Generated UI spec
> **"Is there a `generated_ui/<feature>/` directory with specs?
> If yes I'll read every file in it — including `.yaml` widget-tree exports —
> and convert them to responsive Flutter code. If no, please describe the
> screen(s) you want."**

### Q3 — Screens list
> **"List every screen that belongs to this feature.
> For each screen tell me its route name and a one-sentence purpose."**

### Q4 — Cubit / data state needed
> **"Which Cubits (from the data-flow layer) does this UI need to consume?
> List them, or say 'none' if this screen has no async data."**

### Q5 — Theme tokens
> **"Should I follow the existing `AppColors` / `AppStyles` / `AppTextStyles`
> tokens in `lib/core/theme/`, or do you want new tokens added?"**
> Default answer if skipped: **use existing tokens only**.

---

## Step 1 — Read the Generated UI Spec

If `generated_ui/<feature>/` exists, read every file in it before writing
code. Files may be:

| Extension | Treat as |
|-----------|----------|
| `.yaml`   | Figma/design-tool widget-tree export — **primary spec format** (see §1.1) |
| `.md`     | Natural-language screen description |
| `.png` / `.jpg` | Visual wireframe — describe it back to the user before building |
| `.json`   | Structured widget tree or props spec |

### 1.1 — YAML Widget-Tree Spec (Figma export format)

The YAML files exported from the design tool use the following schema:

```yaml
screen:
  name: <ScreenName>
  children:
    - type: column | row | text | icon | image | button | input
      id: <figma-node-id>       # informational only, ignore in code
      x / y: <float>            # absolute positions — IGNORE (use layouts instead)
      width / height: <float>   # treat as sizing hints, not hard-coded sizes
      padding: <float>          # uniform padding in logical pixels
      spacing: <float>          # gap / spacing between children
      background: '#RRGGBB'     # map to AppColors or inline Color
      radius: <float>           # BorderRadius.circular(radius)
      alignment: center | left | right  # crossAxisAlignment / mainAxisAlignment
      color: '#RRGGBB'          # text or icon color
      size: <float>             # font size
      fontWeight: <int>         # 100-900
      fontFamily: <string>      # map to GoogleFonts or theme TextTheme
      value: <string>           # text content
      name: <string>            # icon / image label
      url: <string>             # asset path (e.g. assets/icons/foo.svg)
      children: [...]           # recursive widget tree
```

**YAML → Flutter mapping rules:**

| YAML type | Flutter widget | Notes |
|-----------|---------------|-------|
| `column`  | `Column` | Use `spacing:` as `Column(spacing: ...)` if children > 1; wrap in `Padding` for `padding:` |
| `row`     | `Row` | Same padding/spacing rules as column |
| `text`    | `Text` | Map `fontWeight` int → `FontWeight.w<int>`. Use closest `AppTextStyles` token; only fall back to `GoogleFonts.<family>` if no token matches |
| `icon`    | `SvgPicture.asset` or `Image.asset` | Use `flutter_svg` for `.svg` assets |
| `image`   | `Image.asset` | Always add `errorBuilder` |
| `button`  | `ElevatedButton` / `TextButton` | Choose based on `background` fill |
| `input`   | `TextFormField` | Apply theme input decoration |

**Critical conversion rules:**

1. **Never hard-code `width` / `height` from the YAML** unless the element is a fixed-size icon/avatar.  
   Use `Expanded`, `Flexible`, `double.infinity`, or `LayoutBuilder` instead.
2. **Ignore `x` / `y` coordinates entirely.** All layout must be flow-based (`Column`, `Row`, `Stack` only when explicitly needed for overlapping layers).
3. **`background: '#000000'`** in container nodes is almost always a Figma canvas colour — check context before applying it. When it appears on a root column it likely means "transparent" or matches the screen background.
4. **`spacing` < 0** is a Figma glitch — treat it as `0`.
5. Map design colours to the nearest `AppColors` constant. Only add a raw `Color(0xFFRRGGBB)` if no token is close enough; log it as a TODO comment.
6. Every YAML node with `children` → a dedicated widget class in `widgets/`.

After reading all YAML files, produce a **Screen Breakdown** table:

| Screen | Purpose | Widgets to extract | State type |
|--------|---------|-------------------|------------|
| `FooScreen` | ... | `FooHeader`, `FooCard`, ... | local setState / Cubit / none |

Show this table to the user and wait for approval before generating files.

---

## Step 2 — File & Directory Layout

```
lib/features/<feature>/
├── presentation/
│   ├── <feature>_screen.dart          ← one file per screen
│   └── <other_screen>_screen.dart
└── widgets/
    ├── <feature>_<widget_a>.dart      ← one file per widget
    └── <feature>_<widget_b>.dart
```

**Rules:**

1. **One widget class per file.** No private helper widgets left at the bottom
   of a screen file — extract them immediately.
2. **File naming** : `snake_case`, always prefixed with the feature name
   (e.g. `workout_rest_timer.dart`, not `rest_timer.dart`).
3. **Class naming** : `PascalCase`, always prefixed with the feature
   (e.g. `WorkoutRestTimer`).

---

## Step 3 — State Management Policy

### 3.1 setState-first rule (default)

> **Default to `setState` for ALL interactive state.  
> Only reach for a Cubit when data must survive widget disposal or be shared
> across unrelated screen trees.**

This project intentionally keeps Cubits thin and scoped to async data loading.
Pure UI state (what is selected, what is expanded, which tab is active) stays
local to the widget via `setState`.

### 3.2 Decision tree

```
Does the state need to persist across navigation / be shared app-wide?
│
├─ YES → consume the existing Cubit via BlocBuilder / BlocConsumer
│         (NEVER create a new Cubit here — use the data-flow skill)
│
└─ NO  → StatefulWidget + setState  ← DEFAULT CHOICE
    │
    ├─ Single boolean / int / string
    │   tab index, expanded flag, hover, carousel page, char count
    │
    └─ Multiple related UI values
        form step, multi-select chip list (not persisted),
        animation stage, scroll-driven header collapse
```

### 3.3 Hard rules

- **Never** create a new Cubit solely to track UI interaction state.
- **Never** use `ValueNotifier` / `ChangeNotifier` in a widget that could
  simply call `setState` — add complexity only when there is a measurable
  benefit.
- **Never** lift UI state to a parent screen unless the child needs to
  communicate upward; in that case use a callback (`VoidCallback` or
  `ValueChanged<T>`).
- **Always** `dispose` controllers (`AnimationController`,
  `TextEditingController`, `ScrollController`) in `dispose()`.
- Use `StatelessWidget` + `const` constructors for any widget with **zero**
  mutable state.

---

## Step 4 — Widget Authoring Rules

### 4.1 Data passing
- Pass the **whole model object** when a widget needs multiple fields from it
  (e.g. `final WorkoutGoal goal;`) not individual primitives.
- Use `required` named parameters; avoid positional parameters beyond `key`.

### 4.2 Const correctness
- Every `StatelessWidget` constructor must be `const`.
- In `build()` methods, prefix every widget literal that accepts a `const`
  constructor with `const`.

### 4.3 Styling
- Use **only** existing `AppColors`, `AppStyles`, and `AppTextStyles` tokens
  unless the user approved new tokens in Q5.
- Do **not** inline `TextStyle(...)` — reference a named token.
- Border radii, paddings, and icon sizes should use the project's spacing
  constants if they exist, otherwise use `const` literals.

### 4.4 Accessibility
- Every tappable element must have a `Semantics` label or an explicit
  `tooltip`.
- Images must have `semanticLabel`.

### 4.5 Performance
- Use `ListView.builder` / `SliverList` for lists with more than ~5 items.
- Avoid `Opacity` widget for animations; prefer `AnimatedOpacity` or
  `FadeTransition`.

---

## Step 5 — Screen Scaffold Pattern

Every screen file follows this template:

```dart
// lib/features/<feature>/presentation/<feature>_<name>_screen.dart

import 'package:flutter/material.dart';
// import cubits only if consumed
// import feature widgets

/// [FeatureNameScreen] — one-line description.
class FeatureNameScreen extends StatelessWidget {
  const FeatureNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            const FeatureHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
                child: Column(
                  spacing: 24,
                  children: const [
                    FeatureSectionA(),
                    FeatureSectionB(),
                  ],
                ),
              ),
            ),
            const FeatureFooter(),
          ],
        ),
      ),
    );
  }
}
```

If a screen needs BLoC state, wrap the outermost widget with
`BlocProvider` / `BlocBuilder` — never inject the Cubit deeper than the
screen root.

---

## Step 6 — StatefulWidget Pattern (UI-only state)

```dart
// lib/features/<feature>/widgets/<feature>_<name>.dart

import 'package:flutter/material.dart';

/// [FeatureExpandableCard] — expands to show details on tap.
class FeatureExpandableCard extends StatefulWidget {
  const FeatureExpandableCard({super.key, required this.title});

  final String title;

  @override
  State<FeatureExpandableCard> createState() => _FeatureExpandableCardState();
}

class _FeatureExpandableCardState extends State<FeatureExpandableCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: AnimatedCrossFade(
        firstChild: _CollapsedView(title: widget.title),
        secondChild: _ExpandedView(title: widget.title),
        crossFadeState: _isExpanded
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 250),
      ),
    );
  }
}
```

Note: `_CollapsedView` and `_ExpandedView` are private only because they
are trivially small (< 15 lines each) **and** never referenced outside this
file. Extract to a public widget file if they grow beyond 15 lines.

---

## Step 7 — Quality Checklist (run before reporting done)

Before handing off, verify each item:

- [ ] Every widget is in its own file under `widgets/`
- [ ] No inline private widget classes left in screen files (unless < 15 lines
      and semantically inseparable)
- [ ] All `StatelessWidget` constructors are `const`
- [ ] Local UI state uses `setState`; no new Cubits created
- [ ] All imported Cubits are only consumed, never instantiated inside widgets
- [ ] Model objects passed whole, not destructured into primitives
- [ ] No raw `TextStyle(...)` in widget files — only named tokens
- [ ] `dispose()` called for every controller
- [ ] Run `dart analyze` (via `analyze_files` tool) and fix all warnings

---

## Step 8 — Handoff Report

After all files are generated, output a summary table:

| File | Type | State | Consumes Cubit |
|------|------|-------|----------------|
| `presentation/feature_screen.dart` | Screen | — | `FeatureCubit` |
| `widgets/feature_header.dart` | Widget | `StatelessWidget` | No |
| `widgets/feature_tab_bar.dart` | Widget | `StatefulWidget` (local) | No |

Then remind the user:

> **Next steps**:
> 1. Register the new screen(s) in `lib/core/router/`.
> 2. If new Cubit(s) are needed for data, run the `flutter-feature-data-flow`
>    skill first, then rerun this skill to consume them.
> 3. Run `flutter analyze` to catch any remaining issues.
