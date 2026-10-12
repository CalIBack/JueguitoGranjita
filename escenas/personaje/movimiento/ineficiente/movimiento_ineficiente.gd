extends Node

var personaje
var esta_saltando = false
var esta_cayendo = false

func _ready():
	personaje = get_parent()

func _physics_process(delta):
	if Input.is_action_pressed("derecha" + personaje.sufijo) and not Input.is_action_pressed("izquierda" + personaje.sufijo):
		personaje.velocity.x = personaje.velocidad
		personaje.sprite.flip_h = false
	elif Input.is_action_pressed("izquierda" + personaje.sufijo) and not Input.is_action_pressed("derecha" + personaje.sufijo):
		personaje.velocity.x = -personaje.velocidad
		personaje.sprite.flip_h = true
	else:
		personaje.velocity.x = 0

	if Input.is_action_just_pressed("arriba" + personaje.sufijo) and personaje.is_on_floor() and not esta_saltando and not esta_cayendo:
		esta_saltando = true
		personaje.velocity.y = -personaje.fuerza_salto

	if esta_saltando and Input.is_action_just_released("arriba" + personaje.sufijo) and personaje.velocity.y < 0:
		personaje.velocity.y = personaje.velocity.y / 2

	if esta_saltando and personaje.velocity.y >= 0:
		esta_saltando = false
		esta_cayendo = true

	if not personaje.is_on_floor() and not esta_saltando:
		esta_cayendo = true

	if esta_cayendo and personaje.is_on_floor():
		esta_cayendo = false

	personaje.velocity.y += personaje.gravedad * delta
	personaje.move_and_slide()
