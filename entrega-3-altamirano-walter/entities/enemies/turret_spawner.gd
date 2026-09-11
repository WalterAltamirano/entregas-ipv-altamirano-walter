extends Marker2D

@export var turret_scene: PackedScene

func initialize(player: Node2D) -> void:
	var visible_rect: Rect2 = get_viewport().get_visible_rect()
	for i in 3:
		var turret_instance: Node2D = turret_scene.instantiate()
		var turret_pos: Vector2 = Vector2(
			randf_range(self.global_position.x, self.global_position.x + 200),
			randf_range(self.global_position.y, self.global_position.y - 300)
		)
		add_child(turret_instance);
		turret_instance.initialize(turret_pos, self);
		
