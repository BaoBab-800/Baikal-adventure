import 'package:flame/components.dart';

abstract interface class Interactable {
  double get interactionRange;

  Vector2 get interactionPosition;

  String get interactionPrompt;

  void interact();
}