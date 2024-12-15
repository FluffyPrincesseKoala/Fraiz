extends BaseTrapButton

func init_button():	
	trap_id = 4
	trap_model = preload("res://animations/bump.gltf")
	assert(trap_model != null, "model arrow cannot be load")
