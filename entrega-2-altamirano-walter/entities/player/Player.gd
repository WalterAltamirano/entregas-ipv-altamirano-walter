extends Sprite2D

var speed = 200 #Pixeles

func _physics_process(delta):
	# Movimiento izq a der.
	var direction_optimized:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	var cannon = $Cannon;
	#Manera compleja (Matematica de vectores)
	var mouse_cannon_orientation:Vector2 = get_global_mouse_position() - global_position;
	rotation = mouse_cannon_orientation.angle();
	
	#Delegacion a Godot
	#look_at()
	
	if Input.is_action_just_pressed("fire"):
		cannon.fire();
		
	position.x += direction_optimized * speed * delta
	
	#Anotaciones:
		#var origen:Vector2 = global_position; Mi posicion como nodo global.
		#@onready var cannon:Sprite2D; Evitar en loops.
