extends Node3D

var hud_escena = preload("res://hud.tscn")
var pausa_escena = preload("res://pause_menu.tscn")

@onready var animador: AnimationPlayer = $recorridocamara
@onready var camara_cinematica: Camera3D = $Path3D/PathFollow3D/Camera3D
@onready var jugador: CharacterBody3D = $Jugador

# Esta variable estática no se borra al morir y reiniciar el nivel
static var ya_vio_cinematica: bool = false

func _ready() -> void:
	var hud_instancia = hud_escena.instantiate()
	add_child(hud_instancia)
	
	var pausa_instancia = pausa_escena.instantiate()
	add_child(pausa_instancia)
	
	if not ya_vio_cinematica:
		# --- PRIMERA VEZ: REPRODUCE LA CINEMÁTICA ---
		hud_instancia.visible = false
		
		if animador and camara_cinematica:
			camara_cinematica.current = true
			
			if jugador:
				jugador.set_physics_process(false)
				jugador.set_process_unhandled_input(false)
			
			animador.play("recorridocamara")
			await animador.animation_finished
			
			if jugador and jugador.has_node("Camera3D"):
				jugador.get_node("Camera3D").current = true
			
			if jugador:
				jugador.set_physics_process(true)
				jugador.set_process_unhandled_input(true)
				
			hud_instancia.visible = true
			
			# Marcamos que ya se vio la cinemática
			ya_vio_cinematica = true
	else:
		# --- SI MURIÓ Y REINICIÓ: SALTA DIRECTO AL JUEGO ---
		hud_instancia.visible = true
		if jugador and jugador.has_node("Camera3D"):
			jugador.get_node("Camera3D").current = true
