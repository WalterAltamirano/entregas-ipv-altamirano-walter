extends TurretState

func enter() -> void:
	turret.velocity = Vector2.ZERO;
	fire();

func fire():
	turret._fire();
	turret._play_animation(&"attack");
	
func exit() -> void:
	return

func handle_input(event: InputEvent) -> void:
	return

func update(delta: float) -> void:
	turret._look_at_target();

func _on_animation_finished(anim_name: StringName) -> void:
	if turret.target == null:
		finished.emit(&"idle");
	else:
		match anim_name:
			&"attack":
				turret._play_animation(&"alert");
			&"alert":
				if turret._can_see_target():
					fire();
				else:
					finished.emit(&"idle");

func _handle_body_exited(body:Node) -> void:
	super(body)
	if turret.target == null:
		if turret.get_current_animation() != &"attack":
			finished.emit(&"idle");
			
