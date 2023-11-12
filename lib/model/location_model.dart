class LocationModel {
  final String code;
  final int no;
  final int continent;
  final String location;
  final Duration? timezone;

  const LocationModel({
    required this.code,
    required this.no,
    required this.continent,
    required this.location,
    this.timezone,
  });

  LocationModel copyWith({
    final String? code,
    final int? no,
    final int? continent,
    final String? location,
    final Duration? timezone,
  }) {
    return LocationModel(
      code: code ?? this.code,
      no: no ?? this.no,
      continent: continent ?? this.continent,
      location: location ?? this.location,
      timezone: timezone ?? this.timezone,
    );
  }

  factory LocationModel.init() => const LocationModel(
        code: "",
        no: 0,
        continent: 0,
        location: "",
      );
}
