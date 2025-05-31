import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareefi/core/theming/colors.dart';
import 'package:masareefi/core/theming/styles.dart';
import 'package:masareefi/features/add_expense/logic/add_expense_cubit.dart';
import 'package:masareefi/features/add_expense/logic/add_expense_state.dart';

class AddExpenseBlocListener extends StatelessWidget {
  const AddExpenseBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddExpenseCubit, AddExpenseState>(
      bloc: BlocProvider.of<AddExpenseCubit>(context),
      listenWhen: (previous, current) =>
          current is AddExpenseFailure || current is AddExpenseSuccess,
      listener: (context, state) {
        if (state is AddExpenseFailure) {
          _showSnackBar(context, state.message, AppColors.errorColor);
        } else if (state is AddExpenseSuccess) {
          _showSnackBar(
              context, "تم إضافة المصروف بنجاح", AppColors.successColor);
          Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.of(context).pop(true); // now safely returns true
          }); // <- return true to trigger refresh
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyles.font14DarkBlueMedium.copyWith(color: Colors.white),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
