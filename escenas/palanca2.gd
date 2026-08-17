extends Node3D

@export var angulo_rotacion: float = 19.0
@export var velocidad_activacion: float = 0.5

var jugador_en_zona: bool = false
var activada: bool = false

func _ready() -> void:
	$AreaDeteccion.body_entered.connect(_on_body_entered)
	$AreaDeteccion.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Jugador"):
		jugador_en_zona = true

func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("Jugador"):
		jugador_en_zona = false

func _process(_delta: float) -> void:
	if jugador_en_zona and not activada and Input.is_action_just_pressed("activar_palanca"):
		activar()

func activar() -> void:
	activada = true
	var tween := create_tween()
	tween.tween_property(
		self,
		"rotation_degrees:x",
		rotation_degrees.x + angulo_rotacion,
		velocidad_activacion
	)
	get_tree().call_group("plataformas_verticales", "activar_movimiento")
