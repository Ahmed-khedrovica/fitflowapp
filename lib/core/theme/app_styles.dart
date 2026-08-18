import 'package:fitflowapp/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppStyles {
  static TextStyle get splashTitle => GoogleFonts.lexend(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: AppColors.onBackground,
        height: 1,
      );

  static TextStyle get splashTagline => GoogleFonts.lexend(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: AppColors.onBackground,
        height: 1.43,
      );

  static TextStyle get onboardingTitle => GoogleFonts.plusJakartaSans(
        fontSize: 34,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        height: 1.2,
      );

  static TextStyle get onboardingSubtitle => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  static TextStyle get onboardingSectionTitle => GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get onboardingGoalTitle => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get onboardingGoalDescription => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  static TextStyle get onboardingChipLabel => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 1.2,
      );

  static TextStyle get onboardingBrand => GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        height: 1.2,
      );

  static TextStyle get onboardingContinue => GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: AppColors.surface,
        height: 1.2,
      );

  static TextStyle get onboardingFooterNote => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: AppColors.textMuted,
        letterSpacing: 0.5,
        height: 1.2,
      );

  static TextStyle get onboardingBadge => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        letterSpacing: 0.5,
        height: 1.2,
      );

  static TextStyle get onboardingCaption => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.textSubtle,
        height: 1.2,
      );
}
