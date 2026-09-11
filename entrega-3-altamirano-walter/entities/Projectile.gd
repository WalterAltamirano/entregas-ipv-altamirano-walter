extends Area2D

@onready var lifetime_timer = $LifetimeTimer

@export var VELOCITY: float = 800.0

var direction:Vector2

func _ready():
	body_entered.connect(_on_collision);

func initialize(container: Node, spawn_position:Vector2, direction_to_go:Vector2):
	container.add_child(self);
	self.direction = direction_to_go;
	global_position = spawn_position;
	lifetime_timer.timeout.connect( _on_lifetime_timer_timeout);
	lifetime_timer.start();

func _on_collision(body: Node2D):
	_remove.call_deferred();

func _physics_process(delta):
	position += direction * VELOCITY * delta;
	# Necesitamos que desaparezca en algun momento
	
	# Si está fuera de la pantalla
	var visible_rect:Rect2 = get_viewport().get_visible_rect();
	if !visible_rect.has_point(global_position):
		_remove();

# Si supero una cantidad de tiempo de vida
func _on_lifetime_timer_timeout():
	_remove();

func _remove():
	get_parent().remove_child(self);
	queue_free();
	
