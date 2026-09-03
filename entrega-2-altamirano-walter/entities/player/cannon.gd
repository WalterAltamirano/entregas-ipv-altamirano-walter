extends Sprite2D

@onready var fire_position:Marker2D = $FirePosition;
@export var projectile_scene:PackedScene;

func fire():
	var projectile_instance:Projectile = projectile_scene.instantiate(); #No existe mas instance()
	fire_position.add_child(projectile_instance);
	
#Anotaciones:
	#Position2D fue renombrado por Marker2D
	#Usar preload() implica cambiar la ruta del recurso cuando se cambie su path.
