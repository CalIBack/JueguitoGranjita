extends Node2D

@export var manzana_scene: PackedScene
@export var cantidad_manzanas: int = 10
@export var area_spawn: Area2D

@export var personaje1: CharacterBody2D
@export var personaje2: CharacterBody2D

@export var label_puntos_p1: Label
@export var label_maximo_p1: Label
@export var label_puntos_p2: Label
@export var label_maximo_p2: Label
@export var label_tiempo: Label

@export var ronda_timer: Timer

func _ready() -> void:
	Global.cargar()
	generar_manzanas()
	ronda_timer.timeout.connect(_on_ronda_timer_timeout)

func _process(delta: float) -> void:
	if personaje1.puntos > Global.maximo1:
		Global.maximo1 = personaje1.puntos
		Global.guardar()
	if personaje2.puntos > Global.maximo2:
		Global.maximo2 = personaje2.puntos
		Global.guardar()

	label_puntos_p1.text = "Puntos: " + str(personaje1.puntos)
	label_maximo_p1.text = "Máximo: " + str(Global.maximo1)
	label_puntos_p2.text = "Puntos: " + str(personaje2.puntos)
	label_maximo_p2.text = "Máximo: " + str(Global.maximo2)

	label_tiempo.text = str(int(ceil(ronda_timer.time_left)))

func generar_manzanas() -> void:
	var shape = area_spawn.get_node("CollisionShape2D")
	var extents = shape.shape.size / 2
	var centro = shape.global_position

	for i in range(cantidad_manzanas):
		var manzana = manzana_scene.instantiate()
		manzana.position = Vector2(
			randf_range(centro.x - extents.x, centro.x + extents.x),
			randf_range(centro.y - extents.y, centro.y + extents.y)
		)
		add_child(manzana)

func _on_ronda_timer_timeout() -> void:
	for m in get_tree().get_nodes_in_group("manzanas"):
		m.queue_free()
	generar_manzanas()
