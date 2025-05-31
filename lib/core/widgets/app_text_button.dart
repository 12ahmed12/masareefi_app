import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/colors.dart';

class AppTextButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final TextStyle textStyle;
  final double? buttonHeight;
  final double? buttonWidth;
  final double? borderRadius;
  final bool useGradient;
  final bool isLoading;

  const AppTextButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.textStyle,
    this.buttonHeight,
    this.buttonWidth,
    this.borderRadius,
    this.useGradient = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? 12.r;
    final content = isLoading
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 18.w,
                height: 18.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10.w),
              Text(buttonText, style: textStyle),
            ],
          )
        : Text(buttonText, style: textStyle);

    if (useGradient) {
      return SizedBox(
        height: buttonHeight ?? 50.h,
        width: buttonWidth ?? double.infinity,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(radius),
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.mainColor, AppColors.secondaryText],
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Center(child: content),
          ),
        ),
      );
    }

    return SizedBox(
      height: buttonHeight ?? 50.h,
      width: buttonWidth ?? double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          elevation: 2,
        ),
        child: content,
      ),
    );
  }
}
