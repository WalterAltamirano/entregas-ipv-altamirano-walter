extends Sprite2D

@onready var fire_position: Node2D = $FirePosition;
@onready var fire_timer: Timer = $FireTimer;
@onready var where_player: RayCast2D = $WherePlayer;
@export var projectile_scene: PackedScene;

var target:Node2D;
var projectile_container: Node;

func _ready():
	self.projectile_container = get_parent();

func initialize(turret_pos: Vector2, projectile_container: Node) -> void:
	self.projectile_container = projectile_container;
	global_position = turret_pos;
	
func fire_at_player() -> void:
	if target != null:
		where_player.target_position = to_local(target.global_position);
		where_player.force_raycast_update();
		if where_player.is_colliding():
			var collider:Object = where_player.get_collider();
			if collider is Player:
				var proj_instance = projectile_scene.instantiate();
				proj_instance.initialize(
					self.projectile_container,
					fire_position.global_position,
					fire_position.global_position.direction_to(target.global_position)
				);
				fire_timer.start();

func _on_detection_area_body_entered(body: Node2D) -> void:
	if target == null: 
		target = body;
		fire_at_player();

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body == target:  
		target = null;

func _on_fire_timer_timeout() -> void:
	fire_at_player();

func notify_hit() -> void:
	_remove.call_deferred();
	
func _remove() -> void:
	get_parent().remove_child(self);
	queue_free();
	
