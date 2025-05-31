import 'package:dartz/dartz.dart';
import 'package:masareefi/core/helpers/sqlite_helper.dart';
import 'package:masareefi/core/models/api_error_model.dart';
import 'package:masareefi/features/dashboard/data/models/dashboard_summary.dart';
import 'package:masareefi/features/dashboard/data/models/category_model.dart';
import 'package:masareefi/core/constants/app_constants.dart';

import '../../../add_expense/data/models/expense_model.dart';

class DashboardRepository {
  final SQLiteHelper db;

  DashboardRepository(this.db);

  /// ✅ Get expenses summary between two dates
  Future<Either<ApiErrorModel, DashboardSummary>> getDashboardSummary({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      logger.i('📊 Getting summary from $startDate to $endDate');

      final summary = await db.getExpensesSummaryByRange(startDate, endDate);

      return Right(DashboardSummary(
        totalExpenses: summary['egp'] ?? 0.0,
        totalExpensesUsd: summary['usd'] ?? 0.0,
      ));
    } catch (e, st) {
      logger.e('❌ getDashboardSummary failed: $e\n$st');
      return Left(
          ApiErrorModel(message: "Error loading summary", success: false));
    }
  }

  /// ✅ Get expenses with pagination and filter
  Future<Either<ApiErrorModel, List<ExpenseModel>>> getExpenses({
    required DateTime startDate,
    required DateTime endDate,
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final offset = (page - 1) * pageSize;
      logger.i('📄 Getting expenses (Page: $page) from $startDate to $endDate');

      final rows = await db.getExpensesByDateRangePaginated(
        startDate: startDate,
        endDate: endDate,
        limit: pageSize,
        offset: offset,
      );

      final expenses = rows.map((e) => ExpenseModel.fromJson(e)).toList();
      return Right(expenses);
    } catch (e, st) {
      logger.e('❌ getExpenses failed: $e\n$st');
      return Left(
          ApiErrorModel(message: "Error loading expenses", success: false));
    }
  }
}
