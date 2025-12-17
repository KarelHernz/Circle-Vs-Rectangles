extends Control

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("omitir") or Input.is_action_pressed("omitir"):
		get_tree().change_scene_to_file("res://escenas/interface/menu/MenuPrincipal.tscn")

func _on_sair_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/interface/menu/MenuPrincipal.tscn")
