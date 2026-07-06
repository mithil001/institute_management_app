/*
 *  Created by Mithil Devkar
 *  Common Confirmation Dialog
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../theme/app_theme.dart';

class ConfirmationDialog {
  ConfirmationDialog._();

  static Future<void> show({
    required String title,
    required String message,

    String confirmText = "Confirm",
    String cancelText = "Cancel",

    VoidCallback? onConfirm,
    VoidCallback? onCancel,

    bool showCancel = true,
    bool barrierDismissible = false,

    IconData icon = Icons.info_outline_rounded,
    Color iconColor = AppColor.primary,
  }) {
    return Get.dialog(
      PopScope(
        canPop: barrierDismissible,
        child: Dialog(
          backgroundColor: Get.isDarkMode
              ? AppColor.darkCard
              : AppColor.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
               AppSizes.radiusLg,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(
               AppSizes.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// Icon
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 36,
                    color: iconColor,
                  ),
                ),

                const SizedBox(
                  height:  AppSizes.lg,
                ),

                /// Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTheme.textStyle(
                    size:  AppSizes.fontXl,
                    weight: FontWeight.w700,
                  ),
                ),

                const SizedBox(
                  height:  AppSizes.sm,
                ),

                /// Message
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTheme.textStyle(
                    size:  AppSizes.fontSm,
                    color: AppColor.textSecondary,
                    height: 1.5,
                  ),
                ),

                const SizedBox(
                  height:  AppSizes.xl,
                ),

                /// Buttons
                Row(
                  children: [

                    if (showCancel)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Get.back();

                            onCancel?.call();
                          },
                          child: Text(cancelText),
                        ),
                      ),

                    if (showCancel)
                      const SizedBox(
                        width:  AppSizes.md,
                      ),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();

                          onConfirm?.call();
                        },
                        child: Text(confirmText),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }
}