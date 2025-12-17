extends Control

@onready var lblTempo = $Panel/lblTempo
const RES = preload("res://scripts/resource/SaveData.gd")

func _ready() -> void:
	mostrar_melhor_tempo()

func mostrar_melhor_tempo():
	var tempo:Dictionary = RES.getTempo()
	
	if tempo["Hora"] == "0":
		if tempo["Minutos"] == "00":
			lblTempo.text += "Nenhum"
		#Verifica se os minutos começam com 0, no caso que seja verdade retorna 0 que é o indice 
		#onde aparece
		elif tempo["Minutos"].findn("0") == 0:
			#apaga o primeiro zero
			lblTempo.text += str(tempo["Minutos"].erase(0), "segs")
		else:
			lblTempo.text += str(tempo["Minutos"], "segs")
	else:
		if tempo["Minutos"] == "00":
			lblTempo.text += str(tempo["Hora"], "min")
		else:
			lblTempo.text += str(tempo["Hora"], ":", tempo["Minutos"], "min")

func _on_jogar_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/tile_map_layers/Mapa.tscn")
	
func _on_creditos_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/interface/Creditos.tscn")

func _on_sair_pressed() -> void:
	get_tree().quit()
