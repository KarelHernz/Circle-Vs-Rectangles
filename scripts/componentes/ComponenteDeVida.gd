extends Node2D
class_name ComponenteDeVida

@export var VIDA_MAXIMA = 0

var vida = 0

func _ready() -> void:
	vida += VIDA_MAXIMA

func dano(dano_ataque):
	vida -= dano_ataque
	if vida <= 0:
		get_parent().queue_free()

func buff_vida(buff_vida:int):
	vida += buff_vida

func get_vida():
	return vida
