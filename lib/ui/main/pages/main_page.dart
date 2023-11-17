import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:watime/model/main_model.dart';
import 'package:watime/services/main_service.dart';
import 'package:watime/ui/locations/locations_page.dart';
import 'package:watime/services/theme_service.dart';
import 'package:watime/ui/main/widgets/main_widget.dart';
import 'package:watime/ui/setting/setting_page.dart';

class MainPage extends StatefulWidget {
  final Brightness brightness;
  const MainPage({
    super.key,
    required this.brightness,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    ThemeService.init(widget.brightness);
    MainService.init();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      DateTime now = DateTime.now().toUtc();
      MainService.syncTime(now);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            floating: true,
            snap: true,
            centerTitle: false,
            title: GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  ThemeService.onChanged();
                },
                child: const Text(
                  "WATIME",
                )),
            actions: [
              _action(icon: Icons.view_list_rounded, to: const LocationsPage()),
              _action(icon: Icons.settings, to: const SettingPage()),
              _action(icon: Icons.add_box_rounded, to: const LocationsPage()),
              const SizedBox(width: 8),
            ],
          ),
          ValueListenableBuilder<MainModel>(
              valueListenable: MainService.main,
              builder: (
                BuildContext context,
                MainModel main,
                Widget? child,
              ) {
                return SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 25,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "UTC ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.4),
                                    fontSize: 14,
                                  ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              DateFormat(main.format).format(main.standard),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.4),
                                    fontSize: 14,
                                  ),
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.transparent,
                          child: Text(
                            main.standard.toString().substring(11, 19),
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.4),
                                      fontSize: 14,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          const MainWidget(),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  GestureDetector _action({
    required IconData icon,
    required Widget to,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => to));
      },
      child: SizedBox(
        width: 48,
        child: Icon(icon, size: 28),
      ),
    );
  }
}
