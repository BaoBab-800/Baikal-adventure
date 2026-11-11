import '/data/actions/game_action.dart';
import '/data/game_state/game_state.dart';

abstract interface class GameStateAccess {
  GameState get state;

  void startCombat();

  void finishCombat();

  void returnToExploration();

  void dispatch(GameAction action);
}