extends Sprite2D
class_name Projectile
signal delete_requested(projectile);
@export var speed:float;
#Vector normalizado.
var direction:Vector2;

func _ready():
	set_physics_process(false);

func _physics_process(delta: float) -> void:
	position += direction* speed * delta;
	var screen_size = get_viewport_rect().size;
	if (global_position.x > screen_size.x || global_position.y > screen_size.y 
		|| global_position.y < 0 || global_position.x < 0): 
		emit_signal("delete_requested",self);
	
func set_starting_values(starting_position:Vector2, direction:Vector2):
	global_position = starting_position;
	self.direction = direction;
	set_physics_process(true);
