extends Node2D
const NIVEL = 1
const COORDENADAS = {"ilha_1": [Vector2(-1121, -83), 	Vector2(-1186, -148), 	 
								Vector2(-1250, -83),	Vector2(-1185, -20)],
					 "ilha_2": [Vector2(-97, 748),	Vector2(-162, 812),	
								Vector2(-97, 876),		Vector2(-32, 812.)],
					 "ilha_3": [Vector2(926, -83), 	Vector2(990, -148),	
								Vector2(1054, -83),		Vector2(990, -20)]}
const ESCENA_ENEMIGOS = preload("res://escenas/Enemigo.tscn")
@onready var personagem = $Personagem

func _ready() -> void:
	match NIVEL:
		1:
			aparecer_enemigos(COORDENADAS["ilha_1"])
		2:
			aparecer_enemigos(COORDENADAS["ilha_1"])
			aparecer_enemigos(COORDENADAS["ilha_2"])
		3:
			aparecer_enemigos(COORDENADAS["ilha_1"])
			aparecer_enemigos(COORDENADAS["ilha_2"])
			aparecer_enemigos(COORDENADAS["ilha_3"])
		4:
			pass
		5:
			pass

func aparecer_enemigos(lista_Enemigos):
	for coordenadas in lista_Enemigos:
		var enemigo = ESCENA_ENEMIGOS.instantiate()
		enemigo.position = coordenadas
		add_child(enemigo)
		enemigo.definir_objetivo(personagem)
