import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flame/game.dart';

import '/session/game_session.dart';

class GameSessionView extends StatefulWidget {
  const GameSessionView({super.key});

  @override
  State<GameSessionView> createState() => _GameSessionViewState();
}

class _GameSessionViewState extends State<GameSessionView> {
  late final GameSession _session;

  Object? _initializationError;

  @override
  void initState() {
    super.initState();

    _session = GameSession();

    try {
      _session.initialize();
    } catch (error, stackTrace) {
      _initializationError = error;

      debugPrint('GameSession initialization failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initializationError != null) {
      return const Center(
        child: Text('Failed to initialize game session.'),
      );
    }

    return UncontrolledProviderScope(
      container: _session.container,
      child: GameWidget(
        game: _session.game,
      ),
    );
  }

  @override
  void dispose() {
    _session.dispose();
    super.dispose();
  }
}