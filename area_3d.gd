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
		
		# 1. Ocultar la gema/moneda visualmente al instante
		visible = false
		
		# 2. Desactivar la colisión para no recolectarla dos veces
		if has_node("CollisionShape3D"):
			$CollisionShape3D.set_deferred("disabled", true)
		
		# 3. Reproducir sonido y esperar a que termine
		if has_node("SonidoTomar"):
			$SonidoTomar.play()
			await $SonidoTomar.finished
		
		# 4. Eliminar el objeto completo
		get_parent().queue_free()
