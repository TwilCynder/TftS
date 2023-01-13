extends Node2D

class_name Layer

var tileMaps: Array = []

func  _find_tilemaps(node: Node):
	for child in node.get_children():
		if child is TileMap:
			tileMaps.append(child)
		else:
			_find_tilemaps(child)

func _ready():
	_find_tilemaps(self)
	return

func get_tilemaps():
	return tileMaps

func _enter_tree():
	SceneManager.current_layer = self
