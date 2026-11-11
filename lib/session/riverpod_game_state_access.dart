import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/data/actions/game_action.dart';
import '/data/game_state/game_state.dart';
import '/data/game_state/game_state_controller.dart';
import 'game_state_access.dart';

final class RiverpodGameStateAccess implements GameStateAccess {
  RiverpodGameStateAccess(this._container);

  final ProviderContainer _container;

  @override
  GameState get state => _container.read(gameStateProvider);

  @override
  void startCombat() {
    dispatch(StartCombat());
  }

  @override
  void finishCombat() {
    dispatch(FinishCombat());
  }

  @override
  void returnToExploration() {
    dispatch(ReturnToExploration());
  }

  @override
  void dispatch(GameAction action) {
    _container.read(gameStateProvider.notifier).dispatch(action);
  }
}