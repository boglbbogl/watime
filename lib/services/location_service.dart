class LocationService {
  static LocationService instance = LocationService._internal();
  factory LocationService() => instance;
  LocationService._internal();

  // static List<LocationModel> locations = [];

  // static getLocations(List<LocationModel> data) => locations = data;
}
