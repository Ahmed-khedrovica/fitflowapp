import 'package:fitflowapp/generated/l10n.dart';
import 'package:flutter/widgets.dart';

/// Shorthand for [S.of(context)].
///
/// Usage: `context.localize.someKey`
extension LocalizationX on BuildContext {
  S get localize => S.of(this);
}
