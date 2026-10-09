extends Node

# VERSION DECENTE
# Las banderas se reemplazan por un solo "estado" a la vez (enum).
# Cada rama del match hace lo suyo y decide a donde pasar.
# Es mucho mas facil de leer, pero todos los estados siguen
# viviendo en el mismo archivo.

enum Estado { QUIETO, CAMINANDO, SALTANDO, CAYENDO }

var estado = Estado.QUIETO
var personaje

func _ready():
	personaje = get_parent()

func _physics_process(delta):
	var dir = direccion()

	match estado:
		Estado.QUIETO:
			personaje.velocity.x = 0
			if not personaje.is_on_floor():
				cambiar_estado(Estado.CAYENDO)
			elif salto_apretado():
				cambiar_estado(Estado.SALTANDO)
			elif dir != 0:
				cambiar_estado(Estado.CAMINANDO)

		Estado.CAMINANDO:
			mover(dir)
			if not personaje.is_on_floor():
				cambiar_estado(Estado.CAYENDO)
			elif salto_apretado():
				cambiar_estado(Estado.SALTANDO)
			elif dir == 0:
				cambiar_estado(Estado.QUIETO)

		Estado.SALTANDO:
			mover(dir)
			if salto_soltado() and personaje.velocity.y < 0:
				personaje.velocity.y = personaje.velocity.y / 2
			if personaje.velocity.y >= 0:
				cambiar_estado(Estado.CAYENDO)

		Estado.CAYENDO:
			mover(dir)
			if personaje.is_on_floor():
				if dir == 0:
					cambiar_estado(Estado.QUIETO)
				else:
					cambiar_estado(Estado.CAMINANDO)

	personaje.velocity.y += personaje.gravedad * delta
	personaje.move_and_slide()

func cambiar_estado(nuevo):
	estado = nuevo
	if nuevo == Estado.SALTANDO:
		personaje.velocity.y = -personaje.fuerza_salto

func mover(dir):
	personaje.velocity.x = dir * personaje.velocidad
	if dir != 0:
		personaje.sprite.flip_h = dir < 0

func direccion():
	return Input.get_axis("izquierda" + personaje.sufijo, "derecha" + personaje.sufijo)

func salto_apretado():
	return Input.is_action_just_pressed("arriba" + personaje.sufijo)

func salto_soltado():
	return Input.is_action_just_released("arriba" + personaje.sufijo)
