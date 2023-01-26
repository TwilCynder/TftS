extends Node

onready var IceMaterial = load("res://VFX/Ice_Material.tres")

static func apply_material(node: CanvasItem, material: Material):
	node.material = material

static func remove_material(node: CanvasItem):
	node.material = null

func ice_material(node: CanvasItem):
	apply_material(node, IceMaterial)
