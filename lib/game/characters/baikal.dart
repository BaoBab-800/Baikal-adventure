import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/interactable.dart';

import '../components/collidable.dart';

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

    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.keyE) {
      _findNearestInteractable()?.interact();
    }

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
      final world = findGame()!.world;
      final collidables = _findCollidables(world).toList();

      final nextX = position + Vector2(delta.x, 0);

      if (!_collidesAt(nextX, collidables)) {
        position.x = nextX.x;
      }

      final nextY = position + Vector2(0, delta.y);

      if (!_collidesAt(nextY, collidables)) {
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

  Iterable<Collidable> _findCollidables(Component component) sync* {
    for (final child in component.children) {
      if (child case final Collidable collidable) {
        yield collidable;
      }

      yield* _findCollidables(child);
    }
  }

  bool _collidesAt(Vector2 candidate, Iterable<Collidable> objects) {
    final playerRect = Rect.fromLTWH(
      candidate.x,
      candidate.y,
      size.x,
      size.y,
    );

    for (final object in objects) {
      if (playerRect.overlaps(object.collisionRect)) {
        return true;
      }
    }

    return false;
  }

  Interactable? _findNearestInteractable() {
    final world = findGame()!.world;

    Interactable? nearest;
    var nearestDistance = double.infinity;

    void search(Component component) {
      for (final child in component.children) {
        if (child case final Interactable interactable) {
          final distance = absolutePosition.distanceTo(
            interactable.interactionPosition,
          );

          if (distance <= interactable.interactionRange && distance < nearestDistance) {
            nearest = interactable;
            nearestDistance = distance;
          }
        }

        search(child);
      }
    }

    search(world);
    return nearest;
  }
}