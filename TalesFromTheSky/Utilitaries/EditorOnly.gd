tool

extends Node

func _ready():
	if !Engine.is_editor_hint():
		queue_free()
