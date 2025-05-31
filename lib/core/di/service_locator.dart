// 📦 lib/core/di/service_locator.dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/add_expense/data/apis/currency_api.dart';
import '../../features/auth/cubit/auth_cubit.dart';
import '../../features/auth/cubit/user_data_cubit.dart';
import '../../features/auth/login/data/apis/auth_api.dart';
import '../../features/auth/login/data/repository/auth_repository.dart';
import '../../features/dashboard/logic/dashboard_cubit.dart';
import '../../features/dashboard/data/repository/dashboard_repository.dart';
import '../../features/add_expense/data/repository/add_expense_repository.dart';
import '../../features/add_expense/logic/add_expense_cubit.dart';

import '../networking/api_client.dart';
import '../theming/app_theme_cubit.dart';
import '../helpers/sqlite_helper.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final apiClient = ApiClient();
  await apiClient.initialize();
  getIt.registerLazySingleton<ApiClient>(() => apiClient);

  getIt.registerLazySingleton<SQLiteHelper>(() => SQLiteHelper());

  setupAuthModule();
  setupDashboardModule();
  setupAddExpenseModule();

  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<UserDataCubit>(() => UserDataCubit());
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
}

void setupAuthModule() {
  getIt.registerLazySingleton<AuthApi>(() => AuthApi(getIt<ApiClient>()));
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(getIt<AuthApi>()),
  );
}

void setupDashboardModule() {
  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepository(getIt<SQLiteHelper>()),
  );
  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(getIt<DashboardRepository>()),
  );
}

void setupAddExpenseModule() {
  getIt.registerLazySingleton<CurrencyApi>(
      () => CurrencyApi(getIt<ApiClient>()));
  getIt.registerLazySingleton<AddExpenseRepository>(
    () => AddExpenseRepository(getIt<SQLiteHelper>(), getIt<CurrencyApi>()),
  );
  getIt.registerFactory(() => AddExpenseCubit(getIt<AddExpenseRepository>()));
}
