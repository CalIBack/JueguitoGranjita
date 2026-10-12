class_name Personaje
extends CharacterBody2D

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
	motion_mode = MOTION_MODE_GROUNDED
	sufijo = "P" + str(numero_jugador)

	if numero_jugador == 1:
		sprite.texture = textura_p1
	else:
		sprite.texture = textura_p2

	if movimiento:
		add_child(movimiento.instantiate())
