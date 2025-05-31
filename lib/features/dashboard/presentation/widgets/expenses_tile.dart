import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:masareefi/core/theming/colors.dart';
import 'package:masareefi/core/helpers/icon_helper.dart';
import '../../../add_expense/data/models/expense_model.dart';
import '../../../dashboard/data/models/category_model.dart';

class ExpenseTile extends StatelessWidget {
  final ExpenseModel expense;
  final List<CategoryModel> categories;
  final VoidCallback? onTap;

  const ExpenseTile({
    super.key,
    required this.expense,
    required this.categories,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final category = categories.firstWhere(
      (cat) => cat.id == expense.categoryId,
      orElse: () => CategoryModel(
        id: -1,
        label: 'غير معروف',
        iconName: 'help',
        colorHex: '#BDBDBD',
      ),
    );

    final iconColor =
        Color(int.parse(category.colorHex.replaceFirst('#', '0xFF')));

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildCategoryIcon(iconColor, category.iconName),
                SizedBox(width: 16.w),
                Expanded(child: _buildExpenseDetails(category.label)),
                _buildAmountSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(Color iconColor, String iconName) {
    return Container(
      width: 48.w,
      height: 48.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: iconColor.withOpacity(0.15),
        border: Border.all(color: iconColor.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      alignment: Alignment.center,
      child: IconHelper.getIconWidget(
        iconName,
        color: iconColor,
        size: 26.sp,
      ),
    );
  }

  Widget _buildExpenseDetails(String categoryLabel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          categoryLabel,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryText,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          _formatDate(DateTime.parse(expense.date)),
          style: TextStyle(
            fontSize: 11.sp,
            color: AppColors.secondaryText.withOpacity(0.7),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '- ${expense.amount.toStringAsFixed(0)} ${expense.currency}',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.errorColor,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          '\$ ${expense.convertedAmount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 11.sp,
            color: AppColors.secondaryText,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'اليوم ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays == 1) {
      return 'أمس ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays < 7) {
      return 'منذ ${difference.inDays} أيام';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }
}
