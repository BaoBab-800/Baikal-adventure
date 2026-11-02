import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../components/collision_obstacle.dart';

class CollisionLoader {
  static void load(TiledComponent map, World world) {
    final layer = map.tileMap.getLayer<ObjectGroup>('Collisions');

    if (layer == null) {
      throw Exception('Collision layer not found!');
    }

    for (final object in layer.objects) {
      world.add(
        CollisionObstacle(
          position: Vector2(object.x, object.y),
          size: Vector2(object.width, object.height),
        ),
      );
    }
  }
}