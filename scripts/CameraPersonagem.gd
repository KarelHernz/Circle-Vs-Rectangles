extends Camera2D

@export var objeto:Node2D

# Called when the node enters the scene tree for the first time.
func _process(delta):
	position = objeto.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
