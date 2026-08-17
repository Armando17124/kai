extends Area3D

@export var valor: int = 1

func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		var hud = get_tree().get_first_node_in_group("HUD")
		if hud:
			hud.sumar_gemas(valor)
		
		# Elimina la gema completa de la escena
		get_parent().queue_free()
