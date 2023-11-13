import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:watime/ui/locations/locations_page.dart';
import 'package:watime/services/theme_service.dart';

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
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("WATIME"),
        actions: [
          GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              ThemeService.onChanged();
            },
            child: Container(
              width: 48,
              // color: Colors.red,
              child: Icon(
                Icons.view_list_rounded,
                size: 34,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              Navigator.of(context).push(
                  CupertinoPageRoute(builder: (_) => const LocationsPage()));
            },
            child: Container(
              width: 48,
              child: Icon(
                Icons.settings,
                size: 32,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LocationsPage()));
            },
            child: Container(
              width: 48,
              // color: Colors.red,
              child: Icon(
                Icons.add_box_rounded,
                size: 34,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
