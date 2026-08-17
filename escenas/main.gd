extends Node3D

# Cargar las escenas correspondientes (Verifica que las rutas coincidan exactamente)
var hud_escena = preload("res://hud.tscn")
var pausa_escena = preload("res://pause_menu.tscn")

func _ready():
	# Instanciar e insertar el HUD
	var hud_instancia = hud_escena.instantiate()
	add_child(hud_instancia)
	
	# Instanciar e insertar el Menú de Pausa
	var pausa_instancia = pausa_escena.instantiate()
	add_child(pausa_instancia)
