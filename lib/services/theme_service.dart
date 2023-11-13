import 'package:flutter/material.dart';
import 'package:watime/repository/internal_repository.dart';

class ThemeService {
  static final ThemeService instance = ThemeService._internal();
  factory ThemeService() => instance;
  ThemeService._internal();

  static ValueNotifier<ThemeMode> mode = ValueNotifier(ThemeMode.system);

  static Future<void> init(Brightness brightness) async {
    ThemeMode? theme = await InternalRepository.instance.getThemeMode();
    if (theme == null) {
      mode.value = switch (brightness) {
        Brightness.light => ThemeMode.light,
        Brightness.dark => ThemeMode.dark,
      };
      await InternalRepository.instance.setThemeMode(mode.value);
    } else {
      mode.value = theme;
    }
  }

  static Future<void> onChanged() async {
    ThemeMode change;
    if (mode.value == ThemeMode.light) {
      change = ThemeMode.dark;
    } else {
      change = ThemeMode.light;
    }
    await InternalRepository.instance.setThemeMode(change);
    mode.value = change;
  }
}
