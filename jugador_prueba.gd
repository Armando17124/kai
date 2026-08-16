extends CharacterBody3D

@export var velocidad: float = 10.0
@export var fuerza_salto: float = 20.0
@export var gravedad: float = 15.0

func _physics_process(delta: float) -> void:
	# Gravedad
	if not is_on_floor():
		velocity.y -= gravedad * delta
	elif Input.is_action_just_pressed("ui_accept"):
		velocity.y = fuerza_salto

	# Movimiento horizontal (usa las flechas o WASD por defecto)
	var input_dir := Vector2.ZERO
	input_dir.x = Input.get_axis("ui_left", "ui_right")
	input_dir.y = Input.get_axis("ui_up", "ui_down")

	var direccion := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direccion:
		velocity.x = direccion.x * velocidad
		velocity.z = direccion.z * velocidad
	else:
		velocity.x = move_toward(velocity.x, 0, velocidad)
		velocity.z = move_toward(velocity.z, 0, velocidad)

	move_and_slide()
