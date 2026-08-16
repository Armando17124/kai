extends Area3D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	print("MAR Algo entró: ", body.name)
	if body.is_in_group("jugador"):
		print("¡Es el jugador!")
	if body.is_in_group("Jugador"):
		reiniciar_juego()

func reiniciar_juego() -> void:
	get_tree().reload_current_scene()
