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
	if (GlobalVariable.trapSelected == 1):
		set_posTrap()

func _pressed():
	GlobalVariable.trapSelected = 1
	var mat = %MeshInstance3D.get_surface_override_material(0)
	mat.albedo_color = Color(1, 0, 0)
	%MeshInstance3D.set_surface_override_material(0, mat)
	

func set_posTrap():
		var plane = Plane(Vector3(0, 1, 0), 1)
		%StaticBody3D.visible = true
		var mouse_pos = get_viewport().get_mouse_position()
		var camera = get_viewport().get_camera_3d()
		if camera:
			# Cast a ray from the mouse position
			var ray_origin = camera.project_ray_origin(mouse_pos)
			var ray_direction = camera.project_ray_normal(mouse_pos)
			
			# Intersect the ray with the plane
			var intersection = plane.intersects_ray(ray_origin, ray_direction)
			intersection.x = round(intersection.x)
			intersection.y = round(intersection.y)
			intersection.z = round(intersection.z)
			%StaticBody3D.position = intersection
