extends Area3D

@export var valor: int = 1

func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		var hud = get_tree().get_first_node_in_group("HUD")
		if hud:
			hud.sumar_gemas(valor)
		
		# 1. Ocultar la gema visualmente al instante
		visible = false
		
		# 2. Desactivar la colisión para evitar recolección doble
		if has_node("CollisionShape3D"):
			$CollisionShape3D.set_deferred("disabled", true)
		
		# 3. Reproducir sonido y esperar a que termine
		if has_node("SonidoTomar"):
			$SonidoTomar.play()
			await $SonidoTomar.finished
		
		# 4. Eliminar el objeto completo de la escena
		get_parent().queue_free()
