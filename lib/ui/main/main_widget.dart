import 'package:flutter/material.dart';
import 'package:watime/model/main_model.dart';
import 'package:watime/model/view_type.dart';
import 'package:watime/services/main_service.dart';
import 'package:watime/ui/main/main_grid_widget.dart';
import 'package:watime/ui/main/main_list_widget.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: MainService.main,
        builder: (
          BuildContext context,
          MainModel main,
          Widget? child,
        ) {
          return switch (main.view) {
            ViewType.list => MainListWidget(
                locations: main.locations,
                standard: main.standard,
              ),
            ViewType.grid => MainGridWidget(
                locations: main.locations,
                standard: main.standard,
              ),
          };
        });
  }
}
