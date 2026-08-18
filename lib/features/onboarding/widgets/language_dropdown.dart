import 'package:flutter/material.dart';
import 'package:fitflowapp/core/theme/app_colors.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String _selectedValue = 'English';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: AppColors.onBackground,
          value: _selectedValue,
          icon: const Icon(
            Icons.language,
            size: 20,
            color: AppColors.textSecondary,
          ),
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
          items: const [
            DropdownMenuItem(value: 'English', child: Text('English ')),
            DropdownMenuItem(value: 'Arabic', child: Text('Arabic')),
          ],
          onChanged: (String? value) {
            if (value != null) {
              setState(() {
                _selectedValue = value;
              });
            }
          },
        ),
      ),
    );
  }
}
