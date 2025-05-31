import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/styles.dart';
import '../theming/colors.dart';
import 'app_text_button.dart';

class AlertDialogWidget extends StatelessWidget {
  final String text;
  final String iconPath;
  const AlertDialogWidget({
    super.key,
    required this.text,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      icon: SvgPicture.asset(
        iconPath,
        width: 64.w,
        height: 64.h,
      ),
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyles.font14DarkBlueMedium,
      ),
      actions: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: AppTextButton(
              buttonText: 'إغلاق',
              textStyle: TextStyles.font16White600Weight,
              buttonWidth: 120.w,
              onPressed: () {
                context.pop();
              },
            ),
          ),
        ),
      ],
    );
  }
}

// Alternative version without SVG (using Material Icons)
class SimpleAlertDialogWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? iconColor;

  const SimpleAlertDialogWidget({
    super.key,
    required this.text,
    this.icon = Icons.info_outline,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      icon: Icon(
        icon,
        size: 64.sp,
        color: iconColor ?? AppColors.mainColor,
      ),
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyles.font14DarkBlueMedium,
      ),
      actions: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: AppTextButton(
              buttonText: 'إغلاق',
              textStyle: TextStyles.font16White600Weight,
              buttonWidth: 120.w,
              onPressed: () {
                context.pop();
              },
            ),
          ),
        ),
      ],
    );
  }
}

// Helper function to show error dialog
void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => SimpleAlertDialogWidget(
      text: message,
      icon: Icons.error_outline,
      iconColor: AppColors.errorColor,
    ),
  );
}

// Helper function to show success dialog
void showSuccessDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => SimpleAlertDialogWidget(
      text: message,
      icon: Icons.check_circle_outline,
      iconColor: AppColors.successColor,
    ),
  );
}

// Helper function to show info dialog
void showInfoDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => SimpleAlertDialogWidget(
      text: message,
      icon: Icons.info_outline,
      iconColor: AppColors.mainColor,
    ),
  );
}
