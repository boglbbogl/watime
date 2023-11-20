import 'package:flutter/material.dart';
import 'package:watime/model/continent_type.dart';
import 'package:watime/model/location_model.dart';
import 'package:watime/model/main_model.dart';
import 'package:watime/model/view_type.dart';
import 'package:watime/repository/internal_repository.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class MainService {
  static final MainService instance = MainService._internal();
  factory MainService() => instance;
  MainService._internal();

  static ValueNotifier<MainModel> main = ValueNotifier(MainModel.init());

  static void syncTime(DateTime sync) =>
      main.value = main.value.copyWith(standard: sync);

  static ViewType _viewType(int? index) {
    if (index == null) {
      return ViewType.list;
    } else {
      return switch (index) {
        0 => ViewType.list,
        1 => ViewType.grid,
        2 => ViewType.page,
        3 => ViewType.analogue,
        _ => ViewType.list,
      };
    }
  }

  static Future<void> init() async {
    int? no = await InternalRepository.instance.getViewType();
    main.value = main.value.copyWith(view: _viewType(no));
    tz.initializeTimeZones();
    List<String> codes = await InternalRepository.instance.getLocations();
    if (codes.isNotEmpty) {
      List<LocationModel> locations = [];
      for (final code in codes) {
        tz.Location location = tz.getLocation(code);
        DateTime timezone = tz.TZDateTime.now(location);

        final String locationName = code.contains("/")
            ? code.split("/")[1].replaceAll("_", " ").replaceAll("-", " ")
            : code;
        LocationModel current = LocationModel(
          code: code,
          continent: getContinent(code.split("/")[0]),
          location: locationName,
          timezone: timezone.timeZoneOffset,
        );
        locations = List.from(locations)..add(current);
        main.value = main.value.copyWith(locations: locations);
      }
    }
    String? format = await InternalRepository.instance.getDateFormat();
    if (format != null) {
      main.value = main.value.copyWith(format: format);
    }
  }

  static Future<void> onChangedFormat(String format) async {
    await InternalRepository.instance.setDateFormat(format);
    main.value = main.value.copyWith(format: format);
  }

  static Future<void> onChangedView(ViewType type) async {
    await InternalRepository.instance.setViewType(type.no);
    main.value = main.value.copyWith(view: type);
  }

  static Future<void> addLocation(LocationModel location) async {
    List<LocationModel> current = main.value.locations;
    current = List.from(current)..insert(0, location);
    main.value = main.value.copyWith(locations: current);
    await InternalRepository.instance.setLocation(location.code);
  }

  static Future<void> _syncLocations() async {
    List<String> codes = [];
    for (final location in main.value.locations) {
      codes = List.from(codes)..add(location.code);
    }
    await InternalRepository.instance.changedLocations(codes);
  }

  static Future<void> onReorder(int previous, int current) async {
    if (previous < current) {
      current -= 1;
    }
    List<LocationModel> locations = main.value.locations;
    LocationModel location = main.value.locations[previous];
    locations = List.from(locations)
      ..removeAt(previous)
      ..insert(current, location);
    main.value = main.value.copyWith(locations: locations);
    await _syncLocations();
  }

  static Future<void> onRemove(int index) async {
    List<LocationModel> locations = main.value.locations;
    locations = List.from(locations)..removeAt(index);
    main.value = main.value.copyWith(locations: locations);
    await _syncLocations();
  }

  static ContinentType getContinent(String code) {
    return switch (code) {
      "Pacific" => ContinentType.pacific,
      "Atlantic" => ContinentType.atlantic,
      "Indian" => ContinentType.indian,
      "Antarctica" => ContinentType.antarctica,
      "America" => ContinentType.america,
      "US" => ContinentType.us,
      "Europe" => ContinentType.europe,
      "Asia" => ContinentType.asia,
      "Africa" => ContinentType.africa,
      "Australia" => ContinentType.australia,
      _ => ContinentType.empty,
    };
  }
}
