extends Node3D

signal cannotCreateTrap_tooPoor(trap_id: int)
signal characters_have_won
signal characters_have_lost

@export var number_of_characters = 4
@export var number_of_character_that_need_to_win = 4
@export var number_of_character_that_won = 0
@export var number_of_dead_characters = 0

@onready var spike_trap = preload("res://spike.tscn")
@onready var bumper_trap = preload("res://bumper.tscn")
@onready var arrow_trap = preload("res://arrow.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	assert(number_of_characters - number_of_character_that_need_to_win >= 0, "Seriously ?")
	pass # Replace with function body.

func getTrapCost(trap_id: int) -> int:
	assert(GlobalGameState.trap_costs.has(trap_id), "fuck...")
	return GlobalGameState.trap_costs[trap_id]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("start_wave"):
		GlobalGameState.game_state = GlobalGameState.GameState.STARTED

func instanciateTrap(node: Node3D, position: Vector3, rotation: Vector3, trap_id: int):
	var cost = getTrapCost(trap_id)
	if GlobalGameState.number_of_coin - cost < 0:
		cannotCreateTrap_tooPoor.emit(trap_id)
		print("you poor")
		return
	node.rotation = rotation
	node.global_position = position
	GlobalGameState.number_of_coin -= cost
	add_child(node)

func _on_control_trap_selected(trap_type: int, position: Vector3, rotation: Vector3):
	if trap_type == 1:
		instanciateTrap(spike_trap.instantiate(), position, rotation, trap_type)
	elif trap_type == 2:
		instanciateTrap(arrow_trap.instantiate(), position, rotation, trap_type)
	elif trap_type == 4:
		instanciateTrap(bumper_trap.instantiate(), position, rotation, trap_type)
	else:
		print("oh nooooo!!!")



func _on_goal_area_on_character_win():
	number_of_character_that_won += 1
	print("win !!")
	if number_of_character_that_won >= number_of_character_that_need_to_win:
		print("These fuckers survived")
		characters_have_won.emit()
		GlobalGameState.game_state = GlobalGameState.GameState.PRE_WAVE
		get_tree().change_scene_to_file("res://LostMenu.tscn")



func _on_character_death():
	print("death and taxes")
	number_of_dead_characters += 1
	if number_of_dead_characters > number_of_characters - number_of_character_that_need_to_win :
		print("HHAHAHA Blood for the blood god!!!")
		characters_have_lost.emit()
		GlobalGameState.game_state = GlobalGameState.GameState.PRE_WAVE
		get_tree().change_scene_to_file("res://WonMenu.tscn")
		
