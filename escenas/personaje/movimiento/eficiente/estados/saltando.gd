extends EstadoJugador

func entrar():
	personaje.velocity.y = -personaje.fuerza_salto

func fisica(delta):
	mover()
	caer(delta)

	if salto_soltado() and personaje.velocity.y < 0:
		personaje.velocity.y = personaje.velocity.y / 2

	if personaje.velocity.y >= 0:
		return "Cayendo"
	return ""
