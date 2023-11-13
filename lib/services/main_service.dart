import 'package:flutter/material.dart';
import 'package:watime/model/continent_type.dart';
import 'package:watime/model/location_model.dart';
import 'package:watime/model/main_model.dart';
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

  static Future<void> init() async {
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
  }

  static Future<void> addLocation(LocationModel location) async {
    List<LocationModel> current = main.value.locations;
    current = List.from(current)..insert(0, location);
    main.value = main.value.copyWith(locations: current);
    await InternalRepository.instance.setLocation(location.code);
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
