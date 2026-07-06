/*
 *  Created by Mithil Devkar
 *  Copyright (c) 2026.
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../theme/app_theme.dart';

class Toast {
  Toast._();

  static void success({required String message}) {
    _show(
      message: message,
      backgroundColor: AppColor.success,
      icon: Icons.check_circle_rounded,
    );
  }

  static void error({required String message}) {
    _show(
      message: message,
      backgroundColor: AppColor.error,
      icon: Icons.cancel_rounded,
    );
  }

  static void warning({required String message}) {
    _show(
      message: message,
      backgroundColor: AppColor.warning,
      icon: Icons.warning_amber_rounded,
    );
  }

  static void info({required String message}) {
    _show(
      message: message,
      backgroundColor: AppColor.info,
      icon: Icons.info_rounded,
    );
  }

  static void action({
    required String message,
    required String actionText,
    VoidCallback? onPressed,
  }) {
    Get.closeAllSnackbars();

    Get.showSnackbar(
      GetSnackBar(
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING,
        margin: const EdgeInsets.all(16),
        borderRadius: 14,
        backgroundColor: AppColor.primary,
        duration: const Duration(seconds: 4),
        boxShadows: const [
          BoxShadow(
            color: AppColor.shadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
        icon: const Icon(
          Icons.info_outline_rounded,
          color: Colors.white,
        ),
        messageText: Text(
          message,
          style: AppTheme.textStyle(
            color: Colors.white,
            size: 14,
            weight: FontWeight.w500,
          ),
        ),
        mainButton: TextButton(
          onPressed: onPressed,
          child: Text(
            actionText.toUpperCase(),
            style: AppTheme.textStyle(
              color: Colors.white,
              weight: FontWeight.w700,
              size: 13,
            ),
          ),
        ),
      ),
    );
  }

  static void _show({
    required String message,
    required Color backgroundColor,
    required IconData icon,
  }) {
    Get.closeAllSnackbars();

    Get.showSnackbar(
      GetSnackBar(
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING,
        margin: const EdgeInsets.all(16),
        borderRadius: 14,
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
        boxShadows: const [
          BoxShadow(
            color: AppColor.shadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
        icon: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        messageText: Text(
          message,
          style: AppTheme.textStyle(
            color: Colors.white,
            size: 14,
            weight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}