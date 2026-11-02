import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class CollisionObstacle extends PositionComponent {
  CollisionObstacle({
    required super.position,
    required super.size,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(
      RectangleHitbox(
        collisionType: CollisionType.passive,
      ),
    );
  }
}