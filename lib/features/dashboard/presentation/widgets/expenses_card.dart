import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:masareefi/core/theming/colors.dart';

import '../../logic/dashboard_states.dart';

class ExpenseCard extends StatelessWidget {
  final DashboardLoaded state;

  const ExpenseCard({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.mainColor,
            AppColors.darkBlue,
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Total Expenses Title
          Text(
            'إجمالي المصروفات - ${state.selectedFilter}',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 20.h),

          // Expenses Row
          Row(
            children: [
              // Total Expenses (EGP)
              Expanded(
                child: _buildExpenseSection(
                  icon: Icons.trending_down,
                  title: 'المصروفات',
                  amount:
                      '${NumberFormat('#,##0.00').format(state.summary.totalExpenses)} ج.م',
                ),
              ),

              SizedBox(width: 20.w),

              // Expenses in USD
              Expanded(
                child: _buildExpenseSection(
                  icon: Icons.attach_money,
                  title: 'بالدولار',
                  amount:
                      '\$ ${NumberFormat('#,##0.00').format(state.summary.totalExpensesUsd)}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseSection({
    required IconData icon,
    required String title,
    required String amount,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 14.sp,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          amount,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
