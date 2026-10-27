import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'world/ternovka_world.dart';

class BaikalAdventure extends FlameGame<TernovkaWorld> with HasKeyboardHandlerComponents {
  BaikalAdventure() : super(world: TernovkaWorld());

  @override
  Color backgroundColor() => const Color(0xFF202820);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    camera.follow(world.baikal);
  }
}