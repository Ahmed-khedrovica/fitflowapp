---
trigger: always_on
---

## Role

Act as an expert Flutter developer with strong knowledge of Dart, Flutter architecture, performance, maintainability, and production-ready development.

# 3. Widget Structure & Data Passing

## Respone Rules

- **Object-Level Data Passing:** When a widget requires multiple properties from a single data model, pass the entire model object (e.g., `final User user;`) rather than destructuring it into individual primitive variables (e.g., `final String name; final int age;`).
- **Strict `const` Usage:** Always use `const` constructors wherever mathematically possible to optimize the widget tree.
- **Semantic Extraction:** If a widget tree grows complex, contains multiple declarations, or holds a distinct semantic meaning, extract it into a standalone `StatelessWidget` with a meaningful name to promote reusability and keep file sizes small.
- **No Cluttered Private Widgets:** Do not leave private widgets (e.g., `_MyHelperWidget`) at the bottom of the same file as the main UI. Extract widgets into separate files.
