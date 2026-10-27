import 'package:flutter/material.dart';
import 'package:flame/components.dart';

import 'package:baikal_adventure/game/characters/baikal.dart';

import 'fence.dart';

class TernovkaWorld extends World {
  TernovkaWorld() {
    baikal = Baikal();
    add(baikal);
  }

  late final Baikal baikal;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(
      RectangleComponent(
        position: Vector2(-100, -100),
        size: Vector2(250, 450),
        paint: Paint()..color = const Color(0xFF496B42),
      ),
    );

    add(
      RectangleComponent(
        position: Vector2(-4000, 400),
        size: Vector2(10000, 160),
        paint: Paint()..color = const Color(0xFF707070),
      ),
    );

    add(
      RectangleComponent(
        position: Vector2(-275, -1000),
        size: Vector2(160, 10000),
        paint: Paint()..color = const Color(0xFF707070),
      ),
    );

    add(
      Fence(
        position: Vector2(-105, -105),
        size: Vector2(12, 460),
      ),
    );

    add(
      Fence(
        position: Vector2(-105, -105),
        size: Vector2(260, 12),
      ),
    );

    add(
      Fence(
        position: Vector2(150, -105),
        size: Vector2(12, 460),
      ),
    );

    add(
      Fence(
        position: Vector2(-105, 350),
        size: Vector2(90, 12),
      ),
    );

    add(
      Fence(
        position: Vector2(40, 350),
        size: Vector2(122, 12),
      ),
    );

    add(baikal);
  }
}