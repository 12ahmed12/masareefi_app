import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:oktoast/oktoast.dart';

import 'core/di/service_locator.dart';
import 'core/routing/app_router.dart';
import 'core/theming/app_theme_cubit.dart';
import 'core/theming/colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        bloc: getIt<ThemeCubit>(),
        builder: (context, state) {
          return OKToast(
            child: GlobalLoaderOverlay(
              duration: Durations.medium4,
              reverseDuration: Durations.medium4,
              overlayColor: Colors.grey.withAlpha(200),
              overlayWidgetBuilder: (_) => const Center(
                child: SpinKitCubeGrid(
                  color: AppColors.mainColor,
                  size: 70.0,
                ),
              ),
              child: MaterialApp.router(
                title: 'مصاريفي',
                debugShowCheckedModeBanner: false,
                theme: state.themeData,
                locale: const Locale('ar', 'SA'), // ✅ Arabic locale
                supportedLocales: const [
                  Locale('ar', 'SA'),
                ],
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                builder: (context, child) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: child!,
                ),
                routerConfig: router,
              ),
            ),
          );
        },
      ),
    );
  }
}
