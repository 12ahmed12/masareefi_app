import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/expense_model.dart';
import '../data/repository/add_expense_repository.dart';
import 'add_expense_state.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  final AddExpenseRepository repo;
  AddExpenseCubit(this.repo) : super(AddExpenseInitial());

  Future<void> submitExpense(ExpenseModel model) async {
    emit(AddExpenseLoading());

    final result = await repo.addExpense(model);

    result.fold(
      (error) => emit(AddExpenseFailure(error.message!)),
      (success) {
        if (success) {
          emit(AddExpenseSuccess());
        } else {
          emit(AddExpenseFailure("حدث خطأ غير متوقع أثناء حفظ المصروف"));
        }
      },
    );
  }
}
