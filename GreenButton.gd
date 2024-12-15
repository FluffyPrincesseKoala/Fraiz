extends BaseTrapButton

func init_button():	
	trap_id = 3
	trap_model = preload("res://animations/ice.gltf")
	assert(trap_model != null, "model arrow cannot be load")
