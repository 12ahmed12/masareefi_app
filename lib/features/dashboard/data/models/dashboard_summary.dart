class DashboardSummary {
  final double totalExpenses;
  final double totalExpensesUsd;

  const DashboardSummary({
    required this.totalExpenses,
    required this.totalExpensesUsd,
  });

  factory DashboardSummary.fromDatabase(Map<String, dynamic> data) {
    return DashboardSummary(
      totalExpenses: (data['total_expenses'] as num?)?.toDouble() ?? 0.0,
      totalExpensesUsd: (data['total_expenses_usd'] as num?)?.toDouble() ?? 0.0,
    );
  }

  factory DashboardSummary.fromJson(Map<String, dynamic> json) {
    return DashboardSummary(
      totalExpenses: (json['total_expenses'] as num?)?.toDouble() ?? 0.0,
      totalExpensesUsd: (json['total_expenses_usd'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_expenses': totalExpenses,
      'total_expenses_usd': totalExpensesUsd,
    };
  }

  DashboardSummary copyWith({
    double? totalExpenses,
    double? totalExpensesUsd,
  }) {
    return DashboardSummary(
      totalExpenses: totalExpenses ?? this.totalExpenses,
      totalExpensesUsd: totalExpensesUsd ?? this.totalExpensesUsd,
    );
  }

  @override
  String toString() {
    return 'DashboardSummary(totalExpenses: $totalExpenses, totalExpensesUsd: $totalExpensesUsd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DashboardSummary &&
            other.totalExpenses == totalExpenses &&
            other.totalExpensesUsd == totalExpensesUsd);
  }

  @override
  int get hashCode => Object.hash(totalExpenses, totalExpensesUsd);
}
