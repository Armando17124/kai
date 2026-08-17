extends Area3D

enum TipoRecurso { ORO, GEMA }
@export var tipo: TipoRecurso = TipoRecurso.ORO
@export var valor: int = 1

func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		var hud = get_tree().get_first_node_in_group("HUD")
		if hud:
			if tipo == TipoRecurso.ORO:
				hud.sumar_oro(valor)
			elif tipo == TipoRecurso.GEMA:
				hud.sumar_gemas(valor)
		
		# Elimina la moneda completa del juego
		get_parent().queue_free()
