import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareefi/core/theming/styles.dart';
import 'package:masareefi/features/add_expense/presentation/widgets/add_expense_form_widget.dart';
import '../../../../core/theming/colors.dart';
import '../widgets/add_expenses_bloc_listeners.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة مصروف'),
        backgroundColor: AppColors.mainColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // 🟢 BlocListener like Login
          const AddExpenseBlocListener(),

          // 🟢 Form Layout
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'أدخل تفاصيل المصروف أدناه',
                  style: TextStyles.font14GrayRegular,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                const AddExpenseFormWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
