
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../characters/baikal.dart';
import '../components/test_chest.dart';
import 'locations/house_of_baikal.dart';

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
    );

    add(map);

    add(
      HouseOfBaikal(
        position: Vector2(-105, -105),
      ),
    );

    add(
      TestChest(
        position: Vector2(100, 100),
      ),
    );

    add(baikal);
  }
}