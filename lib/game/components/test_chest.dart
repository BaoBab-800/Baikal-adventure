import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'interactable.dart';

class TestChest extends RectangleComponent implements Interactable {
  TestChest({
    required super.position,
  }) : super(
    size: Vector2(32, 24),
    paint: Paint()..color = const Color(0xFF9B633C),
  );

  @override
  double get interactionRange => 60;

  @override
  Vector2 get interactionPosition => absolutePosition + size / 2;

  @override
  String get interactionPrompt => 'Open chest';

  @override
  void interact() {
    print('Baikal has enabled interaction!');
  }
}