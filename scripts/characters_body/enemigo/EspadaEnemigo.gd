class_name EspadaEnemigo
extends Node2D

var dano_ataque:float = 1

#Sinal que determina se a espada entrou dentro de uma Area2D para fazer dano à personagem
func _on_componente_da_hitbox_area_entered(area: Area2D) -> void:
	if area is ComponenteDaHitbox:
		var hitbox : ComponenteDaHitbox = area
		hitbox.dano(dano_ataque)

func set_ataque(novo_dano: float) -> void:
	dano_ataque = novo_dano
