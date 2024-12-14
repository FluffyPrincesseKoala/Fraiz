extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (is_hovered() == true):
		$TextHover.visible = true
	else:
		$TextHover.visible = false

func _pressed():
	print("hello")
	print(GlobalVariable.trapSelected)
	GlobalVariable.trapSelected = 1
	print(GlobalVariable.trapSelected)
