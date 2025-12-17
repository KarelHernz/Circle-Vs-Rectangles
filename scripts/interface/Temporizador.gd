extends Control

var hora:int = 0
var minutoDecima:int = 0
var minutoUnidade:int = 0

func _ready() -> void:
	$Timer.start()
	
func _on_timer_timeout() -> void:
	set_MinutoUnidade()

func set_MinutoUnidade() -> void:
	minutoUnidade += 1
	if minutoUnidade >= 10:
		minutoUnidade = 0
		set_MinutoDecima()
	set_Image(minutoUnidade, $HBoxContainer/MinutoUnidade)
	
func set_MinutoDecima() -> void:
	minutoDecima += 1
	if minutoDecima >= 6:
		minutoDecima = 0
		set_Hora()
	set_Image(minutoDecima, $HBoxContainer/MinutoDecima)
	
func set_Hora() -> void:
	hora += 1 
	set_Image(hora, $HBoxContainer/Hora)
	
func getTempo() -> Dictionary:
	return {"Hora": hora, "Minutos": int(str(minutoDecima, minutoUnidade))}
	
func set_Image(tempo:int, textureRect:TextureRect) -> void:
	var endereco_imagem = str("res://assets/interface/ui_num", tempo, ".png")
	textureRect.texture = load(endereco_imagem)
