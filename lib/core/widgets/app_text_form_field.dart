import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/colors.dart';
import '../theming/styles.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;
  final TextInputType? keyboardType; // ✅ added

  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType, // ✅ numeric or default
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.mainColor,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.borderColor,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.errorColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.errorColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        hintStyle: hintStyle ??
            TextStyles.font14LightGrayRegular.copyWith(
              color: AppColors.lightText,
            ),
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: backgroundColor ?? const Color(0xFFF5F5F5),
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      style: inputTextStyle ??
          TextStyles.font14DarkBlueMedium.copyWith(
            color: AppColors.primaryText,
          ),
      validator: (value) => validator(value),
    );
  }
}
