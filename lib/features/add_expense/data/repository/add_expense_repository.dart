import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import '../../../../core/helpers/sqlite_helper.dart';
import '../apis/currency_api.dart';
import '../models/expense_model.dart';
import '../../../../core/models/api_error_model.dart';

final logger = Logger();

class AddExpenseRepository {
  final SQLiteHelper db;
  final CurrencyApi api;

  AddExpenseRepository(this.db, this.api);

  Future<Either<ApiErrorModel, bool>> addExpense(ExpenseModel model) async {
    try {
      final rate = await api.fetchExchangeRate();
      if (rate == null) {
        logger.w('Exchange rate is null');
        return Left(
            ApiErrorModel(message: "فشل في تحميل سعر الصرف", success: false));
      }

      final convertedAmount = model.amount * rate;

      final record = ExpenseModel(
        id: model.id,
        categoryId: model.categoryId,
        amount: model.amount,
        convertedAmount: convertedAmount,
        exchangeRate: rate,
        currency: model.currency,
        date: model.date,
      );

      logger.i('Saving expense: $record');

      await db.insertExpense(record.toJson());
      return const Right(true);
    } catch (e, stack) {
      logger.e('Error while adding expense', error: e, stackTrace: stack);
      return Left(ApiErrorModel(
        message: "خطأ أثناء حفظ المصروف",
        success: false,
      ));
    }
  }
}
