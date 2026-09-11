extends Node

@onready var player: Node2D = $Player;
@onready var turret_spawner: Node = $TurretsSpawner;

func _ready() -> void:
	player.initialize(self);
	turret_spawner.initialize(player);
