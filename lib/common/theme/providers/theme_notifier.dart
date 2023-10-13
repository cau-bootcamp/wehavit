import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wehavit/common/common.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    _initializeThemeFromSharedPrefs();
  }

  void _initializeThemeFromSharedPrefs() {
    final isDarkMode = SharedPrefs.instance.getBool(AppKeys.kDarkMode) ?? false;
    state = _getThemeMode(isDarkMode);
  }

  Future<void> changeTheme(bool isDarkMode) async {
    state = _getThemeMode(isDarkMode);
    SharedPrefs.instance.setBool(AppKeys.kDarkMode, isDarkMode);
  }

  ThemeMode _getThemeMode(bool isDarkMode) {
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
}
