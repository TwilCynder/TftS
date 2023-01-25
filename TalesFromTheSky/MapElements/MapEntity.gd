extends KinematicBody2D

class_name MapEntity

var Map = load("res://Scripts/Map.gd")

var layer: Layer = null

func add_to_parent(node: Node2D, position: Vector2):
	get_parent().add_child(node)
	node.position = self.position if position == null else self.position + position

func instance_on_parent(res: Resource, position: Vector2):
	var node = res.instance()
	add_to_parent(node, position)

func _enter_tree():
	if SceneManager.current_layer:
		layer = SceneManager.current_layer

func _freeze_animations(node: Node, state: bool = false):
	for child in node.get_children():
		if child is AnimatedSprite:
			if state:
				VFX.remove_material(child)
			else:
				VFX.ice_material(child)
			child.playing = state
		_freeze_animations(child)

func freeze_animations():
	_freeze_animations(self)

func unfreeze_animations():
	_freeze_animations(self, true)
