extends CanvasLayer

@onready var label = $UI_Container/TopLeft/HBoxContainer/Label
@onready var label_oro = $UI_Container/TopRight/HBoxContainer/Label
@onready var label_gemas = $UI_Container/TopRight/HBoxContainer/Label2

var tiempo_restante: float = 150.0 # 2 minutos y 30 segundos
var oro: int = 0
var gemas: int = 0

func _process(delta):
	if tiempo_restante > 0:
		tiempo_restante -= delta
		#actualizar_reloj()
	else:
		tiempo_restante = 0
		# Aquí puedes llamar a una función de Game Over o Fin de Tiempo

#func actualizar_reloj(): 
	#var minutos = int(tiempo_restante) / 60
	#var segundos = int(tiempo_restante) % 60
	#label.text = "" % [minutos, segundos]

func actualizar_oro(cantidad: int):
	oro = cantidad
	label_oro.text = str(oro)

func actualizar_gemas(cantidad: int):
	gemas = cantidad
	label_gemas.text = str(gemas)
