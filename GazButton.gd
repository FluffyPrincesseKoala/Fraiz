extends BaseTrapButton

func init_button():	
	trap_id = 7
	trap_model = preload("res://animations/gaz.gltf")
	assert(trap_model != null, "model arrow cannot be load")
