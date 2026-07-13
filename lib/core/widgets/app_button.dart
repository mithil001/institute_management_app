import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/sizes.dart';
import '../theme/app_theme.dart';

enum ButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  final bool enabled;
  final bool isLoading;

  final ButtonSize size;

  final IconData? prefixIcon;
  final IconData? suffixIcon;

  final double? width;
  final double? height;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final BorderRadius? borderRadius;

  final EdgeInsetsGeometry? padding;

  final bool expanded;

  final bool outlined;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.enabled = true,
    this.isLoading = false,
    this.size = ButtonSize.medium,
    this.prefixIcon,
    this.suffixIcon,
    this.width,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.padding,
    this.expanded = true,
  }) : outlined = false;

  const AppButton.outlined({
    super.key,
    required this.text,
    this.onPressed,
    this.enabled = true,
    this.isLoading = false,
    this.size = ButtonSize.medium,
    this.prefixIcon,
    this.suffixIcon,
    this.width,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.padding,
    this.expanded = true,
  }) : outlined = true;

  double get _height {
    switch (size) {
      case ButtonSize.small:
        return 44;

      case ButtonSize.medium:
        return AppSizes.buttonHeight;

      case ButtonSize.large:
        return 58;
    }
  }

  double get _fontSize {
    switch (size) {
      case ButtonSize.small:
        return AppSizes.fontSm;

      case ButtonSize.medium:
        return AppSizes.fontMd;

      case ButtonSize.large:
        return AppSizes.fontLg;
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = SizedBox(
      width: expanded ? double.infinity : width,
      height: height ?? _height,
      child: outlined
          ? OutlinedButton(
              onPressed:
                  enabled && !isLoading ? onPressed : null,
              style: OutlinedButton.styleFrom(
                foregroundColor: foregroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius ??
                      BorderRadius.circular(
                        AppSizes.buttonRadius,
                      ),
                ),
                padding: padding,
              ),
              child: _buildChild(),
            )
          : ElevatedButton(
              onPressed:
                  enabled && !isLoading ? onPressed : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius ??
                      BorderRadius.circular(
                        AppSizes.buttonRadius,
                      ),
                ),
                padding: padding,
              ),
              child: _buildChild(),
            ),
    );

    return expanded ? child : IntrinsicWidth(child: child);
  }

  Widget _buildChild() {
    if (isLoading) {
      return const SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColor.white,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          Icon(prefixIcon, size: AppSizes.buttonIconSize),
          const SizedBox(width: AppSizes.sm),
        ],
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.textStyle(
              size: _fontSize,
              weight: FontWeight.w600,
            ),
          ),
        ),
        if (suffixIcon != null) ...[
          const SizedBox(width: AppSizes.sm),
          Icon(suffixIcon, size: AppSizes.buttonIconSize),
        ],
      ],
    );
  }
}
