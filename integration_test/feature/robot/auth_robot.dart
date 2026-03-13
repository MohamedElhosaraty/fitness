import 'package:fitness/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';


class AuthRobot {
  final WidgetTester tester;

  AuthRobot({required this.tester});

  Future<void> runApp({required Widget widgetScreen}) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.generateRoute,
            home: widgetScreen,  ),
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
      await tester.drag(listFinder, Offset(0, -scrollOffset));
      await tester.pumpAndSettle();
    }
    await tester.enterText(textField, text);
    // await tester.testTextInput.receiveAction(TextInputAction.done); // إغلاق الكيبورد
    await tester.pumpAndSettle();
  }


  Future<void> sendButton({
    required Key key,
  }) async {
    final listFinder = find.byType(ListView);
    final buttonFinder = find.byKey(key);
    await tester.dragUntilVisible(
      buttonFinder,
      listFinder,
      Offset(0, -250),
    );
    await tester.pumpAndSettle();

    await tester.tap(buttonFinder);
  }
}
