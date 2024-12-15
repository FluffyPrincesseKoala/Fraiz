extends Node3D

@export var goals: Array[Node3D]
@export var characters: Array[CharacterMain]

# Called when the node enters the scene tree for the first time.
func _ready():
	for goal in goals:
		goal.visible = false
		assert(goal is Node3D)
	for character in characters:
		assert(character is CharacterMain)
	if characters.size() > 0:
		assert(goals.size() > 0)
	
	
	var rng = RandomNumberGenerator.new()
	for character in characters:
		if character.marker != null:
			return
		var goal = goals[rng.randi_range(0, goals.size() -1)]
		character.marker = goal
		goal.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
