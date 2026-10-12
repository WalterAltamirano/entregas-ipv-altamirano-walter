@abstract
class_name TurretState extends AbstractState

var turret: EnemyTurret

func handle_event(event: StringName, value = null) -> void:
	match event:
		"body_entered":
			_handle_body_entered(value)
		"body_exited":
			_handle_body_exited(value)

func _handle_body_entered(body:Node) -> void:
	if turret.target == null && !turret.dead:
		turret.target = body
		
func _handle_body_exited(body:Node) -> void:
	if body == turret.target && !turret.dead:
		turret.target = null;
