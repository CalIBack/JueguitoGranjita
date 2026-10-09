extends EstadoJugador

func fisica(delta):
	mover()
	caer(delta)

	if personaje.is_on_floor():
		if direccion() == 0:
			return "Quieto"
		return "Caminando"
	return ""
