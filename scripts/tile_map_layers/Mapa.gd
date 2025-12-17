extends Node2D

@onready var personagem:CharacterBody2D = $Personagem
@onready var chao:TileMapLayer = $Chão
@onready var temporizador:Control = $CanvasLayer/Temporizador
@onready var canvasModulate:CanvasModulate = $CanvasModulate

const ENEMIGOS = preload("res://escenas/character_body/Enemigo.tscn")
const RES = preload("res://scripts/resource/SaveData.gd")
const HORA_MAXIMA:int = 6 #Número máximo de horas que vão aparecer os enemigos
enum LISTA_TIPOS {NORMAL, SEMIBOSS, BOSS} #Tipo de enemigo

var tempo:Dictionary = {}
var coordsEnemigos:Array = []
var rng:RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	gerar_nivel()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pausa"):
		pausa($CanvasLayer/MenuPausa, !get_tree().paused)
		
	if personagem == null:
		mudar_vida(0)
		salvar_melhor_tempo()
		pausa($CanvasLayer/MenuDerrota, !get_tree().paused)
		
	if !get_tree().paused and personagem != null:
		tempo = temporizador.getTempo()
		canvasModulate.setTempo(tempo["Hora"], tempo["Minutos"])
		$CanvasLayer/Pausa.visible = true
		
		#Valida constantemente a vida da personagem para ver
		var vida_personagem = personagem.getVida()
		mudar_vida(vida_personagem)
		
		#Fim do jogo
		if tempo["Hora"] >= HORA_MAXIMA + 2:
			salvar_melhor_tempo()
			get_tree().change_scene_to_file("res://escenas/interface/menu/MenuVitoria.tscn")
		else:
			hordas()

#Adiciona à lista coordsEnemigos às coordenadas onde vão a aparecer os enemigos
#de forma aleatoria
func gerar_nivel() -> void:
	var coordsChao:Array = []
	#Obtem as coordenadas dos TileSets colocados no mapa no TileMapLayer Chão
	for cel in chao.get_used_cells():
		#Transforma aquelas coordenadas com as coordenadas do mapa
		var pos_global:Vector2 = chao.to_global(chao.map_to_local(cel))
		coordsChao.append(pos_global)
		
	#Adiciona as coordenadas na lista coordsEnemigos
	for i in range(HORA_MAXIMA - 3):
		var keyMinutos:Dictionary = {
			15:{"coordsEnemigos": gerar_coords(coordsChao,4, 10), "Spawned": false, "Tipo": LISTA_TIPOS.NORMAL}, 
			45:{"coordsEnemigos": gerar_coords(coordsChao,6, 11), "Spawned": false, "Tipo": LISTA_TIPOS.NORMAL}}			
		coordsEnemigos.append(keyMinutos)
	 		
	for i in range(HORA_MAXIMA - 4):
		coordsEnemigos.append({0:{"coordsEnemigos": gerar_coords(coordsChao, 3, 6), "Spawned": false, "Tipo": LISTA_TIPOS.SEMIBOSS}})
	
	coordsEnemigos.append({0:{"coordsEnemigos": gerar_coords(coordsChao, 3, 4), "Spawned": false, "Tipo": LISTA_TIPOS.BOSS}})
	coordsEnemigos.append({0:{"coordsEnemigos": gerar_coords(coordsChao, 4, 6), "Spawned": false, "Tipo": LISTA_TIPOS.BOSS}})
	
#Gera de forma aleatoria a posição onde vão a aparecer os enemigos no mapa
func gerar_coords(coordenadas:Array, numMinEnemigos:int, numMaxEnemigos:int) -> Array:
	var listaEnemigos = []
	var nEnemigos = rng.randi_range(numMinEnemigos, numMaxEnemigos)
	for k in range(nEnemigos):
		var coordEnemigos = coordenadas.pick_random()
		listaEnemigos.append(coordEnemigos)
	return listaEnemigos

func hordas() -> void:
	var tipo:int = 0
	#Faz aparecer os enemigos do tipo Semi-boss e Boss a partir das 3:00 e assim com o resto
	if ((HORA_MAXIMA - 3) <= tempo["Hora"] and tempo["Hora"] <= HORA_MAXIMA) and tempo["Minutos"] == 0:
		tipo = coordsEnemigos[tempo["Hora"]][0]["Tipo"]
		aparecer_enemigos(coordsEnemigos[tempo["Hora"]][0], tipo)
	#Faz aparecer os enemigos do tipo Normal a partir das 0:15 e 0:45 e assim até as 2:15 e 2:45:
	elif (tempo["Hora"] < (HORA_MAXIMA - 3)) and (tempo["Minutos"] == 15 or tempo["Minutos"] == 45):
		aparecer_enemigos(coordsEnemigos[tempo["Hora"]][tempo["Minutos"]], LISTA_TIPOS.NORMAL)

#Faz aparecer os enemigos no mapa
func aparecer_enemigos(coordsEnemigos:Dictionary, tipo:int) -> void:
	if coordsEnemigos["Spawned"]:
		return
		
	for coordenadas in coordsEnemigos["coordsEnemigos"]:
		var enemigo:CharacterBody2D = ENEMIGOS.instantiate()
		enemigo.position = coordenadas
		enemigo.definir_objetivo(personagem)
		if tipo == LISTA_TIPOS.SEMIBOSS:
			enemigo.set_semi_boss()
		elif tipo == LISTA_TIPOS.BOSS:
			enemigo.set_boss()
		add_child(enemigo)
		coordsEnemigos["Spawned"] = true
		#Espera 1.1 segundos depois de fazer aparecer um enemigo
		await get_tree().create_timer(1.1).timeout

func _on_pausa_pressed() -> void:
	pausa($CanvasLayer/MenuPausa, true)

func salvar_melhor_tempo() -> void:
	var xpto:Dictionary = RES.getTempo()
	if str(tempo["Hora"]) == xpto["Hora"] and str(tempo["Minutos"]) < xpto["Minutos"] or str(tempo["Hora"]) < xpto["Hora"]:
		return
	RES.saveTempo(tempo)

#Muda a imagem do número de vidas da personagem
func mudar_vida(vida:int) -> void:
	var endereco_imagem:String = str("res://assets/interface/ui_num", vida, ".png")
	$CanvasLayer/Vida.texture = load(endereco_imagem)

func pausa(menu:Control ,pausado:bool) -> void:
	get_tree().paused = pausado
	menu.visible = pausado
	$CanvasLayer/Pausa.visible = !pausado
