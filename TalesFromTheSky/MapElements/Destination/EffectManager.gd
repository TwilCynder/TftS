extends Node2D

class_name EffectManager

func add_effect(fx, position):
	return add_effect_to(self, fx, position)
		
static func add_effect_to(node: Node2D, fx, position):
	var effect = fx.instance()
	node.add_child(effect)
	if position != null:
		effect.position = position
	return effect
