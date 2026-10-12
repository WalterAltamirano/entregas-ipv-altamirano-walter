extends GenericStateMachine

@export var turret: Node

# Asignamos el character a cada PlayerState
func _setup() -> void:
	if turret == null:
		printerr("%s: character is not defined!" % name)
	for state: PlayerState in states_list:
		state.turret = turret


## Esta función deriva el handleo de cada golpe que recibe
## el personaje al estado actual particular, en vez de vincular
## la señal de "hit" a los estados que lo usan, ya que sino se
## podría ejecutar código de estados inactivos.
func notify_hit(amount: int) -> void:
	current_state.handle_event(&"hit", amount)


## Esta función no se utiliza aun, ya que aun no contamos con
## una pool de HP variable.
func notify_healed(amount: int) -> void:
	current_state.handle_event(&"healed", amount)


func _on_detection_area_body_entered(body: Node2D) -> void:
	current_state.handle_event("body_entered",body);


func _on_detection_area_body_exited(body: Node2D) -> void:
	current_state.handle_event("body_exited",body);
