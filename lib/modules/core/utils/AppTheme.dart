import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'AppDialogStyle.dart';
import 'AppTextStyle.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: white,
    primary: black,
    secondary: greySecondary,
  ),
  appBarTheme: const AppBarTheme(
    color: white,
    iconTheme: IconThemeData(
      color: blue,
    ),
    titleTextStyle: black16BoldTextStyle,
  ),
  textTheme: const TextTheme(
    bodyLarge: black16TextStyle,
    bodyMedium: black12TextStyle,
    bodySmall: black12TextStyle,
    labelMedium: black16TextStyle,
    labelSmall: grey13TextStyle,
    titleLarge: black16TextStyle,
    titleMedium: black12BoldTextStyle,
    titleSmall: black12BoldTextStyle,
  ),
  extensions: const <ThemeExtension<dynamic>>{
    DialogStyle(),
  },
  dividerColor: greySecondary.withOpacity(0.1),
  scaffoldBackgroundColor: white,
);

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: black,
    primary: Colors.black,
    secondary: greySecondary,
  ),
  appBarTheme: const AppBarTheme(
    color: black,
    iconTheme: IconThemeData(
      color: blue,
    ),
    titleTextStyle: white16BoldTextStyle,
  ),
  textTheme: const TextTheme(
    bodyLarge: white16TextStyle,
    bodyMedium: white12TextStyle,
    bodySmall: white12TextStyle,
    labelMedium: white16TextStyle,
    labelSmall: grey13TextStyle,
    titleLarge: white16TextStyle,
    titleMedium: white12BoldTextStyle,
    titleSmall: white12BoldTextStyle,
  ),
  extensions: const <ThemeExtension<dynamic>>{
    DialogStyle(),
  },
  dividerColor: greySecondary.withOpacity(0.1),
  scaffoldBackgroundColor: black,
);
