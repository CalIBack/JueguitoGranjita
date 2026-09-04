extends Area2D

func _ready():
	add_to_group("manzanas")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.has_method("get") and "puntos" in body:
		body.puntos += 1
		queue_free()
