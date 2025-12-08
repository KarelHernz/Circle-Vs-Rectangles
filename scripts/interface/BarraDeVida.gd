extends TextureProgressBar
@onready var componente_de_vida = $"../ComponenteDeVida"

func _ready() -> void:
	var vida = componente_de_vida.get_vida()
	value = vida
	max_value = vida
	
func _process(delta: float) -> void:
	value = componente_de_vida.get_vida()
