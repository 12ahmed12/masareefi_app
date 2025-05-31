import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareefi/core/di/service_locator.dart';
import 'package:masareefi/core/helpers/extensions.dart';
import 'package:upgrader/upgrader.dart';
import 'app.dart';
import 'core/helpers/constants.dart';
import 'core/helpers/shared_pref_helper.dart';
import 'core/theming/app_theme_cubit.dart';
import 'core/helpers/bloc_observer.dart';
import 'features/auth/cubit/auth_cubit.dart';
import '../core/helpers/sqlite_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SQLite database
  await SQLiteHelper().database;

  await Upgrader.clearSavedSettings();
  final upgrader = Upgrader();
  // REMOVE this for release builds
  upgrader.initialize();

  await setupServiceLocator();
  // To fix texts being hidden bug in flutter_screenutil in release mode.
  await ScreenUtil.ensureScreenSize();

  await getIt<AuthCubit>().checkLoginStatus(); // ✅ Use GetIt instance

  Bloc.observer = MyBlocObserver();
  runApp(const AppWidget());
}
