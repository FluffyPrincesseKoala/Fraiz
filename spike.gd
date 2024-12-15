extends "res://trapBase.gd"

var bodies_inside = []  # To track the bodies inside the trap

func _ready():
	damage = 10
	$Area3D.body_entered.connect(self._on_area_3d_body_entered)
	$Area3D.body_exited.connect(self._on_area_3d_body_exited)  # Connect for body exit
	$Timer.timeout.connect(self.reset_trap)
	

# Handle body entering the trap
func _on_area_3d_body_entered(body):
	if not bodies_inside.has(body):  # Add the body if it's not already tracked
		bodies_inside.append(body)
	
	if is_ready and body.has_method("take_damage"):
		body.take_damage(damage)
		activate_trap(body)

# Handle body exiting the trap
func _on_area_3d_body_exited(body):
	if bodies_inside.has(body):  # Remove the body when it exits
		bodies_inside.erase(body)

# Activate the trap
func activate_trap(body):
	super.activate_trap(body)
	is_ready = false
	if body.has_method("take_damage"):
		body.take_damage(damage)
		$Timer.start(cooldown_time)
		print("SpikeTrap activated! target", body.name)

# Reset the trap and check for remaining bodies
func reset_trap():
	super.reset_trap()  # Call parent class reset logic
	$Timer.stop()
	is_ready = true
	print("SpikeTrap ready again!")

	# Check if there are still bodies inside the trap
	for body in bodies_inside:
		if body and body.is_inside_tree() and body.has_method("take_damage"):  # Ensure the body still exists
			print("Reactivating trap for:", body.name)
			activate_trap(body)
			return  # Reactivate for the first valid body

# Called every frame (optional, if needed)
func _process(delta):
	pass
