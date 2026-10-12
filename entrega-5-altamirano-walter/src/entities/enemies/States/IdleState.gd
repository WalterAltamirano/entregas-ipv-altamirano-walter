extends TurretState
@export var idle_timer: Timer

func enter() -> void:
	turret.velocity = Vector2.ZERO;
	if turret.target != null:
		turret._play_animation("idle_start");
	else:
		turret._play_animation("idle");
	idle_timer.start();

func exit() -> void:
	idle_timer.stop();

func handle_input(event: InputEvent) -> void:
	pass

func update(delta: float) -> void:
	turret._apply_movement();
	if turret._can_see_target():
		finished.emit(&"alert");

func _on_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"alert":
			turret._play_animation("idle_start");
		"go_normal":
			turret._play_animation("idle");

func _handle_body_entered(body:Node) -> void:
	super._handle_body_entered(body);
	turret._play_animation("alert");
		
func _handle_body_exited(body:Node) -> void:
	super._handle_body_exited(body);
	turret._play_animation("go_normal");

func _on_idle_timer_timeout() -> void:
	finished.emit(&"walk");
