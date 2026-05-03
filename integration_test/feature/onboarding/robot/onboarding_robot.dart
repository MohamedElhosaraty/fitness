import 'package:fitness/core/helpers/shared_pref_helper.dart';
import 'package:fitness/core/localization/cubit/localization_cubit.dart';
import 'package:fitness/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnboardingRobot {
  final WidgetTester tester;

  OnboardingRobot({required this.tester});

  Future<void> runApp({required Widget widgetScreen}) async {
    SharedPreferences.setMockInitialValues({});
    SharedPrefHelper.init();

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<LocalizationCubit>(
            create: (_) => LocalizationCubit(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRouter.generateRoute,
            home: widgetScreen,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
  }
  Future<void> enterText({
    required String text,
    required Key key,
    double scrollOffset = 0,
  }) async {

    final textField = find.byKey(key);

    if (scrollOffset != 0) {
      final listFinder = find.byType(ListView);

      await tester.dragUntilVisible(
        textField,
        listFinder,
        Offset(0, -scrollOffset),
      );

      await tester.pumpAndSettle();
    }

    await tester.enterText(textField, text);

    await tester.pumpAndSettle();
  }


  Future<void> sendButton({required Key key}) async {
    final buttonFinder = find.byKey(key);

    await tester.scrollUntilVisible(
      buttonFinder,
      50,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(buttonFinder, warnIfMissed: true);
    await tester.pump();
  }

  Future<void> tapItem({required Key key}) async {
    final itemFinder = find.byKey(key);

    await tester.pumpAndSettle();
    await tester.tap(itemFinder);
    await tester.pumpAndSettle();
  }
}
