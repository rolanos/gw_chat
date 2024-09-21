import 'package:flutter/material.dart';
import 'package:gw_chat/core/extension.dart';

class AppTheme {
  //Светлая тема
  static ThemeData lightTheme = ThemeData(
    dividerColor: const Color.fromRGBO(227, 243, 255, 1),
    appBarTheme: const AppBarTheme(color: Color.fromRGBO(24, 117, 186, 1)),
    scaffoldBackgroundColor: const Color.fromRGBO(227, 243, 255, 1),
    primaryColor: const Color.fromRGBO(21, 142, 207, 1),
    canvasColor: const Color.fromRGBO(255, 255, 255, 1),
    cardColor: const Color.fromRGBO(24, 117, 186, 1),
    indicatorColor: const Color.fromRGBO(227, 243, 255, 0.52),
    iconTheme: const IconThemeData(
      color: Color.fromRGBO(24, 117, 186, 1),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Color.fromRGBO(255, 255, 255, 1),
    ),
    fontFamily: 'Gotham',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(24, 117, 186, 1),
      ),
      titleMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 0.9,
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(24, 117, 186, 1),
      ),
      bodyMedium: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      labelMedium: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(147, 147, 147, 1),
      ),
      bodySmall: TextStyle(
        fontSize: 8,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      labelSmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(21, 142, 207, 1),
      ),
    ),
  );

  //Темная тема
  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Gotham',
    dividerColor: const Color.fromRGBO(4, 25, 38, 1),
    appBarTheme: const AppBarTheme(color: Color.fromRGBO(4, 25, 38, 1)),
    scaffoldBackgroundColor: const Color.fromRGBO(5, 26, 38, 1),
    primaryColor: const Color.fromRGBO(16, 77, 122, 1),
    canvasColor: const Color.fromRGBO(6, 34, 51, 1),
    cardColor: const Color.fromRGBO(16, 77, 122, 1),
    indicatorColor: const Color.fromRGBO(14, 71, 113, 0.64),
    iconTheme: const IconThemeData(
      color: Color.fromRGBO(244, 239, 233, 1),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color.fromRGBO(244, 239, 233, 1)),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(244, 239, 233, 1),
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(244, 239, 233, 1),
      ),
      titleMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 0.9,
        color: Color.fromRGBO(244, 239, 233, 1),
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(244, 239, 233, 1),
      ),
      bodyMedium: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(244, 239, 233, 1),
      ),
      bodySmall: TextStyle(
        fontSize: 8,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(244, 239, 233, 1),
      ),
      labelMedium: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(244, 239, 233, 1),
      ),
      labelSmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(244, 239, 233, 1),
      ),
    ),
  );

  static Gradient gradient(BuildContext context) {
    if (context.theme.brightness == Brightness.light) {
      return const LinearGradient(
        colors: [
          Color.fromRGBO(21, 142, 207, 1),
          Color.fromRGBO(21, 142, 207, 0.71),
        ],
      );
    } else {
      return const LinearGradient(
        colors: [
          Color.fromRGBO(16, 77, 122, 1),
          Color.fromRGBO(16, 77, 122, 0.55),
        ],
      );
    }
  }
}
