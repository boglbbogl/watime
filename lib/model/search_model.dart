import 'package:watime/model/location_model.dart';

class SearchModel {
  final List<LocationModel> locations;
  final String word;

  const SearchModel({
    required this.locations,
    required this.word,
  });

  SearchModel copyWith({
    final List<LocationModel>? locations,
    final String? word,
  }) {
    return SearchModel(
      locations: locations ?? this.locations,
      word: word ?? this.word,
    );
  }

  factory SearchModel.empty() => const SearchModel(
        locations: [],
        word: "",
      );
}
