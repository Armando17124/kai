extends Node3D

@export var altura_inicial: float = -36.6
@export var altura_final: float = -2.0
@export var duracion_subida: float = 3.0
@export var duracion_bajada: float = 3.0
@export var desfase_inicial: float = 0.0  # distinto por cada isla

func _ready() -> void:
	position.y = altura_inicial
	if desfase_inicial > 0.0:
		await get_tree().create_timer(desfase_inicial).timeout
	_iniciar_ciclo()

func _iniciar_ciclo() -> void:
	var tween := create_tween()
	tween.tween_property(self, "position:y", altura_final, duracion_subida)
	tween.tween_property(self, "position:y", altura_inicial, duracion_bajada)
	tween.finished.connect(_iniciar_ciclo)
