@abstract
class_name TurretState extends AbstractState

var turret: EnemyTurret

func handle_event(event: StringName, value = null) -> void:
	match event:
		&"body_entered":
			_handle_body_entered(value);
		&"body_exited":
			_handle_body_exited(value);

func _handle_body_entered(body) -> void:
	if turret.target == null:
		turret.target  = body;
		
		turret._play_animation("alert");
	
func _handle_body_exited(body) -> void:
	if body == turret.target:
		turret.target = null;
		
		turret._play_animation("go_normal");
