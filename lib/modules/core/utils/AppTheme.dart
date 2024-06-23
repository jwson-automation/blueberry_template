import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'AppDialogStyle.dart';
import 'AppTextStyle.dart';

final ThemeData appTheme = ThemeData(
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
    // コンポーネントごとのスタイルをここに追加していく
    DialogStyle(),
  },
  dividerColor: greySecondary.withOpacity(0.1),
  scaffoldBackgroundColor: white,
);