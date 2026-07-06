/*
 *  Created by Mithil Devkar
 *  Application Loader
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class Loader {
  Loader._();

  static bool _isLoading = false;

  static void showLoader() {
    if (_isLoading) return;

    FocusManager.instance.primaryFocus?.unfocus();
    _isLoading = true;

    Get.dialog(
      PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.black.withValues(alpha: 0.35),
          body: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: AppSizes.loaderSize,
                  height: AppSizes.loaderSize,
                  decoration: BoxDecoration(
                    color: AppColor.surface,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.shadow,
                        blurRadius: 18,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: AppSizes.loaderSize,
                  height: AppSizes.loaderSize,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    color: AppColor.primary,
                  ),
                ),
            ///temp loader
                FlutterLogo(
                  size: AppSizes.loaderLogo,
                ),
                ///replace FlutterLogo with :
                //Image.asset(
                //   AssetPath.appLogo,
                //   width: AppDimensions.loaderLogoSize,
                //   height: AppDimensions.loaderLogoSize,
                // )
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.transparent,
    );
  }

  static void hideLoader() {
    if (!_isLoading) return;

    _isLoading = false;

    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}