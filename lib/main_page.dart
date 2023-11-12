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
        title: Text("Watime"),
        actions: [
          GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const LocationsPage()));
              },
              child: Icon(Icons.add_box_outlined)),
        ],
      ),
    );
  }
}
