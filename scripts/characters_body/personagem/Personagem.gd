class_name Personagem
extends CharacterBody2D

@export var velocidade:float = 380

@onready var animation:AnimationPlayer = $AnimationPlayer
@onready var componente_de_vida:ComponenteDeVida = $ComponenteDeVida

var lado_esq:bool = false
var esta_a_atacar:bool = false

func _process(delta: float) -> void:
	ponteiro_rato()
	atacar()

func _physics_process(delta: float) -> void:
	movimento_personagem()

#Faz com que a personagem se consiga mover
func movimento_personagem() -> void:
	var direction = Input.get_vector("esquerda", "direita", "acima", "abaixo")
	velocity = direction * velocidade
	move_and_slide()

#Muda a posição da mão e da espada em base à posição do rato
func ponteiro_rato() -> void:
	var mouse:Vector2 = get_global_mouse_position()
	lado_esq = mouse.x < global_position.x
	$"Mão".position.x = -32.536 if lado_esq else 32.536

func atacar() -> void:
	if (Input.is_action_just_pressed("atacar") or Input.is_action_pressed("atacar")) and not esta_a_atacar:
		esta_a_atacar = true
		if lado_esq:
			animation_atacar("ataque_espada_esq", "parado_esq")
		else:
			animation_atacar("ataque_espada_direita", "parado_direita")
		esta_a_atacar = false
		
func animation_atacar(ataque:String, parado:String) -> void:
	animation.play(ataque)
	await (animation.animation_finished)
	animation.play(parado)

func getVida() -> float:
	return componente_de_vida.get_vida()
