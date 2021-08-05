import 'dart:math';

import 'package:flutter/material.dart';

class RadialPainter extends CustomPainter {
  final Color bgColor;
  final Color lineColor;
  final double percent;
  final double thickness;

  RadialPainter(
      {required this.bgColor,
      required this.lineColor,
      required this.percent,
      required this.thickness});

  @override
  void paint(Canvas canvas, Size size) {
    print('repaint... RadialPainter');

    Paint bgPaint = Paint()
      ..color = bgColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    Paint linePaint = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    Offset center = Offset(size.width / 2, size.height / 2);
    double diameter = min(size.width, size.height);
    double radius = diameter / 2;

    canvas.drawCircle(center, radius, bgPaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        -2 * pi * percent, false, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
