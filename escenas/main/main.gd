extends Node2D


@export var camara: Camera2D
@export var personaje1: CharacterBody2D

func _process(delta):
	camara.global_position = personaje1.global_position
