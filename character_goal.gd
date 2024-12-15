extends Area3D
class_name GoalArea

signal on_character_win
@onready var marker: MeshInstance3D = $Marker
@onready var timer = $Timer



# Called when the node enters the scene tree for the first time.
func _ready():
	var color: Color  = marker.get_active_material(0).albedo_color
	color.a = 0
	marker.get_active_material(0).albedo_color = color
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var time_left = timer.time_left
	if GlobalGameState.game_state == GlobalGameState.GameState.STARTED && timer.is_stopped():
		timer.start()
	if timer.is_stopped():
		time_left = timer.wait_time
	var normalized_wait_time = (timer.wait_time - time_left) / timer.wait_time
	var color: Color  = marker.get_active_material(0).albedo_color
	color.a = normalized_wait_time
	marker.get_active_material(0).albedo_color = color
	pass

func handleCharacterEntered(body: Node3D):
	body.call("on_character_win")
	on_character_win.emit()

func _on_body_entered(body):
	if body.has_method("on_character_win"):
		handleCharacterEntered(body)
