import 'package:flutter/material.dart';
import 'package:flame/components.dart';

import '../../components/fence.dart';

class HouseOfBaikal extends PositionComponent {
  HouseOfBaikal({
   required super.position,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(
      RectangleComponent(
        position: Vector2(0, 0),
        size: Vector2(255, 455),
        paint: Paint()..color = const Color(0xFF496B42),
      ),
    );

    add(
      Fence(
        position: Vector2(0, 0),
        size: Vector2(12, 460),
      ),
    );

    add(
      Fence(
        position: Vector2(0, 0),
        size: Vector2(260, 12),
      ),
    );

    add(
      Fence(
        position: Vector2(255, 0),
        size: Vector2(12, 460),
      ),
    );

    add(
      Fence(
        position: Vector2(0, 455),
        size: Vector2(90, 12),
      ),
    );

    add(
      Fence(
        position: Vector2(145, 455),
        size: Vector2(122, 12),
      ),
    );
  }
}