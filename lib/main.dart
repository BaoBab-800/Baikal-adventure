import 'package:flutter/material.dart';

import 'presentation/game_session_view.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GameSessionView(),
      ),
    ),
  );
}