extends BaseTrapButton

func init_button():
	trap_id = 1 
	trap_model = preload("res://animations/Spike1.gltf")
	assert(trap_model != null, "model spike cannot be load")

