extends Node2D
const NIVEL = 1
const COORDENADAS = {"ilha_1": [Vector2(-1121, -83), 	Vector2(-1186, -148), 	 
								Vector2(-1250, -83),	Vector2(-1185, -20)],
					 "ilha_2": [Vector2(-97, 748),	Vector2(-162, 812),	
								Vector2(-97, 876),		Vector2(-32, 812.)],
					 "ilha_3": [Vector2(926, -83), 	Vector2(990, -148),	
								Vector2(1054, -83),		Vector2(990, -20)],
					 "nivel4": [Vector2(-1121, -83), Vector2(-97, 748), Vector2(926, -83)],
					 "nivel5": [Vector2(-96, -85)]}
					
const ESCENA_ENEMIGOS = preload("res://escenas/Enemigo.tscn")

@onready var personagem = $Personagem
var listaEnemigos = []
var nivelAtual = NIVEL
var pausado = false

func _ready() -> void:
	aparecer_enemigos(COORDENADAS["ilha_1"])
			
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pausa"):
			pausa(true)
		
	var xpto = 0
	for i in listaEnemigos:
		if i == null:
			xpto += 1
	
	if xpto != listaEnemigos.size():
		return
	
	nivelAtual += 1
	listaEnemigos = []
	match nivelAtual:
		2:
			aparecer_enemigos(COORDENADAS["ilha_1"])
			aparecer_enemigos(COORDENADAS["ilha_2"])
		3:
			aparecer_enemigos(COORDENADAS["ilha_1"])
			aparecer_enemigos(COORDENADAS["ilha_2"])
			aparecer_enemigos(COORDENADAS["ilha_3"])
		4:
			aparecer_enemigos(COORDENADAS["nivel4"])
		5:
			aparecer_enemigos(COORDENADAS["nivel5"])

func aparecer_enemigos(coordsEnemigos):
	for coordenadas in coordsEnemigos:
		var enemigo = ESCENA_ENEMIGOS.instantiate()
		enemigo.position = coordenadas
		add_child(enemigo)
		listaEnemigos.append(enemigo)
		enemigo.definir_objetivo(personagem)

func _on_pausa_pressed() -> void:
	pausa(!pausado)
	
func pausa(pausado:bool):
	$Camera2D/Coracao.visible = !pausado
	$Camera2D/Vida.visible = !pausado
	$Camera2D/Pausa.visible = !pausado
	get_tree().paused = pausado
	$Camera2D/MenuPausa.visible = pausado
