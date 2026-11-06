import 'game_mode.dart';
import 'game_screen.dart';
import 'game_status.dart';

class GameState {
  final GameMode gameMode;
  final GameScreen gameScreen;
  final GameStatus gameStatus;

  const GameState({
   required this.gameMode,
   required this.gameScreen,
   required this.gameStatus,
  });

  static const GameState initialState = GameState(
    gameMode: GameMode.exploration,
    gameScreen: GameScreen.none,
    gameStatus: GameStatus.running,
  );

  GameState copyWith({
    GameMode? gameMode,
    GameScreen? gameScreen,
    GameStatus? gameStatus,
  }) {
    return GameState(
      gameMode: gameMode ?? this.gameMode,
      gameScreen: gameScreen ?? this.gameScreen,
      gameStatus: gameStatus ?? this.gameStatus,
    );
  }
}