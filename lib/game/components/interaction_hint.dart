import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class InteractionHint extends TextComponent {
  InteractionHint() : super(
    text: '',
    anchor: Anchor.bottomCenter,
    textRenderer: TextPaint(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        backgroundColor: Color(0xCC17191B),
      ),
    ),
  );
}