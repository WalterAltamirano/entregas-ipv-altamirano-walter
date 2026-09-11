extends CharacterBody2D
@onready var cannon: Node = $Cannon;

@export var ACCELERATION: float = 20.0;
@export var H_SPEED_LIMIT: float = 600.0;
@export var FRICTION_WEIGHT: float = 0.1;
@export var JUMP_SPEED: float = -300.0;
@export var GRAVITY: float = 10.0;
@export var PUSH_FORCE: float = 80.0;
var speed: Vector2 = Vector2.ZERO;
var projectile_container: Node;

func initialize(projectile_container: Node) -> void:
	self.projectile_container = projectile_container;
	cannon.projectile_container = projectile_container;

func handle_events():
	# Cannon rotation
	var mouse_position: Vector2 = get_global_mouse_position();
	cannon.look_at(mouse_position);
	
	# Cannon fire
	if Input.is_action_just_pressed("fire_cannon"):
		if projectile_container == null:
			projectile_container = get_parent();
			cannon.projectile_container = projectile_container;
		cannon.fire();
	
	# Player movement
	var h_movement_direction: int = int(
		Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")
	);
	if h_movement_direction != 0:
		velocity.x = clamp(
			velocity.x + (h_movement_direction * ACCELERATION),
			-H_SPEED_LIMIT,
			H_SPEED_LIMIT
		);
	else:
		# Ternary if: {true code} if {condition} else {false code}
		velocity.x = lerp(velocity.x, 0.0, FRICTION_WEIGHT) if abs(velocity.x) > 1.0 else 0.0;
	
	if Input.is_action_pressed("jump"):
		velocity.y = JUMP_SPEED;
	
func _physics_process(delta: float) -> void:
	handle_events();
	velocity.y += GRAVITY;
	move_and_slide();
	for i in get_slide_collision_count():
		var c = get_slide_collision(i);
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * PUSH_FORCE);
	#No es recomendable modificar la posicion. Usar la interfaz de Godot
	#position += velocity * delta
