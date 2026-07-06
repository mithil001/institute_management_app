/*
 * Created by Mithil
 * Centralized application color palette
 */

import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  // Brand Colors

  static const Color primary = Color(0xFF0F172A);
  static const Color secondary = Color(0xFF334155);
  static const Color tertiary = Color(0xFFF8FAFC);


  // Neutral Colors

  static const Color neutral = Color(0xFF787778);
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Backgrounds

  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  static const Color darkBackground = Color(0xFF0B1120);
  static const Color darkSurface = Color(0xFF111827);
  static const Color darkCard = Color(0xFF1E293B);

  // Text

  static const Color textPrimary = primary;
  static const Color textSecondary = secondary;
  static const Color textHint = neutral;
  static const Color textDisabled = Color(0xFFB0B0B0);

  static const Color textOnPrimary = Colors.white;
  static const Color textOnDark = Colors.white;


  // Buttons


  static const Color button = primary;
  static const Color buttonSecondary = secondary;
  static const Color buttonTextColor = Colors.white;
  static const Color buttonDisabled = Color(0xFFE2E8F0);

  // Borders & Dividers


  static const Color border = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF334155);

  static const Color divider = Color(0xFFE5E7EB);


  // Input Fields


  static const Color inputBackground = Colors.white;
  static const Color inputBackgroundDark = Color(0xFF1C1C1C);

  static const Color inputBorder = border;
  static const Color inputFocused = primary;


  // Status Colors

  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);


  // Status Backgrounds


  static const Color successLight = Color(0xFFDCFCE7);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color infoLight = Color(0xFFDBEAFE);


  // Icons

  static const Color iconPrimary = primary;
  static const Color iconSecondary = secondary;
  static const Color iconDisabled = neutral;


  // Cards


  static const Color card = Colors.white;
  static const Color cardDark = Color(0xFF1E293B);


  // Shadows


  static const Color shadow = Color(0x14000000);

  // Misc


  static const Color transparent = Colors.transparent;

  static const Color overlay = Color(0x66000000);

  // Gradients

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      Color(0xFF0F172A),
      Color(0xFF334155),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [
      Color(0xFFF8FAFC),
      Colors.white,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}