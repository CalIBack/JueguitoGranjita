class_name EstadoJugador
extends Node

var personaje: Personaje

func entrar():
	pass

func salir():
	pass

func fisica(_delta) -> String:
	return ""

func direccion() -> float:
	return Input.get_axis("izquierda" + personaje.sufijo, "derecha" + personaje.sufijo)

func mover():
	var dir = direccion()
	personaje.velocity.x = dir * personaje.velocidad
	if dir != 0:
		personaje.sprite.flip_h = dir < 0

func caer(delta):
	personaje.velocity.y += personaje.gravedad * delta

func salto_apretado() -> bool:
	return Input.is_action_just_pressed("arriba" + personaje.sufijo)

func salto_soltado() -> bool:
	return Input.is_action_just_released("arriba" + personaje.sufijo)
