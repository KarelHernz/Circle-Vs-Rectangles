extends Control

func _ready() -> void:
	visible = false

func _on_continuar_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_btt_reiniciar_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_btt_menu_principal_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://escenas/interface/menu/MenuPrincipal.tscn")
