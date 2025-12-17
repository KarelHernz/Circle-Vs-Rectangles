class_name ComponenteDaHitbox
extends Area2D

#O @export visualiza a variavel nas proriedades do Nó, para que dessa forma consiga
#ser alterada sem a necesidade de entrar no script dele
@export var componente_de_vida : ComponenteDeVida
	
func dano(ataque) -> void:
	if componente_de_vida:
		componente_de_vida.dano(ataque)
