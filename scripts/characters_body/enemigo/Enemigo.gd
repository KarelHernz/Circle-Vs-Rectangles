class_name Enemigo
extends CharacterBody2D

@export var velocidade: float = 135

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var navegation: NavigationAgent2D = $NavigationAgent2D

var jogador = null
var esta_a_atacar:bool = false
var lado_esq:bool = false
var semi_boss:bool = false
var boss:bool = false

func _process(delta: float) -> void:
	if jogador == null:
		return
		
	visualizar_personagem()

func _physics_process(_delta: float):
	if esta_a_atacar:
		return
		
	var direction = Vector2.ZERO
	if boss:
		#Isto faz com que o enemigo consiga fazer teleport na posição do jogador
		#Nem perguntes como foi que cheguei naquele resultado, só Deus sabe.
		direction = to_local(navegation.get_next_path_position())
	else:
		direction = to_local(navegation.get_next_path_position()).normalized()
	velocity = direction * velocidade
	move_and_slide()

func _on_timer_timeout() -> void:
	if jogador != null:
		navegation.target_position = jogador.global_position

#Devine o objetivo para que o NavigationAgent2D consiga saber qual objetivo perseguir
func definir_objetivo(objetivo) -> void:
	jogador = objetivo

func _on_area_de_ataque_body_entered(body: Node2D) -> void:
	esta_a_atacar = true
	#Se for um semi-boss, vai recuperar 2 de vida cada que
	#entre um corpo na Area2D chamada de AtaqueDeAtaque
	if semi_boss:
		buff(2, 0)
	while esta_a_atacar:
		animation.play("ataque_espada_esq" if lado_esq else "ataque_espada_direita")
		await (animation.animation_finished)
		animation.play("parado_esq" if lado_esq else "parado_direita")

#Valida se tem algum body dentro da Area2D chamada de AreaDeAtaque
func _on_area_de_ataque_body_exited(body: Node2D) -> void:
	await (animation.animation_finished)
	animation.play("parado_esq" if lado_esq else "parado_direita")
	esta_a_atacar = false

#Faz com que o enemigo esteja a ver na posição do jogador
func visualizar_personagem() -> void:
	lado_esq = jogador.global_position.x < position.x
	$"Mão".position.x = -30.0 if lado_esq else 30.0
	if !esta_a_atacar:
		$Corpo.flip_h = lado_esq
	$Corpo/OlhoEsquerdo.position.x = -9.05 if lado_esq else -4.05
	$Corpo/OlhoDireito.position.x = 4.1 if lado_esq else 9.1

#Melhoras na vida e na velociade do enemigo
func buff(buff_vida:int, buff_velocidade:float) -> void:
	$ComponenteDeVida.buff_vida(buff_vida)
	velocidade += buff_velocidade

func set_semi_boss() -> void:
	semi_boss = true
	set_color(Color(0.0, 1.15, 6.733))
	buff(210, 290)
	
func set_boss() -> void:
	boss = true
	set_color(Color(1.549, 1.114, 0.372, 1.0))
	buff(160, 80)
	$"Mão/Espada".set_ataque(2)
	
func set_color(color:Color) -> void:
	$Corpo.self_modulate = color
	$"Mão".self_modulate = color
	$Corpo/OlhoEsquerdo.color = color
	$Corpo/OlhoDireito.color = color
