import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:baikal_adventure/game/baikal_adventure.dart';

final class GameSession {
  ProviderContainer? _container;
  BaikalAdventure? _game;

  bool _isDisposed = false;

  ProviderContainer get container => _container ?? _throwNotInitialized();
  BaikalAdventure get game => _game ?? _throwNotInitialized();
  bool get isInitialized => _container != null && _game != null;

  void initialize() {
    if (_isDisposed) {
      throw StateError('GameSession has already been disposed.');
    }

    if (isInitialized) {
      throw StateError('GameSession is already initialized.');
    }

    final container = ProviderContainer();

    try {
      final game = BaikalAdventure();

      _container = container;
      _game = game;
    } catch (_) {
      container.dispose();
      rethrow;
    }
  }

  void dispose() {
    if (_isDisposed) return;

    _isDisposed = true;

    _container?.dispose();

    _container = null;
    _game = null;
  }

  Never _throwNotInitialized() {
    throw StateError('GameSession has not been initialized.');
  }
}