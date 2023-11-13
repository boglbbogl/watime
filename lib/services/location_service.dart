import 'package:flutter/material.dart';
import 'package:watime/model/continent_type.dart';
import 'package:watime/model/location_model.dart';
import 'package:watime/model/search_model.dart';

class LocationService {
  static LocationService instance = LocationService._internal();
  factory LocationService() => instance;
  LocationService._internal();

  static ValueNotifier<bool> isSuffix = ValueNotifier(false);
  static ValueNotifier<SearchModel> search = ValueNotifier(SearchModel.empty());
  static ValueNotifier<ContinentType> continentType =
      ValueNotifier(ContinentType.all);

  static onCanceled() {
    isSuffix.value = false;
    search.value = SearchModel.empty();
  }

  static onContinentChanged(ContinentType type, List<LocationModel> locations) {
    List<LocationModel> continentLocations = type.no == 0
        ? locations
        : locations.where((e) => e.continent == type).toList();
    search.value = search.value.copyWith(
      word: "",
      locations: continentLocations,
    );
    continentType.value = type;
  }

  static onChanged(String value, List<LocationModel> locations) {
    if (value.isEmpty) {
      isSuffix.value = false;
      search.value = SearchModel.empty();
    } else {
      isSuffix.value = true;
      String word = value.toLowerCase();
      List<LocationModel> list = [];
      for (final data in locations) {
        String location = data.location.toLowerCase();
        if (location.contains(word)) {
          list = list..add(data);
        }
      }
      search.value = search.value.copyWith(
        word: word,
        locations: list,
      );
      continentType.value = ContinentType.all;
    }
  }
}
