import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Fence extends RectangleComponent {
  Fence({
    required super.position,
    required super.size,
  }) : super(
    paint: Paint()..color = const Color(0xFF995548),
  );
}