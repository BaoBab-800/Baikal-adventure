import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Baikal extends PositionComponent with KeyboardHandler {
  Baikal() : super(
    position: Vector2.zero(),
    size: Vector2(32, 32),
  );

  final double speed = 150;
  final Set<LogicalKeyboardKey> _keysPressed = {};

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _keysPressed
      ..clear()
      ..addAll(keysPressed);

    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);

    final direction = Vector2.zero();

    if (_keysPressed.contains(LogicalKeyboardKey.keyW) ||
        _keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      direction.y -= 1;
    }

    if (_keysPressed.contains(LogicalKeyboardKey.keyS) ||
        _keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      direction.y += 1;
    }

    if (_keysPressed.contains(LogicalKeyboardKey.keyA) ||
        _keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      direction.x -= 1;
    }

    if (_keysPressed.contains(LogicalKeyboardKey.keyD) ||
        _keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      direction.x += 1;
    }

    if (direction.length > 0) {
      position += direction.normalized() * speed * dt;
    }

    final visibleRect = findGame()!.camera.visibleWorldRect;

    position.x = position.x
        .clamp(visibleRect.left, visibleRect.right - size.x)
        .toDouble();

    position.y = position.y
        .clamp(visibleRect.top, visibleRect.bottom - size.y)
        .toDouble();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      size.toRect(),
      Paint()..color = Colors.lightBlue,
    );
  }
}