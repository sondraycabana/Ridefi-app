import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF42A5F5);
  static const Color primaryDark = Color(0xFF0D47A1);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF2E5E5A);
  static const Color secondaryLight = Color(0xFF4CAF50);
  static const Color secondaryDark = Color(0xFF1B5E20);
  
  // Background Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFE8EDF5);
  static const Color cardBackground = Color(0xFF2E5E5A);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textOnPrimary = Colors.white;
  static const Color textOnSurface = Color(0xFF212121);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Neutral Colors
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);
  
  // Gradient Colors
  static const Color gradientStart = Color(0xFFD4E8DA);
  static const Color gradientEnd = Color(0xFFE8F5E8);
  
  // Shadow Colors
  static Color shadow = Colors.black.withValues(alpha: 0.15);
  static Color shadowLight = Colors.black.withValues(alpha: 0.08);
  static Color shadowDark = Colors.black.withValues(alpha: 0.25);
  
  // Flight Status Colors
  static const Color flightDirect = Color(0xFF4CAF50);
  static const Color flightConnecting = Color(0xFFFF9800);
  static const Color flightDelayed = Color(0xFFF44336);
  
  // Price Colors
  static const Color priceHigh = Color(0xFFF44336);
  static const Color priceMedium = Color(0xFFFF9800);
  static const Color priceLow = Color(0xFF4CAF50);
}