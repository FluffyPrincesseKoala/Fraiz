extends "res://trapBase.gd"

# die() takeDamage() Designe goalFunction()

func _on_area_3d_body_entered(body):
	print(body.name)
	if is_ready and body.has_method("take_damage"):  # Ensure the body has a `take_damage` method
		body.take_damage(damage)
		activate_trap()


func activate_trap():
	is_ready = false
	# Animation d'activation (ex: spikes qui sortent)
	#$StaticBody3D.play("spike_activate")
	$Timer.start(cooldown_time)
	# Specific logic for spike trap activation
	if $Area3D.get_overlapping_bodies().size() > 0:
		for body in $Area3D.get_overlapping_bodies():
			if body.has_method("take_damage"):
				body.take_damage(damage)
		#$StaticBody3D.play("spike_activate")  # Play animation
		$AnimationPlayer.play("spike_activate")  # Play reset animation
		print("SpikeTrap activated!")

func reset_trap():
	super.reset_trap()  # Call parent class reset logic
	#$StaticBody3D.play("spike_reset")  # Reset animation
	#$AnimationPlayer.play("spike_reset")  # Play reset animation
	print("SpikeTrap ready again!")

func _on_timer_timeout():
	# Réinitialisation du piège après le cooldown
	is_ready = true
	#$StaticBody3D.play("spike_reset")  # Animation de réinitialisation (ex: spikes qui rentrent)

# Called when the node enters the scene tree for the first time.
func _ready():
	damage = 10
	$Area3D.body_entered.connect(self._on_area_3d_body_entered)
	$Timer.timeout.connect(self.reset_trap)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
