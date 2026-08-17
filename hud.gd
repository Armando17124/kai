extends CanvasLayer

@onready var label_tiempo = %LabelTiempo
@onready var label_oro = %LabelOro
@onready var label_gemas = %LabelGemas

var tiempo_restante: float = 150.0 # 2 minutos y 30 segundos
var oro: int = 0
var gemas: int = 0
var tiempo_agotado: bool = false

func _ready() -> void:
	# Asegura que el HUD se registre en el grupo para llamarlo fácilmente desde los coleccionables
	add_to_group("HUD")
	
	# Inicializa los textos en pantalla
	actualizar_reloj()
	label_oro.text = str(oro)
	label_gemas.text = str(gemas)

func _process(delta: float) -> void:
	if tiempo_restante > 0:
		tiempo_restante -= delta
		actualizar_reloj()
	elif not tiempo_agotado:
		tiempo_restante = 0
		tiempo_agotado = true
		actualizar_reloj()
		_on_tiempo_finalizado()

func actualizar_reloj() -> void:
	var total_segundos: int = int(tiempo_restante)
	var minutos: int = total_segundos / 60
	var segundos: int = total_segundos % 60
	
	# Agrega "Tiempo: " antes del formato numérico
	label_tiempo.text = "Tiempo: %02d:%02d" % [minutos, segundos]

func sumar_oro(cantidad: int) -> void:
	oro += cantidad
	label_oro.text = str(oro)

func sumar_gemas(cantidad: int) -> void:
	gemas += cantidad
	label_gemas.text = str(gemas)

func _on_tiempo_finalizado() -> void:
	print("¡Se acabó el tiempo!")
	# Aquí puedes pausar el juego o instanciar la pantalla de Game Over
	# get_tree().paused = true
