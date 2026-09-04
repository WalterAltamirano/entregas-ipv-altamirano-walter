extends Sprite2D

@onready var cannon:Sprite2D = $Cannon;

@export var ACCELERATION:float = 20.0
@export var H_SPEED_LIMIT:float = 600.0
@export var FRICTION_WEIGHT:float = 0.1

var velocity:Vector2 = Vector2.ZERO;
var projectile_container:Node;

func set_projectile_container(container:Node): 
	cannon.projectile_container = container;
	projectile_container = container;

func _physics_process(delta):
	# Movimiento izq a der.
	var direction_optimized:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	var mouse_position:Vector2 = get_global_mouse_position();
	cannon.look_at(mouse_position);
	
	if Input.is_action_just_pressed("fire"):
		cannon.fire();
		
	#MRUB
	var h_movement_direction:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"));
	if h_movement_direction != 0:
		velocity.x = clamp(velocity.x + (h_movement_direction * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT);
	else: 
		velocity.x = lerp(velocity.x, 0.0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0;
	position += velocity * delta
	
	#Anotaciones:
		#var origen:Vector2 = global_position; Mi posicion como nodo global.
		#@onready var cannon:Sprite2D; Evitar en loops.
		#look_at() Delegar a godot.
