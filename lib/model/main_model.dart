import 'package:watime/model/location_model.dart';
import 'package:watime/model/view_type.dart';

class MainModel {
  final List<LocationModel> locations;
  final ViewType view;
  final DateTime standard;

  const MainModel({
    required this.locations,
    required this.view,
    required this.standard,
  });

  factory MainModel.init() => MainModel(
        locations: [],
        view: ViewType.list,
        standard: DateTime.now().toUtc(),
      );

  MainModel copyWith({
    final List<LocationModel>? locations,
    final ViewType? view,
    final DateTime? standard,
  }) {
    return MainModel(
      locations: locations ?? this.locations,
      view: view ?? this.view,
      standard: standard ?? this.standard,
    );
  }
}
