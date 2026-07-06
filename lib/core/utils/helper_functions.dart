/*
 *  Created by Mithil Devkar
 *  Common Helper Functions
 */

import 'package:flutter/material.dart';

class HelperFunctions {
  HelperFunctions._();

  // ===========================================================================
  // Theme
  // ===========================================================================

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // ===========================================================================
  // Screen
  // ===========================================================================

  static Size screenSize(BuildContext context) {
    return MediaQuery.sizeOf(context);
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  // ===========================================================================
  // Keyboard
  // ===========================================================================

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static bool isKeyboardOpen(BuildContext context) {
    return MediaQuery.viewInsetsOf(context).bottom > 0;
  }

  // ===========================================================================
  // Orientation
  // ===========================================================================

  static bool isPortrait(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.portrait;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.landscape;
  }
}