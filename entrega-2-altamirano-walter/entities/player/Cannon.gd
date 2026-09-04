extends Sprite2D

@onready var fire_position:Marker2D = $FirePosition;

@export var projectile_scene:PackedScene;

var projectile_container:Node;

func fire():
	var projectile_instance:Projectile = projectile_scene.instantiate(); #No existe mas instance()
	projectile_container.add_child(projectile_instance);
	#Necesitamos decirle donde empezar porque main empieza en (0,0)
	projectile_instance.set_starting_values(
		fire_position.global_position,
		(get_global_mouse_position() - fire_position.global_position).normalized()
	);
	projectile_instance.connect("delete_requested",_on_projectile_delete_requested);
	
func _on_projectile_delete_requested(projectile): 
	projectile_container.remove_child(projectile);
	projectile.queue_free(); #Evita los memory leaks.

#Anotaciones:
	#Position2D fue renombrado por Marker2D
	#Usar preload() implica cambiar la ruta del recurso cuando se cambie su path.
