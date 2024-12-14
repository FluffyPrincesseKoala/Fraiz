extends Node

@export var available_traps: Array
@export var number_of_coin: int = 10;

enum GameState {
	STARTED,
	PAUSED,
	PRE_WAVE
}

@export var game_state: GameState = GameState.PRE_WAVE;
