import 'package:flutter/material.dart';
import 'package:flame/components.dart';

import 'package:baikal_adventure/game/characters/baikal.dart';

import 'locations/house_of_baikal.dart';

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
      HouseOfBaikal(
        position: Vector2(-105, -105),
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

    add(baikal);
  }
}