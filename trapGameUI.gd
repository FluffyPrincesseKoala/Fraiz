extends Control
class_name TrapGameUI

signal  trap_selected(trap_type: int, position: Vector3)
@export var trap_target_spawn_location = Vector3()
@export var trap_overlay_height: int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("put_trap") && GlobalVariable.trapSelected != 0:
		trap_selected.emit(GlobalVariable.trapSelected, GlobalVariable.trapSelectedPosition)
	if Input.is_action_just_pressed("deselect_traps"):
		GlobalVariable.trapSelected = 0
		GlobalVariable.trapSelectedPosition = Vector3()
		$StaticBody3D.visible = false;
