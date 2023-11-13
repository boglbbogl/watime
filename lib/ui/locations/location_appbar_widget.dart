import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watime/model/continent_type.dart';
import 'package:watime/model/location_model.dart';
import 'package:watime/model/theme_model.dart';
import 'package:watime/services/location_service.dart';

class LocationAppbarWidget extends StatelessWidget {
  final List<LocationModel> locations;
  final List<ContinentType> continents;
  final TextEditingController controller;
  final GlobalKey initKey;
  final Function() onClear;
  const LocationAppbarWidget({
    super.key,
    required this.locations,
    required this.continents,
    required this.onClear,
    required this.controller,
    required this.initKey,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      pinned: true,
      title: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).pop();
              },
              child: Container(
                height: 40,
                width: 40,
                margin: const EdgeInsets.only(left: 12),
                color: Colors.transparent,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 12, right: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              height: 40,
              width: MediaQuery.of(context).size.width - 128,
              child: Stack(
                children: [
                  TextFormField(
                      onChanged: (String value) {
                        LocationService.onChanged(value, locations);
                      },
                      controller: controller,
                      cursorColor: Theme.of(context).colorScheme.primary,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-z\s]')),
                      ],
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Search for location...",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                fontSize: 14,
                                color: const Color.fromRGBO(155, 155, 155, 1)),
                        contentPadding: const EdgeInsets.only(
                            bottom: 12, right: 40, left: 8),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                      )),
                  ValueListenableBuilder<bool>(
                    valueListenable: LocationService.isSuffix,
                    builder: (
                      BuildContext context,
                      bool value,
                      Widget? child,
                    ) {
                      return Positioned(
                        right: 0,
                        child: Visibility(
                          visible: value,
                          child: GestureDetector(
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              onClear();
                              LocationService.onCanceled();
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              color: Colors.transparent,
                              child: const Icon(
                                Icons.close_rounded,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            ValueListenableBuilder<ContinentType>(
                valueListenable: LocationService.continentType,
                builder: (
                  BuildContext context,
                  ContinentType type,
                  Widget? child,
                ) {
                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      _bottomSheet(context, type);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      height: 40,
                      width: 40,
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          Center(
                              child: Icon(
                            Icons.place_outlined,
                            size: 32,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                          Positioned(
                            right: 2,
                            top: 2,
                            child: Visibility(
                              visible: type.no != 0,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: ThemeModel.firstColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Future<void> _bottomSheet(
    BuildContext context,
    ContinentType type,
  ) async {
    return showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent.withOpacity(0.7),
      builder: (context) {
        return Container(
          color: Theme.of(context).colorScheme.background,
          height: MediaQuery.of(context).padding.bottom +
              60 +
              (continents.length * 40),
          width: MediaQuery.of(context).size.width,
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Color.fromRGBO(155, 155, 155, 1),
                  ))),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Cotinent",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ),
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    ...List.generate(
                      continents.length,
                      (index) => GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          onClear();
                          Navigator.of(context).pop();
                          LocationService.onContinentChanged(
                              continents[index], locations);
                          if (initKey.currentContext != null) {
                            Scrollable.ensureVisible(initKey.currentContext!,
                                duration: const Duration(milliseconds: 350));
                          }
                        },
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.only(left: 24),
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Icon(
                                continents[index] == type
                                    ? Icons.circle
                                    : Icons.circle_outlined,
                                size: 14,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                continents[index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: continents[index] == type
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : const Color.fromRGBO(
                                              155, 155, 155, 1),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      isScrollControlled: true,
    );
  }
}
