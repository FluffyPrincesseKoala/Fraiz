extends Node

@export var available_traps: Array
@export var number_of_coin: int = 10;

enum GameState {
	STARTED,
	PAUSED,
	PRE_WAVE
}

@export var game_state: GameState = GameState.PRE_WAVE;

var trap_costs = {
	1: 2,
	2: 5,
	3: 5,
	4: 5,
	5: 5,
	6: 5,
	7: 5,
	8: 5,
	9: 5,
	10: 5,
}
