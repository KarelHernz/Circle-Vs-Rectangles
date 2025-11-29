extends Node2D

@onready var personagem = $Personagem

const NIVEL = 1
const COORDENADAS = {"ilha_1": [Vector2(-1121, -83), Vector2(-1186, -148), 	 
								Vector2(-1250, -83),Vector2(-1185, -20)],
					 "ilha_2": [Vector2(-97, 748),	Vector2(-162, 812),	
								Vector2(-97, 876),	Vector2(-32, 812.)],
					 "ilha_3": [Vector2(926, -83), 	Vector2(990, -148),	
								Vector2(1054, -83),	Vector2(990, -20)],
					 "semi_bosses": [Vector2(-1121, -83), Vector2(-97, 748), Vector2(926, -83)],
					 "boss": [Vector2(-96, -85)]}
const ESCENA_ENEMIGOS = preload("res://escenas/Enemigo.tscn")

var listaEnemigos = []
var nivelAtual = NIVEL

func _ready() -> void:
	aparecer_enemigos(COORDENADAS["ilha_1"])
			
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pausa"):
		pausa(!get_tree().paused)
	
	if !get_tree().paused:
		$CanvasLayer/Pausa.visible = true
		
		var vida_personagem = personagem.get_vida()
		mudar_vida(vida_personagem)
		
		var enemigos_mortos = 0
		for i in listaEnemigos:
			if i == null:
				enemigos_mortos += 1
		
		if enemigos_mortos != listaEnemigos.size():
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
				aparecer_enemigos(COORDENADAS["semi_bosses"])
			5:
				aparecer_enemigos(COORDENADAS["boss"])

func aparecer_enemigos(coordsEnemigos):
	for coordenadas in coordsEnemigos:
		var enemigo = ESCENA_ENEMIGOS.instantiate()
		enemigo.position = coordenadas
		enemigo.definir_objetivo(personagem)
		if nivelAtual == 4:
			enemigo.set_color(Color(1.549, 1.114, 0.372, 1.0))
		elif nivelAtual == 5:
			enemigo.set_color(Color(0.0, 1.15, 6.733))
		add_child(enemigo)
		listaEnemigos.append(enemigo)

func _on_pausa_pressed() -> void:
	pausa(true)

func mudar_vida(vida):
	match vida:
		5:
			$CanvasLayer/Vida.texture = load("res://assets/interface/personagem/ui_num5.png")
		4:
			$CanvasLayer/Vida.texture = load("res://assets/interface/personagem/ui_num4.png")
		3:
			$CanvasLayer/Vida.texture = load("res://assets/interface/personagem/ui_num3.png")
		2:
			$CanvasLayer/Vida.texture = load("res://assets/interface/personagem/ui_num2.png")
		1:
			$CanvasLayer/Vida.texture = load("res://assets/interface/personagem/ui_num1.png")
		0:
			pass

func pausa(pausado:bool):
	get_tree().paused = pausado
	$CanvasLayer/MenuPausa.visible = pausado
	$CanvasLayer/Pausa.visible = !pausado
