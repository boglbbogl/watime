import 'package:watime/model/continent_type.dart';

class LocationModel {
  final String code;
  final ContinentType continent;
  final String location;
  final Duration timezone;

  const LocationModel({
    required this.code,
    required this.continent,
    required this.location,
    required this.timezone,
  });

  LocationModel copyWith({
    final String? code,
    final ContinentType? continent,
    final String? location,
    final Duration? timezone,
  }) {
    return LocationModel(
      code: code ?? this.code,
      continent: continent ?? this.continent,
      location: location ?? this.location,
      timezone: timezone ?? this.timezone,
    );
  }

  factory LocationModel.init() => const LocationModel(
        code: "",
        continent: ContinentType.empty,
        location: "",
        timezone: Duration.zero,
      );

  @override
  String toString() =>
      "LocationModel(code : $code, contient : $continent, location : $location, timezone : $timezone)";
}
