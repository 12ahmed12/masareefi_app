import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/app_constants.dart';
import '../helpers/constants.dart';
import '../helpers/shared_pref_helper.dart';

class ThemeState {
  final ThemeData themeData;
  ThemeState({required this.themeData});
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeData: ThemeData.light())) {
    loadTheme();
  }

  Future<void> toggleTheme() async {
    final bool isDark = state.themeData.brightness == Brightness.dark;

    final newTheme = isDark ? ThemeData.light() : ThemeData.dark();
    await SharedPrefHelper.setData(SharedPrefKeys.userThemeBlack, !isDark);
    logger.i('emit-new-theme ${!isDark}');
    emit(ThemeState(themeData: newTheme));
  }

  Future<void> loadTheme() async {
    final bool isDark =
        await SharedPrefHelper.getBool(SharedPrefKeys.userThemeBlack);
    logger.i('loaded-theme $isDark');

    final theme = isDark ? ThemeData.dark() : ThemeData.light();
    logger.e('current-is-dark? $isDark');
    await SharedPrefHelper.setData(
        SharedPrefKeys.userThemeBlack, isDark == true ? isDark : false);

    emit(ThemeState(themeData: theme));
  }
}
