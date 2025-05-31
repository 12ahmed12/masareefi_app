import 'package:flutter/material.dart';

class AppColors {
  // MAIN THEME COLORS - PURPLE TO DARK BLUE (FIXED!!!)
  static const Color mainColor = Color(0xFF8F3BB2); // PURPLE PRIMARY
  static const Color secondaryColor = Color(0xFF312E81); // DARK BLUE SECONDARY
  static const Color darkBlue = Color(0xFF1E1B4B); // VERY DARK BLUE
  static const Color mediumBlue = Color(0xFF312E81); // MEDIUM DARK BLUE

  // GRADIENT COLORS (PURPLE TO DARK BLUE)
  static const Color gradientStart = Color(0xFF8B5CF6); // PURPLE START
  static const Color gradientEnd = Color(0xFF1E1B4B); // DARK BLUE END

  // Text colors
  static const Color primaryText = Color(0xFF1F2937);
  static const Color secondaryText = Color(0xFF6B7280);
  static const Color lightText = Color(0xFF9CA3AF);

  // Background colors
  static const Color backgroundColor = Color(0xFFFAFAFA);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color inputBackground = Color(0xFFF9FAFB);

  // Border colors
  static const Color borderColor = Color(0xFFE5E7EB);
  static const Color dividerColor = Color(0xFFE5E7EB);
  static const Color focusedBorderColor = Color(0xFF8B5CF6); // PURPLE FOCUS

  // Status colors
  static const Color successColor = Color(0xFF10B981);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color infoColor = Color(0xFF3B82F6);

  // Income/Expense colors
  static const Color incomeColor = Color(0xFF10B981);
  static const Color expenseColor = Color(0xFFEF4444);

  // Social media colors
  static const Color googleColor = Color(0xFFDB4437);
  static const Color appleColor = Color(0xFF000000);

  // Legacy mappings
  static const Color gray = secondaryText;
  static const Color lightGray = lightText;
  static const Color lighterGray = borderColor;
  static const Color moreLightGray = inputBackground;
  static const Color scaffoldBackgroundColor = backgroundColor;
  static const Color suffixIconColor = lightText;

  // Category colors
  static const Color category1 = Color(0xFF10B981);
  static const Color category2 = Color(0xFFFF6B35);
  static const Color category3 = Color(0xFF3B82F6);
  static const Color category4 = Color(0xFF8B5CF6);
  static const Color category5 = Color(0xFFEF4444);
  static const Color category6 = Color(0xFFEC4899);
}