extends "res://trapBase.gd"

@export var force_strength: float = 10.0  # Total force applied to the enemy
@export var upward_strength: float = 0.5   # Proportion of the force directed upward

func activate_trap(body):
	super.activate_trap(body)
	print("Trap activated for:", body.name)

	# Ensure the target has a method to handle the bump
	if not body.has_method("get_bumped"):
		print("Body does not support get_bumped:", body.name)
		return

	# Get the trap's forward direction (local +Z in world space, negated)
	var forward_direction = -global_transform.basis.z.normalized()

	# Calculate upward and forward forces
	var upward_force = Vector3(0, upward_strength, 0)  # Pure upward force
	var forward_force = forward_direction * (1.0 - upward_strength)  # Scaled forward force
	print("forwar_force", forward_force, "forward_direction", forward_direction)

	# Combine forces and normalize the direction
	var bump_direction = (forward_force + upward_force).normalized()

	# Apply the force to the enemy
	var final_force = bump_direction * force_strength
	body.get_bumped(final_force)

	# Debugging information
	print("Forward direction:", forward_direction)
	print("Upward force:", upward_force)
	print("Forward force:", forward_force)
	print("Combined bump direction:", bump_direction, "Final force applied:", final_force)
