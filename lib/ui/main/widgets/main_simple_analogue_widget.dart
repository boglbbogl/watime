import 'dart:math';

import 'package:flutter/material.dart';
import 'package:watime/model/location_model.dart';

class MainSimpleAnalogueWidget extends StatefulWidget {
  final List<LocationModel> locations;
  final String format;
  final DateTime standard;
  const MainSimpleAnalogueWidget({
    super.key,
    required this.locations,
    required this.format,
    required this.standard,
  });

  @override
  State<MainSimpleAnalogueWidget> createState() =>
      _MainSimpleAnalogueWidgetState();
}

class _MainSimpleAnalogueWidgetState extends State<MainSimpleAnalogueWidget> {
  final List<int> clocks = List.generate(12, (index) => index + 1);
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: 24),
          Container(
            color: Colors.blue,
            child: Transform.rotate(
              angle: -pi / 2,
              child: CustomPaint(
                size: Size(
                  MediaQuery.of(context).size.width * 0.8,
                  MediaQuery.of(context).size.width * 0.8,
                ),
                painter: ClockPainter(
                    // clocks: clocks,
                    ),
              ),
            ),
          ),
          Container(
            color: Colors.red,
            child: Transform.rotate(
              angle: -pi / 2,
              // angle: 0,
              child: CustomPaint(
                size: Size(
                  MediaQuery.of(context).size.width * 0.8,
                  MediaQuery.of(context).size.width * 0.8,
                ),
                painter: _Clock(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

  //60 sec - 360, 1 sec - 6degree
  //12 hours  - 360, 1 hour - 30degrees, 1 min - 0.5degrees

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = Color(0xFF444974);

    var outlineBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    var centerFillBrush = Paint()..color = Color(0xFFEAECFF);

    var secHandBrush = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8;

    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    var dashBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    var hourHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 16, centerFillBrush);

    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 14;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _Clock extends CustomPainter {
  final DateTime dateTime = DateTime.now();

  _Clock();
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.green;
    final double center = size.width / 2;
    final Offset offset = Offset(center, center);

    paint = Paint()..color = Colors.green;

    canvas.drawCircle(offset, center, paint);
    paint = Paint()..color = Colors.yellow;
    canvas.drawCircle(offset, center - 30, paint);
    paint = Paint()..color = Colors.white;
    canvas.drawCircle(offset, center - center - 20, paint);

    double hourX = center +
        60 *
            cos((dateTime.hour * (center * 0.3) + dateTime.minute * 0.5) *
                pi /
                180);
    double hourY = center +
        60 *
            sin((dateTime.hour * (center * 0.3) + dateTime.minute * 0.5) *
                pi /
                180);
    double minX = center + (center * 0.5) * cos(dateTime.minute * 6 * pi / 180);
    double minY = center + (center * 0.5) * sin(dateTime.minute * 6 * pi / 180);

    double secX =
        center + (center * 0.55) * cos(dateTime.second * 6 * pi / 180);
    double secY =
        center + (center * 0.55) * sin(dateTime.second * 6 * pi / 180);

    paint = Paint()
      ..color = Colors.cyan
      ..strokeWidth = 12;
    canvas.drawLine(offset, Offset(hourX, hourY), paint);

    paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 12;
    canvas.drawLine(offset, Offset(minX, minY), paint);

    paint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 12;
    canvas.drawLine(offset, Offset(secX, secY), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
