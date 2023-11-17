import 'package:flutter/material.dart';
import 'package:watime/model/main_model.dart';
import 'package:watime/model/view_type.dart';
import 'package:watime/services/main_service.dart';
import 'package:watime/ui/main/widgets/main_simple_analogue_widget.dart';
import 'package:watime/ui/main/widgets/main_simple_grid_widget.dart';
import 'package:watime/ui/main/widgets/main_simple_list_widget.dart';
import 'package:watime/ui/main/widgets/main_simple_page_widget.dart';

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
            ViewType.list => MainSimpleListWidget(
                locations: main.locations,
                standard: main.standard,
                format: main.format,
              ),
            ViewType.grid => MainGridWidget(
                format: main.format,
                locations: main.locations,
                standard: main.standard,
              ),
            ViewType.page => MainSimplePageWidget(
                format: main.format,
                locations: main.locations,
                standard: main.standard,
              ),
            ViewType.analogue => MainSimpleAnalogueWidget(
                format: main.format,
                locations: main.locations,
                standard: main.standard,
              ),
          };
        });
  }
}
