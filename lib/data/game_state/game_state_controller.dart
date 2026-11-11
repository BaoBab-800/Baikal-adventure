import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/data/actions/game_action.dart';

import 'game_state.dart';
import 'game_mode.dart';
import 'game_screen.dart';
import 'game_status.dart';

final gameStateProvider = NotifierProvider<GameStateController, GameState>(
  GameStateController.new,
);

class GameStateController extends Notifier<GameState> {
  @override
  GameState build() => GameState.initialState();

  void dispatch(GameAction action) {
    switch (action) {
      case StartCombat():
        state = state.copyWith(
          gameMode: GameMode.combat,
          gameScreen: GameScreen.combat,
          gameStatus: GameStatus.running,
        );

      case FinishCombat():
        state = state.copyWith(
          gameMode: GameMode.exploration,
          gameScreen: GameScreen.map,
          gameStatus: GameStatus.running,
        );

      case ReturnToExploration():
        state = state.copyWith(
          gameMode: GameMode.exploration,
          gameScreen: GameScreen.map,
        );
    }
  }
}