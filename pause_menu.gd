extends CanvasLayer

func _ready():
	# OBLIGATORIO: Mantiene este script activo aunque el juego esté pausado
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()

func _input(event):
	# Escucha la tecla ESC (ui_cancel)
	if event.is_action_pressed("ui_cancel"):
		toggle_pausa()

func toggle_pausa():
	var nuevo_estado = not get_tree().paused
	get_tree().paused = nuevo_estado
	visible = nuevo_estado
	
	# Cambia el estado del cursor del ratón
	if nuevo_estado:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# --- SEÑALES DE LOS BOTONES ---

func _on_btn_reanudar_pressed():
	toggle_pausa()

func _on_btn_opciones_pressed():
	print("Abrir submenú de opciones")

func _on_btn_menu_principal_pressed():
	# Despausar el motor antes de cambiar de escena
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")
