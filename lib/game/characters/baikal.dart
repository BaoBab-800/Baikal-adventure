import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:baikal_adventure/game/world/fence.dart';

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
      final delta = direction.normalized() * speed * dt;
      final fences = parent!.children.query<Fence>();

      final nextX = position + Vector2(delta.x, 0);

      if (!_collidesAt(nextX, fences)) {
        position.x = nextX.x;
      }

      final nextY = position + Vector2(0, delta.y);

      if (!_collidesAt(nextY, fences)) {
        position.y = nextY.y;
      }
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

  bool _collidesAt(Vector2 candidate, Iterable<Fence> fences) {
    final playerRect = Rect.fromLTWH(
      candidate.x,
      candidate.y,
      size.x,
      size.y,
    );

    for (final fence in fences) {
      final fenceRect = Rect.fromLTWH(
        fence.position.x,
        fence.position.y,
        fence.size.x,
        fence.size.y,
      );

      if (playerRect.overlaps(fenceRect)) return true;
    }

    return false;
  }
}