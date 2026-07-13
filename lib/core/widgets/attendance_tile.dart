/*
 * Created by Mithil Devkar
 * Attendance Tile
 */

import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/sizes.dart';
import '../theme/app_theme.dart';

enum AttendanceStatus {
  present,
  absent,
}

class AttendanceTile extends StatelessWidget {
  final String rollNo;
  final String studentName;
  final String? imageUrl;

  final AttendanceStatus? status;

  final ValueChanged<AttendanceStatus> onChanged;

  const AttendanceTile({
    super.key,
    required this.rollNo,
    required this.studentName,
    required this.onChanged,
    this.status,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.md),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.md),
        child: Row(
          children: [

            // Avatar

            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColor.border,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: AppColor.surfaceVariant,
                backgroundImage:
                    imageUrl != null ? NetworkImage(imageUrl!) : null,
                child: imageUrl == null
                    ? Text(
                        studentName.isNotEmpty
                            ? studentName[0].toUpperCase()
                            : "?",
                        style: AppTheme.textStyle(
                          size: AppSizes.fontLg,
                          weight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
            ),

            const SizedBox(width: AppSizes.md),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    rollNo,
                    style: AppTheme.textStyle(
                      size: AppSizes.fontMd,
                      weight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: AppSizes.xs),

                  Text(
                    studentName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.textStyle(
                      size: AppSizes.fontSm,
                      color: isDark
                          ? AppColor.textOnDark.withOpacity(.75)
                          : AppColor.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: AppSizes.md),

            _AttendanceButton(
              text: "Present",
              selected: status == AttendanceStatus.present,
              color: AppColor.success,
              onTap: () => onChanged(AttendanceStatus.present),
            ),

            const SizedBox(width: AppSizes.sm),

            _AttendanceButton(
              text: "Absent",
              selected: status == AttendanceStatus.absent,
              color: AppColor.error,
              onTap: () => onChanged(AttendanceStatus.absent),
            ),
          ],
        ),
      ),
    );
  }
}

class _AttendanceButton extends StatelessWidget {
  final String text;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _AttendanceButton({
    required this.text,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppSizes.animationDuration,
      child: ElevatedButton(
        onPressed: selected ? null : onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: const Size(90, 42),
          backgroundColor: selected ? color : color.withOpacity(.10),
          foregroundColor: selected ? Colors.white : color,
          disabledBackgroundColor: color,
          disabledForegroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppSizes.buttonRadius),
          ),
        ),
        child: Text(
          text,
          style: AppTheme.textStyle(
            weight: FontWeight.w600,
            color: selected ? Colors.white : color,
          ),
        ),
      ),
    );
  }
}
