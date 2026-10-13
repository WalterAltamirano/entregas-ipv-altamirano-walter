extends TurretState

func enter() -> void:
	turret._play_animation(&"die");
	turret.dead = true;
	turret.collision_layer = 0;
	turret.collision_mask = 0;
	
	if turret.target != null:
		turret._play_animation(&"die_alert");
	else:
		turret._play_animation(&"die");

func exit() -> void:
	return

func handle_input(event: InputEvent) -> void:
	return

func update(delta: float) -> void:
	return

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name in [&"die_alert",&"die"]:
		turret._remove();
