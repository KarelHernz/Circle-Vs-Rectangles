extends Area2D
class_name ComponenteDaHitbox

@export var componente_de_vida : ComponenteDeVida
	
func dano(ataque):
	if componente_de_vida:
		componente_de_vida.dano(ataque)
