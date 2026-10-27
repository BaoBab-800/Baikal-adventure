import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'collidable.dart';

class Fence extends RectangleComponent implements Collidable {
  Fence({
    required super.position,
    required super.size,
  }) : super(
    paint: Paint()..color = const Color(0xFF995548),
  );

  @override
  Rect get collisionRect {
    final position = absolutePosition;

    return Rect.fromLTWH(
      position.x,
      position.y,
      size.x,
      size.y,
    );
  }
}