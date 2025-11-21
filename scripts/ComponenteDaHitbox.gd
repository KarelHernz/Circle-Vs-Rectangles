extends Area2D
class_name ComponenteDaHitbox
@export var componente_de_vida : ComponenteDeVida

func _ready() -> void:
	pass 
	
func dano(dano:ComponenteDeAtaque):
	if componente_de_vida:
		componente_de_vida.dano(dano)
