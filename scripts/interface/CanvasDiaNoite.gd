extends CanvasModulate

@export var DIA_NOITE: GradientTexture2D

const HORA:int = 8
const MINUTO:int = 60
var horaAtual:int = 0
var minutosAtual:int = 0

func _process(delta: float) -> void:
	var tempo:float = horaAtual * MINUTO + minutosAtual
	
	#Calcula em base ao resultado anterior o valor do gradiente
	var resultado:float = clamp(tempo/(HORA*MINUTO), 0.0, 1.0)
	
	#Devolve o color do gradiente em base ao resultado anterior para definir
	#a cor do CanvasModulate
	color = DIA_NOITE.gradient.sample(resultado)

func setTempo(horas:int, minutos:int) -> void:
	horaAtual = horas
	minutosAtual = minutos
