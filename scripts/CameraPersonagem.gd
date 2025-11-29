extends Camera2D

@export var objeto:Node2D

func _process(delta):
	position = objeto.position

func _physics_process(delta):
	pass
