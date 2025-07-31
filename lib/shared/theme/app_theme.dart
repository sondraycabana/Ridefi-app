import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  // Border Radius
  static const BorderRadius radiusSmall = BorderRadius.all(Radius.circular(4));
  static const BorderRadius radiusMedium = BorderRadius.all(Radius.circular(8));
  static const BorderRadius radiusLarge = BorderRadius.all(Radius.circular(12));
  static const BorderRadius radiusXLarge = BorderRadius.all(Radius.circular(16));
  static const BorderRadius radiusRound = BorderRadius.all(Radius.circular(40));

  // Shadows
  static List<BoxShadow> get shadowSmall => [
        BoxShadow(
          color: AppColors.shadowLight,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get shadowMedium => [
        BoxShadow(
          color: AppColors.shadow,
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get shadowLarge => [
        BoxShadow(
          color: AppColors.shadow,
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ];

  static List<BoxShadow> get shadowXLarge => [
        BoxShadow(
          color: AppColors.shadowDark,
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ];

  // Elevation
  static double get elevationSmall => 2;
  static double get elevationMedium => 4;
  static double get elevationLarge => 8;
  static double get elevationXLarge => 12;

  // Input Decoration Theme
  static InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: radiusMedium,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radiusMedium,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radiusMedium,
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radiusMedium,
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: radiusMedium,
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: AppTextStyles.inputLabel,
        hintStyle: AppTextStyles.inputHint,
        errorStyle: AppTextStyles.inputError,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      );

  // Button Themes
  static ElevatedButtonThemeData get elevatedButtonTheme => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: elevationSmall,
          shadowColor: AppColors.shadow,
          shape: RoundedRectangleBorder(borderRadius: radiusRound),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: AppTextStyles.buttonMedium,
          minimumSize: const Size(120, 48),
        ),
      );

  static OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1),
          shape: RoundedRectangleBorder(borderRadius: radiusRound),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: AppTextStyles.buttonMedium.copyWith(color: AppColors.primary),
          minimumSize: const Size(120, 48),
        ),
      );

  static TextButtonThemeData get textButtonTheme => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: AppTextStyles.buttonMedium.copyWith(color: AppColors.primary),
          shape: RoundedRectangleBorder(borderRadius: radiusMedium),
        ),
      );

  // Card Theme
  static CardTheme get cardTheme => CardTheme(
        color: AppColors.surface,
        shadowColor: AppColors.shadow,
        elevation: elevationSmall,
        shape: RoundedRectangleBorder(borderRadius: radiusMedium),
        margin: const EdgeInsets.all(8),
      );

  // App Bar Theme
  static AppBarTheme get appBarTheme => const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.h5,
        iconTheme: IconThemeData(color: AppColors.textOnPrimary),
      );

  // Bottom Navigation Bar Theme
  static BottomNavigationBarThemeData get bottomNavigationBarTheme =>
      const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      );

  // Gradients
  static LinearGradient get primaryGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.gradientStart, AppColors.gradientEnd],
      );

  static LinearGradient get backgroundGradient => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.background, AppColors.surface],
      );

  // Light Theme
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          primaryContainer: AppColors.primaryLight,
          secondary: AppColors.secondary,
          secondaryContainer: AppColors.secondaryLight,
          surface: AppColors.surface,
          surfaceContainerHighest: AppColors.surfaceVariant,
          error: AppColors.error,
          onPrimary: AppColors.textOnPrimary,
          onSecondary: AppColors.textOnPrimary,
          onSurface: AppColors.textOnSurface,
          onError: AppColors.textOnPrimary,
        ),
        textTheme: const TextTheme(
          displayLarge: AppTextStyles.h1,
          displayMedium: AppTextStyles.h2,
          displaySmall: AppTextStyles.h3,
          headlineLarge: AppTextStyles.h4,
          headlineMedium: AppTextStyles.h5,
          headlineSmall: AppTextStyles.h6,
          bodyLarge: AppTextStyles.bodyLarge,
          bodyMedium: AppTextStyles.bodyMedium,
          bodySmall: AppTextStyles.bodySmall,
          labelLarge: AppTextStyles.labelLarge,
          labelMedium: AppTextStyles.labelMedium,
          labelSmall: AppTextStyles.labelSmall,
        ),
        appBarTheme: appBarTheme,
        cardTheme: cardTheme,
        elevatedButtonTheme: elevatedButtonTheme,
        outlinedButtonTheme: outlinedButtonTheme,
        textButtonTheme: textButtonTheme,
        inputDecorationTheme: inputDecorationTheme,
        bottomNavigationBarTheme: bottomNavigationBarTheme,
        scaffoldBackgroundColor: AppColors.background,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  // Dark Theme (for future use)
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryLight,
          primaryContainer: AppColors.primary,
          secondary: AppColors.secondaryLight,
          secondaryContainer: AppColors.secondary,
          surface: Color(0xFF121212),
          surfaceContainerHighest: Color(0xFF1E1E1E),
          error: AppColors.error,
          onPrimary: AppColors.textPrimary,
          onSecondary: AppColors.textPrimary,
          onSurface: Colors.white,
          onError: AppColors.textOnPrimary,
        ),
        scaffoldBackgroundColor: const Color(0xFF000000),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
}