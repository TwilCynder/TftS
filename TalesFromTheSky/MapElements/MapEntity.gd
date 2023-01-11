extends KinematicBody2D

class_name MapEntity

var Map = load("res://Scripts/Map.gd")

func add_to_parent(node: Node2D, position: Vector2):
	get_parent().add_child(node)
	node.position = self.position if position == null else self.position + position

func instance_on_parent(res: Resource, position: Vector2):
	var node = res.instance()
	add_to_parent(node, position)
