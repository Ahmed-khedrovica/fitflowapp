import 'package:fitflowapp/core/localization/language_cubit.dart';
import 'package:fitflowapp/core/router/app_router.dart';
import 'package:fitflowapp/core/theme/app_colors.dart';
import 'package:fitflowapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => LanguageCubit(),
      child: const FitFlowApp(),
    ),
  );
}

class FitFlowApp extends StatelessWidget {
  const FitFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp.router(
          title: 'FitFlow',
          debugShowCheckedModeBanner: false,
          locale: locale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
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
      },
    );
  }
}
