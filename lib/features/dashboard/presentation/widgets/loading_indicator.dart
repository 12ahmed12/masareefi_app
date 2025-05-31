import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareefi/core/theming/colors.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  final String message;
  final bool isSmall;
  final Color? color;

  const LoadingIndicatorWidget({
    super.key,
    this.message = 'جاري التحميل...',
    this.isSmall = false,
    this.color,
  });

  const LoadingIndicatorWidget.small({
    super.key,
    this.message = 'جاري تحميل المزيد...',
    this.color,
  }) : isSmall = true;

  const LoadingIndicatorWidget.filter({
    super.key,
    this.message = 'جاري تحميل البيانات...',
    this.color,
  }) : isSmall = false;

  @override
  Widget build(BuildContext context) {
    if (isSmall) {
      return Container(
        padding: EdgeInsets.all(16.h),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(
                  color: color ?? AppColors.mainColor,
                  strokeWidth: 2.w,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                message,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      padding: EdgeInsets.all(32.w),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: 40.w,
              height: 40.h,
              child: CircularProgressIndicator(
                color: color ?? AppColors.mainColor,
                strokeWidth: 3.w,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.secondaryText,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
