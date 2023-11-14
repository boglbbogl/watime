import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watime/model/location_model.dart';
import 'package:watime/services/main_service.dart';

class MainSimplePageWidget extends StatefulWidget {
  final List<LocationModel> locations;
  final String format;
  final DateTime standard;
  const MainSimplePageWidget({
    super.key,
    required this.locations,
    required this.format,
    required this.standard,
  });

  @override
  State<MainSimplePageWidget> createState() => _MainSimplePageWidgetState();
}

class _MainSimplePageWidgetState extends State<MainSimplePageWidget> {
  int current = 0;
  final PageController controller = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          margin: const EdgeInsets.only(top: 40),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          color: Colors.transparent,
          child: PageView.builder(
              controller: controller,
              onPageChanged: (int i) {
                setState(() {
                  current = i;
                });
              },
              itemCount: widget.locations.length,
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(
                      left: 8,
                      right: 8,
                      top: index != current ? 20 : 0,
                      bottom: index != current ? 29 : 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 70,
                            padding: const EdgeInsets.only(left: 8),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: Theme.of(context).colorScheme.background,
                              width: 4,
                            ))),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                widget.locations[index].location,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 32,
                                    ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat(widget.format)
                                      .format(widget.standard),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                                Text(
                                  widget.standard
                                      .add(widget.locations[index].timezone)
                                      .toString()
                                      .substring(11, 16),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 100,
                                      ),
                                ),
                                const SizedBox(height: 70),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 24,
                        right: 16,
                        child: Text(
                          widget.locations[index].timezone.inHours > 0
                              ? "UTC +${widget.locations[index].timezone.inHours.toString().padLeft(2, "0")}:00"
                              : "UTC -${widget.locations[index].timezone.inHours.abs().toString().padLeft(2, "0")}:00",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.6),
                                    fontSize: 14,
                                  ),
                        ),
                      ),
                      Positioned(
                        bottom: 24,
                        left: 16,
                        child: Text(
                          MainService.getContinent(
                                  widget.locations[index].continent.code)
                              .name,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.6),
                                    fontSize: 14,
                                  ),
                        ),
                      )
                    ],
                  ),
                );
              })),
    );
  }
}
