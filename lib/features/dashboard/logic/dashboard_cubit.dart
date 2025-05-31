import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helpers/date_range_helper.dart';
import '../../add_expense/data/models/expense_model.dart';
import '../data/repository/dashboard_repository.dart';
import 'dashboard_states.dart';
import '../../../core/constants/app_constants.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository dashboardRepository;

  DashboardCubit(this.dashboardRepository) : super(DashboardInitial());

  static const int _pageSize = 10;
  int _currentPage = 1;
  String _currentFilter = 'هذا الشهر';

  void loadDashboardData({bool showBodyLoaderOnly = false}) async {
    if (showBodyLoaderOnly && state is DashboardLoaded) {
      emit((state as DashboardLoaded).copyWith(isFilterLoading: true));
    } else {
      emit(DashboardLoading());
    }

    try {
      final range = DateRangeUtils.getRange(_currentFilter);

      final summaryResult = await dashboardRepository.getDashboardSummary(
        startDate: range.start,
        endDate: range.end,
      );

      final expensesResult = await dashboardRepository.getExpenses(
        startDate: range.start,
        endDate: range.end,
        page: 1,
        pageSize: _pageSize,
      );

      summaryResult.fold(
        (error) => emit(DashboardError(error.message ?? 'فشل تحميل البيانات')),
        (summary) {
          expensesResult.fold(
            (error) =>
                emit(DashboardError(error.message ?? 'فشل تحميل المصروفات')),
            (expenses) {
              logger.i('✅ Loaded ${expenses.length} records for page 1');
              emit(DashboardLoaded(
                summary: summary,
                recentExpenses: expenses,
                selectedFilter: _currentFilter,
                currentPage: 1,
                hasMoreData: expenses.length == _pageSize,
                isFilterLoading: false,
              ));
            },
          );
        },
      );
    } catch (e) {
      logger.e("Error in loadDashboardData", error: e);
      emit(DashboardError('حدث خطأ أثناء تحميل البيانات'));
    }
  }

  void refreshDashboard() {
    logger.i("🔄 Refreshing dashboard after add");
    _currentFilter = 'هذا الشهر';
    _currentPage = 1;
    loadDashboardData();
  }

  void changeFilterAndResetPagination(String newFilter) {
    _currentFilter = newFilter;
    _currentPage = 1;
    loadDashboardData(showBodyLoaderOnly: true);
  }

  List<ExpenseModel> get currentExpenses =>
      state is DashboardLoaded ? (state as DashboardLoaded).recentExpenses : [];

  void loadMoreExpenses() async {
    logger.w('⚠️ trigger loadmore');

    final currentState = state;
    DashboardLoaded baseState;

    if (currentState is DashboardLoaded) {
      baseState = currentState;
    } else if (currentState is DashboardLoadMoreComplete) {
      baseState = currentState.updatedState;
    } else {
      return;
    }

    if (!baseState.hasMoreData) {
      logger.w('⚠️ Skipping page $_currentPage — no more data expected');
      return;
    }

    emit(DashboardLoadingMore(baseState));
    _currentPage++;

    try {
      final range = DateRangeUtils.getRange(_currentFilter);

      final result = await dashboardRepository.getExpenses(
        startDate: range.start,
        endDate: range.end,
        page: _currentPage,
        pageSize: _pageSize,
      );

      result.fold(
        (error) {
          _currentPage--;
          emit(DashboardError(error.message ?? 'فشل تحميل المزيد'));
        },
        (newExpenses) {
          logger.i(
              '📄 Loaded ${newExpenses.length} records for page $_currentPage');

          final allExpenses = [...baseState.recentExpenses, ...newExpenses];
          final hasMore = newExpenses.length == _pageSize;

          final updatedState = baseState.copyWith(
            recentExpenses: allExpenses,
            currentPage: _currentPage,
            hasMoreData: hasMore,
          );

          emit(DashboardLoadMoreComplete(
            updatedState: updatedState,
            hasMoreData: hasMore,
          ));
        },
      );
    } catch (e) {
      _currentPage--;
      logger.e('❌ Error while loading more expenses', error: e);
      emit(DashboardError('حدث خطأ أثناء تحميل المزيد'));
    }
  }
}
