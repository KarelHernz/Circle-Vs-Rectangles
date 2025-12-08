extends Control

func _on_btt_reiniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/tile_map_layers/Mapa.tscn")

func _on_btt_menu_principal_pressed() -> void:
		get_tree().change_scene_to_file("res://escenas/interface/menu/MenuPrincipal.tscn")
