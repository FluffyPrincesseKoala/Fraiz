extends BaseTrapButton

func init_button():	
	trap_id = 5
	trap_model = preload("res://animations/ecler.gltf")
	assert(trap_model != null, "model arrow cannot be load")
