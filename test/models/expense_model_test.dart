import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masareefi/core/models/api_error_model.dart';
import 'package:masareefi/features/dashboard/data/models/dashboard_summary.dart';
import 'package:masareefi/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:masareefi/features/dashboard/logic/dashboard_cubit.dart';
import 'package:masareefi/features/dashboard/logic/dashboard_states.dart';
import 'package:masareefi/features/add_expense/data/models/expense_model.dart';
import 'package:mockito/mockito.dart';

class MockDashboardRepository extends Mock implements DashboardRepository {}

void main() {
  late DashboardCubit cubit;
  late MockDashboardRepository mockRepo;

  final mockStartDate = DateTime(2025, 5, 1);
  final mockEndDate = DateTime(2025, 5, 31);

  final mockExpensesPage1 = [
    ExpenseModel(
      id: '1',
      categoryId: 1,
      amount: 100.0,
      convertedAmount: 5.0,
      exchangeRate: 0.05,
      currency: 'EGP',
      date: mockStartDate.toIso8601String(),
    ),
  ];

  final mockSummary = DashboardSummary(
    totalExpenses: 100.0,
    totalExpensesUsd: 5.0,
  );

  setUp(() {
    mockRepo = MockDashboardRepository();
    cubit = DashboardCubit(mockRepo);
  });

  tearDown(() => cubit.close());

  blocTest<DashboardCubit, DashboardState>(
    'emits DashboardLoaded when loadDashboardData is successful',
    build: () {
      when(mockRepo.getDashboardSummary(
        startDate: mockStartDate,
        endDate: mockEndDate,
      )).thenAnswer((_) async => Right(mockSummary));

      when(mockRepo.getExpenses(
        startDate: mockStartDate,
        endDate: mockEndDate,
        page: 1,
        pageSize: 10,
      )).thenAnswer((_) async => Right(mockExpensesPage1));

      return cubit;
    },
    act: (cubit) => cubit.loadDashboardData(),
    expect: () => [
      isA<DashboardLoading>(),
      isA<DashboardLoaded>(),
    ],
  );

  blocTest<DashboardCubit, DashboardState>(
    'emits DashboardError when summary API fails',
    build: () {
      when(mockRepo.getDashboardSummary(
        startDate: mockStartDate,
        endDate: mockEndDate,
      )).thenAnswer(
        (_) async => Left(ApiErrorModel(message: 'Error', success: false)),
      );

      return cubit;
    },
    act: (cubit) => cubit.loadDashboardData(),
    expect: () => [
      isA<DashboardLoading>(),
      isA<DashboardError>(),
    ],
  );
}
