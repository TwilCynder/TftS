tool

extends "res://Utilitaries/EditorOnly.gd"

class_name MapBounds

var camW = 320
var camH = 240
export (Vector2) var size = Vector2(camW, camH) setget onset

var color = Color(255, 0, 0)


onready var rect = Rect2(Vector2(0, 0), size)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func onset(s: Vector2):
	size = s
	rect = Rect2(Vector2(0, 0), size)
	pass

func _draw():
	draw_rect(rect, color, false, 3)
	
	var x: int = camW
	while (x < size.x):
		draw_line(Vector2(x, 0), Vector2(x, size.y), color, 1.5)
		x += camW
	
	var y: int = camH
	while (y < size.y):
		draw_line(Vector2(0, y), Vector2(size.x, y), color, 1.5)
		y+= camH
