import 'dart:math';
import 'package:flutter/material.dart';

Color generateRandomColor() {
  const predefinedColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.black,
    Colors.orange,
    Colors.purple,
    Colors.pink,

  ];
  Random random = Random();
  return predefinedColors[random.nextInt(predefinedColors.length)];
}