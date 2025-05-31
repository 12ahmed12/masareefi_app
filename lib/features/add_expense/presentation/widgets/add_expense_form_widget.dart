import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareefi/core/constants/dummy_data.dart';
import 'package:masareefi/core/theming/colors.dart';
import 'package:masareefi/core/theming/styles.dart';
import 'package:masareefi/core/widgets/app_text_button.dart';
import 'package:masareefi/core/widgets/app_text_form_field.dart';
import 'package:masareefi/core/widgets/custom%20_toast.dart';
import 'package:masareefi/features/add_expense/data/models/expense_model.dart';
import 'package:masareefi/features/add_expense/logic/add_expense_cubit.dart';
import 'package:masareefi/features/add_expense/logic/add_expense_state.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class AddExpenseFormWidget extends StatefulWidget {
  const AddExpenseFormWidget({super.key});

  @override
  State<AddExpenseFormWidget> createState() => _AddExpenseFormWidgetState();
}

class _AddExpenseFormWidgetState extends State<AddExpenseFormWidget> {
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate = DateTime.now();
  int? _selectedCategoryId;
  bool _showCategoryValidation = false;
  final uuid = const Uuid();

  void _handleSubmit() {
    final isValid = _formKey.currentState!.validate();

    if (_selectedCategoryId == null) {
      setState(() => _showCategoryValidation = true);
      showToast(text: "يرجى اختيار التصنيف", state: ToastStates.ERROR);
      return;
    }

    if (isValid && _selectedDate != null) {
      final model = ExpenseModel(
        id: uuid.v4(),
        categoryId: _selectedCategoryId!,
        amount: double.parse(_amountController.text),
        convertedAmount: 0,
        exchangeRate: 0,
        currency: "EGP",
        date: _selectedDate!.toIso8601String(),
      );

      context.read<AddExpenseCubit>().submitExpense(model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'المبلغ بالجنيه المصري',
            style: TextStyles.font14DarkBlue500Weight.copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: 8.h),
          AppTextFormField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            hintText: 'أدخل المبلغ',
            backgroundColor: const Color(0xFFF5F5F5),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يرجى إدخال المبلغ';
              }
              return null;
            },
          ),
          SizedBox(height: 20.h),
          Text(
            'التاريخ',
            style: TextStyles.font14DarkBlue500Weight.copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: _selectDate,
            child: AbsorbPointer(
              child: AppTextFormField(
                validator: (value) {
                  return null;
                },
                controller: TextEditingController(
                  text: _selectedDate == null
                      ? ''
                      : DateFormat('yyyy/MM/dd', 'ar_SA')
                          .format(_selectedDate!),
                ),
                hintText: 'اختر التاريخ',
                backgroundColor: const Color(0xFFF5F5F5),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'التصنيفات',
            style: TextStyles.font14DarkBlue500Weight.copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: 12.h),
          _buildCategorySelector(),
          SizedBox(height: 30.h),
          BlocBuilder<AddExpenseCubit, AddExpenseState>(
            buildWhen: (prev, curr) =>
                curr is AddExpenseLoading ||
                curr is AddExpenseSuccess ||
                curr is AddExpenseFailure ||
                curr is AddExpenseInitial,
            builder: (context, state) {
              final isLoading = state is AddExpenseLoading;
              return AppTextButton(
                buttonText: isLoading ? "جاري الحفظ..." : "حفظ",
                isLoading: isLoading,
                onPressed: isLoading ? null : _handleSubmit,
                textStyle:
                    TextStyles.font16White600Weight.copyWith(fontSize: 18.sp),
                borderRadius: 12.r,
                buttonHeight: 56.h,
                buttonWidth: double.infinity,
                useGradient: true,
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    final categories = Dummy.kDefaultCategories;

    return Wrap(
      spacing: 30,
      runSpacing: 30,
      children: categories.map((cat) {
        final isSelected = _selectedCategoryId == cat.id;
        final backgroundColor = isSelected
            ? AppColors.mainColor
            : Color(int.parse(cat.colorHex.replaceFirst('#', '0xFF')));
        final textColor =
            isSelected ? AppColors.mainColor : AppColors.primaryText;

        return GestureDetector(
          onTap: () => setState(() => _selectedCategoryId = cat.id),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: backgroundColor,
                child: Icon(
                  _getIconFromName(cat.iconName),
                  color: isSelected ? Colors.white : Colors.black87,
                  size: 24.sp,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                cat.label,
                style: TextStyles.font12DarkBlueRegular.copyWith(
                  color: textColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  IconData _getIconFromName(String name) {
    switch (name) {
      case 'shopping_cart':
        return Icons.shopping_cart;
      case 'movie':
        return Icons.movie;
      case 'local_gas_station':
        return Icons.local_gas_station;
      case 'shopping_bag':
        return Icons.shopping_bag;
      case 'newspaper':
        return Icons.newspaper;
      case 'directions_car':
        return Icons.directions_car;
      case 'home':
        return Icons.home;
      default:
        return Icons.category;
    }
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 2),
      locale: const Locale('ar', 'SA'),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }
}
