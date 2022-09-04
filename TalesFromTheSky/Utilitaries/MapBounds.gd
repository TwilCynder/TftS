tool

extends "res://Utilitaries/EditorOnly.gd"

class_name MapBounds

export (Vector2) var size = Vector2(320, 240) setget onset

onready var rect = Rect2(Vector2(0, 0), size)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func onset(s: Vector2):
	size = s
	rect = Rect2(Vector2(0, 0), size)
	pass

func _draw():
	draw_rect(rect, Color(255, 0, 0), false, 3)
	pass
