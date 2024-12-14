extends Node3D

# Variables de base
@export var is_static: bool = true
@export var is_triggered: bool = false
@export var is_ready: bool = true
@export var cooldown_time: float = 2.0  # Cooldown time for all tra
@export var damage: int = 0
@export var activation_radius: float = 5.0

# Shader
@export var trap_color: Color = Color(1, 0, 0)  # Default white
@onready var mesh_instance: MeshInstance3D = $baseZone  # Adjust path if needed

@export var activationType: String = "none" # trigger or continue
@export var positionType: String = "none" # static or moving

func rotate_trap():
	rotation_degrees.y += 90
	rotation_degrees.y = wrapf(rotation_degrees.y, 0, 360)

# Méthodes génériques
func activate_trap():
	print("Trap activated!")
	# Surchargé par les enfants pour définir le comportement

func deactivate_trap():
	print("Trap deactivated!")
	# Surchargé pour les pièges avec désactivation

func reset_trap():
	is_ready = true

func on_trigger(body):
	if is_ready:
		activate_trap()
		is_ready = false
		$Timer.start(cooldown_time)

func _ready():
	if not is_static:
		print("Error: StaticTrap must be static!")
	set_trap_color(trap_color)
	print(mesh_instance.material_override)
	
func set_trap_color(color: Color):
	trap_color = color
	if mesh_instance and mesh_instance.material_override:
		var material = mesh_instance.material_override.duplicate()  # Ensure unique material for each instance
		material.albedo_color = color  # Set the material's color
		mesh_instance.material_override = material
