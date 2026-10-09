extends EstadoJugador

func fisica(delta):
	mover()
	caer(delta)

	if not personaje.is_on_floor():
		return "Cayendo"
	if salto_apretado():
		return "Saltando"
	if direccion() == 0:
		return "Quieto"
	return ""
