import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 작성일: 2024-07-01
/// 작성자: 오물개
/// 내용: 다크모드 토글 기능 추가를 위해 ThemeProvider 추가
class ThemeProvider extends StateNotifier<ThemeMode> {
  ThemeProvider() : super(ThemeMode.light);

  void toggleTheme() {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
  }
}

final themeNotifierProvider =
    StateNotifierProvider<ThemeProvider, ThemeMode>((ref) {
  return ThemeProvider();
});
