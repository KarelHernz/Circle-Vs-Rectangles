class_name Personagem
extends CharacterBody2D

@export var velocidade:float = 380

@onready var animation = $AnimationPlayer
@onready var componente_de_vida = $ComponenteDeVida

var lado_esq = false
var esta_a_atacar = false

func _process(delta: float) -> void:
	ponteiro_rato()
	atacar()

func _physics_process(delta: float) -> void:
	movimento_personagem()

func movimento_personagem():
	var direction = Input.get_vector("esquerda", "direita", "acima", "abaixo")
	velocity = direction * velocidade
	move_and_slide()

func ponteiro_rato():
	var mouse = get_global_mouse_position()
	lado_esq = mouse.x < global_position.x
	$"Mão".position.x = -32.536 if lado_esq else 32.536

func atacar():
	if (Input.is_action_just_pressed("atacar") or Input.is_action_pressed("atacar")) and not esta_a_atacar:
		esta_a_atacar = true
		if lado_esq:
			animation_atacar("ataque_espada_esq", "parado_esq")
		else:
			animation_atacar("ataque_espada_direita", "parado_direita")
		esta_a_atacar = false
		
func animation_atacar(ataque, parado):
	animation.play(ataque)
	await (animation.animation_finished)
	animation.play(parado)

func getVida():
	return componente_de_vida.get_vida()
