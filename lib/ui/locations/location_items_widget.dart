import 'package:flutter/material.dart';
import 'package:watime/model/location_model.dart';
import 'package:watime/model/search_model.dart';
import 'package:watime/model/theme_model.dart';
import 'package:watime/services/location_service.dart';

class LocationItemsWidget extends StatelessWidget {
  final List<LocationModel> locations;
  final TextEditingController controller;
  const LocationItemsWidget({
    super.key,
    required this.locations,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<SearchModel>(
        valueListenable: LocationService.search,
        builder: (
          BuildContext context,
          SearchModel search,
          Widget? child,
        ) {
          return SliverList.builder(
              itemCount: (search.locations.isEmpty && controller.text.isEmpty)
                  ? locations.length
                  : search.locations.length,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ((search.locations.isEmpty &&
                                        controller.text.isEmpty)
                                    ? locations[index]
                                    : search.locations[index])
                                .continent
                                .name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          RichText(
                            text: TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                children: [
                                  ...((search.locations.isEmpty &&
                                              controller.text.isEmpty)
                                          ? locations[index]
                                          : search.locations[index])
                                      .location
                                      .split("")
                                      .map((e) => TextSpan(
                                          text: e,
                                          style: TextStyle(
                                            color: search.word
                                                    .contains(e.toLowerCase())
                                                ? ThemeModel.firstColor
                                                : null,
                                          )))
                                ]),
                          ),
                        ],
                      ),
                      Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Center(
                            child: Text(
                              "+",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 32,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          )),
                    ],
                  ),
                );
              });
        });
  }
}
