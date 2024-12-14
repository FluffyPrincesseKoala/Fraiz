extends CharacterBody3D


const speed = 2;
const acceleration = 10;

@onready var nav: NavigationAgent3D = $NavigationAgent3D;
@onready var marker: Marker3D = $Marker3D

func _physics_process(delta):
	
	var direction = Vector3();
	var target_position = marker.global_position;
	
	nav.target_position = target_position;
	direction = nav.get_next_path_position() - global_position;
	direction.normalized();
	
	velocity = velocity.lerp(direction*speed, acceleration * delta);
	
	if abs(global_position.distance_to(marker.global_position)) <= 2:
		velocity = Vector3();
	print(velocity)
	move_and_slide()
