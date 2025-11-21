class_name Personagem
extends CharacterBody2D

const VIDA = 5
@export var velocidade = 400
@onready var animation = $AnimationPlayer
@onready var personagem = $Corpo

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
	
	if lado_esq:
		$"Mão".position.x = -32.536
	else:
		$"Mão".position.x = 32.536

func atacar():
	if (Input.is_action_just_pressed("atacar") or Input.is_action_pressed("atacar")) and not esta_a_atacar:
		esta_a_atacar = true
		if lado_esq:
			animation.play("ataque_espada_esq")
			await (animation.animation_finished)
			animation.play("parado_esq")
		else:
			animation.play("ataque_espada_direita")
			await (animation.animation_finished)
			animation.play("parado_dereita")
		esta_a_atacar = false
