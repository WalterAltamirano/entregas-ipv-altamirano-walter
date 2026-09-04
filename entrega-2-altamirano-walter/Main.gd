extends Node

func _ready():
	$Player.set_projectile_container(self); #Podria pasar otro nodo
	spawn_aleatorio($Turret);
	spawn_aleatorio($Turret2);
	spawn_aleatorio($Turret3);
	
func spawn_aleatorio(turret:Sprite2D):
	turret.set_values($Player,self);
	var x_random:float = randf_range(0.0, 1152.0);
	var y_random:float = randf_range(0.0, 400.0);
	turret.position = Vector2(x_random, y_random);
