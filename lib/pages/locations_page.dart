import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watime/model/continent_type.dart';
import 'package:watime/model/location_model.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:watime/model/search_model.dart';
import 'package:watime/services/location_service.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final TextEditingController controller = TextEditingController();
  List<LocationModel> locations = [];

  final List<ContinentType> continents = [
    ContinentType.all,
    ContinentType.america,
    ContinentType.us,
    ContinentType.europe,
    ContinentType.asia,
    ContinentType.africa,
    ContinentType.australia,
    ContinentType.pacific,
    ContinentType.atlantic,
    ContinentType.indian,
    ContinentType.antarctica,
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    DateTime now = DateTime.now();
    Duration nowToUtc = now.timeZoneOffset;
    tz.initializeTimeZones();
    Map<String, tz.Location> locationList = tz.timeZoneDatabase.locations;
    List<LocationModel> after = [];
    List<LocationModel> before = [];
    for (final data in locationList.keys) {
      if (!(data == "UTC" || data == "GMT")) {
        tz.Location location = tz.getLocation(data);
        DateTime timezone = tz.TZDateTime.now(location);
        final String locationName = data.contains("/")
            ? data.split("/")[1].replaceAll("_", " ").replaceAll("-", " ")
            : data;
        LocationModel current = LocationModel(
          code: data,
          continent: getContinent(data.split("/")[0]),
          location: locationName,
          timezone: timezone.timeZoneOffset,
        );
        if (nowToUtc <= timezone.timeZoneOffset) {
          after = after..add(current);
        } else {
          before = before..add(current);
        }
      }
    }
    after = after..sort((a, b) => a.timezone.compareTo(b.timezone));
    before = before..sort((a, b) => b.timezone.compareTo(a.timezone));
    locations = [...after, ...before];
  }

  ContinentType getContinent(String code) {
    return switch (code) {
      "Pacific" => ContinentType.pacific,
      "Atlantic" => ContinentType.atlantic,
      "Indian" => ContinentType.indian,
      "Antarctica" => ContinentType.antarctica,
      "America" => ContinentType.america,
      "US" => ContinentType.us,
      "Europe" => ContinentType.europe,
      "Asia" => ContinentType.asia,
      "Africa" => ContinentType.africa,
      "Australia" => ContinentType.australia,
      _ => ContinentType.empty,
    };
  }

  @override
  void dispose() {
    LocationService.onCanceled();
    super.dispose();
  }

  void clear() {
    FocusManager.instance.primaryFocus?.unfocus();
    controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              titleSpacing: 0,
              automaticallyImplyLeading: false,
              elevation: 0,
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
                        child: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 12, right: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
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
                              cursorColor: Colors.black,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-z\s]')),
                              ],
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    bottom: 8, right: 40, left: 8),
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
                                      clear();
                                      LocationService.onCanceled();
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      color: Colors.transparent,
                                      child: Icon(
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
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height:
                                        MediaQuery.of(context).padding.bottom +
                                            50 +
                                            (continents.length * 40),
                                    width: MediaQuery.of(context).size.width,
                                    child: Container(
                                      color: Colors.red,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.amber,
                                            child: Text("Cotinent"),
                                          ),
                                          ListView(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            children: [
                                              ...List.generate(
                                                continents.length,
                                                (index) => GestureDetector(
                                                  onTap: () {
                                                    HapticFeedback
                                                        .mediumImpact();
                                                    clear();
                                                    Navigator.of(context).pop();
                                                    LocationService
                                                        .onContinentChanged(
                                                            continents[index],
                                                            locations);
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    // color: Colors.accents[index],
                                                    child: Row(
                                                      children: [
                                                        Icon(continents[
                                                                    index] ==
                                                                type
                                                            ? Icons.circle
                                                            : Icons
                                                                .circle_outlined),
                                                        Text(continents[index]
                                                            .name),
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
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              height: 40,
                              width: 40,
                              color: Colors.transparent,
                              child: Stack(
                                children: [
                                  Center(child: Icon(Icons.place_outlined)),
                                  Positioned(
                                    right: 4,
                                    top: 4,
                                    child: Visibility(
                                      visible: type.no != 0,
                                      child: Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.red,
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
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ValueListenableBuilder<SearchModel>(
                valueListenable: LocationService.search,
                builder: (
                  BuildContext context,
                  SearchModel search,
                  Widget? child,
                ) {
                  return SliverList.builder(
                      itemCount:
                          (search.locations.isEmpty && controller.text.isEmpty)
                              ? locations.length
                              : search.locations.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.amber.shade50,
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(((search.locations.isEmpty &&
                                              controller.text.isEmpty)
                                          ? locations[index]
                                          : search.locations[index])
                                      .continent
                                      .name
                                      .toString()),
                                  RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                          color: Colors.black,
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
                                                    color: search.word.contains(
                                                            e.toLowerCase())
                                                        ? Colors.red
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
                                  color: Colors.red,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                margin: EdgeInsets.symmetric(vertical: 4),
                                child: Icon(Icons.add),
                              ),
                            ],
                          ),
                        );
                      });
                })
          ],
        ),
      ),
    );
  }
}
