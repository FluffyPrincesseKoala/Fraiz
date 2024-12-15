extends BaseTrapButton

func init_button():	
	trap_id = 6
	trap_model = preload("res://animations/lava.gltf")
	assert(trap_model != null, "model arrow cannot be load")
