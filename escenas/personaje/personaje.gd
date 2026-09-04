extends CharacterBody2D

@export var numero_jugador: int = 1
@export var textura_p1: Texture2D
@export var textura_p2: Texture2D

var velocidad = 100
var puntos = 0

func _ready():
	if numero_jugador == 1:
		$Sprite2D.texture = textura_p1
	else:
		$Sprite2D.texture = textura_p2

func _physics_process(delta):
	var direccion = Vector2.ZERO
	var sufijo = "P" + str(numero_jugador)

	if Input.is_action_pressed("derecha" + sufijo):
		direccion.x += 1
	if Input.is_action_pressed("izquierda" + sufijo):
		direccion.x -= 1
	if Input.is_action_pressed("abajo" + sufijo):
		direccion.y += 1
	if Input.is_action_pressed("arriba" + sufijo):
		direccion.y -= 1

	velocity = direccion.normalized() * velocidad
	move_and_slide()
