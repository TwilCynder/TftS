tool

extends Node2D

class_name EditorOnly

func _ready():
	if !Engine.is_editor_hint():
		queue_free()
