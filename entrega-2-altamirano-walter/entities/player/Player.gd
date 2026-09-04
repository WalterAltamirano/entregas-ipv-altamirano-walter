extends Sprite2D

@onready var cannon:Sprite2D = $Cannon;

var speed = 200 #Pixeles
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
		
	position.x += direction_optimized * speed * delta
	
	#Anotaciones:
		#var origen:Vector2 = global_position; Mi posicion como nodo global.
		#@onready var cannon:Sprite2D; Evitar en loops.
		#look_at() Delegar a godot.
