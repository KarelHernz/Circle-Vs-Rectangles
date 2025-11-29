class_name Enemigo
extends CharacterBody2D

@export var velocidade: float = 150.0

@onready var animation = $AnimationPlayer
@onready var navegation = $NavigationAgent2D
@onready var componenteDaHitbox : ComponenteDaHitbox
@onready var componenteDaVida : ComponenteDeVida

var jogador = null
var esta_a_atacar = false
var lado_esq = false

func _process(delta: float) -> void:
	if jogador == null:
		return
		
	lado_esq = jogador.global_position.x < position.x
	$"Mão".position.x = -30.0 if lado_esq else 30.0
	$Corpo.flip_h = lado_esq

func _physics_process(_delta: float):
	if !esta_a_atacar:
		var direction = to_local(navegation.get_next_path_position()).normalized()
		velocity = direction * velocidade
		move_and_slide()

func _on_timer_timeout() -> void:
	if jogador != null:
		navegation.target_position = jogador.global_position

func definir_objetivo(objetivo):
	jogador = objetivo

func _on_area_de_ataque_body_entered(body: Node2D) -> void:
	esta_a_atacar = true
	while esta_a_atacar:
		animation.play("ataque_espada_esq" if lado_esq else "ataque_espada_direita")
		await (animation.animation_finished)
		animation.play("parado_esq" if lado_esq else "parado_direita")

func _on_area_de_ataque_body_exited(body: Node2D) -> void:
	await (animation.animation_finished)
	animation.play("parado_esq" if lado_esq else "parado_direita")
	esta_a_atacar = false

func buff(buff_vida:int, buff_velocidade:float):
	$ComponenteDeVida.vida += buff_vida
	velocidade += buff_velocidade

func set_color(color:Color):
	$Corpo.self_modulate = color
	$"Mão".self_modulate = color
