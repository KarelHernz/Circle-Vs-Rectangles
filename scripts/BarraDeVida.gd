extends TextureProgressBar
@onready var componente_de_vida = $"../ComponenteDeVida"

func _ready() -> void:
	value = componente_de_vida.get_vida()
	max_value = value
	
func _process(delta: float) -> void:
	value = componente_de_vida.get_vida()
