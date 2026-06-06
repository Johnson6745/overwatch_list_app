import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../app_themes.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _boxName = 'settings_box';
  static const String _themeKey = 'selected_theme';

  AppTheme _currentTheme = AppTheme.dark;

  AppTheme get currentTheme => _currentTheme;
  ThemeData get themeData => AppThemes.getTheme(_currentTheme);

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() {
    final box = Hive.box(_boxName);
    final saved = box.get(_themeKey, defaultValue: 0) as int;
    _currentTheme = AppTheme.values[saved];
    notifyListeners();
  }

  Future<void> setTheme(AppTheme theme) async {
    _currentTheme = theme;
    final box = Hive.box(_boxName);
    await box.put(_themeKey, theme.index);
    notifyListeners();
  }
}