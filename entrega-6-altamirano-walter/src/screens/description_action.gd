extends Node
@export var action_id: String;
@export var action_name: String;
@onready var input: Button = $ContainerInfo/Input; 
@onready var action: Label = $ContainerInfo/Action;

func _ready() -> void:
	set_process_input(false);
	input.set_text(action_id);
	action.set_text(action_name);
	if !Engine.is_editor_hint() && InputMap.has_action(action_id):
		var event: InputEvent = InputMap.action_get_events(action_id)[0];
		_set_event(event);
		
func _input(event: InputEvent) -> void:
	if !event is InputEventMouseMotion:
		InputMap.action_erase_event(action_id,event);
		InputMap.action_add_event(action_id,event);
		_set_event(event);
		set_process_input(false);
		await get_tree().create_timer(0.1).timeout;
		input.grab_focus();

func _set_event(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		input.text =  event.as_text().get_slice(":",1).get_slice(",",0).get_slice("=",1);
	else: 
		input.text =event.as_text()

func set_action_name(nam:String) -> void:
	action_name = nam;
	if Engine.is_editor_hint() && has_node("%Action"):
		$"%Action".text = nam; 


func _on_input_pressed() -> void:
	set_process_input(true);
	input.text = "...";
	input.release_focus();
