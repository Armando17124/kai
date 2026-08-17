extends CharacterBody3D

# Velocidad de movimiento e intensidad de salto
@export var speed: float = 5.0
@export var jump_velocity: float = 4.5

# Obtener la gravedad global configurada en Godot
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

# Referencia al AnimationPlayer del modelo importado
@onready var animation_player: AnimationPlayer = $MiPersonajeAnimado/AnimationPlayer
@onready var visual_model: Node3D = $MiPersonajeAnimado

func _physics_process(delta: float) -> void:
	# --- CONTROL DE PAUSA ---
	# Si el juego está pausado, detener cualquier movimiento o entrada en este personaje
	if get_tree().paused:
		return

	# 1. Aplicar Gravedad
	if not is_on_floor():
		velocity.y -= gravity * delta

	# 2. Manejo de Salto (Teclas de acción por defecto)
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# 3. Obtener la dirección de entrada desde el teclado (WASD / Flechas)
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# 4. Movimiento y Rotación del personaje
	if direction != Vector3.ZERO:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		
		# Orientar suavemente el personaje hacia la dirección en la que camina
		var target_angle = atan2(-direction.x, -direction.z)
		visual_model.rotation.y = lerp_angle(visual_model.rotation.y, target_angle, 0.15)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	# 5. Ejecutar la física de movimiento
	move_and_slide()

	# 6. Controlar la reproducción de animaciones
	_update_animations(direction)

func _update_animations(direction: Vector3) -> void:
	# Si está en el suelo, reproducir la caminata o volver a reposo
	if is_on_floor():
		if direction != Vector3.ZERO:
			if animation_player.current_animation != "Walk":
				animation_player.play("Walk")
		else:
			# Si tienes una animación estática, sustituye "Walk" por "Idle" o usa stop()
			if animation_player.current_animation == "Walk":
				animation_player.stop()
