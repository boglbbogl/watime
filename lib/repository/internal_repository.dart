import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watime/model/internal_key.dart';

class InternalRepository {
  static final InternalRepository instance = InternalRepository._internal();
  factory InternalRepository() => instance;
  InternalRepository._internal();

  Future<List<String>> getLocations() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> codes = preferences.getStringList(InternalKey.locations) ?? [];
    return codes;
  }

  Future<void> setLocation(String code) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> codes = preferences.getStringList(InternalKey.locations) ?? [];
    codes = List.from(codes)..insert(0, code);
    await preferences.setStringList(InternalKey.locations, codes);
  }

  Future<ThemeMode?> getThemeMode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int type = preferences.getInt(InternalKey.themeMode) ?? 0;
    return switch (type) {
      1 => ThemeMode.light,
      2 => ThemeMode.dark,
      _ => null,
    };
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    int index = switch (mode) {
      ThemeMode.system => 0,
      ThemeMode.light => 1,
      ThemeMode.dark => 2,
    };
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(InternalKey.themeMode, index);
  }
}
