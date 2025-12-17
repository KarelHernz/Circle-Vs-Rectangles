class_name ComponenteDeVida
extends Node2D

@export var VIDA_MAXIMA: float = 0

var vida:float = 0

func _ready() -> void:
	vida += VIDA_MAXIMA

func dano(dano_ataque) -> void:
	vida -= dano_ataque
	if vida <= 0:
		#Elimina ao enemigo/personagem
		get_parent().queue_free()

func buff_vida(buff_vida:int) -> void:
	vida += buff_vida

func get_vida() -> float:
	return vida
