/*
 *  Created by Deepak Gupta on 07/10/25, 5:20 pm
 *  Copyright (c) 2025 . All rights reserved.
 */

// Flutter imports:

// Project imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show Theme, TextFormField, Colors, InputDecoration, OutlineInputBorder;
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../theme/app_theme.dart';



class EditText extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? value;
  final String? hint;
  final bool isRequired;
  final bool readOnly;
  final bool enabled;
  final bool obscureText;
  final int? maxLength;
  final int? maxLines;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChange;
  final Function(String? value)? validate;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextCapitalization capitalization;
  final List<TextInputFormatter> formatter;
  final Widget? prefix;
  final Widget? suffix;
  final Color? background;
  final ValidationType validationType;
  final int? minCharLength;
  final int? maxCharLength;
  final num? minValue;
  final num? maxValue;

  const EditText({
    super.key,
    this.controller,
    this.label,
    this.value,
    this.hint,
    this.isRequired = false,
    this.readOnly = false,
    this.maxLength,
    this.maxLines,
    this.onTap,
    this.onChange,
    this.validate,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.capitalization = TextCapitalization.none,
    this.formatter = const [],
    this.prefix,
    this.suffix,
    this.background,
    this.obscureText = false,
    this.validationType = ValidationType.none,
    this.minCharLength,
    this.maxCharLength,
    this.minValue,
    this.maxValue,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final outline = Theme.of(context).colorScheme.outline;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              '${label ?? ''}${isRequired ? '*' : ''}',
              style: AppTheme.textStyle(
                size: 12,
                weight: FontWeight.w400,
                color: AppColor.primary,
              ),
            ),
          ),

        TextFormField(
          controller: controller,
          obscureText: obscureText,
          readOnly: readOnly,
          style: AppTheme.textStyle(
            size: 16,
            weight: FontWeight.w600,
            color: isDark ? Colors.white : AppColor.primary,
          ),
          maxLength: maxLength,
          maxLines: maxLines ?? 1,
          textInputAction: textInputAction,
          textCapitalization: capitalization,
          keyboardType: textInputType,
          inputFormatters: formatter,
          onTap: onTap,
          onChanged: onChange,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            final result = AppValidator.validate(
              value: value,
              field: label ?? 'Field',
              isRequired: isRequired,
              type: validationType,
              minLength: minCharLength,
              maxLength: maxCharLength,
              minValue: minValue,
              maxValue: maxValue,
            );
            if (isRequired && (value == null || value.trim().isEmpty)) {
              return "$label is required";
            }

            if (result != null) return result;

            return validate?.call(value);
          },
          decoration: InputDecoration(
            filled: true,

            fillColor: !enabled
                ? Colors.grey.shade300
                : readOnly
                ? Colors.grey.shade300
                : background ??
                (Get.isDarkMode
                    ? const Color(0xFF1C1C1C)
                    : AppColor.buttonTextColor),

            // fillColor: background ??
            //     (isDark ? Colors.grey.shade900 : const Color(0xFFF5F7FA)),
            hintText: hint,
            hintStyle: AppTheme.textStyle(
              size: 16,
              weight: FontWeight.w400,
              color: AppColor.secondary,
            ),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 18,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColor.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColor.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColor.error, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),

            prefixIcon: prefix != null
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: prefix,
            )
                : null,

            suffixIcon: suffix != null
                ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: suffix,
            )
                : null,

            counterText: '',
            errorStyle: const TextStyle(fontSize: 12, height: 1.3),
          ),
        ),
      ],
    );
  }
}

///Validations for all fields (Non-Mandatory natured)

enum ValidationType {
  none,
  name,
  email,
  phone,
  password,
  number,
  url,
  username,
}

class AppValidator {
  static String? validate({
    required String? value,
    required String field,
    bool isRequired = false,
    ValidationType type = ValidationType.none,
    int? minLength,
    int? maxLength,
    num? minValue,
    num? maxValue,
  }) {
    final text = value?.trim() ?? '';

    if (isRequired && text.isEmpty) {
      return '$field is required';
    }

    if (text.isEmpty) return null;

    if (minLength != null && text.length < minLength) {
      return '$field must contain at least $minLength characters';
    }

    if (maxLength != null && text.length > maxLength) {
      return '$field cannot exceed $maxLength characters';
    }

    switch (type) {
      case ValidationType.email:
        if (!GetUtils.isEmail(text)) {
          return 'Enter a Valid Email';
        }
        break;

      case ValidationType.phone:
        if (!RegExp(r'^[0-9]{10}$').hasMatch(text)) {
          return 'Enter a valid mobile number';
        }
        break;

      case ValidationType.password:
        if (text.length < 8) {
          return 'Password must be at least 8 characters';
        }

        if (!RegExp(r'[A-Z]').hasMatch(text)) {
          return 'Password must contain one uppercase letter';
        }

        if (!RegExp(r'[a-z]').hasMatch(text)) {
          return 'Password must contain one lowercase letter';
        }

        if (!RegExp(r'[0-9]').hasMatch(text)) {
          return 'Password must contain one number';
        }

        if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(text)) {
          return 'Password must contain one special character';
        }
        break;

      case ValidationType.number:
        final number = num.tryParse(text);

        if (number == null) {
          return 'Enter a valid number';
        }

        if (minValue != null && number < minValue) {
          return 'Minimum value is $minValue';
        }

        if (maxValue != null && number > maxValue) {
          return 'Maximum value is $maxValue';
        }

        break;

      case ValidationType.url:
        final uri = Uri.tryParse(text);

        if (uri == null ||
            !(uri.hasScheme &&
                (uri.scheme == 'http' || uri.scheme == 'https') &&
                uri.host.isNotEmpty)) {
          return 'Enter a valid URL';
        }
        break;

      case ValidationType.username:
        if (!RegExp(r'^[a-zA-Z0-9_]{4,20}$').hasMatch(text)) {
          return 'Invalid username';
        }
        break;

      case ValidationType.name:
        if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(text)) {
          return 'Only alphabets are allowed';
        }
        break;

      case ValidationType.none:
        break;
    }

    return null;
  }
}