extends Node3D

@export var velocidad_rotacion: float = 15.0  # grados por segundo
var girando: bool = false

func _process(delta: float) -> void:
	if girando:
		rotate_y(deg_to_rad(velocidad_rotacion * delta))

func activar_rotacion() -> void:
	girando = true
