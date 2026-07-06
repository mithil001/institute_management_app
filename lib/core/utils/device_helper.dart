/*
 *  Created by Mithil Devkar
 *  Device Helper
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeviceHelper {
  DeviceHelper._();


  // Keyboard

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  static double keyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }


  // Screen Size


  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Orientation

  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  // Device Type

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide < 600;
  }


  // Safe Area


  static double statusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double bottomInset(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  // Constants

  static double appBarHeight() {
    return kToolbarHeight;
  }

  static double bottomNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }


  // System UI
  

  static Future<void> setStatusBarColor(
      Color color, {
        Brightness iconBrightness = Brightness.light,
      }) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarIconBrightness: iconBrightness,
        statusBarBrightness: iconBrightness,
      ),
    );
  }

  static Future<void> setFullScreen(bool enabled) async {
    await SystemChrome.setEnabledSystemUIMode(
      enabled
          ? SystemUiMode.immersiveSticky
          : SystemUiMode.edgeToEdge,
    );
  }
}