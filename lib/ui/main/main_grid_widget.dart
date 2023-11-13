import 'package:flutter/material.dart';
import 'package:watime/model/location_model.dart';

class MainGridWidget extends StatelessWidget {
  final List<LocationModel> locations;
  final DateTime standard;
  const MainGridWidget({
    super.key,
    required this.locations,
    required this.standard,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
