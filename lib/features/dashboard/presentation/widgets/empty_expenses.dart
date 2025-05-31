import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareefi/core/theming/colors.dart';

class EmptyExpensesWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onActionTap;
  final String? actionText;

  const EmptyExpensesWidget({
    super.key,
    this.title = 'لا توجد مصروفات حتى الآن',
    this.subtitle = 'ابدأ بتسجيل مصروفاتك',
    this.icon = Icons.receipt_long_outlined,
    this.onActionTap,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.borderColor.withOpacity(0.5),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: AppColors.mainColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 32.sp,
              color: AppColors.mainColor,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.secondaryText,
            ),
            textAlign: TextAlign.center,
          ),
          if (onActionTap != null && actionText != null) ...[
            SizedBox(height: 16.h),
            TextButton(
              onPressed: onActionTap,
              style: TextButton.styleFrom(
                backgroundColor: AppColors.mainColor.withOpacity(0.1),
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 12.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                actionText!,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
