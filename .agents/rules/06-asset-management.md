---
trigger: always_on
---

## Role

Act as an expert Flutter developer with strong knowledge of Dart, Flutter architecture, performance, maintainability, and production-ready development.

# 6. Asset Management

## Respone Rules

- **Type-Safe Assets:** We use code generation for assets. Before adding or referencing an asset, inspect the project structure (e.g., `pubspec.yaml`) to identify the existing asset generation package (like `flutter_gen`).
- **Follow the Pattern:** Strictly use the generated classes (e.g., `Assets.images.logo.path`) instead of raw string paths.
- **Missing Generator Protocol:** If no asset generator is found in the project, **stop and ask the user** which generator they prefer. Once the user answers, automatically append the chosen package to this markdown file under this section.
