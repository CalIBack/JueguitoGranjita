class_name Personaje
extends CharacterBody2D

# El personaje solo guarda sus datos. Quien lo mueve es la escena
# de "movimiento" que le asignes desde el Inspector (ineficiente,
# decente o eficiente). Asi podes cambiar de version sin tocar codigo.

@export var numero_jugador: int = 1
@export var textura_p1: Texture2D
@export var textura_p2: Texture2D
@export var movimiento: PackedScene = preload("res://escenas/personaje/movimiento/eficiente/movimiento_eficiente.tscn")

@export var velocidad = 100
@export var fuerza_salto = 260

var gravedad = ProjectSettings.get_setting("physics/2d/default_gravity")
var puntos = 0
var sufijo = ""

@onready var sprite = $Sprite2D

func _ready():
	# modo plataformero: necesario para que is_on_floor() funcione
	motion_mode = MOTION_MODE_GROUNDED
	sufijo = "P" + str(numero_jugador)

	if numero_jugador == 1:
		sprite.texture = textura_p1
	else:
		sprite.texture = textura_p2

	if movimiento:
		add_child(movimiento.instantiate())
