import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:watime/pages/locations_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
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
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LocationsPage()));
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
                  MaterialPageRoute(builder: (_) => const LocationsPage()));
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
