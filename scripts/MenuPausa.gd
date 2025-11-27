extends Control

func _on_continuar_pressed() -> void:
	pausa(false)

func _on_reiniciar_pressed() -> void:
	get_tree().reload_current_scene()

func _on_sair_pressed() -> void:
	get_tree().change_scene_to_file("res://escenas/MenuPrincipal.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pausa"):
		if visible == true:
			pausa(false)
		
func pausa(pausa:bool):
	get_tree().paused = pausa
	visible = pausa
