import 'package:flutter/material.dart';

import '../../router/main_router.dart';

class MainApp extends StatelessWidget {
  static const primaryColor = Color(0xFF1c73e8);

  static final mainRouter = MainRouter();

  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: mainRouter.routes,
      initialRoute: mainRouter.initialRoute,
      onGenerateRoute: mainRouter.onGenerateRoute,
      theme: ThemeData(
        fontFamily: 'KyivTypeSerif',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'KyivTypeSerif',
            fontWeight: FontWeight.w500,
            letterSpacing: 3,
            fontSize: 25,
          ),
          centerTitle: true,
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: primaryColor, foregroundColor: Colors.white),
        inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(), focusColor: primaryColor),
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        primaryColor: primaryColor,
        checkboxTheme: CheckboxThemeData(),
      ),
    );
  }
}
