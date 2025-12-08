extends CanvasModulate

@export var DIA_NOITE: GradientTexture2D
const HORA = 8
const MINUTO = 60
var horaAtual = 0
var minutosAtual = 0

func _process(delta: float) -> void:
	var tempo = horaAtual * MINUTO + minutosAtual
	var resultado = clamp(float(tempo)/(HORA*MINUTO), 0.0, 1.0)
	color = DIA_NOITE.gradient.sample(resultado)

func setTempo(horas, minutos):
	horaAtual = horas
	minutosAtual = minutos
