import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '/session/game_state_access.dart';

import 'world/ternovka_world.dart';

class BaikalAdventure extends FlameGame<TernovkaWorld> with HasKeyboardHandlerComponents, HasCollisionDetection {
  final GameStateAccess gameStateAccess;

  BaikalAdventure({
    required this.gameStateAccess,
  }) : super(world: TernovkaWorld());

  @override
  Color backgroundColor() => const Color(0xFF202820);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    camera.follow(world.baikal);
    camera.viewfinder.zoom = 1.6;
  }
}