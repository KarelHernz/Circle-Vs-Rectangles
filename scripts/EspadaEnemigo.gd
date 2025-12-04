extends Node2D
class_name EspadaEnemigo
var dano_ataque = 1

func _on_componente_da_hitbox_area_entered(area: Area2D) -> void:
	if area is ComponenteDaHitbox:
		var hitbox : ComponenteDaHitbox = area
		hitbox.dano(dano_ataque)
