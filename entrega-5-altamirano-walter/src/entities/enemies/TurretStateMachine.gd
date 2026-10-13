extends GenericStateMachine

@export var turret: Node
@export var dead_state: TurretState
# Asignamos el character a cada PlayerState
func _setup() -> void:
	if turret == null:
		printerr("%s: character is not defined!" % name)
	for state: TurretState in states_list:
		state.turret = turret


## Esta función deriva el handleo de cada golpe que recibe
## el personaje al estado actual particular, en vez de vincular
## la señal de "hit" a los estados que lo usan, ya que sino se
## podría ejecutar código de estados inactivos.
func notify_hit(amount: int) -> void:
	if current_state != dead_state:
		_change_state(dead_state.state_id);

func _on_detection_area_body_entered(body) -> void:
	current_state.handle_event(&"body_entered",body);


func _on_detection_area_body_exited(body) -> void:
	current_state.handle_event(&"body_exited",body);


func _on_body_animation_finished() -> void:
	_on_animation_finished(turret.get_current_animation());
