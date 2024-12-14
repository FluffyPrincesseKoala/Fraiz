extends CharacterBody3D

signal character_death

enum NavigationMode {
	DIRECT,
	DODGE_TRAP,
	ONLY_90_DEG
};

enum DodgeDirection {
	LEFT,
	RIGHT,
	UP,
	DOWN	
};


@export var acceleration = 10;
@export var ai_mode: NavigationMode = NavigationMode.DIRECT;
@export var dodge_direction: DodgeDirection = DodgeDirection.LEFT;
@export var HP: int = 5;
@export var base_speed: float = 2
@export var speed: float = base_speed;

@onready var nav: NavigationAgent3D = $NavigationAgent3D;
@onready var marker: Marker3D = $Marker3D

func receive_dammage(amount: int):
	HP -= amount;

func update_speed(new_speed: float):
	speed = new_speed;

func add_speed_buff(new_speed: float, duration_sec: float):
	var buff_timer = Timer.new();
	buff_timer.autostart = true;
	buff_timer.one_shot = true;
	buff_timer.wait_time = duration_sec;
	buff_timer.connect("timeout", func ():
		reset_speed());
	add_child(buff_timer)

func reset_speed():
	speed = base_speed;

func _process(delta):
	if HP <= 0:
		character_death.emit();
		queue_free()

func take_damage(damage_taken: int):
	receive_dammage(damage_taken)

func _physics_process(delta):
	if (GlobalGameState.game_state != GlobalGameState.GameState.STARTED):
		return
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
