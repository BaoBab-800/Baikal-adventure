import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:baikal_adventure/game/baikal_adventure.dart';

class GameSession {
  late final ProviderContainer container;
  late final BaikalAdventure game;

  bool _isInitialized = false;

  void initialize() {
    if (_isInitialized) {
      throw StateError('GameSession is already initialized.');
    }

    final container = ProviderContainer();

    try {
      final game = BaikalAdventure();

      this.container = container;
      this.game = game;

      _isInitialized = true;
    } catch (_) {
      container.dispose();
      rethrow;
    }
  }
}