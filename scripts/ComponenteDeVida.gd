extends Node2D
class_name ComponenteDeVida
@export var VIDA_MAXIMA = 50
var vida

func _ready() -> void:
	vida = VIDA_MAXIMA

func dano(dano_ataque):
	vida -= dano_ataque
	if vida <= 0:
		get_parent().queue_free()

func get_vida():
	return vida
