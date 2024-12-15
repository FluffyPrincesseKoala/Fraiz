extends BaseTrapButton

func init_button():	
	trap_id = 2
	trap_model = preload("res://animations/Arrow.gltf")
	assert(trap_model != null, "model arrow cannot be load")
