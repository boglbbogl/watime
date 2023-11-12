import 'package:flutter/material.dart';
import 'package:watime/model/continent_type.dart';
import 'package:watime/model/location_model.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  List<LocationModel> locations = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    DateTime now = DateTime.now();
    Duration nowToUtc = now.timeZoneOffset;
    tz.initializeTimeZones();
    Map<String, tz.Location> locationList = tz.timeZoneDatabase.locations;
    List<LocationModel> after = [];
    List<LocationModel> before = [];
    for (final data in locationList.keys) {
      if (!(data == "UTC" || data == "GMT")) {
        tz.Location location = tz.getLocation(data);
        DateTime timezone = tz.TZDateTime.now(location);
        final String locationName =
            data.contains("/") ? data.split("/")[1].replaceAll("_", " ") : data;
        LocationModel current = LocationModel(
          code: data,
          continent: getContinent(data.split("/")[0]),
          location: locationName,
          timezone: timezone.timeZoneOffset,
        );
        if (nowToUtc <= timezone.timeZoneOffset) {
          after = after..add(current);
        } else {
          before = before..add(current);
        }
      }
    }
    after = after..sort((a, b) => a.timezone.compareTo(b.timezone));
    before = before..sort((a, b) => b.timezone.compareTo(a.timezone));
    // setState(() {
    locations = [...after, ...before];
    // });
  }

  ContinentType getContinent(String code) {
    return switch (code) {
      "Pacific" => ContinentType.pacific,
      "Atlantic" => ContinentType.atlantic,
      "Indian" => ContinentType.indian,
      "America" => ContinentType.america,
      "US" => ContinentType.us,
      "Europe" => ContinentType.europe,
      "Asia" => ContinentType.asia,
      "Africa" => ContinentType.africa,
      "Australia" => ContinentType.australia,
      _ => ContinentType.empty,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Visibility(
              visible: true,
              // visible: locations[index].continent == ContinentType.asia,
              child: Container(
                child: Text(
                  locations[index].location,
                ),
              ),
            );
          }),
    );
  }
}
