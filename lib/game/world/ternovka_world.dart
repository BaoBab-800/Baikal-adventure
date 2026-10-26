import 'package:flame/components.dart';

import 'package:baikal_adventure/game/characters/baikal.dart';

class TernovkaWorld extends World {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(Baikal());
  }
}