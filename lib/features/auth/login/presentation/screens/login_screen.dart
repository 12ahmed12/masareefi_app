import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareefi/core/theming/colors.dart';
import 'package:masareefi/core/theming/styles.dart';
import '../widgets/login_form_widget.dart';
import '../widgets/login_bloc_listener.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // BLoC Listener
              const LoginBlocListener(),

              SizedBox(height: 40.h),

              // App Title (مصاريفي)
              Center(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.gradientStart, AppColors.gradientEnd],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'مصاريفي',
                    style: TextStyles.font32BlueBold.copyWith(
                      color: Colors.white,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              // Login Title
              Text(
                'تسجيل الدخول',
                style: TextStyles.font28BlackBold.copyWith(
                  fontSize: 25.sp,
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),

              SizedBox(height: 40.h),

              // Login Form
              const LoginFormWidget(),

              SizedBox(height: 22.h),

              // Or Login With Divider
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1.h,
                      color: AppColors.dividerColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'أو سجل الدخول باستخدام',
                      style: TextStyles.font12Gray400Weight.copyWith(
                        color: AppColors.secondaryText,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1.h,
                      color: AppColors.dividerColor,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 22.h),

              // Google Button
              _buildSocialButton(
                'متابعة مع جوجل',
                AppColors.googleColor,
                Icons.g_mobiledata,
              ),

              SizedBox(height: 16.h),

              // Apple Button
              _buildSocialButton(
                'متابعة مع آبل',
                AppColors.appleColor,
                Icons.apple,
              ),

              SizedBox(height: 22.h),

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ليس لديك حساب؟ ',
                    style: TextStyles.font12Gray400Weight.copyWith(
                      color: AppColors.lightText,
                      fontSize: 16.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to sign up
                    },
                    child: Text(
                      'سجل الآن',
                      style: TextStyles.font14Blue600Weight.copyWith(
                        color: AppColors.mainColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String text, Color brandColor, IconData icon) {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            // TODO: Implement social login
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 28.w,
                  height: 28.h,
                  decoration: BoxDecoration(
                    color: brandColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  text,
                  style: TextStyles.font14DarkBlue500Weight.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
