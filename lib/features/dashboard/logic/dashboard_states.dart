import '../../add_expense/data/models/expense_model.dart';
import '../data/models/dashboard_summary.dart';

abstract class DashboardState {
  const DashboardState();
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardSummary summary;
  final List<ExpenseModel> recentExpenses;
  final String selectedFilter;
  final int currentPage;
  final bool hasMoreData;
  final bool isFilterLoading; // ✅ NEW

  const DashboardLoaded({
    required this.summary,
    required this.recentExpenses,
    required this.selectedFilter,
    required this.currentPage,
    required this.hasMoreData,
    this.isFilterLoading = false,
  });

  DashboardLoaded copyWith({
    DashboardSummary? summary,
    List<ExpenseModel>? recentExpenses,
    String? selectedFilter,
    int? currentPage,
    bool? hasMoreData,
    bool? isFilterLoading,
  }) {
    return DashboardLoaded(
      summary: summary ?? this.summary,
      recentExpenses: recentExpenses ?? this.recentExpenses,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      currentPage: currentPage ?? this.currentPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      isFilterLoading: isFilterLoading ?? this.isFilterLoading,
    );
  }
}

class DashboardLoadingMore extends DashboardState {
  final DashboardLoaded currentState;

  const DashboardLoadingMore(this.currentState);
}

class DashboardLoadMoreComplete extends DashboardState {
  final DashboardLoaded updatedState;
  final bool hasMoreData;

  const DashboardLoadMoreComplete({
    required this.updatedState,
    required this.hasMoreData,
  });
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);
}
