import 'package:flutter/material.dart';

class ColorHelper {
  static Color getColor(double percentRemain) {
    percentRemain = percentRemain * 100;
    if (percentRemain <= 30) return Colors.red;
    if (percentRemain > 30 && percentRemain < 60) return Colors.orange;

    return Colors.green;
  }
}
