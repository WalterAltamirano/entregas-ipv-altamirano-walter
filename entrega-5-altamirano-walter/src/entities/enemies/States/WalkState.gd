extends TurretState

@export var wander_radius:Vector2 = Vector2(10.0,10.0);
@export var speed:float = 10.0;
@export var max_speed:float = 100.0;
@export var pathfinding_step_threshold:float = 5.0;
var path: Array = []

func enter() -> void:
	pass

func exit() -> void:
	pass

func handle_input(event: InputEvent) -> void:
	pass

func update(delta: float) -> void:
	pass

func _on_animation_finished(anim_name: StringName) -> void:
	pass

func handle_event(event: StringName, value = null) -> void:
	pass
