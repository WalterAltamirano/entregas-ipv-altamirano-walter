extends Sprite2D

#@onready var cannon:Sprite2D;

var speed = 200 #Pixeles

func _physics_process(delta):
	# Manera optimizada
	var direction_optimized:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	var mouse_position:Vector2 = get_global_mouse_position();
	var origen:Vector2 = global_position; #Mi posicion como nodo global.
	var direccion_vector:Vector2= (mouse_position - origen).normalized();
	
	var cannon = $Cannon;
	#Manera compleja (Matematica de vectores)
	var mouse_cannon_orientation:Vector2 = mouse_position - global_position;
	rotation = mouse_cannon_orientation.angle();
	
	if Input.is_action_just_pressed("fire"):
		cannon.fire();
	position.x += direction_optimized * speed * delta
