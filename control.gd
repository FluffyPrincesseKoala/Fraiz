extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
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
