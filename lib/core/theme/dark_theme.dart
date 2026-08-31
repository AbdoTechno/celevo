import 'package:celevo/core/sizes/app_sizes.dart';
import 'package:celevo/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData get darkTheme => ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,

  // =========================
  // Color Scheme
  // =========================
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primary,
    onPrimary: Colors.white,

    secondary: AppColors.primary,
    onSecondary: Colors.white,

    surface: AppColors.darkSurface,
    onSurface: AppColors.textPrimaryDark,

    error: AppColors.error,
    onError: Colors.white,
  ),

  scaffoldBackgroundColor: AppColors.darkBackground,

  // =========================
  // Typography
  // =========================
  textTheme: GoogleFonts.manropeTextTheme(
    TextTheme(
      displayLarge: TextStyle(
        fontSize: AppSizes.fontSize40,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        height: 1.15,
      ),

      displayMedium: TextStyle(
        fontSize: AppSizes.fontSize24,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        height: 1.2,
      ),

      headlineLarge: TextStyle(
        fontSize: AppSizes.fontSize24,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimaryDark,
        height: 1.2,
      ),

      headlineMedium: TextStyle(
        fontSize: AppSizes.fontSize20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDark,
        height: 1.25,
      ),

      headlineSmall: TextStyle(
        fontSize: AppSizes.fontSize18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDark,
        height: 1.25,
      ),

      titleLarge: TextStyle(
        fontSize: AppSizes.fontSize18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDark,
        height: 1.3,
      ),

      titleMedium: TextStyle(
        fontSize: AppSizes.fontSize16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDark,
        height: 1.3,
      ),

      titleSmall: TextStyle(
        fontSize: AppSizes.fontSize14,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondaryDark,
        height: 1.3,
      ),

      bodyLarge: TextStyle(
        fontSize: AppSizes.fontSize16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimaryDark,
        height: 1.5,
      ),

      bodyMedium: TextStyle(
        fontSize: AppSizes.fontSize14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondaryDark,
        height: 1.5,
      ),

      bodySmall: TextStyle(
        fontSize: AppSizes.fontSize12,
        fontWeight: FontWeight.w400,
        color: AppColors.textMutedDark,
        height: 1.4,
      ),

      labelLarge: TextStyle(
        fontSize: AppSizes.fontSize14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDark,
      ),

      labelMedium: TextStyle(
        fontSize: AppSizes.fontSize12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondaryDark,
      ),

      labelSmall: TextStyle(
        fontSize: AppSizes.fontSize12,
        fontWeight: FontWeight.w500,
        color: AppColors.textMutedDark,
      ),
    ),
  ),

  // =========================
  // AppBar
  // =========================
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkBorder,
    foregroundColor: AppColors.textPrimaryDark,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: GoogleFonts.manrope(
      fontSize: AppSizes.fontSize20,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimaryDark,
    ),
  ),

  // =========================
  // Cards
  // =========================
  cardTheme: const CardThemeData(
    color: AppColors.darkCard,
    elevation: 0,
    margin: EdgeInsets.zero,
  ),

  // =========================
  // Divider
  // =========================
  dividerTheme: DividerThemeData(
    color: AppColors.darkBorder,
    thickness: AppSizes.borderWidth2,
  ),

  // =========================
  // Icons
  // =========================
  iconTheme: IconThemeData(
    color: AppColors.textSecondaryDark,
    size: AppSizes.iconSize24,
  ),

  // =========================
  // Inputs
  // =========================
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkCard,

    contentPadding: EdgeInsets.symmetric(
      horizontal: AppSizes.spacingWidth16,
      vertical: AppSizes.spacingHeight12,
    ),

    hintStyle: TextStyle(
      color: AppColors.textMutedDark,
      fontSize: AppSizes.fontSize14,
      fontWeight: FontWeight.w400,
    ),

    labelStyle: TextStyle(
      color: AppColors.textSecondaryDark,
      fontSize: AppSizes.fontSize14,
      fontWeight: FontWeight.w400,
    ),

    prefixIconColor: AppColors.textSecondaryDark,

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        AppSizes.borderRadius16,
      ),
      borderSide: const BorderSide(
        color: AppColors.darkBorder,
      ),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        AppSizes.borderRadius16,
      ),
      borderSide: const BorderSide(
        color: AppColors.darkBorder,
      ),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        AppSizes.borderRadius16,
      ),
      borderSide: BorderSide(
        color: AppColors.primary,
        width: AppSizes.borderWidth2,
      ),
    ),
  ),

  // =========================
  // Buttons
  // =========================
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,

      minimumSize: Size(0, AppSizes.spacingHeight52),

      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spacingWidth16,
      ),

      textStyle: TextStyle(
        fontSize: AppSizes.fontSize14,
        fontWeight: FontWeight.w600,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppSizes.borderRadius12,
        ),
      ),
    ),
  ),

  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,

      minimumSize: Size(0, AppSizes.spacingHeight52),

      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spacingWidth16,
      ),

      textStyle: TextStyle(
        fontSize: AppSizes.fontSize14,
        fontWeight: FontWeight.w600,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppSizes.borderRadius12,
        ),
      ),
    ),
  ),

  // =========================
  // FAB
  // =========================
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 0,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        AppSizes.borderRadius16,
      ),
    ),
  ),

  // =========================
  // Bottom Sheet
  // =========================
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: AppColors.darkSurface,
    modalBackgroundColor: AppColors.darkSurface,
    showDragHandle: true,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppSizes.borderRadius24),
      ),
    ),
  ),

  // =========================
  // Progress
  // =========================
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.primary,
  ),
);
