extends Node2D

@onready var personagem = $Personagem
@onready var temporizador = $CanvasLayer/Temporizador

const ENEMIGOS = preload("res://escenas/Enemigo.tscn")
var tempo = null
var coordsEnemigos = []
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	var coordsChao = []
	for cel in $"Chão".get_used_cells():
		var pos_global = $"Chão".to_global($"Chão".map_to_local(cel))
		coordsChao.append(pos_global)

	for i in range(6):
		var keyMinutos = {
			15:{"coordsEnemigos": retornar_enemigos(coordsChao), "Spawned": false}, 
			45:{"coordsEnemigos": retornar_enemigos(coordsChao), "Spawned": false}}			
		coordsEnemigos.append(keyMinutos)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pausa"):
		pausa(!get_tree().paused)
	
	if !get_tree().paused:
		tempo = temporizador.getTempo()
		$CanvasLayer/Pausa.visible = true
			
		if personagem != null:
			var vida_personagem = personagem.get_vida()
			mudar_vida(vida_personagem)
		else:
			get_tree().paused=true
		
		ordas()

func retornar_enemigos(coordenadas):
	var listaEnemigos = []
	var nEnemigos = rng.randi_range(5, 12)
	for k in range(nEnemigos):
		var coordEnemigos = coordenadas.pick_random()
		listaEnemigos.append(coordEnemigos)
	return listaEnemigos

func ordas():
	if tempo["Hora"] == 6:
		aparecer_enemigos(coordsEnemigos[6]["semi_boss"])
	if tempo["Hora"] == 7:
		aparecer_enemigos(coordsEnemigos[7]["boss"])
		
	if (tempo["Minutos"] == 15 || tempo["Minutos"] == 45):
		pass
	else:
		return

	match tempo["Hora"]:
		0:
			aparecer_enemigos(coordsEnemigos[0][tempo["Minutos"]])
		1:
			aparecer_enemigos(coordsEnemigos[1][tempo["Minutos"]])
		2:
			aparecer_enemigos(coordsEnemigos[2][tempo["Minutos"]])
		3:
			aparecer_enemigos(coordsEnemigos[3][tempo["Minutos"]])
		4:
			aparecer_enemigos(coordsEnemigos[4][tempo["Minutos"]])
		5:
			aparecer_enemigos(coordsEnemigos[5][tempo["Minutos"]])
				
func aparecer_enemigos(coordsEnemigos):
	if coordsEnemigos["Spawned"] == true:
		return
		
	for coordenadas in coordsEnemigos["coordsEnemigos"]:
		var enemigo = ENEMIGOS.instantiate()
		enemigo.position = coordenadas
		enemigo.definir_objetivo(personagem)
		if tempo["Hora"] == 6:
			enemigo.set_color(Color(1.549, 1.114, 0.372, 1.0))
			enemigo.buff(140, 80)
			enemigo.set_semi_boss()
		elif tempo["Hora"] == 7:
			enemigo.set_color(Color(0.0, 1.15, 6.733))
			enemigo.buff(260, 300)
			enemigo.set_boss()
		add_child(enemigo)
		coordsEnemigos["Spawned"] = true
		await get_tree().create_timer(0.8).timeout

func _on_pausa_pressed() -> void:
	pausa(true)

func mudar_vida(vida):
	match vida:
		5:
			$CanvasLayer/Vida.texture = load("res://assets/interface/ui_num5.png")
		4:
			$CanvasLayer/Vida.texture = load("res://assets/interface/ui_num4.png")
		3:
			$CanvasLayer/Vida.texture = load("res://assets/interface/ui_num3.png")
		2:
			$CanvasLayer/Vida.texture = load("res://assets/interface/ui_num2.png")
		1:
			$CanvasLayer/Vida.texture = load("res://assets/interface/ui_num1.png")

func pausa(pausado:bool):
	get_tree().paused = pausado
	$CanvasLayer/MenuPausa.visible = pausado
	$CanvasLayer/Pausa.visible = !pausado
