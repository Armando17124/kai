extends Node3D

@export var altura_inicial: float = -36.6
@export var altura_final: float = -2.0
@export var duracion_subida: float = 3.0
@export var duracion_bajada: float = 3.0

var girando: bool = false  # se mantiene por consistencia, no se usa aquí
var moviendo: bool = false
var tween: Tween

func _ready() -> void:
	position.y = altura_inicial

func activar_movimiento() -> void:
	if moviendo:
		return
	moviendo = true
	_iniciar_ciclo()

func _iniciar_ciclo() -> void:
	tween = create_tween()
	tween.tween_property(self, "position:y", altura_final, duracion_subida)
	tween.tween_property(self, "position:y", altura_inicial, duracion_bajada)
	tween.finished.connect(_iniciar_ciclo)
