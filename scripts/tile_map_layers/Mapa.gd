extends Node2D

@onready var personagem = $Personagem
@onready var temporizador = $CanvasLayer/Temporizador
@onready var canvasModulate = $CanvasModulate

const ENEMIGOS = preload("res://escenas/character_body/Enemigo.tscn")
const HORA_MAXIMA = 6
const LISTA_TIPOS = ["Normal", "Semi-Boss", "Boss"]
var tempo = null
var coordsEnemigos = []
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	var coordsChao = []
	for cel in $"Chão".get_used_cells():
		var pos_global = $"Chão".to_global($"Chão".map_to_local(cel))
		coordsChao.append(pos_global)
		
	for i in range(HORA_MAXIMA - 3):
		var keyMinutos = {
			15:{"coordsEnemigos": gerar_Enemigos(coordsChao,4, 11), "Spawned": false, "Tipo": LISTA_TIPOS[0]}, 
			45:{"coordsEnemigos": gerar_Enemigos(coordsChao,5, 10), "Spawned": false, "Tipo": LISTA_TIPOS[0]}}			
		coordsEnemigos.append(keyMinutos)
	 		
	for i in range(HORA_MAXIMA - 4):
		coordsEnemigos.append({0:{"coordsEnemigos": gerar_Enemigos(coordsChao, 3, 5), "Spawned": false, "Tipo": LISTA_TIPOS[1]}})
	
	coordsEnemigos.append({0:{"coordsEnemigos": gerar_Enemigos(coordsChao, 2, 4), "Spawned": false, "Tipo": LISTA_TIPOS[2]}})
	coordsEnemigos.append({0:{"coordsEnemigos": gerar_Enemigos(coordsChao, 2, 4), "Spawned": false, "Tipo": LISTA_TIPOS[2]}})

func gerar_Enemigos(coordenadas, minEnemigos, maxEnemigos):
	var listaEnemigos = []
	var nEnemigos = rng.randi_range(minEnemigos, maxEnemigos)
	for k in range(nEnemigos):
		var coordEnemigos = coordenadas.pick_random()
		listaEnemigos.append(coordEnemigos)
	return listaEnemigos

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pausa"):
		pausa($CanvasLayer/MenuPausa, !get_tree().paused)
		
	if personagem == null:
		mudar_vida(0)
		pausa($CanvasLayer/MenuDerrota, !get_tree().paused)
		
	if !get_tree().paused and personagem != null:
		tempo = temporizador.getTempo()
		canvasModulate.setTempo(tempo["Hora"], tempo["Minutos"])
		$CanvasLayer/Pausa.visible = true
		
		var vida_personagem = personagem.getVida()
		mudar_vida(vida_personagem)
		
		if tempo["Hora"] >= HORA_MAXIMA + 2:
			get_tree().change_scene_to_file("res://escenas/interface/menu/MenuVitoria.tscn")
		hordas()

func hordas():
	var tipo = null
	if ((HORA_MAXIMA - 3) <= tempo["Hora"] and tempo["Hora"] <= HORA_MAXIMA) and tempo["Minutos"] == 0:
		tipo = coordsEnemigos[tempo["Hora"]][0]["Tipo"]
		aparecer_enemigos(coordsEnemigos[tempo["Hora"]][0], tipo)
	elif (tempo["Hora"] < (HORA_MAXIMA - 3)) and (tempo["Minutos"] == 15 or tempo["Minutos"] == 45):
		aparecer_enemigos(coordsEnemigos[tempo["Hora"]][tempo["Minutos"]], LISTA_TIPOS[0])

func aparecer_enemigos(coordsEnemigos, tipo):
	if coordsEnemigos["Spawned"] == true:
		return
		
	for coordenadas in coordsEnemigos["coordsEnemigos"]:
		var enemigo = ENEMIGOS.instantiate()
		enemigo.position = coordenadas
		enemigo.definir_objetivo(personagem)
		if tipo == LISTA_TIPOS[1]:
			enemigo.set_color(Color(0.0, 1.15, 6.733))
			enemigo.buff(220, 288)
			enemigo.set_semi_boss()
		elif tipo == LISTA_TIPOS[2]:
			enemigo.set_color(Color(1.549, 1.114, 0.372, 1.0))
			enemigo.buff(140, 90)
			enemigo.set_boss()
		add_child(enemigo)
		coordsEnemigos["Spawned"] = true
		await get_tree().create_timer(1.1).timeout

func _on_pausa_pressed() -> void:
	pausa($CanvasLayer/MenuPausa, true)

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
		0:
			$CanvasLayer/Vida.texture = load("res://assets/interface/ui_num0.png")

func pausa(menu:Control ,pausado:bool):
	get_tree().paused = pausado
	menu.visible = pausado
	$CanvasLayer/Pausa.visible = !pausado
