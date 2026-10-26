import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game/baikal_adventure.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GameWidget.controlled(
          gameFactory: BaikalAdventure.new,
        ),
      ),
    ),
  );
}