import 'package:flame/components.dart';

import 'interactable.dart';

class TestChest extends SpriteComponent implements Interactable {
  TestChest({
    required super.position,
  }) : super(
    size: Vector2(18, 18),
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await Sprite.load('test/test_chest.png');
  }

  @override
  double get interactionRange => 40;

  @override
  Vector2 get interactionPosition => absolutePosition + size / 2;

  @override
  String get interactionPrompt => 'Open chest';

  @override
  void interact() {
    print('Baikal has enabled interaction!');
  }
}