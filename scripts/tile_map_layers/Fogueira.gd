extends TileMapLayer

func _process(delta: float) -> void:
	$AnimationPlayer.play("iluminação")
