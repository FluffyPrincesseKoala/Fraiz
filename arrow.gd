extends "res://trapBase.gd"

@export var range: Vector3 = Vector3(3, 1, 1)  # Range dimensions (length, height, width)
@export var damage_per_tick: int = 5  # Damage dealt per interval
@export var tick_interval: float = 0.5  # Interval in seconds between damage ticks

var targets_in_range = []  # To track entities in the trap's range

# Trap-specific setup
func _ready():
	super._ready()  # Call the base trap's _ready()
	$Timer.wait_time = tick_interval
	$Timer.connect("timeout", self._on_timer_timeout)
	$Area3D.body_entered.connect(self._on_body_entered)
	$Area3D.body_exited.connect(self._on_body_exited)

# Rotate the trap by 90 degrees
func rotate_trap():
	super.rotate_trap()
	print("ArrowTrap rotated to", rotation_degrees.y, "degrees")

# Handle body entering the trap's area
func _on_body_entered(body):
	print(body.name)
	if body.has_method("take_damage") and body not in targets_in_range:
		targets_in_range.append(body)
		if $Timer.is_stopped():
			$Timer.start()

# Handle body exiting the trap's area
func _on_body_exited(body):
	if body in targets_in_range:
		targets_in_range.erase(body)
	if targets_in_range.is_empty():
		$Timer.stop()


# Periodically deal damage to targets in range
func _on_timer_timeout():
	for target in targets_in_range:
		if target and target.is_inside_tree():
			target.take_damage(damage_per_tick)
			print("ArrowTrap dealt", damage_per_tick, "damage to", target.name)
		else:
			targets_in_range.erase(target)

# Activation behavior
func activate_trap(body):
	super.activate_trap(body)
	is_ready = false
	print("ArrowTrap activated for", body.name)
	$Timer.start()

# Reset trap
func reset_trap():
	super.reset_trap()
	targets_in_range.clear()
	$Timer.stop()
	print("ArrowTrap reset and ready again!")
