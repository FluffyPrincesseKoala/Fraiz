extends Node3D

signal cannotCreateTrap_tooPoor(trap_id: int)

@onready var spike_trap = preload("res://spike.tscn")
@onready var trap_costs = {
	1: 5,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	print(trap_costs.get(1))
	pass # Replace with function body.

func getTrapCost(trap_id: int) -> int:
	assert(trap_costs.has(trap_id), "fuck...")
	return trap_costs[trap_id]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("start_wave"):
		GlobalGameState.game_state = GlobalGameState.GameState.STARTED

func instanciateTrap(node: Node3D, position: Vector3, trap_id: int):
	var cost = getTrapCost(trap_id)
	if GlobalGameState.number_of_coin - cost < 0:
		cannotCreateTrap_tooPoor.emit(trap_id)
		print("you poor")
		return
	node.global_position = position
	GlobalGameState.number_of_coin -= cost
	add_child(node)

func _on_control_trap_selected(trap_type: int, position: Vector3):
	if trap_type == 1:
		instanciateTrap(spike_trap.instantiate(), position, trap_type)
	else:
		print("oh nooooo!!!")
