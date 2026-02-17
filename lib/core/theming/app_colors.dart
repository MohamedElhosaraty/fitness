import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFFFFFFF);
  static const Color primaryColor = Color(0xFF2563EB);
  static const Color darkBlue = Color(0xFF0E1025);
  static const Color lightGrey = Color(0xFFD9D9D9);






  static const Color grey = Color(0xFF757575);
  static const Color lightBlack = Color(0xFF292D32);
  static const Color lightGreen = Color(0xFF3ABF38);
  static const Color moreGrey = Color(0xFFA1A1A1);
  static const Color lighterGrey = Color(0xFFEEEEEE);
  static const Color darkGrey = Color(0xFF656565);
  static const Color lighterBlack = Color(0xFF3F3F3F);
  static const Color lightGrey2 = Color(0xFFF4F4F4);
  static const Color lightBlack2 = Color(0xFF3E3E3E);



  static const Color transparent = Colors.transparent;

  // Optional: Add a method to create a MaterialColor from a single Color
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }
}
