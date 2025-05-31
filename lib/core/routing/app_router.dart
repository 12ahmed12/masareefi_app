import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masareefi/core/routing/routes.dart';
import 'package:masareefi/features/auth/login/presentation/screens/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:upgrader/upgrader.dart';

import '../../core/di/service_locator.dart';
import '../../core/helpers/upgrader.dart';
import '../../features/add_expense/logic/add_expense_cubit.dart';
import '../../features/add_expense/presentation/screens/add_expenses_screen.dart';
import '../../features/auth/cubit/auth_cubit.dart';
import '../../features/auth/cubit/auth_state.dart';
import '../../features/dashboard/logic/dashboard_cubit.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../core/constants/app_constants.dart';
import 'go_router_refresh.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final upgrader = MyUpgrader(debugLogging: true);

final AuthCubit authCubit = getIt<AuthCubit>(); // ✅ Get AuthCubit Instance

const publicRoutes = [
  Routes.loginScreen,
];

final router = GoRouter(
    navigatorKey: navigatorKey,
    debugLogDiagnostics: true,
    refreshListenable:
        GoRouterRefreshStream(authCubit.stream), // ✅ Listen to state changes
    initialLocation: Routes.dashboard,
    redirect: (context, state) {
      final isAuthenticated = authCubit.state is Authenticated;
      final isPublicRoute = publicRoutes.contains(state.matchedLocation);

      logger.i(
          'Router redirect - isAuthenticated: $isAuthenticated, location: ${state.matchedLocation}');

      if (!isAuthenticated && !isPublicRoute) {
        logger.i('Redirecting to login - User not authenticated');
        return Routes.loginScreen;
      }

      if (isAuthenticated && state.matchedLocation == Routes.loginScreen) {
        logger.i('Redirecting to dashboard - User already authenticated');
        return Routes.dashboard;
      }

      return null; // No redirection
    },
    routes: [
      GoRoute(
        path: Routes.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: Routes.dashboard,
        name: Routes.dashboard,
        builder: (context, state) => BlocProvider.value(
            value: getIt<DashboardCubit>(), // Use the same instance
            child: const DashboardScreen()),
      ),

      GoRoute(
        path: Routes.addExpense,
        name: Routes.addExpense,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<AddExpenseCubit>(),
          child: const AddExpenseScreen(),
        ),
      ),

      // TODO: Add these routes when screens are implemented
      /*
      GoRoute(
        path: Routes.addExpense,
        builder: (context, state) => const AddExpenseScreen(),
      ),

      GoRoute(
        path: Routes.expenseDetails,
        builder: (context, state) {
          final expenseId = state.pathParameters['id'] ?? '';
          return ExpenseDetailsScreen(expenseId: expenseId);
        },
      ),

      GoRoute(
        path: Routes.categories,
        builder: (context, state) => const CategoriesScreen(),
      ),

      GoRoute(
        path: Routes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      */
    ]);
