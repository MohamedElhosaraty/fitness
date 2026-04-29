import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/dependency_injection.dart';
import 'core/localization/cubit/localization_cubit.dart';
import 'core/localization/set_localization.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';

class Fitness extends StatelessWidget {
  const Fitness({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) =>
          BlocProvider(
            create: (context) => getIt<LocalizationCubit>(),
            child: BlocBuilder<LocalizationCubit, LocalizationState>(
              builder: (context, state) {
                final locale = (state as ChangeLanguageSuccess).language;
                return MaterialApp(
                  locale: locale,
                  supportedLocales: const [
                    Locale('en', 'US'),
                    Locale('ar', 'EG'),
                  ],
                  localizationsDelegates: const [
                    SetLocalization.localizationsDelegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  title: 'Fitness',
                  theme: ThemeData(
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.white,
                    ),
                    primaryColor: Colors.blue,
                    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
                    scaffoldBackgroundColor: Colors.white,
                  ),
                  debugShowCheckedModeBanner: false,
                  initialRoute: Routes.splashScreen,
                  onGenerateRoute: AppRouter.generateRoute,
                );
              },
            ),
          ),
    );
  }
}