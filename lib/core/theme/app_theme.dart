/*
 *  Created by Mithil Devkar
 *  Application Theme
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../constants/sizes.dart';

class AppTheme {
  AppTheme._();

  //==========================================================================
  // LIGHT THEME
  //==========================================================================

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.light,

      primaryColor: AppColor.primary,

      scaffoldBackgroundColor: AppColor.background,

      dividerColor: AppColor.divider,

      shadowColor: AppColor.shadow,

      splashFactory: InkRipple.splashFactory,

      colorScheme: const ColorScheme.light(
        primary: AppColor.primary,
        secondary: AppColor.secondary,
        surface: AppColor.surface,
        error: AppColor.error,
        outline: AppColor.border,
      ),

      appBarTheme: const AppBarTheme(
        toolbarHeight: AppSizes.appBarHeight,
        elevation: 0,
        centerTitle: false,
        backgroundColor: AppColor.surface,
        foregroundColor: AppColor.primary,
        surfaceTintColor: Colors.transparent,
      ),

      cardTheme: const CardThemeData(
        color: AppColor.card,
        elevation: AppSizes.cardElevation,
        shadowColor: AppColor.shadow,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.button,
          foregroundColor: AppColor.buttonTextColor,
          minimumSize: const Size(
            double.infinity,
            AppSizes.buttonHeight,
          ),
          elevation: AppSizes.cardElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSizes.buttonRadius,
            ),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColor.primary,
          side: const BorderSide(
            color: AppColor.border,
          ),
          minimumSize: const Size(
            double.infinity,
            AppSizes.buttonHeight,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSizes.buttonRadius,
            ),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.inputBackground,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.lg,
          vertical: AppSizes.md,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.inputRadius,
          ),
          borderSide: const BorderSide(
            color: AppColor.inputBorder,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.inputRadius,
          ),
          borderSide: const BorderSide(
            color: AppColor.inputBorder,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.inputRadius,
          ),
          borderSide: const BorderSide(
            color: AppColor.inputFocused,
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.inputRadius,
          ),
          borderSide: const BorderSide(
            color: AppColor.error,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.inputRadius,
          ),
          borderSide: const BorderSide(
            color: AppColor.error,
            width: 1.5,
          ),
        ),
      ),

      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.radiusXs,
          ),
        ),
        side: const BorderSide(
          color: AppColor.border,
          width: 1.5,
        ),
      ),

      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.radiusCircular,
          ),
        ),
        side: BorderSide.none,
      ),
    );
  }

  //==========================================================================
  // DARK THEME
  //==========================================================================

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.dark,

      primaryColor: AppColor.primary,

      scaffoldBackgroundColor: AppColor.darkBackground,

      dividerColor: AppColor.borderDark,

      shadowColor: Colors.black45,

      splashFactory: InkRipple.splashFactory,

      colorScheme: const ColorScheme.dark(
        primary: AppColor.primary,
        secondary: AppColor.secondary,
        surface: AppColor.darkSurface,
        error: AppColor.error,
        outline: AppColor.borderDark,
      ),

      appBarTheme: const AppBarTheme(
        toolbarHeight: AppSizes.appBarHeight,
        elevation: 0,
        centerTitle: false,
        backgroundColor: AppColor.darkSurface,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),

      cardTheme: const CardThemeData(
        color: AppColor.darkCard,
        elevation: AppSizes.cardElevation,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.button,
          foregroundColor: AppColor.buttonTextColor,
          minimumSize: const Size(
            double.infinity,
            AppSizes.buttonHeight,
          ),
          elevation: AppSizes.cardElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSizes.buttonRadius,
            ),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: const BorderSide(
            color: AppColor.borderDark,
          ),
          minimumSize: const Size(
            double.infinity,
            AppSizes.buttonHeight,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSizes.buttonRadius,
            ),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.inputBackgroundDark,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.lg,
          vertical: AppSizes.md,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.inputRadius,
          ),
          borderSide: const BorderSide(
            color: AppColor.borderDark,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.inputRadius,
          ),
          borderSide: const BorderSide(
            color: AppColor.borderDark,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.inputRadius,
          ),
          borderSide: const BorderSide(
            color: AppColor.primary,
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.inputRadius,
          ),
          borderSide: const BorderSide(
            color: AppColor.error,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.inputRadius,
          ),
          borderSide: const BorderSide(
            color: AppColor.error,
            width: 1.5,
          ),
        ),
      ),

      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.radiusXs,
          ),
        ),
        side: const BorderSide(
          color: AppColor.borderDark,
          width: 1.5,
        ),
      ),

      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSizes.radiusCircular,
          ),
        ),
        side: BorderSide.none,
      ),
    );
  }

  //==========================================================================
  // TEXT STYLE
  //==========================================================================

  static TextStyle textStyle({
    double size = AppSizes.fontSm,
    FontWeight weight = FontWeight.w400,
    Color? color,
    double? height,
    double? spacing,
  }) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: weight,
      color: color ??
          (Get.isDarkMode
              ? Colors.white
              : AppColor.textPrimary),
      height: height,
      letterSpacing: spacing,
    );
  }

  //==========================================================================
  // SVG COLOR
  //==========================================================================

  static ColorFilter svgColor(Color color) {
    return ColorFilter.mode(
      color,
      BlendMode.srcIn,
    );
  }
}