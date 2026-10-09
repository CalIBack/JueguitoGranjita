class_name MaquinaEstados
extends Node

# VERSION EFICIENTE
# La maquina solo corre el estado activo y hace los cambios.
# Toda la logica de cada estado vive en su propio script (carpeta estados/),
# asi que agregar uno nuevo es crear un nodo hijo mas, sin tocar los otros.

@export var estado_inicial: EstadoJugador
@export var mostrar_cambios = false

var personaje: Personaje
var estado_actual: EstadoJugador

func _ready():
	personaje = get_parent()
	for estado in get_children():
		estado.personaje = personaje

	estado_actual = estado_inicial
	estado_actual.entrar()

func _physics_process(delta):
	var siguiente = estado_actual.fisica(delta)
	personaje.move_and_slide()

	if siguiente != "":
		cambiar_a(siguiente)

func cambiar_a(nombre):
	estado_actual.salir()
	estado_actual = get_node(nombre)
	estado_actual.entrar()

	if mostrar_cambios:
		print(personaje.name, " -> ", nombre)
