class_name Enemigo
extends CharacterBody2D

@export var velocidade: float = 150.0

@onready var animation = $AnimationPlayer
@onready var navegation = $NavigationAgent2D

var jogador = null
var esta_a_atacar = false
var lado_esq = false
var semi_boss = false
var boss = false

func _process(delta: float) -> void:
	if jogador == null:
		return
		
	lado_esq = jogador.global_position.x < position.x
	$"Mão".position.x = -30.0 if lado_esq else 30.0
	$Corpo/OlhoEsquerdo.position.x = -9.05 if lado_esq else -4.05
	$Corpo/OlhoDireito.position.x = 4.1 if lado_esq else 9.1
	$Corpo.flip_h = esta_a_atacar

func _physics_process(_delta: float):
	if esta_a_atacar:
		return
		
	var direction = Vector2.ZERO
	if semi_boss:
		direction = to_local(navegation.get_next_path_position())
	else:
		direction = to_local(navegation.get_next_path_position()).normalized()
	velocity = direction * velocidade
	move_and_slide()

func _on_timer_timeout() -> void:
	if jogador != null:
		navegation.target_position = jogador.global_position

func definir_objetivo(objetivo):
	jogador = objetivo

func _on_area_de_ataque_body_entered(body: Node2D) -> void:
	esta_a_atacar = true
	if boss:
		buff(2, 0)
	while esta_a_atacar:
		animation.play("ataque_espada_esq" if lado_esq else "ataque_espada_direita")
		await (animation.animation_finished)
		animation.play("parado_esq" if lado_esq else "parado_direita")

func _on_area_de_ataque_body_exited(body: Node2D) -> void:
	await (animation.animation_finished)
	animation.play("parado_esq" if lado_esq else "parado_direita")
	esta_a_atacar = false

func buff(buff_vida:int, buff_velocidade:float):
	$ComponenteDeVida.buff_vida(buff_vida)
	velocidade += buff_velocidade

func set_semi_boss():
	semi_boss = true
	
func set_boss():
	boss = true
	
func set_color(color:Color):
	$Corpo.self_modulate = color
	$"Mão".self_modulate = color
