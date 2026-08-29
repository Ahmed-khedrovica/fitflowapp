import 'package:fitflowapp/core/localization/language_cubit.dart';
import 'package:fitflowapp/core/localization/localization_extension.dart';
import 'package:fitflowapp/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key});

  static const _locales = [Locale('en'), Locale('ar')];

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.watch<LanguageCubit>().state;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Locale>(
          dropdownColor: AppColors.onBackground,
          value: currentLocale,
          icon: const Icon(
            Icons.language,
            size: 20,
            color: AppColors.textSecondary,
          ),
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
          items: [
            DropdownMenuItem(
              value: _locales[0],
              child: Text(context.localize.english),
            ),
            DropdownMenuItem(
              value: _locales[1],
              child: Text(context.localize.arabic),
            ),
          ],
          onChanged: (Locale? locale) {
            if (locale != null) {
              context.read<LanguageCubit>().changeLanguage(locale);
            }
          },
        ),
      ),
    );
  }
}
