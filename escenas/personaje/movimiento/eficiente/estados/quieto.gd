extends EstadoJugador

func fisica(delta):
	personaje.velocity.x = 0
	caer(delta)

	if not personaje.is_on_floor():
		return "Cayendo"
	if salto_apretado():
		return "Saltando"
	if direccion() != 0:
		return "Caminando"
	return ""
