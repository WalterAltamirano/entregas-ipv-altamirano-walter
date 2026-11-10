extends Node
@export var action_input: String;
@export var action_name: String;
@onready var input: Label = $ContainerInfo/Panel/Input; 
@onready var action: Label = $ContainerInfo/Action;

func _ready() -> void:
	input.set_text(action_input);
	action.set_text(action_name);

func set_action_input(inp:String) -> void:
	action_input = inp;
	if Engine.is_editor_hint() && has_node("%Input"):
		$"%Input".text = inp; 


func set_action_name(nam:String) -> void:
	action_name = nam;
	if Engine.is_editor_hint() && has_node("%Action"):
		$"%Action".text = nam; 
