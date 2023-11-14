import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watime/model/location_model.dart';
import 'package:watime/services/main_service.dart';

class MainSimpleListWidget extends StatelessWidget {
  final List<LocationModel> locations;
  final DateTime standard;
  final String format;
  const MainSimpleListWidget({
    super.key,
    required this.locations,
    required this.standard,
    required this.format,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          _hourAndMinute(index),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                fontSize: 48,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4, top: 14),
                          child: Text(
                            _second(index),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontSize: 25,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat(format).format(standard),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                            MainService.getContinent(
                                    locations[index].continent.code)
                                .name,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  fontSize: 10,
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                        const SizedBox(height: 12),
                        Text(locations[index].location,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 18,
                                  color: Theme.of(context).colorScheme.primary,
                                ))
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  String _date(int index) =>
      standard.add(locations[index].timezone).toString().substring(0, 10);

  String _second(int index) =>
      standard.add(locations[index].timezone).toString().substring(17, 19);

  String _hourAndMinute(int index) =>
      standard.add(locations[index].timezone).toString().substring(11, 16);
}
