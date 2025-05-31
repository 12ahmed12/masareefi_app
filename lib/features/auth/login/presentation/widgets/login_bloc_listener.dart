import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:masareefi/core/di/service_locator.dart';
import 'package:masareefi/core/routing/routes.dart';
import 'package:masareefi/core/theming/colors.dart';
import 'package:masareefi/core/theming/styles.dart';
import 'package:masareefi/features/auth/cubit/auth_cubit.dart';
import 'package:masareefi/features/auth/cubit/auth_state.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      bloc: getIt<AuthCubit>(),
      listenWhen: (previous, current) =>
          current is AuthLoading ||
          current is Authenticated ||
          current is LoginFailure,
      listener: (context, state) {
        if (state is LoginFailure) {
          _showErrorSnackBar(
              context, state.error.message ?? "فشل في تسجيل الدخول");
        } else if (state is Authenticated && state.success) {
          _showSuccessSnackBar(context, "تم تسجيل الدخول بنجاح");
          // Navigate to dashboard after a short delay
          Future.delayed(const Duration(milliseconds: 500), () {
            context.go(Routes.dashboard);
          });
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyles.font14DarkBlueMedium.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.errorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyles.font14DarkBlueMedium.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.successColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
