class_name Enemigo
extends CharacterBody2D
@export var velocidade: float = 150.0
@onready var navegation = $NavigationAgent2D
var jogador = null

func _physics_process(delta):
	var direction = to_local(navegation.get_next_path_position()).normalized()
	velocity = direction * velocidade
	move_and_slide()

func _on_timer_timeout() -> void:
	navegation.target_position = jogador.global_position

func definir_objetivo(objetivo):
	jogador = objetivo
