extends Control

func _on_jogar_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/tile_map_layers/Mapa.tscn")
	
func _on_creditos_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/interface/Creditos.tscn")

func _on_sair_pressed() -> void:
	get_tree().quit()
