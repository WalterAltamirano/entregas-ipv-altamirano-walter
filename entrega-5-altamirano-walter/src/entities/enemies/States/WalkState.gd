extends TurretState

@export var wander_radius:Vector2 = Vector2(10.0,10.0);
@export var speed:float = 10.0;
@export var max_speed:float = 100.0;
@export var pathfinding_step_threshold:float = 5.0;
var path: Array = []

func enter() -> void:
	if turret.pathfinding != null:
		var random_point:Vector2 = (
			turret.global_position +
			Vector2(
				randf_range(-wander_radius.x, wander_radius.x),
				randf_range(-wander_radius.y, wander_radius.y)
			)
		)
		path = turret.pathfinding.get_simple_path(
			turret.global_position,
			random_point
		);
		#Se agrega por funcionalidad general.
		if path.is_empty() || path.size() == 1:
			finished.emit(&"idle");
		else:
			if turret.target != null:
				turret._play_animation(&"walk_alert");
			else:
				turret._play_animation(&"walk");
	else:
		finished.emit(&"idle");

func exit() -> void:
	path = []

func handle_input(event: InputEvent) -> void:
	return

func update(delta: float) -> void:
	if turret._can_see_target():
		finished.emit(&"alert");
		return
		
	if path.is_empty():
		finished.emit(&"idle");
		return
	var next_point: Vector2 = path.front();
		
	while(turret.global_position.distance_to(next_point) < pathfinding_step_threshold):
		path.pop_front();
		if path.is_empty():
			finished.emit(&"idle");
			return
		next_point = path.front();
		
	turret.velocity = (
		turret.velocity +
		turret.global_position.direction_to(next_point) * speed
	).limit_length(max_speed);
	turret.move_and_slide();
	turret.body_anim.flip_h = turret.velocity.x < 0;
	
func _handle_body_entered(body) -> void:
	super._handle_body_entered(body);
	turret._play_animation(&"alert");
		
func _handle_body_exited(body) -> void:
	super._handle_body_exited(body);
	turret._play_animation(&"go_normal");
	
	
func _on_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		&"alert":
			turret._play_animation(&"walk_alert");
		&"go_normal":
			turret._play_animation(&"walk");
