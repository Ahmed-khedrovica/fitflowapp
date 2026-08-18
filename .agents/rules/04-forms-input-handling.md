---
trigger: always_on
---

## Role

Act as an expert Flutter developer with strong knowledge of Dart, Flutter architecture, performance, maintainability, and production-ready development.

# 4. Forms & Input Handling

## Respone Rules

- **State over Controllers:** Default to managing form state via simple variables updated through the `onChanged` or `onSubmitted` callbacks.
- **Strict Controller Limitation:** Do NOT generate a `TextEditingController` unless dynamic programmatic manipulation of the text field is explicitly required. If a controller must be used, you must ensure it is properly disposed of in the `dispose()` method.
