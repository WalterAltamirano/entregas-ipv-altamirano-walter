extends Sprite2D

@export var speed:float = 50;
func _process(delta: float) -> void:
	#Elijo la mas rapida
	var direction = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	position.x += direction * speed * delta;
	
