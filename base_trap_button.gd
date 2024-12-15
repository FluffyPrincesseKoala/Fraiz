extends Button
class_name  BaseTrapButton

var parent: TrapGameUI
@export var trap_id: int = 0 
var last_trap_id = trap_id 
@export var trap_model: PackedScene
@export var price: int = 0

# Called when the node enters the scene tree for the first time.

func init_button():
	pass

func _ready():
	parent = get_parent()
	assert(parent != null, "yeah I know...")
	print(parent.trap_overlay_height)
	init_button()
	price = GlobalGameState.trap_costs[trap_id]
	assert(price != null, "trap with unknown price !!")	
	var price_ui: Label = find_child("Price", false)
	if price_ui != null:
		price_ui.text = str(price)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if last_trap_id != trap_id:
		last_trap_id = trap_id
		var rota = %MeshSelected.global_rotation
		rota.y = 0
		%MeshSelected.global_rotation = rota
		GlobalVariable.trapSelectedRotation = rota
		
	if (is_hovered() == true):
		$TextHover.visible = true
	else:
		$TextHover.visible = false
	if (GlobalVariable.trapSelected == trap_id):
		set_posTrap()
	if Input.is_action_just_pressed("rotate_trap"):
		%MeshSelected.rotate_y(90)
		#GlobalVariable.trapSelectedRotation =  %MeshSelected.global_rotation

func _pressed():
	GlobalVariable.trapSelected = trap_id

	var new_gltf_instance = trap_model.instantiate()
	for child in %MeshSelected.get_children():
		child.queue_free()
	%MeshSelected.add_child(new_gltf_instance)
	

func set_posTrap():
		var plane = Plane(Vector3(0, 1, 0), parent.trap_overlay_height)
		%MeshSelected.visible = true
		var mouse_pos = get_viewport().get_mouse_position()
		var camera = get_viewport().get_camera_3d()
		if camera:
			# Cast a ray from the mouse position
			var ray_origin = camera.project_ray_origin(mouse_pos)
			var ray_direction = camera.project_ray_normal(mouse_pos)
			
			# Intersect the ray with the plane
			var intersection = plane.intersects_ray(ray_origin, ray_direction)
			if intersection == null:
				return
			intersection.x = round(intersection.x)
			intersection.y = round(intersection.y)
			intersection.z = round(intersection.z)
			GlobalVariable.trapSelectedPosition = intersection
			%MeshSelected.position = intersection

