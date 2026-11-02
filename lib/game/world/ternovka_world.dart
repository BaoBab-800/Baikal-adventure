import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../characters/baikal.dart';
import '../components/test_chest.dart';

import 'collision_loader.dart';

class TernovkaWorld extends World {
  TernovkaWorld() {
    baikal = Baikal();
  }

  late final Baikal baikal;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final map = await TiledComponent.load(
      'ternovka.tmx',
      Vector2.all(32),
      prefix: 'assets/maps/',
    );

    add(map);

    CollisionLoader.load(map, this);

    add(TestChest(position: Vector2(100, 100)));

    add(baikal);
  }
}
