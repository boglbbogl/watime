import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:watime/model/location_model.dart';

class MainSimpleAnalogueWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            (kTextTabBarHeight + MediaQuery.of(context).padding.top + 25),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.transparent,
                            child: Transform.rotate(
                              angle: -pi / 2,
                              child: CustomPaint(
                                size: Size(
                                  MediaQuery.of(context).size.width * 0.8,
                                  MediaQuery.of(context).size.width * 0.8,
                                ),
                                painter: _Clock(
                                  dateTime: standard.add(locations[0].timezone),
                                  location:
                                      "${locations[0].location}   ${locations[0].timezone.inHours > 0 ? "+${locations[0].timezone.inHours.toString().padLeft(2, "0")}:00" : "UTC -${locations[0].timezone.inHours.abs().toString().padLeft(2, "0")}:00"}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 26,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.4),
                                      ),
                                  background:
                                      Theme.of(context).colorScheme.background,
                                  onSecondary:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                  top: 24, left: 20, right: 20),
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    intl.DateFormat(format).format(standard),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: 16,
                                        ),
                                  ),
                                  Text(
                                    standard
                                        .add(locations[0].timezone)
                                        .toString()
                                        .substring(10, 16),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: 24,
                                        ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Clock extends CustomPainter {
  final Color background;
  final Color onSecondary;
  final DateTime dateTime;
  final String location;
  final TextStyle style;

  _Clock({
    required this.background,
    required this.onSecondary,
    required this.dateTime,
    required this.location,
    required this.style,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    final double center = size.width / 2;
    final Offset offset = Offset(center, center);

    paint = Paint()..color = background;
    canvas.drawCircle(offset, center, paint);
    paint = Paint()..color = onSecondary;
    canvas.drawCircle(offset, center - 35, paint);

    double hourX = center +
        (center * 0.4) *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    double hourY = center +
        (center * 0.4) *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    double minX =
        center + (center * 0.55) * cos(dateTime.minute * 6 * pi / 180);
    double minY =
        center + (center * 0.55) * sin(dateTime.minute * 6 * pi / 180);
    double secX =
        center + (center * 0.65) * cos(dateTime.second * 6 * pi / 180);
    double secY =
        center + (center * 0.65) * sin(dateTime.second * 6 * pi / 180);

    Paint linePaint = Paint()
      ..color = background
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    paint = linePaint;
    canvas.drawLine(offset, Offset(hourX, hourY), paint);

    paint = linePaint;
    canvas.drawLine(offset, Offset(minX, minY), paint);

    paint = linePaint..strokeWidth = 4;
    canvas.drawLine(offset, Offset(secX, secY), paint);

    paint = Paint()..color = background;
    canvas.drawCircle(offset, center - center - (center * 0.1), paint);

    TextPainter tp = TextPainter(textDirection: TextDirection.ltr);

    canvas.translate(size.width / 2, size.width / 2 - (center - 35));

    double dx = 2 * (center - 35) * sin((pi / 2) / 2);
    double rotationAngle = (0 + pi / 2) / 2;
    canvas.rotate(rotationAngle);
    canvas.translate(dx, 0);

    double angle = pi / 2;
    for (int i = 0; i < location.length; i++) {
      tp.text = TextSpan(text: location[i], style: style);
      tp.layout(
        minWidth: 0,
        maxWidth: double.maxFinite,
      );
      final double newDx = tp.width;
      final double newAlpha = 2 * asin(newDx / (2 * (center - 35)));
      final newAngle = (newAlpha + angle) / 2;
      canvas.rotate(newAngle);
      tp.paint(canvas, Offset(0, -tp.height));
      canvas.translate(newDx, 0);
      angle = newAlpha;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
