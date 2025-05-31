import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareefi/core/theming/colors.dart';
import 'package:masareefi/core/theming/styles.dart';
import 'package:masareefi/features/auth/cubit/auth_cubit.dart';
import 'package:masareefi/features/auth/cubit/auth_state.dart';
import 'package:masareefi/core/di/service_locator.dart';
import 'package:masareefi/core/widgets/app_text_button.dart';
import 'package:masareefi/core/widgets/app_text_form_field.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill demo credentials
    _emailController.text = "user@masareefi.com";
    _passwordController.text = "123456";
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email Label
          Text(
            'البريد الإلكتروني',
            style: TextStyles.font14DarkBlue500Weight.copyWith(
              color: AppColors.primaryText,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h),

          // Email Field - SHORT height, GRAY background
          AppTextFormField(
            controller: _emailController,
            hintText: 'أدخل بريدك الإلكتروني',
            backgroundColor: const Color(0xFFF5F5F5), // Light gray like design
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يرجى إدخال البريد الإلكتروني';
              }
              if (!value.contains('@')) {
                return 'يرجى إدخال بريد إلكتروني صحيح';
              }
              return null;
            },
          ),

          SizedBox(height: 20.h),

          // Password Label
          Text(
            'كلمة المرور',
            style: TextStyles.font14DarkBlue500Weight.copyWith(
              color: AppColors.primaryText,
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h),

          // Password Field - SHORT height, GRAY background
          AppTextFormField(
            controller: _passwordController,
            hintText: 'أدخل كلمة المرور',
            backgroundColor: const Color(0xFFF5F5F5), // Light gray like design
            isObscureText: !_isPasswordVisible,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يرجى إدخال كلمة المرور';
              }
              if (value.length < 6) {
                return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
              }
              return null;
            },
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                size: 20.sp,
                color: AppColors.secondaryText,
              ),
            ),
          ),

          SizedBox(height: 10.h),

          // Forgot Password Button
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // TODO: Implement forgot password
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'نسيت كلمة المرور؟',
                style: TextStyles.font14Blue600Weight.copyWith(
                  color: AppColors.mainColor,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),

          SizedBox(height: 30.h),

          // Login Button with Purple Gradient
          BlocBuilder<AuthCubit, AuthState>(
            bloc: getIt<AuthCubit>(),
            buildWhen: (previous, current) =>
                current is AuthLoading ||
                current is Authenticated ||
                current is LoginFailure ||
                current is AuthInitial,
            builder: (context, state) {
              final isLoading = state is AuthLoading;

              return AppTextButton(
                buttonText: isLoading ? "جاري تسجيل الدخول..." : "تسجيل الدخول",
                textStyle: TextStyles.font16White600Weight.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                onPressed: isLoading ? null : _handleLogin,
                borderRadius: 12.r,
                buttonHeight: 56.h,
                useGradient: true,
              );
            },
          ),
        ],
      ),
    );
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      getIt<AuthCubit>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    }
  }
}
