extends Control
var hora = 0
var minutoDecima = 0
var minutoUnidade = 0
var start = false

func _ready() -> void:
	$Timer.start()
	
func _on_timer_timeout() -> void:
	set_MinutoUnidade()

func set_start():
	start = true

func stop():
	start = false

func set_MinutoUnidade():
	minutoUnidade += 1
	if minutoUnidade >= 10:
		minutoUnidade = 0
		set_MinutoDecima()
	set_Image(minutoUnidade, $HBoxContainer/MinutoUnidade)
	
func set_MinutoDecima():
	minutoDecima += 1
	if minutoDecima >= 6:
		minutoDecima = 0
		set_Hora()
	set_Image(minutoDecima, $HBoxContainer/MinutoDecima)
	
func set_Hora():
	hora += 1 
	set_Image(hora, $HBoxContainer/Hora)
	
func getTempo():
	return {"Hora": hora, "Minutos": int(str(minutoDecima)+ str(minutoUnidade))}
	
func set_Image(tempo, textureRect:TextureRect):
	match tempo:
		0:
			textureRect.texture = load("res://assets/interface/ui_num0.png")
		1:
			textureRect.texture = load("res://assets/interface/ui_num1.png")
		2:
			textureRect.texture = load("res://assets/interface/ui_num2.png")
		3:
			textureRect.texture = load("res://assets/interface/ui_num3.png")
		4:
			textureRect.texture = load("res://assets/interface/ui_num4.png")
		5:
			textureRect.texture = load("res://assets/interface/ui_num5.png")
		6:
			textureRect.texture = load("res://assets/interface/ui_num6.png")
		7:
			textureRect.texture = load("res://assets/interface/ui_num7.png")
		8:
			textureRect.texture = load("res://assets/interface/ui_num8.png")
		9:
			textureRect.texture = load("res://assets/interface/ui_num9.png")
