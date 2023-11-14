import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:watime/model/view_type.dart';
import 'package:watime/services/main_service.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String format = "EEE, MMM dd";
  ViewType view = ViewType.list;

  @override
  void initState() {
    super.initState();
    format = MainService.main.value.format;
    view = MainService.main.value.view;
  }

  final List<ViewType> views = [
    ViewType.list,
    ViewType.grid,
    ViewType.page,
  ];

  final List<String> formatter = [
    "EEE, MMM dd",
    "EE, MMM dd, yyyy",
    "MMM dd, yyyy",
    "EEEE, MM/dd",
    "MMMM dd, yyyy",
    "EE, MM/dd",
    "EE, MMMM dd",
    "EEEE, MMM dd",
    "yyyy/MM/dd",
    "yyyy-MM-dd",
  ];

  Future<void> onChangedFormat(String change) async {
    await MainService.onChangedFormat(change);
    setState(() {
      format = change;
    });
  }

  Future<void> onChangedView(ViewType type) async {
    await MainService.onChangedView(type);
    setState(() {
      view = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _title("View"),
            _views(),
            _title("Date Format"),
            _dateFormats(),
          ],
        ),
      ),
    );
  }

  Column _dateFormats() {
    return Column(
      children: [
        ...List.generate(
          formatter.length,
          (index) => GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              onChangedFormat(formatter[index]);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              width: MediaQuery.of(context).size.width,
              height: 32,
              color: Colors.transparent,
              child: Row(
                children: [
                  Container(
                    width: 24,
                    margin: const EdgeInsets.only(right: 8),
                    color: Colors.transparent,
                    child: Visibility(
                      visible: format == formatter[index],
                      child: Icon(
                        Icons.check,
                        size: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  Text(
                    DateFormat(formatter[index]).format(DateTime.now()),
                    style: format == formatter[index]
                        ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primary)
                        : Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 14,
                            ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Container _title(String text) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
      height: 60,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 22,
              ),
        ),
      ),
    );
  }

  Container _views() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 170,
      color: Colors.transparent,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 28),
            ...List.generate(
                views.length,
                (index) => GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        onChangedView(views[index]);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12, top: 5),
                        height: view == views[index] ? 160 : 156,
                        width: view == views[index] ? 120 : 116,
                        decoration: BoxDecoration(
                          border: view == views[index]
                              ? Border.all(
                                  width: 4,
                                  color: Theme.of(context).colorScheme.primary,
                                )
                              : null,
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (views[index] == ViewType.list) ...[
                              ...List.generate(
                                4,
                                (i) => Container(
                                  margin:
                                      const EdgeInsets.only(bottom: 4, top: 4),
                                  width: 100,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              )
                            ],
                            if (views[index] == ViewType.grid) ...[
                              ...List.generate(
                                3,
                                (i) => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ...List.generate(
                                      2,
                                      (ii) => Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                        margin: EdgeInsets.only(
                                            bottom: 4,
                                            top: 4,
                                            right: ii % 2 == 0 ? 4 : 0),
                                        width: 50,
                                        height: 40,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                            if (views[index] == ViewType.page) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ...List.generate(
                                    3,
                                    (ii) => Container(
                                      margin: EdgeInsets.only(
                                          right: ii == 0 ? 4 : 0,
                                          left: ii == 2 ? 4 : 0),
                                      height: ii == 1 ? 100 : 80,
                                      width: ii != 1
                                          ? 14
                                          : (view == views[index] ? 76 : 80),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                ii == 0 ? 0 : 4),
                                            topRight: Radius.circular(
                                                ii == 2 ? 0 : 4),
                                            bottomLeft: Radius.circular(
                                                ii == 0 ? 0 : 4),
                                            bottomRight: Radius.circular(
                                                ii == 2 ? 0 : 4)),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
