extends CharacterBody3D

# cyril test placeholder variable
var health: int = 100

func take_damage(amount):
	health -= amount
	print("Health:", health)
	if health <= 0:
		die()

func die():
	print("Character died!")
	queue_free()


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var bump_velocity: Vector3 = Vector3.ZERO

func _physics_process(delta):
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if bump_velocity.length() > 0:
		velocity += bump_velocity
		bump_velocity = bump_velocity.move_toward(Vector3.ZERO, 20 * delta)  # Gradual slowdown

	if not is_on_floor():
		velocity.y -= gravity * delta

	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

# Function to handle getting bumped by traps
func get_bumped(force: Vector3):
	print("Character got bumped with force:", force)
	bump_velocity = force
