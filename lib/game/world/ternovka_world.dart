import 'package:flame/components.dart';

import 'package:baikal_adventure/game/characters/baikal.dart';

class TernovkaWorld extends World {
  TernovkaWorld() {
    baikal = Baikal();
    add(baikal);
  }

  late final Baikal baikal;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(baikal);
  }
}