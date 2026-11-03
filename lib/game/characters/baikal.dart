import 'dart:ui' as ui;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/interactable.dart';
import '../components/interaction_hint.dart';
import '../components/collision_obstacle.dart';

class Baikal extends PositionComponent with KeyboardHandler {
  Baikal() : super(
    position: Vector2.zero(),
    size: Vector2(32, 32),
  ) {
    add(_interactionHint);
  }

  final Paint _paint = Paint()..color = Colors.lightBlue;
  final double speed = 125;
  final Set<LogicalKeyboardKey> _keysPressed = {};

  final InteractionHint _interactionHint = InteractionHint();

  late final RectangleHitbox _hitbox;

  late final SpriteAnimationComponent _sprite;

  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _walkDown;
  late final SpriteAnimation _walkUp;
  late final SpriteAnimation _walkLeft;
  late final SpriteAnimation _walkRight;

  String _currentAnimation = 'idle';

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final idleImage = await findGame()!.images.load(
      'characters/baikal/idle.jpg',
    );

    final walkDownImage = await findGame()!.images.load(
      'characters/baikal/walk_down.png',
    );

    final walkUpImage = await findGame()!.images.load(
      'characters/baikal/walk_up.jpg',
    );

    final walkLeftImage = await findGame()!.images.load(
      'characters/baikal/walk_left.jpg',
    );

    final walkRightImage = await findGame()!.images.load(
      'characters/baikal/walk_right.jpg',
    );

    _idleAnimation = SpriteAnimation.fromFrameData(
      idleImage,
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 1,
        textureSize: Vector2(120, 240),
      ),
    );

    _walkDown = _createAnimation(walkDownImage);
    _walkUp = _createAnimation(walkUpImage);
    _walkLeft = _createAnimation(walkLeftImage);
    _walkRight = _createAnimation(walkRightImage);

    _sprite = SpriteAnimationComponent(
      animation: _idleAnimation,
      position: Vector2(0, -32),
      size: Vector2(34, 68),
    );

    add(_sprite);

    _hitbox = RectangleHitbox(
      position: Vector2(0, 0),
      size: Vector2(32, 32),
      collisionType: CollisionType.active,
    );

    add(_hitbox);
  }

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

    if (!direction.isZero()) {
      direction.normalize();

      final delta = direction * (speed * dt);

      _move(delta);
    }

    _updateAnimation(direction);
    _updateInteractionHint();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(size.toRect(), _paint);
  }

  void _move(Vector2 delta) {
    _moveAxis(delta.x, isHorizontal: true);
    _moveAxis(delta.y, isHorizontal: false);
  }

  void _moveAxis(double amount, {required bool isHorizontal}) {
    if (amount == 0) return;

    final playerRect = _hitbox.toAbsoluteRect();

    var allowedMovement = amount;

    final obstacles = findGame()!.world.children.whereType<CollisionObstacle>();

    for (final obstacle in obstacles) {
      final obstacleRect = obstacle.toAbsoluteRect();

      if (isHorizontal) {
        final verticalOverlap = playerRect.top < obstacleRect.bottom && playerRect.bottom > obstacleRect.top;

        if (!verticalOverlap) continue;

        if (amount > 0 && playerRect.right <= obstacleRect.left) {
          final distance = obstacleRect.left - playerRect.right;

          if (distance < allowedMovement) {
            allowedMovement = distance;
          }
        } else if (amount < 0 && playerRect.left >= obstacleRect.right) {
          final distance = obstacleRect.right - playerRect.left;

          if (distance > allowedMovement) {
            allowedMovement = distance;
          }
        }
      } else {
        final horizontalOverlap = playerRect.left < obstacleRect.right && playerRect.right > obstacleRect.left;

        if (!horizontalOverlap) continue;

        if (amount > 0 && playerRect.bottom <= obstacleRect.top) {
          final distance = obstacleRect.top - playerRect.bottom;

          if (distance < allowedMovement) {
            allowedMovement = distance;
          }
        } else if (amount < 0 && playerRect.top >= obstacleRect.bottom) {
          final distance = obstacleRect.bottom - playerRect.top;

          if (distance > allowedMovement) {
            allowedMovement = distance;
          }
        }
      }
    }

    if (isHorizontal) {
      position.x += allowedMovement;
    } else {
      position.y += allowedMovement;
    }
  }

  Interactable? _findNearestInteractable() {
    final world = findGame()!.world;

    final origin = absoluteCenter;

    Interactable? nearest;
    var nearestDistance = double.infinity;

    void search(Component component) {
      for (final child in component.children) {
        if (child case final Interactable interactable) {
          final distance = origin.distanceTo(
            interactable.interactionPosition,
          );

          if (distance <= interactable.interactionRange &&
              distance < nearestDistance) {
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

  void _updateInteractionHint() {
    final target = _findNearestInteractable();

    final text = target == null ? '' : 'E – ${target.interactionPrompt}';

    if (_interactionHint.text != text) {
      _interactionHint.text = text;
    }

    if (target == null) return;

    _interactionHint.position = target.interactionPosition - absolutePosition + Vector2(0, -24);
  }

  SpriteAnimation _createAnimation(ui.Image image) {
    return SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.15,
        textureSize: Vector2(120, 240),
      ),
    );
  }

  void _updateAnimation(Vector2 direction) {
    if (direction.isZero()) {
      _setAnimation('idle', _idleAnimation);
      return;
    }

    if (direction.x.abs() > direction.y.abs()) {
      if (direction.x > 0) {
        _setAnimation('walk_right', _walkRight);
      } else {
        _setAnimation('walk_left', _walkLeft);
      }
    } else {
      if (direction.y > 0) {
        _setAnimation('walk_down', _walkDown);
      } else {
        _setAnimation('walk_up', _walkUp);
      }
    }
  }

  void _setAnimation(String name, SpriteAnimation animation) {
    if (_currentAnimation == name) return;

    _currentAnimation = name;
    _sprite.animation = animation;
  }
}