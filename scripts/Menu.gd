extends Control

func _on_jogar_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/Mapa.tscn")
	
func _on_sair_pressed() -> void:
	get_tree().quit()
