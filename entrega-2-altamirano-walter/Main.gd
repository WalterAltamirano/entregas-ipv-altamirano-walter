extends Node

func _ready():
	$Player.set_projectile_container(self); #Podria pasar otro nodo
	$Turret.set_values($Player,self);
