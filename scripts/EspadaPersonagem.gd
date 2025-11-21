extends Node2D
class_name EspadaPersonagem

var dano_ataque = 10

func _on_area_entered(area: Area2D) -> void:
	if area is ComponenteDaHitbox:
		var hitbox : ComponenteDaHitbox = area
		var ataque = ComponenteDeAtaque
		ataque.dano = dano_ataque
		hitbox.dano(ataque)
