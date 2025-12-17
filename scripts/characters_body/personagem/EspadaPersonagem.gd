class_name EspadaPersonagem
extends Node2D

var dano_ataque:float = 10

#Igual que com a EspadaEnemigo, valida se a espada entrou numa Area2D
func _on_area_entered(area: Area2D) -> void:
	if area is ComponenteDaHitbox:
		var hitbox : ComponenteDaHitbox = area
		hitbox.dano(dano_ataque)
