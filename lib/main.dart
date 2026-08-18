import 'package:fitflowapp/core/router/app_router.dart';
import 'package:fitflowapp/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const FitFlowApp());
}

class FitFlowApp extends StatelessWidget {
  const FitFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FitFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          surface: AppColors.background,
          onSurface: AppColors.onBackground,
        ),
        textTheme: GoogleFonts.lexendTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      routerConfig: appRouter,
    );
  }
}
