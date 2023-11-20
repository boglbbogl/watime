import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watime/model/location_model.dart';

class MainGridWidget extends StatelessWidget {
  final List<LocationModel> locations;
  final String format;
  final DateTime standard;
  const MainGridWidget({
    super.key,
    required this.locations,
    required this.format,
    required this.standard,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 12),
      sliver: SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 24,
          ),
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                left: index % 2 == 0 ? 12 : 0,
                right: index % 2 != 0 ? 12 : 0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 4, left: 8, right: 8, bottom: 4),
                    child: Text(
                      locations[index].location,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 32,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.4),
                          ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 4,
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Text(
                                DateFormat(format).format(standard),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 12,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            ),
                          ),
                          Text(
                            standard
                                .add(locations[index].timezone)
                                .toString()
                                .substring(11, 16),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  fontSize: 40,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
