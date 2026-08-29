import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Manages the active [Locale] at runtime.
/// Call [changeLanguage] to switch the app locale globally.
class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en'));

  /// Switches the app to the given [locale].
  void changeLanguage(Locale locale) => emit(locale);
}
