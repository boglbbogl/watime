import 'package:flutter/material.dart';
import 'package:watime/ui/main/main_page.dart';
import 'package:watime/model/theme_model.dart';
import 'package:watime/services/theme_service.dart';

class Watime extends StatelessWidget {
  const Watime({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: ThemeService.mode,
        builder: (
          BuildContext context,
          ThemeMode mode,
          Widget? child,
        ) {
          return MaterialApp(
            themeMode: mode,
            theme: ThemeModel.light,
            darkTheme: ThemeModel.dark,
            home: MainPage(
              brightness: MediaQuery.of(context).platformBrightness,
            ),
          );
        });
  }
}
