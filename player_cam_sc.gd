extends CharacterBody3D


const SPEED = 40


func _physics_process(delta):


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (1 * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	print(direction) 
	#if direction:
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
