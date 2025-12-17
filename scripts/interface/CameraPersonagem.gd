extends Camera2D

@export var objeto:Node2D

func _process(delta) -> void:
	position = objeto.position

func _physics_process(delta) -> void:
	pass
